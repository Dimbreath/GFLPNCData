-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormHeroEnter = class("UIDormHeroEnter", UIBaseWindow)
local base = UIBaseWindow
local UINDormHeroEnterItem = require("Game.Dorm.UI.UINDormHeroEnterItem")
local CS_MessageCommon = CS.MessageCommon
UIDormHeroEnter.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnClickConfirm)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self.OnClickCancel)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.heroItemDic = {}
  self.__onClickHeroItem = BindCallback(self, self.OnClickHeroItem)
end

UIDormHeroEnter.InitDormHeroEnter = function(self, allBindFntData, fntData, resloader, confirmEvent)
  -- function num : 0_1
  self.curFntData = fntData
  self.curHeroId = fntData:GetFntParam()
  self.allBindFntData = allBindFntData
  self.resloader = resloader
  self.confirmEvent = confirmEvent
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).verticalNormalizedPosition = 1
  self:RefreshDormHeroEnter()
end

UIDormHeroEnter.RefreshDormHeroEnter = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.curHeroList = {}
  local curHeroData = nil
  for id,heroData in pairs(PlayerDataCenter.heroDic) do
    if id == self.curHeroId then
      curHeroData = heroData
    else
      ;
      (table.insert)(self.curHeroList, heroData)
    end
  end
  ;
  (table.sort)(self.curHeroList, function(a, b)
    -- function num : 0_2_0
    do return a.dataId < b.dataId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  if curHeroData ~= nil then
    (table.insert)(self.curHeroList, 1, curHeroData)
    self.selectItemIndex = 1
  end
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).totalCount = #self.curHeroList
  ;
  ((self.ui).scrollRect):RefillCells()
end

UIDormHeroEnter.__OnNewItem = function(self, go)
  -- function num : 0_3 , upvalues : UINDormHeroEnterItem
  local item = (UINDormHeroEnterItem.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.heroItemDic)[go] = item
end

UIDormHeroEnter.__OnChangeItem = function(self, go, index)
  -- function num : 0_4 , upvalues : _ENV
  local heroItem = (self.heroItemDic)[go]
  if heroItem == nil then
    error("Can\'t find heroItem by gameObject")
    return 
  end
  local listIndex = index + 1
  local heroData = (self.curHeroList)[listIndex]
  if heroData == nil then
    error("Can\'t find heroData by index, index = " .. tonumber(index))
  end
  local bind = ((self.allBindFntData).boundDic)[heroData.dataId] ~= nil and heroData.dataId ~= self.curHeroId
  local select = self.selectItemIndex == listIndex
  heroItem:RefreshDormHeroEnterItem(listIndex, heroData, self.__onClickHeroItem, self.resloader, bind, select)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIDormHeroEnter.__GetHeroItemByIndex = function(self, index)
  -- function num : 0_5
  local go = ((self.ui).scrollRect):GetCellByIndex(index)
  if go ~= nil then
    local heroItem = (self.heroItemDic)[go]
    return heroItem
  end
end

UIDormHeroEnter.OnClickHeroItem = function(self, heroItem)
  -- function num : 0_6
  if heroItem.index == self.selectItemIndex then
    self.selectItemIndex = nil
    heroItem:SelectDormHeroEnterItem(false)
  else
    local oldHeroItem = nil
    if self.selectItemIndex ~= nil then
      oldHeroItem = self:__GetHeroItemByIndex(self.selectItemIndex - 1)
    end
    if oldHeroItem ~= nil then
      oldHeroItem:SelectDormHeroEnterItem(false)
    end
    heroItem:SelectDormHeroEnterItem(true)
    self.selectItemIndex = heroItem.index
  end
end

UIDormHeroEnter.OnClickConfirm = function(self)
  -- function num : 0_7 , upvalues : _ENV, CS_MessageCommon
  local newHeroId = 0
  local newHeroData = (self.curHeroList)[self.selectItemIndex]
  if newHeroData ~= nil then
    newHeroId = newHeroData.dataId
  end
  if newHeroId ~= self.curHeroId then
    if newHeroData ~= nil and ((self.allBindFntData).boundDic)[newHeroId] ~= nil then
      local info = (string.format)(ConfigData:GetTipContent(TipContent.Dorm_ChangeBindConfirm), newHeroData:GetName())
      ;
      (CS_MessageCommon.ShowMessageBox)(info, function()
    -- function num : 0_7_0 , upvalues : self, newHeroId
    self:__OnConfirm(newHeroId)
  end
, nil)
    else
      do
        self:__OnConfirm(newHeroId)
      end
    end
  end
end

UIDormHeroEnter.__OnConfirm = function(self, newHeroId)
  -- function num : 0_8
  if self.confirmEvent ~= nil then
    (self.confirmEvent)(self.curFntData, newHeroId)
  end
  self:Delete()
end

UIDormHeroEnter.OnClickCancel = function(self)
  -- function num : 0_9
  self:Delete()
end

UIDormHeroEnter.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  (base.OnDelete)(self)
end

return UIDormHeroEnter

