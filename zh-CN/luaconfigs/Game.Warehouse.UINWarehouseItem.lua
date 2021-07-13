-- params : ...
-- function num : 0 , upvalues : _ENV
local UINWarehouseItem = class("UINWarehouseItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
UINWarehouseItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.item = (UINBaseItemWithCount.New)()
  ;
  (self.item):Init((self.ui).uINBaseItemWithCount)
end

UINWarehouseItem.InitWarehouseItem = function(self, itemCfg, count, clickEvent, wareHouseNum)
  -- function num : 0_1 , upvalues : _ENV
  self.itemCfg = itemCfg
  ;
  (self.item):InitItemWithCount(itemCfg, count, clickEvent, wareHouseNum, BindCallback(self, self.OnClickExtra))
  self:RefreshRedDotState()
end

UINWarehouseItem.RefreshRedDotState = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Warehouse, (self.itemCfg).warehouse_page, (self.itemCfg).id)
  if node:GetRedDotCount() <= 0 then
    ((self.ui).blueDot):SetActive(not ok)
    ;
    ((self.ui).blueDot):SetActive(false)
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

UINWarehouseItem.OnClickExtra = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Warehouse, (self.itemCfg).warehouse_page, (self.itemCfg).id)
  if ok and node:GetRedDotCount() > 0 then
    node:SetRedDotCount(0)
  end
end

UINWarehouseItem.SetNum = function(self, num)
  -- function num : 0_4
  (self.item):SetNum(num)
end

return UINWarehouseItem

