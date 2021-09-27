local UINItemWithCost = class("UINItemWithCost", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
UINItemWithCost.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.baseItem = (UINBaseItem.New)()
  ;
  (self.baseItem):Init((self.ui).uINBaseItem)
end

UINItemWithCost.InitItemWithCost = function(self, itemCfg, costNum, containNum, clickFunc)
  -- function num : 0_1
  (self.baseItem):InitBaseItem(itemCfg, clickFunc)
  self.itemCfg = itemCfg
  self.costNum = costNum
  self:RefreshItemWithCost(containNum)
end

UINItemWithCost.RefreshItemWithCost = function(self, containNum)
  -- function num : 0_2 , upvalues : _ENV
  if containNum == nil then
    containNum = PlayerDataCenter:GetItemCount((self.itemCfg).id)
  end
  local enough = self.costNum <= containNum
  ;
  ((self.ui).tex_ConsumeCount):SetIndex(enough and 0 or 1, tostring(self.costNum), tostring(containNum))
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINItemWithCost.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (self.baseItem):Delete()
  ;
  (base.OnDelete)(self)
end

return UINItemWithCost

