-- params : ...
-- function num : 0 , upvalues : _ENV
local UIATHDungeon = class("UIATHDungeon", UIBaseWindow)
local base = UIBaseWindow
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UIATHDungeonData = require("Game.CommonUI.DungeonPanelWidgets.UIDungeonData.UIDungeonData")
local UIATHDungeonItem = require("Game.ATHDungeon.UI.UIATHDungeonItem")
local UIATHAreaExtraItem = require("Game.ATHDungeon.UI.UIATHAreaExtraItem")
local UIATHSuitExtraItem = require("Game.ATHDungeon.UI.UIATHSuitExtraItem")
local UIATHSuitDetailItem = require("Game.ATHDungeon.UI.UIATHSuitDetailItem")
local UIATHSuitAreaItem = require("Game.ATHDungeon.UI.UIATHSuitAreaItem")
local UIATHSuitContentItem = require("Game.ATHDungeon.UI.UIATHSuitContentItem")
local UIATHDungeonChapterList = require("Game.CommonUI.DungeonPanelWidgets.UIDungeonChapterList")
local UIATHChapterItem = require("Game.ATHDungeon.UI.UIATHChapterItem")
local RewardItem = require("Game.CommonUI.Item.UINBaseItem")
local eFmtFromModule = require("Game.Formation.Enum.eFmtFromModule")
local eAthAreaType = require("Game.ATHDungeon.Enum.eAthAreaType")
local eAthExtraType = require("Game.ATHDungeon.Enum.eAthExtraType")
local eDungeonUIType = require("Game.DungeonUI.Enum.eDungeonUIType")
local PstConfig = require("Game.PersistentManager.PersistentData.PersistentConfig")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
local CS_GSceneManager_Ins = (CS.GSceneManager).Instance
UIATHDungeon.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIATHDungeonItem, UIATHAreaExtraItem, UIATHSuitExtraItem, UIATHSuitDetailItem, UIATHSuitAreaItem, UIATHSuitContentItem, UINResourceGroup
  local topBtnGroup = (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self, self.__onBack)
  local onTopInfoClick = BindCallback(self, self.OnTopInfoClick)
  topBtnGroup:SetInfoClickAction(onTopInfoClick)
  self.athItemDataList = {}
  self.athItemDict = {}
  self.onBattleStart = BindCallback(self, self.OnBattleStart)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_AllArea, self, self.OnAllAreaClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SuitShowBg, self, self.OnSuitShowBgClick)
  self.dungeonItemPool = (UIItemPool.New)(UIATHDungeonItem, (self.ui).tog_DungeonItem)
  self.areaExtraItemPool = (UIItemPool.New)(UIATHAreaExtraItem, (self.ui).areaItem)
  self.suitExtraItemPool = (UIItemPool.New)(UIATHSuitExtraItem, (self.ui).suitIconItem)
  self.suitDetailItemPool = (UIItemPool.New)(UIATHSuitDetailItem, (self.ui).suitDetailItem)
  self.suitAreaItemPool = (UIItemPool.New)(UIATHSuitAreaItem, (self.ui).suitAreaItem)
  self.suitContentItemPool = (UIItemPool.New)(UIATHSuitContentItem, (self.ui).suitContentItem)
  self.suitDetailItemDic = {}
  ;
  ((self.ui).tog_DungeonItem):SetActive(false)
  self.onItemClick = BindCallback(self, self.__onClickItem)
  self.onChapterItemClick = BindCallback(self, self.__onChapterItemClick)
  self.onAreaExtraItemClick = BindCallback(self, self._onAreaExtraItemClick)
  self.onSuitExtraItemClick = BindCallback(self, self._onSuitExtraItemClick)
  self.OnSuitDetailItemClick = BindCallback(self, self.__OnSuitDetailItemClick)
  -- DECOMPILER ERROR at PC117: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).suitDetailList).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC124: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).suitDetailList).onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.battleDungeonNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)
  self.resourceGroup = (UINResourceGroup.New)()
  ;
  (self.resourceGroup):Init((self.ui).gameResourceGroup)
  ;
  (self.resourceGroup):SetResourceIds({ItemIdOfKey})
  self.__onDailyLimitUpdate = BindCallback(self, self.__dailyLimitUpdate)
  MsgCenter:AddListener(eMsgEventId.OnBattleDungeonLimitChange, self.__onDailyLimitUpdate)
end

UIATHDungeon.InitATHDungeon = function(self, selectItemId, sector3DWindow, onBackCallback)
  -- function num : 0_1 , upvalues : cs_ResLoader, _ENV
  self.resLoader = (cs_ResLoader.Create)()
  self.selectATHId = nil
  if sector3DWindow ~= nil then
    self.sector3DWindow = sector3DWindow
  end
  if onBackCallback ~= nil then
    self.onBackCallback = onBackCallback
  end
  self:__prepareATHItemData()
  self:__loadATHDungeonList()
  if selectItemId == nil then
    self.selectItemId = ((self.athItemDataList)[1]).itemId
    for k,v in ipairs(self.athItemDataList) do
      if v.moduelUnlock then
        self.selectItemId = v.itemId
        break
      end
    end
  else
    do
      self.selectItemId = selectItemId
      self.selectItem = (self.athItemDict)[self.selectItemId]
      self:__updateSelectATHItemDisplay(self.selectItem)
    end
  end
end

UIATHDungeon.__dailyLimitUpdate = function(self)
  -- function num : 0_2 , upvalues : _ENV
  for k,v in pairs(self.athItemDict) do
    if v ~= nil then
      (v.data):ForceUpdate()
      v:UpdateDailyLimit()
    end
  end
  self:__updateSelectATHItemDisplay(self.selectItem)
  ;
  (self.chaptersUI):UpdateIsDouble()
end

UIATHDungeon.__loadATHDungeonList = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.dungeonItemPool == nil then
    return 
  end
  for k,v in ipairs(self.athItemDataList) do
    if v ~= nil then
      local item = (self.dungeonItemPool):GetOne()
      item:InitWithData(v, self.resLoader)
      item.clickEvent = self.onItemClick
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self.athItemDict)[v.itemId] = item
    end
  end
end

UIATHDungeon.OnAllAreaClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(TipContent.ATH_Dungeon_All_Area_Extra_Msg))
end

UIATHDungeon.__onClickItem = function(self, item)
  -- function num : 0_5
  self:OnSelectItemEvent(item)
end

UIATHDungeon.OnSelectItemEvent = function(self, item)
  -- function num : 0_6
  (self.selectItem):OnSelectDisplay(false)
  self.selectItemId = (item.data).itemId
  self.selectItem = (self.athItemDict)[self.selectItemId]
  self:__updateSelectATHItemDisplay(item)
end

UIATHDungeon.__onChapterItemClick = function(self, item)
  -- function num : 0_7
  self.curItem = item
  self:__loadExtraShowUI(item.cfg)
end

UIATHDungeon._onAreaExtraItemClick = function(self, item)
  -- function num : 0_8
end

UIATHDungeon._onSuitExtraItemClick = function(self)
  -- function num : 0_9 , upvalues : eAthExtraType, _ENV
  if self.extraType ~= eAthExtraType.ExtraSuit then
    return 
  end
  self.curSuitIdList = {}
  if #self.extraShow == 1 and (self.extraShow)[1] == 120002 then
    for suitId,v in pairs(ConfigData.ath_suit) do
      (table.insert)(self.curSuitIdList, suitId)
    end
  else
    do
      self.curSuitIdList = self.extraShow
      if #self.curSuitIdList < 1 then
        return 
      end
      ;
      (table.sort)(self.curSuitIdList)
      self._curSelectSuitId = (self.curSuitIdList)[1]
      ;
      ((self.ui).suitDetailNode):SetActive(true)
      self:RefillSuitDetailList()
      if self._curSelectSuitId ~= nil then
        local suitItem = self:__GetSuitDetailItemById(self._curSelectSuitId)
        if suitItem ~= nil then
          self:__OnSuitDetailItemClick(suitItem)
        end
      end
    end
  end
end

UIATHDungeon.RefillSuitDetailList = function(self)
  -- function num : 0_10
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).suitDetailList).totalCount = #self.curSuitIdList
  ;
  ((self.ui).suitDetailList):RefillCells()
end

UIATHDungeon.__OnNewItem = function(self, go)
  -- function num : 0_11 , upvalues : UIATHSuitDetailItem
  local item = (UIATHSuitDetailItem.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.suitDetailItemDic)[go] = item
end

UIATHDungeon.__OnChangeItem = function(self, go, index)
  -- function num : 0_12 , upvalues : _ENV
  local item = (self.suitDetailItemDic)[go]
  if item == nil then
    error("Can\'t find item by gameObject")
    return 
  end
  local suitId = (self.curSuitIdList)[index + 1]
  if suitId == nil then
    error("Can\'t find suitId by index, index = " .. tonumber(index))
  end
  item:InitWithData((self.curSuitIdList)[index + 1], self.resLoader)
  item.clickEvent = self.OnSuitDetailItemClick
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.suitDetailItemDic)[(self.curSuitIdList)[index + 1]] = item
  if self._curSelectSuitId == suitId then
    item:SetAthSuitDetailItemSelect(true)
  end
end

UIATHDungeon.__OnSuitDetailItemClick = function(self, suitItem)
  -- function num : 0_13
  local suitId = suitItem:GetAthSuitDetailItemId()
  local oldItem = self:__GetSuitDetailItemById(self._curSelectSuitId)
  if oldItem ~= nil then
    oldItem:SetAthSuitDetailItemSelect(false)
  end
  self._curSelectSuitId = suitId
  suitItem:SetAthSuitDetailItemSelect(true)
  self:RefreshSelectAthSuitInfo(suitId)
end

UIATHDungeon.__GetSuitDetailItemById = function(self, suitId)
  -- function num : 0_14 , upvalues : _ENV
  for k,v in ipairs(self.curSuitIdList) do
    if v == suitId then
      local index = k - 1
      return self:__GetSuitItemByIndex(index)
    end
  end
  return nil
end

UIATHDungeon.__GetSuitItemByIndex = function(self, index)
  -- function num : 0_15
  local go = ((self.ui).suitDetailList):GetCellByIndex(index)
  if go ~= nil then
    return (self.suitDetailItemDic)[go]
  end
  return nil
end

UIATHDungeon.RefreshSelectAthSuitInfo = function(self, suitId)
  -- function num : 0_16 , upvalues : _ENV
  (self.suitAreaItemPool):HideAll()
  ;
  (self.suitContentItemPool):HideAll()
  if suitId == nil then
    return 
  end
  local areaList = {}
  for id,v in pairs(ConfigData.arithmetic) do
    if suitId == v.suit then
      (table.insert)(areaList, v.area_type)
    end
  end
  ;
  (table.sort)(areaList)
  for index = 1, #areaList do
    local item = (self.suitAreaItemPool):GetOne()
    item:InitWithData(areaList[index], self.resLoader, suitId)
  end
  local descList = {}
  local suitCfgDic = (ConfigData.ath_suit)[suitId]
  for k,v in pairs(suitCfgDic) do
    local item = (self.suitContentItemPool):GetOne()
    item:InitWithData(k + 1, v.describe, self.resLoader)
  end
end

UIATHDungeon.OnSuitShowBgClick = function(self)
  -- function num : 0_17
  ((self.ui).suitDetailNode):SetActive(false)
end

UIATHDungeon.__updateSelectATHItemDisplay = function(self, item)
  -- function num : 0_18 , upvalues : _ENV
  if item == nil or item.data == nil then
    return 
  end
  local athUIData = item.data
  self.double = athUIData.double
  self.haveDouble = (math.max)(0, athUIData.double - athUIData.usedDouble)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_StoryName).text = (LanguageUtil.GetLocaleText)(athUIData.desName)
  ;
  ((self.ui).tex_LimitCount):SetIndex(0, tostring(self.haveDouble), tostring(athUIData.double))
  self:__loadChapterUI(athUIData)
  item:OnSelectDisplay(true)
end

UIATHDungeon.__loadChapterUI = function(self, athUIData)
  -- function num : 0_19 , upvalues : UIATHDungeonChapterList, UIATHChapterItem, RewardItem, _ENV
  if self.chaptersUI == nil then
    self.chaptersUI = (UIATHDungeonChapterList.New)()
    ;
    (self.chaptersUI):Init((self.ui).levelRewardNode)
  end
  if self.chaptersItemPool == nil or self.fstRewardItemPool == nil or self.mbRewardItemPool == nil then
    self.chaptersItemPool = (self.chaptersUI):CreatePool(UIATHChapterItem, RewardItem, RewardItem)
  end
  ;
  (self.chaptersItemPool):HideAll()
  ;
  (self.fstRewardItemPool):HideAll()
  ;
  (self.mbRewardItemPool):HideAll()
  athUIData:CalcUnLockedAndProgress()
  local chapterItemList = {}
  for index = 1, #athUIData.dungeonCfgList do
    local item = (self.chaptersItemPool):GetOne()
    local itemState, lockReason = athUIData:GetChapterState(((athUIData.dungeonCfgList)[index]).id)
    item:InitWithData((athUIData.dungeonCfgList)[index], itemState, index, self.fstRewardItemPool, self.mbRewardItemPool, athUIData.moduelId, lockReason)
    item.clickEvent = self.onChapterItemClick
    ;
    (table.insert)(chapterItemList, item)
  end
  ;
  (self.chaptersUI):UpdateWithChapterList(chapterItemList, athUIData.totalCompleteChapterCount, athUIData.totalChapterCount, self.onBattleStart, athUIData)
end

UIATHDungeon.__loadExtraShowUI = function(self, chapterData)
  -- function num : 0_20 , upvalues : UIATHDungeon, eAthExtraType, eAthAreaType, _ENV
  local extraType = chapterData.day_extra_type
  local extraShow = UIATHDungeon:GetATHExtraCfgData(chapterData.day_extra_type, chapterData.day_extra_show)
  self.extraShow = extraShow
  self.extraType = extraType
  ;
  ((self.ui).areaList):SetActive(false)
  ;
  ((self.ui).suitList):SetActive(false)
  ;
  ((self.ui).obj_AllArea):SetActive(false)
  ;
  (self.areaExtraItemPool):HideAll()
  ;
  (self.suitExtraItemPool):HideAll()
  if extraType == eAthExtraType.ExtraArea then
    if #extraShow == 1 and extraShow[1] == eAthAreaType.AreaAll then
      ((self.ui).obj_AllArea):SetActive(true)
    else
      if self.areaExtraItemPool == nil then
        error("areaExtraItemPool nil")
        return 
      end
      for index = 1, #extraShow do
        local item = (self.areaExtraItemPool):GetOne()
        item:InitWithData(extraShow[index], self.resLoader)
      end
      ;
      ((self.ui).areaList):SetActive(true)
    end
    return 
  end
  if extraType == eAthExtraType.ExtraSuit then
    if self.suitExtraItemPool == nil then
      error("suitExtraItemPool nil")
      return 
    end
    for index = 1, #extraShow do
      local item = (self.suitExtraItemPool):GetOne()
      item:InitWithData(extraShow[index], self.resLoader)
      item.clickEvent = self.onSuitExtraItemClick
    end
    ;
    ((self.ui).suitList):SetActive(true)
    return 
  end
  error("day_extra_type err:" .. chapterData.extraType)
end

UIATHDungeon.OnBattleStart = function(self)
  -- function num : 0_21 , upvalues : _ENV, cs_MessageCommon, base, PstConfig, CS_GSceneManager_Ins, eFmtFromModule
  self.selectChapterItem = (self.chaptersUI).selectChapterItem
  if ((self.selectItem).data).moduelId == proto_csmsg_SystemFunctionID.SystemFunctionID_EquipDungeon and (ConfigData.game_config).athMaxNum <= #(PlayerDataCenter.allAthData):GetAllAthList() then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
    return 
  end
  if ((self.selectItem).data).totalDailyLimit ~= -1 and ((self.selectItem).data).totalDailyLimit <= ((self.selectItem).data).usedDailyLimit then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.BattleDungeon_DailyLimit))
    return 
  end
  if not (self.selectChapterItem):CheckDailyLimit() then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.BattleDungeon_DailyLimit))
    return 
  end
  if (PlayerDataCenter.stamina):GetCurrentStamina() < (self.selectChapterItem).costStrengthNum then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Sector_LackOfStamina))
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
    -- function num : 0_21_0 , upvalues : self, base, _ENV
    if (self.sector3DWindow).ui ~= nil then
      (((self.sector3DWindow).ui).sectorDungeonRoot):SetActive(false)
    end
    ;
    (base.Hide)(self)
    UIManager:HideWindow(UIWindowTypeID.Sector)
  end

  local exitFormationFunc = function()
    -- function num : 0_21_1 , upvalues : self, base, _ENV
    if (self.sector3DWindow).ui ~= nil then
      (((self.sector3DWindow).ui).sectorDungeonRoot):SetActive(true)
    end
    ;
    (base.Show)(self)
    UIManager:ShowWindow(UIWindowTypeID.Sector)
  end

  local startBattleFunc = function(curSelectFormationId, callBack)
    -- function num : 0_21_2 , upvalues : _ENV, PstConfig, self, CS_GSceneManager_Ins
    local formationData = (PlayerDataCenter.formationDic)[curSelectFormationId]
    if formationData == nil then
      return 
    end
    BattleDungeonManager:SaveFormation(formationData)
    local saveUserData = PersistentManager:GetDataModel((PstConfig.ePackage).UserData)
    saveUserData:SetLastFormationId(((self.selectItem).data).moduelId, curSelectFormationId)
    local ATHRewardInfo = {}
    ATHRewardInfo.double = self.double
    ATHRewardInfo.haveDouble = self.haveDouble
    BattleDungeonManager:SaveBattleWinRewardInfo(ATHRewardInfo, false)
    local afterBattleWinEvent = BindCallback(self, self.AfterBattleWin, self.selectChapterItem, self.selectItem)
    BattleDungeonManager:InjectBattleWinEvent(afterBattleWinEvent)
    BattleDungeonManager:InjectBattleExitEvent(BindCallback(self, function(table, itemId)
      -- function num : 0_21_2_0 , upvalues : _ENV, self, CS_GSceneManager_Ins
      local loadATHUIFunc = BindCallback(self, function()
        -- function num : 0_21_2_0_0 , upvalues : _ENV, itemId, self
        UIManager:ShowWindowAsync(UIWindowTypeID.ATHDungeon, function(window)
          -- function num : 0_21_2_0_0_0 , upvalues : itemId, self, _ENV
          if window == nil then
            return 
          end
          window:InitATHDungeon(itemId, self.sector3DWindow, function(tohome)
            -- function num : 0_21_2_0_0_0_0 , upvalues : _ENV
            local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController, true)
            sectorCtrl:ResetToNormalState(tohome)
          end
)
          UIManager:HideWindow(UIWindowTypeID.ClickContinue)
        end
)
      end
)
      CS_GSceneManager_Ins:LoadSceneAsyncByAB((Consts.SceneName).Sector, function()
        -- function num : 0_21_2_0_1 , upvalues : _ENV, loadATHUIFunc
        (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
        local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController, true)
        sectorCtrl:SetFrom(AreaConst.DungeonBattle, loadATHUIFunc)
        sectorCtrl:OnEnterPlotOrMateralDungeon()
      end
)
    end
, self.selectItemId))
    ;
    (self.battleDungeonNetworkCtrl):CS_BATTLE_DungeonEnter(((self.selectChapterItem).cfg).id, formationData, function()
      -- function num : 0_21_2_1 , upvalues : _ENV, callBack
      ControllerManager:DeleteController(ControllerTypeId.SectorController)
      UIManager:DeleteAllWindow()
      callBack()
    end
)
  end

  local lastFmtId = (PersistentManager:GetDataModel((PstConfig.ePackage).UserData)):GetLastFormationId(((self.selectItem).data).moduelId)
  fmtCtrl:InitFromationCtrl(eFmtFromModule.ATHDungeon, ((self.selectChapterItem).cfg).id, enterFormationFunc, exitFormationFunc, startBattleFunc, (self.selectChapterItem).costStrengthNum, lastFmtId)
end

UIATHDungeon.__onBack = function(self, toHome)
  -- function num : 0_22 , upvalues : base
  if self.onBackCallback ~= nil then
    (self.onBackCallback)(toHome)
  end
  ;
  (base.Delete)(self)
end

UIATHDungeon.AfterBattleWin = function(self, selectChapterItem, selectItem)
  -- function num : 0_23 , upvalues : _ENV
  PlayerDataCenter:LocallyAddDungeonLimit((selectItem.data).moduelId, selectChapterItem.chapterId)
  ;
  (selectItem.data):CalcUnLockedAndProgress()
  selectChapterItem:UpdateLimit()
end

UIATHDungeon.__prepareATHItemData = function(self)
  -- function num : 0_24 , upvalues : _ENV, eDungeonUIType, UIATHDungeonData
  for k,v in pairs(ConfigData.material_dungeon) do
    if v ~= nil and v.ui_type == eDungeonUIType.ATHDungeon then
      self.ui_type = v.ui_type
      local athItemData = (UIATHDungeonData.New)()
      athItemData.moduelId = v.id
      athItemData.itemId = k
      athItemData.itemName = v.name
      athItemData.itemNameEn = v.name_en
      athItemData.itemIcon = v.item_icon
      athItemData.itemBgImg = v.dungeon_img
      athItemData.totalDailyLimit = v.frequency_day
      athItemData.desInfo = v.des_info
      athItemData.desName = v.name
      athItemData.double = v.double
      local heroDungeonCfg = v.stage_id
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
      athItemData.dungeonCfgList = dungeonCfgList
      athItemData:CalcUnLockedAndProgress()
      athItemData:CalcSelfUnlock()
      ;
      (table.insert)(self.athItemDataList, athItemData)
    end
  end
end

UIATHDungeon.GetATHExtraCfgData = function(self, cfgType, cfgShow)
  -- function num : 0_25 , upvalues : _ENV
  local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
  local weekNum = timePassCtrl:GetLogicWeekNum()
  local list = (string.split)(cfgShow, "|")
  local dataList = {}
  for k,v in ipairs(list) do
    local tmpList = (string.split)(v, "=")
    if #tmpList >= 2 and tonumber(tmpList[1]) == weekNum then
      dataList = (CommonUtil.SplitStrToNumber)(tmpList[2], "_")
      return dataList
    end
  end
  error("day_extra_show err this day:" .. weekNum)
  return dataList
end

UIATHDungeon.OnTopInfoClick = function(self)
  -- function num : 0_26 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonDropInfo, function(window)
    -- function num : 0_26_0 , upvalues : self
    if window == nil then
      return 
    end
    window:InitDungeonDropInfo(self.ui_type)
  end
)
end

UIATHDungeon.OnDelete = function(self)
  -- function num : 0_27 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnBattleDungeonLimitChange, self.__onDailyLimitUpdate)
  ;
  (self.resourceGroup):Delete()
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
  end
  ;
  (base.OnDelete)(self)
end

return UIATHDungeon

