-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFactoryOrderListItem = class("UINFactoryOrderListItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_MessageCommon = CS.MessageCommon
UINFactoryOrderListItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_factoryItem, self, self.OnClick)
  self.item = (UINBaseItemWithCount.New)()
  ;
  (self.item):Init((self.ui).obj_itemWithCount)
end

UINFactoryOrderListItem.SetValueChangeCallback = function(self, callback)
  -- function num : 0_1
  self.callback = callback
end

UINFactoryOrderListItem.InitOrderListItem = function(self, orderData)
  -- function num : 0_2 , upvalues : _ENV
  self.orderData = orderData
  self.orderCfg = orderData.cfg
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((self.orderCfg).name)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Energy).text = tostring(orderData.energyCost)
  local itemCfg = (ConfigData.item)[(self.orderCfg).outPutItemId]
  ;
  (self.item):InitItemWithCount(itemCfg, 0, nil)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Detail).text = (LanguageUtil.GetLocaleText)(itemCfg.describe)
  self.isUnlcok = (CheckCondition.CheckLua)((self.orderCfg).pre_condition, (self.orderCfg).pre_para1, (self.orderCfg).pre_para2)
  ;
  ((self.ui).obj_lock):SetActive(not self.isUnlcok)
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R3 in 'UnsetPending'

  if not self.isUnlcok then
    ((self.ui).tex_Contidion).text = (CheckCondition.GetUnlockInfoLua)((self.orderCfg).pre_condition, (self.orderCfg).pre_para1, (self.orderCfg).pre_para2)
  end
  self:RefreshWarehousNum()
end

UINFactoryOrderListItem.RefreshWarehousNum = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local itemWarehouseNum = PlayerDataCenter:GetItemCount((self.orderCfg).outPutItemId, false)
  ;
  (self.item):SetNum(itemWarehouseNum, true)
end

UINFactoryOrderListItem.OnClick = function(self)
  -- function num : 0_4 , upvalues : cs_MessageCommon, _ENV
  if not self.isUnlcok then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Factory_OrderUnlock))
    return 
  end
  ;
  (self.callback)(self)
end

UINFactoryOrderListItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINFactoryOrderListItem

