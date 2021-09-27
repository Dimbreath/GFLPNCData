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

UINHeroPotentialCostItem.InitCostInfo = function(self, cfg, needCount)
  -- function num : 0_1 , upvalues : _ENV
  local localFunc = function()
    -- function num : 0_1_0 , upvalues : _ENV, cfg
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(window)
      -- function num : 0_1_0_0 , upvalues : cfg
      window:InitCommonItemDetail(cfg, nil)
    end
)
  end

  ;
  (self.baseItem):InitBaseItem(cfg, localFunc)
  local hasCount = PlayerDataCenter:GetItemCount(cfg.id)
  local textId = needCount <= hasCount and 0 or 2
  ;
  ((self.ui).tex_ExtrCount):SetIndex(textId, tostring(needCount), tostring(hasCount))
end

return UINHeroPotentialCostItem

