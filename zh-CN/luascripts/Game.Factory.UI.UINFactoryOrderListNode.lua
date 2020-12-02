-- params : ...
-- function num : 0 , upvalues : _ENV
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
  self.isSelectDefault = false
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Dig, self, self.OnTogValueChange, (FactoryEnum.eOrderType).dig)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Production, self, self.OnTogValueChange, (FactoryEnum.eOrderType).produce)
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_factoryItemList).onInstantiateItem = BindCallback(self, self.m_OnNewItem)
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_factoryItemList).onChangeItem = BindCallback(self, self.m_OnChangeItem)
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_factoryItemList).onReturnItem = BindCallback(self, self.m_OnReturnItem)
  self.__OnSelectItem = BindCallback(self, self.OnSelectOrderItem)
  self.__OnItemUpdate = BindCallback(self, self.OnItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemUpdate)
end

UINFactoryOrderListNode.InitList = function(self, roomIndex, callback, defaultListType)
  -- function num : 0_1 , upvalues : FactoryEnum
  self.roomIndex = roomIndex
  self.onSelectOrderCallback = callback
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  if defaultListType == (FactoryEnum.eOrderType).dig then
    ((self.ui).tog_Dig).isOn = true
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tog_Production).isOn = false
  else
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

    if defaultListType == (FactoryEnum.eOrderType).produce then
      ((self.ui).tog_Dig).isOn = false
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tog_Production).isOn = true
    else
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tog_Dig).isOn = true
      -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tog_Production).isOn = false
    end
  end
  self:RefreshOrderList()
end

UINFactoryOrderListNode.RefreshOrderList = function(self)
  -- function num : 0_2
  self.orderDataList = (self.factoryController):GetOrders(self.togSelectType)
  if #self.orderDataList >= 1 then
    self.selectedData = (self.orderDataList)[1]
  end
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_factoryItemList).totalCount = #self.orderDataList
  ;
  ((self.ui).loop_factoryItemList):RefillCells()
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
  orderItem:InitOrderListItem(orderData)
  if not self.isSelectDefault and self.selectedData == orderData then
    orderItem:OnClick()
    self.isSelectDefault = true
  end
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
  if (((self.ui).loop_factoryItemList).content).childCount < index then
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

UINFactoryOrderListNode.OnTogValueChange = function(self, type, bool)
  -- function num : 0_10 , upvalues : FactoryEnum
  if bool then
    if type ~= self.togSelectType then
      self.togSelectType = type
      self.selectedData = nil
      self.isSelectDefault = false
      self:RefreshOrderList()
    end
    if type == (FactoryEnum.eOrderType).dig then
      (self.factoryController):ChangeRoomModelGo(self.roomIndex, (FactoryEnum.eRoomType).dig)
      ;
      (((self.ui).img_unSelect_Dig).gameObject):SetActive(false)
      -- DECOMPILER ERROR at PC30: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.ui).img_Icon_Dig).color = (self.ui).color_black
      -- DECOMPILER ERROR at PC35: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.ui).text_Dig).color = (self.ui).color_black
    else
      if type == (FactoryEnum.eOrderType).produce then
        (self.factoryController):ChangeRoomModelGo(self.roomIndex, (FactoryEnum.eRoomType).normal)
        ;
        (((self.ui).img_unSelect_Production).gameObject):SetActive(false)
        -- DECOMPILER ERROR at PC57: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((self.ui).img_Icon_Production).color = (self.ui).color_black
        -- DECOMPILER ERROR at PC62: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((self.ui).text_Production).color = (self.ui).color_black
      end
    end
  else
    if type == (FactoryEnum.eOrderType).dig then
      (((self.ui).img_unSelect_Dig).gameObject):SetActive(true)
      -- DECOMPILER ERROR at PC78: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.ui).img_Icon_Dig).color = (self.ui).color_gray
      -- DECOMPILER ERROR at PC83: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.ui).text_Dig).color = (self.ui).color_gray
    else
      if type == (FactoryEnum.eOrderType).produce then
        (((self.ui).img_unSelect_Production).gameObject):SetActive(true)
        -- DECOMPILER ERROR at PC99: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((self.ui).img_Icon_Production).color = (self.ui).color_gray
        -- DECOMPILER ERROR at PC104: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((self.ui).text_Production).color = (self.ui).color_gray
      end
    end
  end
end

UINFactoryOrderListNode.OnItemUpdate = function(self, itemUpdate)
  -- function num : 0_11 , upvalues : _ENV
  for index,orderData in ipairs(self.orderDataList) do
    if itemUpdate[(orderData.cfg).outPutItemId] ~= nil then
      local item = self:m_GetOrderItemGoByIndex(index - 1)
      if item ~= nil then
        item:RefreshWarehousNum()
      end
    end
  end
end

UINFactoryOrderListNode.OnDelete = function(self)
  -- function num : 0_12 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemUpdate)
  ;
  (base.OnDelete)(self)
end

return UINFactoryOrderListNode

