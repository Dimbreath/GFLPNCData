local UINDmRoomFntList = class("UINDmRoomFntList", UIBaseNode)
local base = UIBaseNode
local UINDmRoomFntListItem = require("Game.Dorm.DUI.Room.Edit.UINDmRoomFntListItem")
UINDmRoomFntList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.fntItemDic = {}
end

UINDmRoomFntList.InitDmRoomFntList = function(self, fntWarehouseDataList, onClickFntItemFunc)
  -- function num : 0_1
  self.oriFntWarehouseDataList = fntWarehouseDataList
  self.onClickFntItemFunc = onClickFntItemFunc
end

local defaultSortFunc = function(fnt1, fnt2)
  -- function num : 0_2
  if fnt1.isDefaultDmFnt ~= fnt2.isDefaultDmFnt then
    return fnt1.isDefaultDmFnt
  end
  local has1 = fnt1.count > 0
  local has2 = fnt2.count > 0
  if has1 ~= has2 then
    return has1
  end
  local comfort1 = (fnt1.fntCfg).comfort
  local comfort2 = (fnt2.fntCfg).comfort
  if comfort2 >= comfort1 then
    do return comfort1 == comfort2 end
    do return fnt1.id < fnt2.id end
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
end

UINDmRoomFntList.RefreshDmRoomFntList = function(self, funcSift, funcSort)
  -- function num : 0_3 , upvalues : defaultSortFunc, _ENV
  self.curFntList = {}
  self.funcSift = funcSift
  self.funcSort = funcSort or defaultSortFunc
  for index,fntData in ipairs(self.oriFntWarehouseDataList) do
    if self.funcSift == nil or (self.funcSift)(fntData) then
      (table.insert)(self.curFntList, fntData)
    end
  end
  if self.funcSort ~= nil then
    (table.sort)(self.curFntList, self.funcSort)
  end
end

UINDmRoomFntList.RefillDmRoomFntList = function(self, refill)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).scrollRect).totalCount = #self.curFntList
  if refill then
    ((self.ui).scrollRect):RefillCells()
  else
    ;
    ((self.ui).scrollRect):RefreshCells()
  end
end

UINDmRoomFntList.__OnNewItem = function(self, go)
  -- function num : 0_5 , upvalues : UINDmRoomFntListItem
  local item = (UINDmRoomFntListItem.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.fntItemDic)[go] = item
end

UINDmRoomFntList.__OnChangeItem = function(self, go, index)
  -- function num : 0_6 , upvalues : _ENV
  local item = (self.fntItemDic)[go]
  if item == nil then
    error("Can\'t find item by gameObject")
    return 
  end
  local fntWarehouseData = (self.curFntList)[index + 1]
  if fntWarehouseData == nil then
    error("Can\'t find fntWarehouseData by index, index = " .. tonumber(index))
  end
  item:InitDmRoomFntListItem(fntWarehouseData, self.onClickFntItemFunc)
end

UINDmRoomFntList.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UINDmRoomFntList

