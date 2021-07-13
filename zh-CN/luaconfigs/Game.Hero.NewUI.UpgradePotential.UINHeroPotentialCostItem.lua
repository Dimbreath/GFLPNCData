-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroPotentialCostItem = class("UINHeroPotentialCostItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
UINHeroPotentialCostItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.baseItem = (UINBaseItem.New)()
  ;
  (self.baseItem):Init((self.ui).obj_uINBaseItem)
end

UINHeroPotentialCostItem.InitCostInfo = function(self, itemId, needCount)
  -- function num : 0_1 , upvalues : _ENV
  local localFunc = function()
    -- function num : 0_1_0 , upvalues : _ENV, itemId
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(window)
      -- function num : 0_1_0_0 , upvalues : _ENV, itemId
      window:InitCommonItemDetail((ConfigData.item)[itemId], nil)
    end
)
  end

  ;
  (self.baseItem):InitBaseItem((ConfigData.item)[itemId], localFunc)
  local hasCount = PlayerDataCenter:GetItemCount(itemId)
  local textId = needCount <= hasCount and 0 or 2
  ;
  ((self.ui).tex_ExtrCount):SetIndex(textId, tostring(needCount), tostring(hasCount))
end

return UINHeroPotentialCostItem

