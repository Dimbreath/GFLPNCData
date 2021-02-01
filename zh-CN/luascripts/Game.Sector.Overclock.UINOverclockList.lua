-- params : ...
-- function num : 0 , upvalues : _ENV
local UINOverclockList = class("UINOverclockList", UIBaseNode)
local base = UIBaseNode
local UINOverclockListItem = require("Game.Sector.Overclock.UINOverclockListItem")
UINOverclockList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.OverclockCtrl = ControllerManager:GetController(ControllerTypeId.Overclock, false)
  self.itemClickCallBack = nil
  self.itemDic = {}
  self.itemDataList = {}
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).overclockList).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).overclockList).onChangeItem = BindCallback(self, self.__OnChangeItem)
end

UINOverclockList.InitList = function(self, OCOptionDatas, itemClickCallBack)
  -- function num : 0_1 , upvalues : _ENV
  self.itemClickCallBack = itemClickCallBack
  self.itemDataList = OCOptionDatas
  ;
  (table.sort)(self.itemDataList, function(a, b)
    -- function num : 0_1_0
    if a.isUnlock ~= b.isUnlock then
      return a.isUnlock
    else
      return a.overclockId < b.overclockId
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
  local num = #self.itemDataList
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).overclockList).totalCount = num
  ;
  ((self.ui).overclockList):RefillCells()
end

UINOverclockList.__OnNewItem = function(self, go)
  -- function num : 0_2 , upvalues : UINOverclockListItem
  local item = (UINOverclockListItem.New)()
  item:Init(go)
  item:BindCallBacks(self.itemClickCallBack)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.itemDic)[go] = item
  ;
  (self.OverclockCtrl):SetOverClockItem(item)
end

UINOverclockList.__OnChangeItem = function(self, go, index)
  -- function num : 0_3 , upvalues : _ENV
  local item = (self.itemDic)[go]
  if item == nil then
    error("Can\'t find OverClock item by gameObject")
    return 
  end
  local data = (self.itemDataList)[index + 1]
  if data == nil then
    error("Can\'t find OverClock Data by index, index = " .. tonumber(index))
  end
  item:InitItem(data)
end

UINOverclockList.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINOverclockList

