-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthSuitDetail = class("UINAthSuitDetail", UIBaseNode)
local base = UIBaseNode
local UINAthSuitDetailItem = require("Game.Arithmetic.AthSuitDetail.UINAthSuitDetailItem")
local UINSuitAthItem = require("Game.Arithmetic.AthSuitDetail.UINSuitAthItem")
local UINAthSuitAttr = require("Game.Arithmetic.AthSuitDetail.UINAthSuitAttr")
UINAthSuitDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINSuitAthItem, UINAthSuitAttr
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Archive, self, self.OnClickArchive)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Bg, self, self.OnClickClose)
  self.__OnAthSuitItemClick = BindCallback(self, self.OnAthSuitItemClick)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.suitItemDic = {}
  ;
  ((self.ui).suitAthItem):SetActive(false)
  self.athPool = (UIItemPool.New)(UINSuitAthItem, (self.ui).suitAthItem)
  ;
  ((self.ui).suitContentItem):SetActive(false)
  self.suitAttrPool = (UIItemPool.New)(UINAthSuitAttr, (self.ui).suitContentItem)
end

UINAthSuitDetail.InitAthSuitDetail = function(self, resLoader, heroSuitDic, suitId)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.SetTopStatus)(self, self.Hide)
  self.resLoader = resLoader
  self.heroSuitDic = heroSuitDic
  self._curSelectSuitId = suitId
  self._isShowCurSuit = true
  self:RefreshAthSuitDetail()
end

UINAthSuitDetail.RefreshAthSuitDetail = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.curSuitIdList = {}
  if self._isShowCurSuit then
    ((self.ui).tex_Archive):SetIndex(0)
    ;
    ((self.ui).tex_Title):SetIndex(0)
    for suitId,v in pairs(self.heroSuitDic) do
      (table.insert)(self.curSuitIdList, suitId)
    end
  else
    do
      ;
      ((self.ui).tex_Archive):SetIndex(1)
      ;
      ((self.ui).tex_Title):SetIndex(1)
      for suitId,v in pairs(ConfigData.ath_suit) do
        (table.insert)(self.curSuitIdList, suitId)
      end
      do
        ;
        (table.sort)(self.curSuitIdList)
        self:RefillAthSuitList()
        if self._curSelectSuitId ~= nil then
          local suitItem = self:__GetSuitItemById(self._curSelectSuitId)
          if suitItem ~= nil then
            self:OnAthSuitItemClick(suitItem)
          end
        end
      end
    end
  end
end

UINAthSuitDetail.RefillAthSuitList = function(self)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).scrollRect).totalCount = #self.curSuitIdList
  ;
  ((self.ui).scrollRect):RefillCells()
end

UINAthSuitDetail.__OnNewItem = function(self, go)
  -- function num : 0_4 , upvalues : UINAthSuitDetailItem
  local item = (UINAthSuitDetailItem.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.suitItemDic)[go] = item
end

UINAthSuitDetail.__OnChangeItem = function(self, go, index)
  -- function num : 0_5 , upvalues : _ENV
  local item = (self.suitItemDic)[go]
  if item == nil then
    error("Can\'t find item by gameObject")
    return 
  end
  local suitId = (self.curSuitIdList)[index + 1]
  if suitId == nil then
    error("Can\'t find suitId by index, index = " .. tonumber(index))
  end
  local curCount = nil
  do
    if self._isShowCurSuit then
      local suitData = (self.heroSuitDic)[suitId]
      curCount = suitData.suitCount
    end
    item:InitAthSuitDetailItem(suitId, self.__OnAthSuitItemClick, self.resLoader, curCount)
    if self._curSelectSuitId == suitId then
      item:SetAthSuitDetailItemSelect(true)
    end
  end
end

UINAthSuitDetail.OnClickArchive = function(self)
  -- function num : 0_6
  self._isShowCurSuit = not self._isShowCurSuit
  self:RefreshAthSuitDetail()
end

UINAthSuitDetail.OnClickClose = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (UIUtil.OnClickBack)()
end

UINAthSuitDetail.OnAthSuitItemClick = function(self, suitItem)
  -- function num : 0_8
  local suitId = suitItem:GetAthSuitDetailItemId()
  local oldItem = self:__GetSuitItemById(self._curSelectSuitId)
  if oldItem ~= nil then
    oldItem:SetAthSuitDetailItemSelect(false)
  end
  self._curSelectSuitId = suitId
  suitItem:SetAthSuitDetailItemSelect(true)
  self:RefreshSelectAthSuitInfo(suitId)
end

UINAthSuitDetail.RefreshSelectAthSuitInfo = function(self, suitId)
  -- function num : 0_9 , upvalues : _ENV
  (self.athPool):HideAll()
  ;
  (self.suitAttrPool):HideAll()
  if suitId == nil then
    return 
  end
  local heroSuitData = (self.heroSuitDic)[suitId]
  local athIdList = ((ConfigData.arithmetic).suitDic)[suitId]
  for k,athId in ipairs(athIdList) do
    local athData, athCfg = nil, nil
    if heroSuitData ~= nil then
      athData = (heroSuitData.athDataDic)[athId]
    end
    if athData == nil then
      athCfg = (ConfigData.arithmetic)[athId]
    end
    local athItem = (self.athPool):GetOne()
    athItem:InitSuitAthItem(athData, athCfg, self.resLoader)
  end
  local suitCfgList = (ConfigData.ath_suit)[suitId]
  for k,suitCfg in ipairs(suitCfgList) do
    local suitCount = suitCfg.num
    local info = (LanguageUtil.GetLocaleText)(suitCfg.describe)
    local textIndex = 0
    if heroSuitData ~= nil and suitCount <= heroSuitData.suitCount then
      textIndex = 1
    end
    local attrItem = (self.suitAttrPool):GetOne()
    attrItem:InitAthSuitAttr(suitCount, info, textIndex)
  end
end

UINAthSuitDetail.__GetSuitItemById = function(self, suitId)
  -- function num : 0_10 , upvalues : _ENV
  for k,v in ipairs(self.curSuitIdList) do
    if v == suitId then
      local index = k - 1
      return self:__GetSuitItemByIndex(index)
    end
  end
  return nil
end

UINAthSuitDetail.__GetSuitItemByIndex = function(self, index)
  -- function num : 0_11
  local go = ((self.ui).scrollRect):GetCellByIndex(index)
  if go ~= nil then
    return (self.suitItemDic)[go]
  end
  return nil
end

UINAthSuitDetail.OnDelete = function(self)
  -- function num : 0_12 , upvalues : base
  (self.athPool):DeleteAll()
  ;
  (self.suitAttrPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINAthSuitDetail

