-- params : ...
-- function num : 0 , upvalues : _ENV
local UIPlotDungeon = class("UIPlotDungeon", UIBaseWindow)
local base = UIBaseWindow
local HeroDungeonItemList = require("Game.CommonUI.DungeonPanelWidgets.UIDungeonItemList")
local UIHeroDungeonData = require("Game.CommonUI.DungeonPanelWidgets.UIDungeonData.UIDungeonData")
local UIHeroDungeonItem = require("Game.Friendship.PlotDungeon.UIHeroDungeonItem")
local UIHeroDungeonChapterList = require("Game.CommonUI.DungeonPanelWidgets.UIDungeonChapterList")
local UIHeroChapterItem = require("Game.Friendship.PlotDungeon.UIHeroChapterItem")
local RewardItem = require("Game.CommonUI.Item.UINBaseItem")
local eFmtFromModule = require("Game.Formation.Enum.eFmtFromModule")
local eDungeonUIType = require("Game.DungeonUI.Enum.eDungeonUIType")
local filterItem = require("Game.Friendship.PlotDungeon.UIFilterItem")
local UIDungeonUtil = require("Game.CommonUI.DungeonPanelWidgets.UIDungeonData.UIDungeonUtil")
local HeroStoryItem = require("Game.Friendship.PlotDungeon.UIDungeonStoryItem")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
local CS_GSceneManager_Ins = (CS.GSceneManager).Instance
local util = require("XLua.Common.xlua_util")
UIPlotDungeon.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, filterItem, UINResourceGroup, UINBaseItemWithCount
  ((self.ui).storyDetailNode):SetActive(false)
  self.moduelId = proto_csmsg_SystemFunctionID.SystemFunctionID_friendship
  local topBtnGroup = (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self, self.__onBack)
  local onTopInfoClick = BindCallback(self, self.OnTopInfoClick)
  topBtnGroup:SetInfoClickAction(onTopInfoClick)
  self.originItemDataList = {}
  self.heroItemDataList = {}
  self.heroItemDataIdDict = {}
  self.heroItemInsDict = {}
  self.onBattleStart = BindCallback(self, self.OnBattleStart)
  self.battleDungeonNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)
  self.filterEvent = BindCallback(self, self.FilterItemAndUpdateList)
  self.filterParam = 0
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_CampName).text = "全部"
  self.filterParamDict = {}
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CampDrop, self, self.__dropCamList)
  self.campFilterItemPool = (UIItemPool.New)(filterItem, (self.ui).btn_CampItem)
  self.onfilterItemClick = BindCallback(self, self.OnClickFilterItem)
  self.resourceGroup = (UINResourceGroup.New)()
  ;
  (self.resourceGroup):Init((self.ui).gameResourceGroup)
  ;
  (self.resourceGroup):SetResourceIds({ItemIdOfKey})
  self.__onDailyLimitUpdate = BindCallback(self, self.__dailyLimitUpdate)
  MsgCenter:AddListener(eMsgEventId.OnBattleDungeonLimitChange, self.__onDailyLimitUpdate)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Friendship, self, self.OnClickFriendship)
  self.__reloadFriendShip = BindCallback(self, self.__loadFriendShip)
  MsgCenter:AddListener(eMsgEventId.OnHeroFriendshipDataChange, self.__reloadFriendShip)
  self.m_ChangeHeroItem = BindCallback(self, self.ChangeHeroItem)
  self.curHeroChipItem = (UINBaseItemWithCount.New)()
  ;
  (self.curHeroChipItem):Init((self.ui).obj_currHeroChip)
end

UIPlotDungeon.InitPlotDungeon = function(self, heroId, sector3DWindow, onBackCallback)
  -- function num : 0_1 , upvalues : cs_ResLoader
  self.resLoader = (cs_ResLoader.Create)()
  self.selectHeroId = heroId
  if sector3DWindow ~= nil then
    self.sector3DWindow = sector3DWindow
  end
  if onBackCallback ~= nil then
    self.onBackCallback = onBackCallback
  end
  self:__updateDailyChanceAndStrength()
  self:__prepareHeroItemData()
  self:__loadHeroDungeonList(self.selectItemIndex)
end

UIPlotDungeon.__dailyLimitUpdate = function(self)
  -- function num : 0_2 , upvalues : _ENV
  for k,v in ipairs(self.heroItemDataList) do
    if v ~= nil then
      v:ForceUpdate()
    end
  end
  ;
  (self.heroItemList):ExecuteFilter((self.filterParamDict)[self.filterParam])
  self:__updateDailyChanceAndStrength()
  ;
  (self.chaptersUI):UpdateIsDouble()
  local isInited = {}
  ;
  (self.campFilterItemPool):HideAll()
  for _,heroItemData in ipairs(self.originItemDataList) do
    if not isInited[heroItemData.sortParam] then
      isInited[heroItemData.sortParam] = true
      local isdouble = heroItemData:IsDouble()
      self:InitDropFilterItem(heroItemData.sortParam, isdouble)
    end
  end
  self:SortDropFilterItems()
  self:InitDropFilterItem(0)
end

UIPlotDungeon.__updateDailyChanceAndStrength = function(self)
  -- function num : 0_3 , upvalues : UIDungeonUtil, _ENV
  if self.dungeonUtil == nil then
    self.dungeonUtil = (UIDungeonUtil.New)()
  end
  self.totalLimit = ((ConfigData.material_dungeon)[self.moduelId]).frequency_day
  local limitAdd = (self.dungeonUtil):TotalDailyLimitAddFromAchievement(self.moduelId)
  self.totalLimit = self.totalLimit + limitAdd
  self.usedLimit = (self.dungeonUtil):GetDailyTotalAndUsedLimit(self.moduelId)
  ;
  ((self.ui).tex_LimitCount):SetIndex(0, tostring(self.totalLimit - self.usedLimit), tostring(self.totalLimit))
end

UIPlotDungeon.__loadHeroDungeonList = function(self, selectItemIndex)
  -- function num : 0_4 , upvalues : HeroDungeonItemList, _ENV
  self.heroItemList = (HeroDungeonItemList.New)()
  ;
  (self.heroItemList):Init((self.ui).heroList)
  ;
  (self.heroItemList):InjectDataAndFilterEvent(self.heroItemDataList)
  ;
  (self.heroItemList):InjectItemInitEvent(BindCallback(self, self.__InitItem))
  ;
  (self.heroItemList):InjectItemUpdateEvent(BindCallback(self, self.__UpdateDungeonItem))
  ;
  (self.heroItemList):LoadItemList(selectItemIndex)
end

UIPlotDungeon.__InitItem = function(self, go)
  -- function num : 0_5 , upvalues : UIHeroDungeonItem, _ENV
  local item = (UIHeroDungeonItem.New)()
  item:Init(go)
  local onclick = BindCallback(self, self.__onClickItem, go)
  item:InjectResLoaderAndClickEvent(self.resLoader, onclick)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.heroItemInsDict)[go] = item
end

UIPlotDungeon.__onClickItem = function(self, go)
  -- function num : 0_6
  self:OnSelectItemEvent(go)
end

UIPlotDungeon.__UpdateDungeonItem = function(self, go, index)
  -- function num : 0_7
  local item = (self.heroItemInsDict)[go]
  local data = (self.heroItemDataList)[index + 1]
  if item ~= nil and data ~= nil then
    item:OnUpdateWithData(data)
    item.index = index + 1
    go.name = data.itemId
    if self.selectHeroId == data.itemId then
      self.selectItem = item
      self:__updateSelectHeroDisplay(item, go)
    else
      if self.selectInsGo ~= nil and self.selectInsGo == go then
        ((self.ui).img_Select):SetActive(false)
      end
    end
  end
end

UIPlotDungeon.OnSelectItemEvent = function(self, go)
  -- function num : 0_8
  if self.heroItemInsDict == nil then
    return 
  end
  local item = (self.heroItemInsDict)[go]
  if item == nil then
    return 
  end
  self.selectHeroId = (item.data).itemId
  self.selectItem = item
  self:__updateSelectHeroDisplay(item, go)
end

UIPlotDungeon.__updateSelectHeroDisplay = function(self, item, itemGo)
  -- function num : 0_9 , upvalues : _ENV, cs_ResLoader
  local heroUIData = item.data
  if self.selectHeroId == nil or heroUIData == nil then
    return 
  end
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_StoryName).text = (LanguageUtil.GetLocaleText)(heroUIData.desName)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_StoryDescr).text = (LanguageUtil.GetLocaleText)(heroUIData.desInfo)
  ;
  (((self.ui).img_Select).transform):SetParent(item.transform, false)
  ;
  ((self.ui).img_Select):SetActive(true)
  self.selectInsGo = itemGo
  if (self.ui).heroHolder == nil then
    return 
  end
  self:__loadBgImg(item)
  if self.heroPrefabResloader ~= nil then
    (self.heroPrefabResloader):Put2Pool()
  end
  self.heroPrefabResloader = (cs_ResLoader.Create)()
  DestroyUnityObject(self.heroImgIns)
  ;
  (self.heroPrefabResloader):LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(heroUIData.itemIcon), function(prefab)
    -- function num : 0_9_0 , upvalues : _ENV, self
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroDungeon")
  end
)
  self:__loadChapterUI(heroUIData)
  self:__loadAvgUI(heroUIData)
  self:__loadFriendShip()
  self:__RefreshCurHeroChip(heroUIData)
  ;
  ((self.ui).storyDetailNode):SetActive(true)
end

UIPlotDungeon.__loadAvgUI = function(self, heroUIData)
  -- function num : 0_10 , upvalues : _ENV, HeroStoryItem
  if heroUIData.storyList ~= nil and #heroUIData.storyList > 0 then
    if self.storyItemPool == nil then
      self.storyItemPool = (UIItemPool.New)(HeroStoryItem, (self.ui).storyItem)
    end
    ;
    (self.storyItemPool):HideAll()
    for i = 1, #heroUIData.storyList do
      local storyItem = (self.storyItemPool):GetOne()
      storyItem:InitWithData((heroUIData.storyList)[i])
      if not storyItem.isUnlock then
        return 
      end
    end
  end
end

UIPlotDungeon.__loadChapterUI = function(self, heroUIData)
  -- function num : 0_11 , upvalues : UIHeroDungeonChapterList, UIHeroChapterItem, RewardItem, _ENV
  if self.chaptersUI == nil then
    self.chaptersUI = (UIHeroDungeonChapterList.New)()
    ;
    (self.chaptersUI):Init((self.ui).levelRewardNode)
  end
  if self.chaptersItemPool == nil or self.fstRewardItemPool == nil or self.mbRewardItemPool == nil then
    self.chaptersItemPool = (self.chaptersUI):CreatePool(UIHeroChapterItem, RewardItem, RewardItem)
  end
  ;
  (self.chaptersItemPool):HideAll()
  ;
  (self.fstRewardItemPool):HideAll()
  ;
  (self.mbRewardItemPool):HideAll()
  heroUIData:CalcUnLockedAndProgress()
  local chapterItemList = {}
  for index = 1, #heroUIData.dungeonCfgList do
    local item = (self.chaptersItemPool):GetOne()
    local itemState, lockReason = heroUIData:GetChapterState(((heroUIData.dungeonCfgList)[index]).id)
    item:InitWithData((heroUIData.dungeonCfgList)[index], itemState, index, self.fstRewardItemPool, self.mbRewardItemPool, self.moduelId, lockReason)
    ;
    (table.insert)(chapterItemList, item)
  end
  ;
  (self.chaptersUI):UpdateWithChapterList(chapterItemList, heroUIData.totalCompleteChapterCount, heroUIData.totalChapterCount, self.onBattleStart, heroUIData)
end

UIPlotDungeon.__loadFriendShip = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local isUnlcok = (ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)):ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship)
  ;
  (((self.ui).btn_Friendship).gameObject):SetActive(isUnlcok)
  if not isUnlcok then
    return 
  end
  local level = (PlayerDataCenter.allFriendshipData):GetLevel(self.selectHeroId)
  if level < 10 then
    ((self.ui).tex_FriendshipLevel):SetIndex(0, "0", tostring(level))
  else
    ;
    ((self.ui).tex_FriendshipLevel):SetIndex(1, tostring(level))
  end
  self:__loadChapterUI((self.selectItem).data)
end

UIPlotDungeon.__RefreshCurHeroChip = function(self, heroUIData)
  -- function num : 0_13 , upvalues : _ENV
  local itemId = ((((self.chaptersUI).selectChapterItem).cfg).first_reward_ids)[1]
  if itemId == nil then
    return 
  end
  local itemcfg = (ConfigData.item)[itemId]
  if itemcfg == nil then
    warn("itemcfg is Can\'t find,id:" .. tostring(itemId))
    return 
  end
  local count = PlayerDataCenter:GetItemCount(itemId)
  ;
  (self.curHeroChipItem):InitItemWithCount(itemcfg, count, nil)
end

UIPlotDungeon.OnClickFriendship = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if self.selectHeroId == nil then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.FriendShip, function(win)
    -- function num : 0_14_0 , upvalues : _ENV, self
    if win ~= nil then
      local heroData = (PlayerDataCenter.heroDic)[self.selectHeroId]
      win:InitFriendshipSkillUpgrade(heroData, self.heroPrefabResloader, nil, self.m_ChangeHeroItem)
    end
  end
)
end

UIPlotDungeon.ChangeHeroItem = function(self, flag, callback)
  -- function num : 0_15 , upvalues : _ENV
  local nowIndex = (self.selectItem).index
  if flag > 0 then
    nowIndex = nowIndex + 1
    if #self.heroItemDataList < nowIndex then
      nowIndex = 1
    end
  else
    nowIndex = nowIndex - 1
    if nowIndex <= 0 then
      nowIndex = #self.heroItemDataList
    end
  end
  ;
  (self.heroItemList):Roll2Index(nowIndex - 1, function()
    -- function num : 0_15_0 , upvalues : _ENV, self, nowIndex, callback
    for go,item in pairs(self.heroItemInsDict) do
      if item.index == nowIndex then
        self:__onClickItem(go)
      end
    end
    if callback ~= nil then
      local heroData = (PlayerDataCenter.heroDic)[self.selectHeroId]
      callback(heroData, self.heroPrefabResloader)
    end
  end
)
end

UIPlotDungeon.OnBattleStart = function(self)
  -- function num : 0_16 , upvalues : cs_MessageCommon, _ENV, base, util, CS_GSceneManager_Ins, eFmtFromModule
  self.selectChapterItem = (self.chaptersUI).selectChapterItem
  if self.totalLimit <= self.usedLimit then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.BattleDungeon_DailyLimit))
    return 
  end
  if not (self.selectChapterItem):CheckDailyLimit() then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.BattleDungeon_DailyLimit))
    return 
  end
  for id,count in pairs((self.selectChapterItem).costItemData) do
    if count ~= nil and count > 0 then
      local itemNum = PlayerDataCenter:GetItemCount(id)
      if itemNum < count then
        (cs_MessageCommon.ShowMessageTips)("消耗道具数量不足")
        return 
      end
    end
  end
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local enterFormationFunc = function()
    -- function num : 0_16_0 , upvalues : self, base, _ENV
    if (self.sector3DWindow).ui ~= nil then
      (((self.sector3DWindow).ui).sectorDungeonRoot):SetActive(false)
    end
    ;
    (base.Hide)(self)
    UIManager:HideWindow(UIWindowTypeID.Sector)
  end

  local exitFormationFunc = function()
    -- function num : 0_16_1 , upvalues : self, base, _ENV
    if (self.sector3DWindow).ui ~= nil then
      (((self.sector3DWindow).ui).sectorDungeonRoot):SetActive(true)
    end
    ;
    (base.Show)(self)
    UIManager:ShowWindow(UIWindowTypeID.Sector)
  end

  local startBattleFunc = function(curSelectFormationId, callBack)
    -- function num : 0_16_2 , upvalues : _ENV, self, cs_MessageCommon, util, CS_GSceneManager_Ins
    if (PlayerDataCenter.stamina):GetCurrentStamina() < (self.selectChapterItem).costStrengthNum then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Sector_LackOfStamina))
      return 
    end
    local formationData = (PlayerDataCenter.formationDic)[curSelectFormationId]
    if formationData == nil then
      return 
    end
    BattleDungeonManager:SaveFormation(formationData)
    BattleDungeonManager:SaveBattleWinRewardInfo(nil, ((self.heroItemDataIdDict)[self.selectHeroId]).isDouble)
    local afterBattleWinEvent = BindCallback(self, self.AfterBattleWin, self.selectChapterItem, self.selectItem)
    BattleDungeonManager:InjectBattleWinEvent(afterBattleWinEvent)
    BattleDungeonManager:InjectBattleExitEvent(BindCallback(self, function(table, itemId)
      -- function num : 0_16_2_0 , upvalues : _ENV, self, util, CS_GSceneManager_Ins
      local loadFriendUIFunc = BindCallback(self, function()
        -- function num : 0_16_2_0_0 , upvalues : _ENV, self, itemId, util
        local loadFunc = function()
          -- function num : 0_16_2_0_0_0 , upvalues : _ENV, self, itemId
          (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
          self.StartLoadFriendShipDungeon = true
          while 1 do
            if UIManager:GetWindow(UIWindowTypeID.Sector) == nil or not (UIManager:GetWindow(UIWindowTypeID.Sector)).isLoadCompleted then
              (coroutine.yield)(nil)
              -- DECOMPILER ERROR at PC31: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC31: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
          UIManager:ShowWindowAsync(UIWindowTypeID.FriendShipPlotDungeon, function(window)
            -- function num : 0_16_2_0_0_0_0 , upvalues : itemId, self, _ENV
            if window == nil then
              return 
            end
            window:InitPlotDungeon(itemId, self.sector3DWindow, function(tohome)
              -- function num : 0_16_2_0_0_0_0_0 , upvalues : _ENV
              local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController, true)
              sectorCtrl:ResetToNormalState(tohome)
            end
)
            UIManager:HideWindow(UIWindowTypeID.ClickContinue)
          end
)
          self.StartLoadFriendShipDungeon = false
        end

        if not self.StartLoadFriendShipDungeon then
          self.__loadFriendShipDungeon = (GR.StartCoroutine)((util.cs_generator)(loadFunc))
        end
      end
)
      CS_GSceneManager_Ins:LoadSceneAsyncByAB((Consts.SceneName).Sector, function()
        -- function num : 0_16_2_0_1 , upvalues : _ENV, loadFriendUIFunc
        (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
        local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController, true)
        sectorCtrl:SetFrom(AreaConst.DungeonBattle, loadFriendUIFunc)
        sectorCtrl:OnEnterPlotOrMateralDungeon()
      end
)
    end
, self.selectHeroId))
    ;
    (self.battleDungeonNetworkCtrl):CS_BATTLE_DungeonEnter(((self.selectChapterItem).cfg).id, formationData, function()
      -- function num : 0_16_2_1 , upvalues : _ENV, callBack
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      UIManager:DeleteAllWindow()
      callBack()
    end
)
  end

  fmtCtrl:InitFromationCtrl(eFmtFromModule.FriendshipDungeon, ((self.selectChapterItem).cfg).id, enterFormationFunc, exitFormationFunc, startBattleFunc, (self.selectChapterItem).costStrengthNum)
end

UIPlotDungeon.AfterBattleWin = function(self, selectChapterItem, selectItem)
  -- function num : 0_17 , upvalues : _ENV
  PlayerDataCenter:LocallyAddDungeonLimit((selectItem.data).moduelId, selectChapterItem.chapterId)
  ;
  (selectItem.data):CalcUnLockedAndProgress()
  selectChapterItem:UpdateLimit()
end

UIPlotDungeon.__loadBgImg = function(self, item)
  -- function num : 0_18
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).img_StoryBg).texture = item.img_StoryBg
end

UIPlotDungeon.__prepareHeroItemData = function(self)
  -- function num : 0_19 , upvalues : _ENV, UIHeroDungeonData
  for k,v in pairs(PlayerDataCenter.heroDic) do
    if v ~= nil then
      local heroItemData = (UIHeroDungeonData.New)()
      heroItemData.moduelId = self.moduelId
      heroItemData.itemId = v.dataId
      heroItemData.itemName = (v.heroCfg).name
      heroItemData.itemNameEn = (v.heroCfg).name_en
      heroItemData.itemIcon = (v.resCfg).res_Name
      heroItemData.itemBgImg = ((ConfigData.friendship_hero)[v.dataId]).dungeon_img
      heroItemData.sortParam = v.camp
      heroItemData.desName = ((ConfigData.friendship_hero)[v.dataId]).des_name
      heroItemData.desInfo = ((ConfigData.friendship_hero)[v.dataId]).des_info
      if ((ConfigData.friendship_hero)[v.dataId]).story_id ~= nil then
        local storyids = ((ConfigData.friendship_hero)[v.dataId]).story_id
        if #storyids <= 0 then
          heroItemData.storyList = nil
        else
          for _,stId in ipairs(storyids) do
            local storyCfg = (ConfigData.story_avg)[stId]
            if storyCfg ~= nil then
              (table.insert)(heroItemData.storyList, storyCfg)
            end
          end
        end
      end
      do
        local heroDungeonCfg = ((ConfigData.friendship_hero)[v.dataId]).plot_stage
        local dungeonCfgList = {}
        for k,v in ipairs(heroDungeonCfg) do
          local cfg = (ConfigData.battle_dungeon)[v]
          if cfg == nil then
            error("read battle_dungeon error stageId:" .. v)
          else
            ;
            (table.insert)(dungeonCfgList, cfg)
          end
        end
        heroItemData.dungeonCfgList = dungeonCfgList
        heroItemData.isDouble = heroItemData:IsDouble()
        heroItemData:CalcUnLockedAndProgress()
        -- DECOMPILER ERROR at PC116: Confused about usage of register: R9 in 'UnsetPending'

        if (self.filterParamDict)[heroItemData.sortParam] == nil then
          (self.filterParamDict)[heroItemData.sortParam] = 1
          local isdouble = heroItemData:IsDouble()
          self:InitDropFilterItem(heroItemData.sortParam, isdouble)
        else
          do
            do
              -- DECOMPILER ERROR at PC130: Confused about usage of register: R9 in 'UnsetPending'

              ;
              (self.filterParamDict)[heroItemData.sortParam] = (self.filterParamDict)[heroItemData.sortParam] + 1
              ;
              (table.insert)(self.originItemDataList, heroItemData)
              ;
              (table.insert)(self.heroItemDataList, heroItemData)
              -- DECOMPILER ERROR at PC143: Confused about usage of register: R9 in 'UnsetPending'

              ;
              (self.heroItemDataIdDict)[v.dataId] = heroItemData
              -- DECOMPILER ERROR at PC144: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC144: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC144: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC144: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC144: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC144: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
  self:SortDropFilterItems()
  ;
  (table.sort)(self.heroItemDataList, function(a, b)
    -- function num : 0_19_0
    local aIsDouble = a.isDouble
    local bIsDouble = b.isDouble
    if aIsDouble ~= bIsDouble then
      return aIsDouble
    else
      return a.itemId < b.itemId
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
  if self.selectHeroId == nil and #self.heroItemDataList > 0 then
    self.selectHeroId = ((self.heroItemDataList)[1]).itemId
  end
  for index,v in ipairs(self.heroItemDataList) do
    if self.selectHeroId == v.itemId then
      self.selectItemIndex = index
    end
  end
  -- DECOMPILER ERROR at PC178: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.filterParamDict)[0] = #self.heroItemDataList
  self:InitDropFilterItem(0)
end

UIPlotDungeon.__dropCamList = function(self, isShow)
  -- function num : 0_20 , upvalues : _ENV
  if isShow ~= nil and isShow == false then
    ((self.ui).campList):SetActive(isShow)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).img_Arrow).transform).localScale = Vector3.one
    return 
  end
  local curActive = ((self.ui).campList).activeSelf
  ;
  ((self.ui).campList):SetActive(not curActive)
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

  if curActive then
    (((self.ui).img_Arrow).transform).localScale = Vector3.one
  else
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((self.ui).img_Arrow).transform).localScale = (Vector3.New)(1, -1, 1)
  end
end

UIPlotDungeon.InitDropFilterItem = function(self, campId, isDouble)
  -- function num : 0_21
  local filterItem = (self.campFilterItemPool):GetOne()
  filterItem:InitWithData(campId, isDouble)
  filterItem.clickEvent = self.onfilterItemClick
end

UIPlotDungeon.SortDropFilterItems = function(self)
  -- function num : 0_22 , upvalues : _ENV
  for _,item in ipairs((self.campFilterItemPool).listItem) do
    if item.isDouble then
      (item.transform):SetAsFirstSibling()
    end
  end
end

UIPlotDungeon.OnClickFilterItem = function(self, campId, campText)
  -- function num : 0_23 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).tex_CampName).text = campText
  self:__dropCamList(false)
  self.filterParam = campId
  if self.filterEvent ~= nil then
    self.heroItemDataList = {}
    for k,v in ipairs(self.originItemDataList) do
      if (self.filterEvent)(v.sortParam) then
        (table.insert)(self.heroItemDataList, v)
      end
    end
  end
  do
    ;
    (table.sort)(self.heroItemDataList, function(a, b)
    -- function num : 0_23_0
    local aIsDouble = a.isDouble
    local bIsDouble = b.isDouble
    if aIsDouble ~= bIsDouble then
      return aIsDouble
    else
      return a.itemId < b.itemId
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
    self.selectHeroId = ((self.heroItemDataList)[1]).itemId
    ;
    (self.heroItemList):ExecuteFilter((self.filterParamDict)[self.filterParam])
  end
end

UIPlotDungeon.FilterItemAndUpdateList = function(self, itemSortParam)
  -- function num : 0_24
  if self.filterParam == 0 then
    return true
  else
    return itemSortParam == self.filterParam
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIPlotDungeon.OnTopInfoClick = function(self)
  -- function num : 0_25 , upvalues : _ENV
  local cfg = (ConfigData.material_dungeon)[self.moduelId]
  if cfg == nil then
    error("material_dungeon cfg is Not Find id:" .. tostring(self.moduelId))
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonDropInfo, function(window)
    -- function num : 0_25_0 , upvalues : cfg
    if window == nil then
      return 
    end
    window:InitDungeonDropInfo(cfg.ui_type)
  end
)
end

UIPlotDungeon.__onBack = function(self, toHome)
  -- function num : 0_26 , upvalues : base
  if self.onBackCallback ~= nil then
    (self.onBackCallback)(toHome)
  end
  ;
  (base.Delete)(self)
end

UIPlotDungeon.OnDelete = function(self)
  -- function num : 0_27 , upvalues : _ENV, base
  (self.resourceGroup):Delete()
  if self.__loadFriendShipDungeon ~= nil and self.StartLoadFriendShipDungeon then
    (GR.StopCoroutine)(self.__loadFriendShipDungeon)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    self.StartLoadFriendShipDungeon = false
    self.__loadFriendShipDungeon = nil
  end
  if self.heroPrefabResloader ~= nil then
    (self.heroPrefabResloader):Put2Pool()
  end
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
  end
  MsgCenter:RemoveListener(eMsgEventId.OnBattleDungeonLimitChange, self.__onDailyLimitUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroFriendshipDataChange, self.__reloadFriendShip)
  ;
  (base.OnDelete)(self)
end

return UIPlotDungeon

