local UINFactoryOrderListItem = class("UINFactoryOrderListItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_MessageCommon = CS.MessageCommon
local FactoryHelper = require("Game.Factory.FactoryHelper")
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

UINFactoryOrderListItem.InitOrderListItem = function(self, orderData, couldProdunc)
  -- function num : 0_2 , upvalues : _ENV, FactoryHelper
  self.orderData = orderData
  self.orderCfg = orderData:GetOrderCfg()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((self.orderCfg).name)
  local costTime = orderData:GetTimeCost()
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_CostTime).text = (FactoryHelper.ConvertTime2DisplayMode)(costTime)
  local itemCfg = (ConfigData.item)[(self.orderCfg).outPutItemId]
  ;
  (self.item):InitItemWithCount(itemCfg, 0, nil)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Detail).text = (LanguageUtil.GetLocaleText)(itemCfg.describe)
  self.isUnlcok = (CheckCondition.CheckLua)((self.orderCfg).pre_condition, (self.orderCfg).pre_para1, (self.orderCfg).pre_para2)
  ;
  ((self.ui).obj_lock):SetActive(not self.isUnlcok)
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R5 in 'UnsetPending'

  if not self.isUnlcok then
    ((self.ui).tex_Contidion).text = (CheckCondition.GetUnlockInfoLua)((self.orderCfg).pre_condition, (self.orderCfg).pre_para1, (self.orderCfg).pre_para2)
  end
  self:RefreshCouldProdunc(couldProdunc)
  self:RefreshWarehousNum()
end

UINFactoryOrderListItem.RefreshWarehousNum = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local itemWarehouseNum = PlayerDataCenter:GetItemCount((self.orderCfg).outPutItemId, false)
  ;
  (self.item):SetNum(itemWarehouseNum, true)
end

UINFactoryOrderListItem.RefreshCouldProdunc = function(self, couldProdunc)
  -- function num : 0_4
  if not (self.orderData):GetIsUnlock() then
    ((self.ui).obj_cannotProduce):SetActive(false)
  else
    ;
    ((self.ui).obj_cannotProduce):SetActive(not couldProdunc)
  end
end

UINFactoryOrderListItem.OnClick = function(self)
  -- function num : 0_5 , upvalues : cs_MessageCommon, _ENV
  if not self.isUnlcok then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Factory_OrderUnlock))
    return 
  end
  ;
  (self.callback)(self)
end

UINFactoryOrderListItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINFactoryOrderListItem

