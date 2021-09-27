local UIPlotDungeon = class("UIPlotDungeon", UIBaseWindow)
local base = UIBaseWindow
local HeroDungeonItemList = require("Game.CommonUI.DungeonPanelWidgets.UIDungeonItemList")
local UIHeroDungeonItem = require("Game.Friendship.PlotDungeon.UIHeroDungeonItem")
local UIHeroDungeonChapterList = require("Game.CommonUI.DungeonPanelWidgets.UIDungeonChapterList")
local UIHeroChapterItem = require("Game.Friendship.PlotDungeon.UIHeroChapterItem")
local RewardItem = require("Game.CommonUI.Item.UINBaseItem")
local FmtEnum = require("Game.Formation.FmtEnum")
local filterItem = require("Game.Friendship.PlotDungeon.UIFilterItem")
local HeroStoryItem = require("Game.Friendship.PlotDungeon.UIDungeonStoryItem")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINDungeonMultRateBase = require("Game.CommonUI.DungeonPanelWidgets.UINDungeonMultRateBase")
local UINStarUpStarList = require("Game.Hero.NewUI.UpgradeStar.UINStarUpStarList")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
local CS_GSceneManager_Ins = (CS.GSceneManager).Instance
local util = require("XLua.Common.xlua_util")
local JumpManager = require("Game.Jump.JumpManager")
UIPlotDungeon.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, filterItem, UINBaseItemWithCount, UINStarUpStarList
  ((self.ui).storyDetailNode):SetActive(false)
  self.originItemDataList = {}
  self.heroItemDataList = {}
  self.heroItemInsDict = {}
  self.onBattleStart = BindCallback(self, self.OnBattleStart)
  self.filterEvent = BindCallback(self, self.FilterItemAndUpdateList)
  self.filterParam = 0
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_CampName).text = "全部"
  self.filterParamDict = {}
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CampDrop, self, self.__dropCamList)
  self.campFilterItemPool = (UIItemPool.New)(filterItem, (self.ui).btn_CampItem)
  self.onfilterItemClick = BindCallback(self, self.OnClickFilterItem)
  ;
  (UIUtil.SetTopStatus)(self, self.__onBack, {ConstGlobalItem.SKey})
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
  self.curStarList = (UINStarUpStarList.New)()
  ;
  (self.curStarList):Init((self.ui).obj_curHeroStars)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_StarUp, self, self.OnClickStarUp)
  self.__refreshHeroRank = BindCallback(self, self.__RefreshCurHeroStarAndFrag)
  MsgCenter:AddListener(eMsgEventId.OnHeroRankChange, self.__refreshHeroRank)
  self.__refreshCostNode = BindCallback(self, self.__RefreshCurHeroFrag)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__refreshCostNode)
  self:__RegisterStarUpRedDotEvent()
  self.__DungeonTimerId = TimerManager:StartTimer(1, self.OnTimerUpdate, self, false, nil, nil)
end

UIPlotDungeon.SortShoewHeroItem = function(self, dataList)
  -- function num : 0_1 , upvalues : _ENV
  (table.sort)(dataList, function(a, b)
    -- function num : 0_1_0
    local aUnlock = a:UnlockAndHasStageOpen()
    local bUnlock = b:UnlockAndHasStageOpen()
    if aUnlock ~= bUnlock then
      return aUnlock
    end
    if not aUnlock then
      local aStageCfg = a:GetNewLockStage()
      local bStageCfg = b:GetNewLockStage()
      if aStageCfg == nil then
        do return aStageCfg ~= nil and bStageCfg ~= nil end
        if (aStageCfg.pre_para1)[1] >= (bStageCfg.pre_para1)[1] then
          do
            do return (aStageCfg.pre_para1)[1] == (bStageCfg.pre_para1)[1] end
            local aIsDouble = a.isDouble
            do
              local bIsDouble = b.isDouble
              if aIsDouble ~= bIsDouble then
                return aIsDouble
              end
              local powerA = (a.heroData):GetFightingPower()
              local powerB = (b.heroData):GetFightingPower()
              if a.itemId >= b.itemId then
                do return powerA ~= powerB end
                do return powerB < powerA end
                -- DECOMPILER ERROR: 9 unprocessed JMP targets
              end
            end
          end
        end
      end
    end
  end
)
end

UIPlotDungeon.InitPlotDungeon = function(self, dungeonTypeData, heroId, onBackCallback)
  -- function num : 0_2 , upvalues : _ENV, cs_ResLoader
  self.dungeonTypeData = dungeonTypeData
  for index,value in ipairs(dungeonTypeData:GetDungeonDataList()) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R9 in 'UnsetPending'

    (self.originItemDataList)[index] = value
  end
  self:SortShoewHeroItem(self.originItemDataList)
  for index,value in ipairs(self.originItemDataList) do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R9 in 'UnsetPending'

    (self.heroItemDataList)[index] = value
  end
  self.resLoader = (cs_ResLoader.Create)()
  self.selectHeroId = heroId
  if onBackCallback ~= nil then
    self.onBackCallback = onBackCallback
  end
  self:__updateDailyChanceAndStrength()
  self:__prepareHeroItemData()
  self:__loadHeroDungeonList(self.selectItemIndex)
end

UIPlotDungeon.__dailyLimitUpdate = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for k,v in ipairs(self.heroItemDataList) do
    if v ~= nil then
      v:CleanCacheData()
    end
  end
  ;
  (self.heroItemList):ExecuteFilter((self.filterParamDict)[self.filterParam])
  self:__updateDailyChanceAndStrength()
  local isInited = {}
  ;
  (self.campFilterItemPool):HideAll()
  for _,heroItemData in ipairs(self.originItemDataList) do
    if not isInited[heroItemData.sortParam] then
      isInited[heroItemData.sortParam] = true
      local isdouble = heroItemData:GetIsHaveMultReward()
      self:InitDropFilterItem(heroItemData.sortParam, isdouble)
    end
  end
  self:InitDropFilterItem(0)
end

UIPlotDungeon.__updateDailyChanceAndStrength = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local leftNum, totaleLimit, playedNums = (self.dungeonTypeData):GetDungeonTypePlayLeftLimitNum()
  ;
  ((self.ui).tex_LimitCount):SetIndex(0, tostring(leftNum), tostring(totaleLimit))
end

UIPlotDungeon.__updateMultReward = function(self, dungeonData)
  -- function num : 0_5 , upvalues : UINDungeonMultRateBase
  if dungeonData:GetIsHaveMultReward() then
    if self.multRateBase == nil then
      self.multRateBase = (UINDungeonMultRateBase.New)()
      ;
      (self.multRateBase):Init((self.ui).isDoubleOrDropUp)
    end
    ;
    (self.multRateBase):Show()
    ;
    (self.multRateBase):InitMultRate(dungeonData)
  else
    if self.multRateBase ~= nil then
      (self.multRateBase):Hide()
    else
      ;
      ((self.ui).isDoubleOrDropUp):SetActive(false)
    end
  end
end

UIPlotDungeon.__loadHeroDungeonList = function(self, selectItemIndex)
  -- function num : 0_6 , upvalues : HeroDungeonItemList, _ENV
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
  -- function num : 0_7 , upvalues : UIHeroDungeonItem, _ENV
  local item = (UIHeroDungeonItem.New)()
  item:Init(go)
  local onclick = BindCallback(self, self.__onClickItem, go)
  item:InjectResLoaderAndClickEvent(self.resLoader, onclick)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.heroItemInsDict)[go] = item
end

UIPlotDungeon.__onClickItem = function(self, go)
  -- function num : 0_8
  self:OnSelectItemEvent(go)
end

UIPlotDungeon.__UpdateDungeonItem = function(self, go, index)
  -- function num : 0_9
  local item = (self.heroItemInsDict)[go]
  local data = (self.heroItemDataList)[index + 1]
  if item ~= nil and data ~= nil then
    item:OnUpdateWithData(data)
    item.index = index + 1
    go.name = data.itemId
    if self.selectHeroId == data.itemId then
      self.selectHeroId = (item.data).itemId
      self.selectItem = item
      self.selectItemIndex = item.index
      self.selectDungeonData = item.data
      self:__updateSelectHeroDisplay(item, go)
    else
      if self.selectInsGo ~= nil and self.selectInsGo == go then
        ((self.ui).img_Select):SetActive(false)
      end
    end
  end
end

UIPlotDungeon.OnSelectItemEvent = function(self, go)
  -- function num : 0_10 , upvalues : _ENV
  if self.heroItemInsDict == nil then
    return 
  end
  local item = (self.heroItemInsDict)[go]
  if item == nil then
    return 
  end
  self.selectHeroId = (item.data).itemId
  self.selectItem = item
  self.selectItemIndex = item.index
  self.selectDungeonData = item.data
  self:__updateSelectHeroDisplay(item, go)
  AudioManager:PlayAudioById(1060)
end

UIPlotDungeon.__updateSelectHeroDisplay = function(self, item, itemGo)
  -- function num : 0_11 , upvalues : _ENV, cs_ResLoader
  if self.chaptersUI ~= nil and (self.chaptersUI).isShowDetailRect then
    (self.chaptersUI):OnShowDetailRectAndSetSelectChapter(false)
  end
  local dungeonData = item.data
  if self.selectHeroId == nil or dungeonData == nil then
    return 
  end
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_StoryName).text = (LanguageUtil.GetLocaleText)(((ConfigData.friendship_hero)[dungeonData.itemId]).des_name)
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_StoryDescr).text = (LanguageUtil.GetLocaleText)(((ConfigData.friendship_hero)[dungeonData.itemId]).des_info)
  ;
  (((self.ui).img_Select).transform):SetParent(item.transform, false)
  ;
  ((self.ui).img_Select):SetActive(true)
  self.selectInsGo = itemGo
  if (self.ui).heroHolder == nil then
    return 
  end
  self:__loadBgImg(item)
  if self.__curBigImgRes == nil or self.__curBigImgRes ~= ((dungeonData:GetDungeonHeroData()).resCfg).res_Name then
    if self.heroPrefabResloader ~= nil then
      (self.heroPrefabResloader):Put2Pool()
    end
    self.heroPrefabResloader = (cs_ResLoader.Create)()
    DestroyUnityObject(self.bigImgGameObject)
    ;
    (self.heroPrefabResloader):LoadABAssetAsync(PathConsts:GetCharacterBigImgPrefabPath(((dungeonData:GetDungeonHeroData()).resCfg).res_Name), function(prefab)
    -- function num : 0_11_0 , upvalues : _ENV, self, dungeonData
    DestroyUnityObject(self.bigImgGameObject)
    self.bigImgGameObject = prefab:Instantiate((self.ui).heroHolder)
    local commonPicCtrl = (self.bigImgGameObject):FindComponent(eUnityComponentID.CommonPicController)
    commonPicCtrl:SetPosType("HeroDungeon")
    self.__curBigImgRes = ((dungeonData:GetDungeonHeroData()).resCfg).res_Name
  end
)
  end
  self:__loadChapterUI(dungeonData)
  self:__updateMultReward(dungeonData)
  self:__loadFriendShip()
  self:__RefreshCurHeroFrage()
  self:__RefreshCurHeroStarAndFrag()
  ;
  ((self.ui).storyDetailNode):SetActive(true)
end

UIPlotDungeon.__loadAvgUI = function(self, dungeonData)
  -- function num : 0_12 , upvalues : _ENV, HeroStoryItem
  local dungeonStoryList = ((ConfigData.friendship_hero)[dungeonData.itemId]).story_id
  if dungeonStoryList ~= nil and #dungeonStoryList > 0 then
    if self.storyItemPool == nil then
      self.storyItemPool = (UIItemPool.New)(HeroStoryItem, (self.ui).storyItem)
    end
    ;
    (self.storyItemPool):HideAll()
    for i = 1, #dungeonStoryList do
      local storyItem = (self.storyItemPool):GetOne()
      local storyCfg = (ConfigData.story_avg)[dungeonStoryList[i]]
      if storyCfg ~= nil then
        storyItem:InitWithData(storyCfg)
      end
      if not storyItem.isUnlock then
        return 
      end
    end
  end
end

UIPlotDungeon.__loadChapterUI = function(self, dungeonData)
  -- function num : 0_13 , upvalues : UIHeroDungeonChapterList, UIHeroChapterItem, RewardItem, _ENV
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
  for index,dungeonStageData in ipairs(dungeonData:GetDungeonStageList()) do
    local item = (self.chaptersItemPool):GetOne()
    item:InitWithStageData(dungeonStageData, index, self.fstRewardItemPool, self.mbRewardItemPool)
  end
  local stageNum = dungeonData:GetDungeonStageCount()
  if stageNum < 6 then
    for i = #dungeonData:GetDungeonStageList() + 1, 6 do
      local item = (self.chaptersItemPool):GetOne()
      item:InitEmptyStageItem()
    end
  end
  do
    ;
    (self.chaptersUI):UpdateWithChapterList((self.chaptersItemPool).listItem, dungeonData, self.onBattleStart)
  end
end

UIPlotDungeon.__loadFriendShip = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local isUnlcok = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship)
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
  ;
  (self.dungeonTypeData):UpdateDungeonAndStageUnlock()
  self:__loadChapterUI(self.selectDungeonData)
end

UIPlotDungeon.__RefreshCurHeroFrage = function(self)
  -- function num : 0_15 , upvalues : _ENV
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
  -- function num : 0_16 , upvalues : _ENV
  if self.selectHeroId == nil then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.FriendShip, function(win)
    -- function num : 0_16_0 , upvalues : _ENV, self
    if win ~= nil then
      local heroData = (PlayerDataCenter.heroDic)[self.selectHeroId]
      win:InitFriendshipSkillUpgrade(heroData, self.heroPrefabResloader, nil, self.m_ChangeHeroItem)
    end
  end
)
end

UIPlotDungeon.__RefreshCurHeroStarAndFrag = function(self, heroId)
  -- function num : 0_17
  self:__RefreshCurHeroStar()
  self:__RefreshCurHeroFrag()
  self:__RefreshStarUpRedDot()
end

UIPlotDungeon.__RefreshCurHeroStar = function(self)
  -- function num : 0_18 , upvalues : _ENV
  if self.selectHeroId == nil then
    return 
  end
  local heroData = (PlayerDataCenter.heroDic)[self.selectHeroId]
  local rankCfg = (ConfigData.hero_rank)[heroData.rank]
  if rankCfg == nil then
    error("Can\'t find rankCfg, id = " .. tostring(heroData.rank))
  end
  ;
  (self.curStarList):InitStarList(nil, rankCfg.star)
end

UIPlotDungeon.__RefreshCurHeroFrag = function(self)
  -- function num : 0_19 , upvalues : _ENV
  if self.selectHeroId == nil then
    return 
  end
  local heroData = (PlayerDataCenter.heroDic)[self.selectHeroId]
  local isFullRank = heroData:IsFullRank()
  ;
  ((self.ui).obj_Chip):SetActive(not isFullRank)
  ;
  (((self.ui).tex_ChipCount).gameObject):SetActive(not isFullRank)
  ;
  ((self.ui).obj_RankMax):SetActive(isFullRank)
  if not isFullRank then
    local fragCount = heroData:GetHeroFragCount()
    local needFrag = heroData:StarNeedFrag()
    ;
    ((self.ui).tex_ChipCount):SetIndex(0, tostring(fragCount or 0), tostring(needFrag or 0))
  end
end

UIPlotDungeon.__RefreshStarUpRedDot = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local ok, heroStarUpNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, self.selectHeroId, RedDotStaticTypeId.HeroStarUp)
  ;
  ((self.ui).obj_StarUpRedDot):SetActive(not ok or heroStarUpNode:GetRedDotCount() > 0)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIPlotDungeon.__RegisterStarUpRedDotEvent = function(self)
  -- function num : 0_21 , upvalues : _ENV
  self.__onheroCardStarRedDotEvent = function(node)
    -- function num : 0_21_0 , upvalues : self
    if node:GetRedDotCount() <= 0 then
      ((self.ui).obj_StarUpRedDot):SetActive(self.selectHeroId == nil or self.selectHeroId ~= node:GetParentNodeId())
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end

  RedDotController:AddListener(RedDotDynPath.HeroCardStartUpPath, self.__onheroCardStarRedDotEvent)
end

UIPlotDungeon.OnClickStarUp = function(self)
  -- function num : 0_22 , upvalues : _ENV
  if self.selectHeroId == nil then
    return 
  end
  local heroData = (PlayerDataCenter.heroDic)[self.selectHeroId]
  if heroData:IsFullRank() then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroStarUp, function(windows)
    -- function num : 0_22_0 , upvalues : _ENV, self, heroData
    if windows == nil then
      error("Can\'t open " .. self.heroId .. "\'s starUP window")
      return 
    end
    windows:InitHeroStarUp(self.resLoader, nil, self.m_ChangeHeroItem)
    windows:SwitchHero(heroData, self.heroPrefabResloader)
  end
)
end

UIPlotDungeon.ChangeHeroItem = function(self, flag, callback)
  -- function num : 0_23 , upvalues : _ENV
  local nowIndex = self.selectItemIndex
  repeat
    if flag > 0 then
      nowIndex = nowIndex + 1
      if #self.heroItemDataList < nowIndex then
        nowIndex = 1
      end
    end
  until ((self.heroItemDataList)[nowIndex]):UnlockAndHasStageOpen()
  repeat
    nowIndex = nowIndex - 1
    if nowIndex <= 0 then
      nowIndex = #self.heroItemDataList
    end
  until ((self.heroItemDataList)[nowIndex]):UnlockAndHasStageOpen()
  ;
  (self.heroItemList):Roll2Index(nowIndex - 1, function()
    -- function num : 0_23_0 , upvalues : _ENV, self, nowIndex, callback
    for go,item in pairs(self.heroItemInsDict) do
      if item.active and item.data == (self.heroItemDataList)[nowIndex] then
        self:__onClickItem(go)
        break
      end
    end
    do
      if callback ~= nil then
        local heroData = (PlayerDataCenter.heroDic)[self.selectHeroId]
        callback(heroData, self.heroPrefabResloader)
      end
    end
  end
)
end

UIPlotDungeon.OnBattleStart = function(self, autoBattleCount)
  -- function num : 0_24 , upvalues : _ENV, cs_MessageCommon, JumpManager, CS_GSceneManager_Ins, FmtEnum
  self.selectChapterItem = (self.chaptersUI).selectChapterItem
  local dungeonData = self.selectDungeonData
  local dungeonStageData = (self.selectChapterItem).dungeonStageData
  if dungeonStageData:IsHaveATHReward() and (ConfigData.game_config).athMaxNum <= #(PlayerDataCenter.allAthData):GetAllAthList() then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
    return 
  end
  if dungeonData:GetDungeonPlayLeftLimitNum() == 0 then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.BattleDungeon_DailyLimit))
    return 
  end
  if dungeonStageData:GetIsReach2Limit() then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.BattleDungeon_DailyLimit))
    return 
  end
  for id,count in pairs(dungeonStageData:GetNormalCostItemDic()) do
    if id ~= ConstGlobalItem.SKey and count ~= nil and count > 0 then
      local itemNum = PlayerDataCenter:GetItemCount(id)
      if itemNum < count then
        (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Item_NotReach))
        return 
      end
    end
  end
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local enterFormationFunc = function()
    -- function num : 0_24_0 , upvalues : _ENV, autoBattleCount
    (ControllerManager:GetController(ControllerTypeId.SectorController)):EnbleSectorUI3D(false)
    UIManager:HideWindow(UIWindowTypeID.FriendShipPlotDungeon)
    UIManager:HideWindow(UIWindowTypeID.Sector)
    if autoBattleCount or 0 > 1 then
      (BattleDungeonManager.autoCtrl):EnterDungeonAutoModel(autoBattleCount)
    end
  end

  local exitFormationFunc = function()
    -- function num : 0_24_1 , upvalues : _ENV
    (ControllerManager:GetController(ControllerTypeId.SectorController)):EnbleSectorUI3D(true)
    UIManager:ShowWindowOnly(UIWindowTypeID.FriendShipPlotDungeon)
    UIManager:ShowWindowOnly(UIWindowTypeID.Sector)
    if (BattleDungeonManager.autoCtrl):IsEnbaleDungeonAutoMode() then
      (BattleDungeonManager.autoCtrl):ExitDungeonAutoModel()
    end
  end

  local startBattleFunc = nil
  startBattleFunc = function(curSelectFormationData, callBack)
    -- function num : 0_24_2 , upvalues : _ENV, dungeonStageData, JumpManager, dungeonData, self, CS_GSceneManager_Ins, startBattleFunc
    if (PlayerDataCenter.stamina):GetCurrentStamina() < dungeonStageData:GetStaminaCost() then
      JumpManager:Jump((JumpManager.eJumpTarget).BuyStamina)
      return 
    end
    local curSelectFormationId = curSelectFormationData.id
    local formationData = (PlayerDataCenter.formationDic)[curSelectFormationId]
    if formationData == nil then
      return 
    end
    BattleDungeonManager:SaveFormation(formationData)
    BattleDungeonManager:SaveBattleWinRewardInfo(dungeonData)
    local saveUserData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
    saveUserData:SetLastFormationId(dungeonData:GetDungeonId4SaveFragFormation(), curSelectFormationId)
    PersistentManager:SaveModelData((PersistentConfig.ePackage).UserData)
    local afterBattleWinEvent = BindCallback(self, self.AfterBattleWin, self.selectChapterItem, self.selectDungeonData)
    BattleDungeonManager:InjectBattleWinEvent(afterBattleWinEvent)
    self.__startDungeonBattleTS = PlayerDataCenter.timestamp
    BattleDungeonManager:InjectBattleExitEvent(BindCallback(self, function()
      -- function num : 0_24_2_0 , upvalues : _ENV, self, CS_GSceneManager_Ins
      local loadMatUIFunc = BindCallback(self, function()
        -- function num : 0_24_2_0_0 , upvalues : self, _ENV
        self.StartLoadDungeon = true
        UIManager:ShowWindowAsync(UIWindowTypeID.FriendShipPlotDungeon, function(window)
          -- function num : 0_24_2_0_0_0 , upvalues : _ENV, self
          if window == nil then
            return 
          end
          local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController, true)
          local newDungeonTypeData = (sectorCtrl.dungeonTypeDataDic)[(self.dungeonTypeData).dungeonType]
          window:InitPlotDungeon(newDungeonTypeData, self.selectHeroId, function(tohome)
            -- function num : 0_24_2_0_0_0_0 , upvalues : sectorCtrl
            sectorCtrl:ResetToNormalState(tohome)
          end
)
          ;
          (UIUtil.CloseOneCover)("loadMatUIFunc")
          local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
          if aftertTeatmentCtrl ~= nil then
            aftertTeatmentCtrl:TeatmentBengin()
          end
        end
)
      end
)
      ;
      (UIManager:GetWindow(UIWindowTypeID.Loading)):SetLoadingTipsSystemId(2)
      CS_GSceneManager_Ins:LoadSceneAsyncByAB((Consts.SceneName).Sector, function()
        -- function num : 0_24_2_0_1 , upvalues : _ENV, loadMatUIFunc, self
        local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController, true)
        ;
        (UIUtil.AddOneCover)("loadMatUIFunc")
        sectorCtrl:SetFrom(AreaConst.DungeonBattle, loadMatUIFunc, nil, self.dungeonTypeData)
        sectorCtrl:OnEnterPlotOrMateralDungeon()
      end
)
    end
, self.selectItemId))
    BattleDungeonManager:RequestEnterDungeon(((self.selectChapterItem).cfg).id, formationData, startBattleFunc, dungeonStageData, function()
      -- function num : 0_24_2_1 , upvalues : _ENV, callBack
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      if callBack ~= nil then
        callBack()
      end
    end
)
  end

  local realEnterFormationFunc = function()
    -- function num : 0_24_3 , upvalues : autoBattleCount, _ENV, dungeonData, fmtCtrl, FmtEnum, self, enterFormationFunc, exitFormationFunc, startBattleFunc
    local forbidSupport = autoBattleCount or 0 > 1
    local lastFmtId = (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):GetLastFormationId(dungeonData:GetDungeonId4SaveFragFormation())
    fmtCtrl:InitFromationCtrl((FmtEnum.eFmtFromModule).FriendshipDungeon, ((self.selectChapterItem).cfg).id, enterFormationFunc, exitFormationFunc, startBattleFunc, (self.selectChapterItem).costStrengthNum, lastFmtId, nil, nil, forbidSupport)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

  if ((dungeonStageData.dungeonData).heroData):GetMaxNeedFragNum(true) <= 0 then
    do
      local isNeedMoreFrage = not dungeonStageData:GetDungeonStageIsCompleted()
      if not isNeedMoreFrage then
        (cs_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(TipContent.PlotDungeon_ReplayFullFrage), function()
    -- function num : 0_24_4 , upvalues : realEnterFormationFunc
    realEnterFormationFunc()
  end
, nil)
        return 
      end
      if (dungeonStageData.dungeonData).itemId == 1001 then
        (cs_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(TipContent.PlotDungeon_ReplayPersicaria), function()
    -- function num : 0_24_5 , upvalues : realEnterFormationFunc
    realEnterFormationFunc()
  end
, nil)
        return 
      end
      realEnterFormationFunc()
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
end

UIPlotDungeon.AfterBattleWin = function(self, selectChapterItem, dungeonData, hasSupport)
  -- function num : 0_25 , upvalues : _ENV
  PlayerDataCenter:LocallyAddDungeonLimit(dungeonData:GetDungeonId(), selectChapterItem.chapterId, hasSupport, self.__startDungeonBattleTS)
  dungeonData:CleanCacheData()
  dungeonData:CalUnLockedAndProgress()
end

UIPlotDungeon.__loadBgImg = function(self, item)
  -- function num : 0_26
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).img_StoryBg).texture = item.img_StoryBg
end

UIPlotDungeon.__prepareHeroItemData = function(self)
  -- function num : 0_27 , upvalues : _ENV
  if self.selectHeroId == nil and #self.heroItemDataList > 0 then
    for index,dungeonData in ipairs(self.heroItemDataList) do
      if dungeonData:GetIsUnlock() then
        self.selectHeroId = dungeonData.itemId
        break
      end
    end
    do
      if self.selectHeroId == nil then
        error("not handle no hero unlock condition")
      end
      for index,v in ipairs(self.heroItemDataList) do
        if self.selectHeroId == v.itemId then
          self.selectItemIndex = index
        end
      end
      for index,dungeonData in ipairs(self.heroItemDataList) do
        -- DECOMPILER ERROR at PC48: Confused about usage of register: R6 in 'UnsetPending'

        if (self.filterParamDict)[dungeonData.sortParam] == nil then
          (self.filterParamDict)[dungeonData.sortParam] = 1
          local isdouble = dungeonData:GetIsHaveMultReward()
          self:InitDropFilterItem(dungeonData.sortParam, isdouble)
        else
          do
            do
              -- DECOMPILER ERROR at PC62: Confused about usage of register: R6 in 'UnsetPending'

              ;
              (self.filterParamDict)[dungeonData.sortParam] = (self.filterParamDict)[dungeonData.sortParam] + 1
              -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
      -- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self.filterParamDict)[0] = #self.heroItemDataList
      self:InitDropFilterItem(0)
    end
  end
end

UIPlotDungeon.__dropCamList = function(self, isShow)
  -- function num : 0_28 , upvalues : _ENV
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
    AudioManager:PlayAudioById(1069)
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((self.ui).img_Arrow).transform).localScale = (Vector3.New)(1, -1, 1)
  end
end

UIPlotDungeon.InitDropFilterItem = function(self, careerId, isDouble)
  -- function num : 0_29
  local filterItem = (self.campFilterItemPool):GetOne()
  filterItem:InitWithData(careerId, isDouble)
  filterItem.clickEvent = self.onfilterItemClick
end

UIPlotDungeon.OnClickFilterItem = function(self, campId, campText)
  -- function num : 0_30 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).tex_CampName).text = campText
  self:__dropCamList(false)
  self.filterParam = campId
  if campId == 0 then
    AudioManager:PlayAudioById(4100)
  else
    local careerCfg = (ConfigData.career)[campId]
    AudioManager:PlayAudioById(careerCfg.click_audio)
  end
  do
    if self.filterEvent ~= nil then
      self.heroItemDataList = {}
      for k,v in ipairs(self.originItemDataList) do
        if (self.filterEvent)(v.sortParam) then
          (table.insert)(self.heroItemDataList, v)
        end
      end
    end
    do
      self.selectHeroId = nil
      for index,dungeonData in ipairs(self.heroItemDataList) do
        if dungeonData:GetIsUnlock() then
          self.selectHeroId = dungeonData.itemId
          break
        end
      end
      do
        if self.selectHeroId == nil then
          error("not handle no hero unlock condition")
        end
        ;
        (self.heroItemList):ExecuteFilter((self.filterParamDict)[self.filterParam])
      end
    end
  end
end

UIPlotDungeon.FilterItemAndUpdateList = function(self, itemSortParam)
  -- function num : 0_31
  if self.filterParam == 0 then
    return true
  else
    return itemSortParam == self.filterParam
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIPlotDungeon.OnTimerUpdate = function(self)
  -- function num : 0_32
  if self.multRateBase ~= nil and (self.multRateBase).active then
    (self.multRateBase):UpdateLeftTime()
  end
end

UIPlotDungeon.__onBack = function(self, toHome)
  -- function num : 0_33 , upvalues : base
  if self.onBackCallback ~= nil then
    (self.onBackCallback)(toHome)
  end
  ;
  (base.Delete)(self)
end

UIPlotDungeon.OnDelete = function(self)
  -- function num : 0_34 , upvalues : _ENV, base
  if self.__DungeonTimerId ~= nil then
    TimerManager:StopTimer(self.__DungeonTimerId)
    self.__DungeonTimerId = nil
  end
  if self.heroPrefabResloader ~= nil then
    (self.heroPrefabResloader):Put2Pool()
  end
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
  end
  if self.chaptersUI ~= nil then
    (self.chaptersUI):Delete()
  end
  MsgCenter:RemoveListener(eMsgEventId.OnBattleDungeonLimitChange, self.__onDailyLimitUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroFriendshipDataChange, self.__reloadFriendShip)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroRankChange, self.__refreshHeroRank)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__refreshCostNode)
  RedDotController:RemoveListener(RedDotDynPath.HeroCardStartUpPath, self.__onheroCardStarRedDotEvent)
  ;
  (base.OnDelete)(self)
end

return UIPlotDungeon

