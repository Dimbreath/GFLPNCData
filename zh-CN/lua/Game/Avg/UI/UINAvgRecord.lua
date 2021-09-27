local UINAvgRecord = class("UINAvgRecord", UIBaseNode)
local base = UIBaseNode
local UINAvgRecordItem = require("Game.Avg.UI.UINAvgRecordItem")
UINAvgRecord.ctor = function(self, avgSystem)
  -- function num : 0_0
  self.avgSystem = avgSystem
end

UINAvgRecord.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Buttom, self, self.OnClickBtnButtom)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.recordItemGoDic = {}
  self.avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg)
  self:Hide()
end

UINAvgRecord.ShowAcgRecord = function(self, recordDataList)
  -- function num : 0_2
  if recordDataList == nil then
    return 
  end
  self:Show()
  self.recordDataList = recordDataList
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).scrollRect).totalCount = #self.recordDataList
  ;
  ((self.ui).scrollRect):RefreshCells()
  ;
  ((self.ui).scrollRect):RefillCellsFromEnd()
  ;
  ((self.ui).scrollRect):SrollToCell(#self.recordDataList - 1, 1000)
end

UINAvgRecord.OnClickBtnButtom = function(self)
  -- function num : 0_3
  (self.avgSystem):OnAvgRecordClose()
  self:Hide()
end

UINAvgRecord.__OnNewItem = function(self, go)
  -- function num : 0_4 , upvalues : UINAvgRecordItem
  local item = (UINAvgRecordItem.New)()
  item:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.recordItemGoDic)[go] = item
end

UINAvgRecord.__OnChangeItem = function(self, go, index)
  -- function num : 0_5 , upvalues : _ENV
  self.scrollRectIndex = index
  local item = (self.recordItemGoDic)[go]
  if item == nil then
    (self.avgCtrl):AvgLogError("Can\'t find item by gameObject")
    return 
  end
  local recordData = (self.recordDataList)[index + 1]
  if recordData == nil then
    (self.avgCtrl):AvgLogError("Can\'t find recordData by index, index = " .. tonumber(index))
    return 
  end
  local isLast = index + 1 == #self.recordDataList
  item:InitAvgRecordItem(self.avgSystem, recordData, isLast)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINAvgRecord.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINAvgRecord

