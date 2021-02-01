-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDungeonBase = require("Game.CommonUI.DungeonPanelWidgets.UIDungeonBase")
local UIATHDungeon = class("UIATHDungeon", UIDungeonBase)
local base = UIDungeonBase
local UIATHDungeonItem = require("Game.ATHDungeon.UI.UIATHDungeonItem")
local UIATHChapterItem = require("Game.ATHDungeon.UI.UIATHChapterItem")
local UIATHSuitDetailItem = require("Game.ATHDungeon.UI.UIATHSuitDetailItem")
local UIATHAreaExtraItem = require("Game.ATHDungeon.UI.UIATHAreaExtraItem")
local UIATHSuitExtraItem = require("Game.ATHDungeon.UI.UIATHSuitExtraItem")
local UIATHSuitAreaItem = require("Game.ATHDungeon.UI.UIATHSuitAreaItem")
local UIATHSuitContentItem = require("Game.ATHDungeon.UI.UIATHSuitContentItem")
local eAthExtraType = {ExtraArea = 1, ExtraSuit = 2}
local eAthAreaType = {AreaA = 1, AreaB = 2, AreaC = 3, AreaAll = 4}
UIATHDungeon.OnInit = function(self)
  -- function num : 0_0 , upvalues : base, _ENV, UIATHAreaExtraItem, UIATHSuitExtraItem, UIATHSuitDetailItem, UIATHSuitAreaItem, UIATHSuitContentItem
  (base.OnInit)(self)
  self.suitDetailItemDic = {}
  self.areaExtraItemPool = (UIItemPool.New)(UIATHAreaExtraItem, (self.ui).areaItem)
  self.suitExtraItemPool = (UIItemPool.New)(UIATHSuitExtraItem, (self.ui).suitIconItem)
  self.suitDetailItemPool = (UIItemPool.New)(UIATHSuitDetailItem, (self.ui).suitDetailItem)
  self.suitAreaItemPool = (UIItemPool.New)(UIATHSuitAreaItem, (self.ui).suitAreaItem)
  self.suitContentItemPool = (UIItemPool.New)(UIATHSuitContentItem, (self.ui).suitContentItem)
  self.onChapterItemClick = BindCallback(self, self.__loadExtraShowUI)
  self.onAreaExtraItemClick = BindCallback(self, self._onAreaExtraItemClick)
  self.onSuitExtraItemClick = BindCallback(self, self._onSuitExtraItemClick)
  self.OnSuitDetailItemClick = BindCallback(self, self.__OnSuitDetailItemClick)
  -- DECOMPILER ERROR at PC66: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).suitDetailList).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC73: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).suitDetailList).onChangeItem = BindCallback(self, self.__OnChangeItem)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_AllArea, self, self.OnAllAreaClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SuitShowBg, self, self.OnSuitShowBgClick)
end

UIATHDungeon.InitDungeonType = function(self, dungeonTypeData, selectItemId, onBackCallback)
  -- function num : 0_1 , upvalues : _ENV, base
  self.dungeonTypeUIEnum = UIWindowTypeID.ATHDungeon
  ;
  (base.InitDungeonType)(self, dungeonTypeData, selectItemId, onBackCallback)
end

UIATHDungeon.InitDungeonList = function(self)
  -- function num : 0_2 , upvalues : base, UIATHDungeonItem
  (base.InitDungeonList)(self, UIATHDungeonItem)
end

UIATHDungeon.InitDungeonStages = function(self, dungeonData)
  -- function num : 0_3 , upvalues : base, UIATHChapterItem, _ENV
  (base.InitDungeonStages)(self, dungeonData, UIATHChapterItem)
  for _,item in ipairs((self.dungeonStageItemPool).listItem) do
    item:SetAthStageClickEvent(self.onChapterItemClick)
  end
end

UIATHDungeon.ShowDungeonDetail = function(self, item)
  -- function num : 0_4 , upvalues : _ENV, base
  local dungeonCfg = (item.dungeonData):GetDungeonCfg()
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_StoryName).text = (LanguageUtil.GetLocaleText)(dungeonCfg.name)
  self.double = (item.dungeonData):GetDungeonDoubleWithLimit()
  if self.double == nil or self.double <= 0 then
    (((((self.ui).tex_LimitCount).transform).parent).gameObject):SetActive(false)
  else
    ;
    (((((self.ui).tex_LimitCount).transform).parent).gameObject):SetActive(true)
    local playedNum = (item.dungeonData):GetDungeonThisCyclePlayedNum()
    self.haveDouble = (math.max)(self.double - playedNum, 0)
    ;
    ((self.ui).tex_LimitCount):SetIndex(0, tostring(self.haveDouble), tostring(self.double))
  end
  do
    ;
    (base.ShowDungeonDetail)(self, item)
  end
end

UIATHDungeon.OnBattleStart = function(self)
  -- function num : 0_5 , upvalues : base
  local ATHRewardInfo = {}
  ATHRewardInfo.double = self.double
  ATHRewardInfo.haveDouble = self.haveDouble or 0
  ;
  (base.OnBattleStart)(self, ATHRewardInfo)
end

UIATHDungeon.__loadExtraShowUI = function(self, stageItem)
  -- function num : 0_6 , upvalues : UIATHDungeon, eAthExtraType, eAthAreaType, _ENV
  local dungeonStageCfg = (stageItem.dungeonStageData):GetDungeonStageCfg()
  local extraType = dungeonStageCfg.day_extra_type
  local extraShow = UIATHDungeon:GetATHExtraCfgData(dungeonStageCfg.day_extra_type, dungeonStageCfg.day_extra_show)
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
  error("day_extra_type err:" .. tostring(extraType))
end

UIATHDungeon.GetATHExtraCfgData = function(self, cfgType, cfgShow)
  -- function num : 0_7 , upvalues : _ENV
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

UIATHDungeon.OnAllAreaClick = function(self)
  -- function num : 0_8 , upvalues : _ENV
  ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(TipContent.ATH_Dungeon_All_Area_Extra_Msg))
end

UIATHDungeon._onAreaExtraItemClick = function(self, item)
  -- function num : 0_9
end

UIATHDungeon._onSuitExtraItemClick = function(self)
  -- function num : 0_10 , upvalues : eAthExtraType, _ENV
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

UIATHDungeon.OnSuitShowBgClick = function(self)
  -- function num : 0_11
  ((self.ui).suitDetailNode):SetActive(false)
end

UIATHDungeon.__OnNewItem = function(self, go)
  -- function num : 0_12 , upvalues : UIATHSuitDetailItem
  local item = (UIATHSuitDetailItem.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.suitDetailItemDic)[go] = item
end

UIATHDungeon.RefillSuitDetailList = function(self)
  -- function num : 0_13
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).suitDetailList).totalCount = #self.curSuitIdList
  ;
  ((self.ui).suitDetailList):RefillCells()
end

UIATHDungeon.__OnChangeItem = function(self, go, index)
  -- function num : 0_14 , upvalues : _ENV
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

UIATHDungeon.__GetSuitDetailItemById = function(self, suitId)
  -- function num : 0_15 , upvalues : _ENV
  for k,v in ipairs(self.curSuitIdList) do
    if v == suitId then
      local index = k - 1
      return self:__GetSuitItemByIndex(index)
    end
  end
  return nil
end

UIATHDungeon.__GetSuitItemByIndex = function(self, index)
  -- function num : 0_16
  local go = ((self.ui).suitDetailList):GetCellByIndex(index)
  if go ~= nil then
    return (self.suitDetailItemDic)[go]
  end
  return nil
end

UIATHDungeon.__OnSuitDetailItemClick = function(self, suitItem)
  -- function num : 0_17
  local suitId = suitItem:GetAthSuitDetailItemId()
  local oldItem = self:__GetSuitDetailItemById(self._curSelectSuitId)
  if oldItem ~= nil then
    oldItem:SetAthSuitDetailItemSelect(false)
  end
  self._curSelectSuitId = suitId
  suitItem:SetAthSuitDetailItemSelect(true)
  self:RefreshSelectAthSuitInfo(suitId)
end

UIATHDungeon.RefreshSelectAthSuitInfo = function(self, suitId)
  -- function num : 0_18 , upvalues : _ENV
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

UIATHDungeon.OnDelete = function(self)
  -- function num : 0_19 , upvalues : base
  (base.OnDelete)(self)
end

return UIATHDungeon

