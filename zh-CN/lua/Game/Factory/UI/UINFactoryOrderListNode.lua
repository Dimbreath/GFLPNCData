local UINFactoryOrderListNode = class("UINFactoryOrderListNode", UIBaseNode)
local base = UIBaseNode
local UINFactoryOrderListItem = require("Game.Factory.UI.UINFactoryOrderListItem")
local FactoryEnum = require("Game.Factory.FactoryEnum")
UINFactoryOrderListNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, FactoryEnum
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  self.togSelectType = (FactoryEnum.eOrderType).dig
  self.orderItemDic = {}
  self.orderDataList = {}
  self.selectedData = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_factoryItemList).onInstantiateItem = BindCallback(self, self.m_OnNewItem)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_factoryItemList).onChangeItem = BindCallback(self, self.m_OnChangeItem)
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_factoryItemList).onReturnItem = BindCallback(self, self.m_OnReturnItem)
  self.__OnSelectItem = BindCallback(self, self.OnSelectOrderItem)
  self.__OnItemUpdate = BindCallback(self, self.OnItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemUpdate)
end

UINFactoryOrderListNode.InitList = function(self, roomIndex, callback)
  -- function num : 0_1 , upvalues : _ENV
  self.roomIndex = roomIndex
  self.onSelectOrderCallback = callback
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).text_RoomName).text = (LanguageUtil.GetLocaleText)(((ConfigData.factory)[roomIndex]).name)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tog_Dig).isOn = false
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tog_Production).isOn = true
  ;
  ((self.ui).obj_Select):SetActive(false)
  self:RefreshOrderList()
end

UINFactoryOrderListNode.RefreshOrderList = function(self)
  -- function num : 0_2
  self.orderDataList = (self.factoryController):GetOrders(self.roomIndex)
  self.selectedData = nil
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_factoryItemList).totalCount = #self.orderDataList
  ;
  ((self.ui).loop_factoryItemList):RefillCells()
  local firstOederData = (self.orderDataList)[1]
  ;
  ((self.ui).img_Icon):SetIndex(firstOederData:GetOrderType() - 1)
end

UINFactoryOrderListNode.m_OnNewItem = function(self, go)
  -- function num : 0_3 , upvalues : UINFactoryOrderListItem
  local orderItem = (UINFactoryOrderListItem.New)()
  orderItem:Init(go)
  orderItem:SetValueChangeCallback(self.__OnSelectItem)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.orderItemDic)[go] = orderItem
end

UINFactoryOrderListNode.m_OnChangeItem = function(self, go, index)
  -- function num : 0_4 , upvalues : _ENV
  local orderItem = (self.orderItemDic)[go]
  if orderItem == nil then
    error("Can\'t find orderItem by gameObject")
    return 
  end
  local orderData = (self.orderDataList)[index + 1]
  if orderData == nil then
    error("Can\'t find orderData by index, index = " .. tonumber(index))
  end
  local couldProdunc = orderData:GetCouldProdunc(self.factoryController)
  orderItem:InitOrderListItem(orderData, couldProdunc)
  if self.selectedData == orderData then
    self:moveSelect2Item(orderItem)
  end
end

UINFactoryOrderListNode.m_OnReturnItem = function(self, go)
  -- function num : 0_5 , upvalues : _ENV
  local levelItem = (self.orderItemDic)[go]
  if levelItem == nil then
    error("Can\'t find levelItem by gameObject")
    return 
  end
  local orderData = levelItem.orderData
  if self.selectedData == orderData then
    ((self.ui).obj_Select):SetActive(false)
  end
end

UINFactoryOrderListNode.m_GetOrderItemByData = function(self, orderData)
  -- function num : 0_6 , upvalues : _ENV
  for k,v in ipairs(self.treeDataList) do
    if v == orderData then
      local index = k - 1
      return self:m_GetOrderItemGoByIndex(index), index
    end
  end
end

UINFactoryOrderListNode.m_GetOrderItemGoByIndex = function(self, index)
  -- function num : 0_7
  if ((self.ui).loop_factoryItemList).totalCount < index then
    return nil
  end
  local go = ((self.ui).loop_factoryItemList):GetCellByIndex(index)
  do
    if go ~= nil then
      local orderItem = (self.orderItemDic)[go]
      return orderItem
    end
    return nil
  end
end

UINFactoryOrderListNode.moveSelect2Item = function(self, orderItem)
  -- function num : 0_8
  ((self.ui).obj_Select):SetActive(true)
  ;
  (((self.ui).obj_Select).transform):SetParent(orderItem.transform)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).obj_Select).transform).position = (orderItem.transform).position
end

UINFactoryOrderListNode.OnSelectOrderItem = function(self, orderItem)
  -- function num : 0_9
  self.selectedData = orderItem.orderData
  self:moveSelect2Item(orderItem)
  if self.onSelectOrderCallback ~= nil then
    (self.onSelectOrderCallback)(orderItem.orderData)
  end
end

UINFactoryOrderListNode.DeSelect = function(self)
  -- function num : 0_10
  self.selectedData = nil
  ;
  ((self.ui).obj_Select):SetActive(false)
end

UINFactoryOrderListNode.UpdateEnergy = function(self)
  -- function num : 0_11
  local goArry = ((self.ui).loop_factoryItemList):GetAllCellObj()
  for i = 0, goArry.Length - 1 do
    local go = goArry[i]
    local item = (self.orderItemDic)[go]
    if item ~= nil then
      local couldProdunc = (item.orderData):GetCouldProdunc(self.factoryController)
      item:RefreshCouldProdunc(couldProdunc)
    end
  end
end

UINFactoryOrderListNode.OnItemUpdate = function(self, itemUpdate)
  -- function num : 0_12 , upvalues : _ENV
  for index,orderData in ipairs(self.orderDataList) do
    if itemUpdate[(orderData:GetOrderCfg()).outPutItemId] ~= nil then
      local item = self:m_GetOrderItemGoByIndex(index - 1)
      if item ~= nil then
        item:RefreshWarehousNum()
      end
    end
  end
  self:UpdateEnergy()
end

UINFactoryOrderListNode.OnDelete = function(self)
  -- function num : 0_13 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemUpdate)
  ;
  (base.OnDelete)(self)
end

return UINFactoryOrderListNode

