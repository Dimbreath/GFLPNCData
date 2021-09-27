local UINMsgCommonItem = class("UINMsgCommonItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
UINMsgCommonItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.baseItem = (UINBaseItem.New)()
  ;
  (self.baseItem):Init((self.ui).obj_uINBaseItem)
end

UINMsgCommonItem.InitMsgCommonItem = function(self, itemCfg, costNum, itemNum)
  -- function num : 0_1 , upvalues : _ENV
  (self.baseItem):InitBaseItem(itemCfg, function()
    -- function num : 0_1_0
  end
)
  if costNum ~= nil then
    local containNum = PlayerDataCenter:GetItemCount(itemCfg.id)
    local enough = costNum <= containNum
    ;
    ((self.ui).tex_ExtrCount):SetIndex(enough and 0 or 2, tostring(costNum), tostring(containNum))
  else
    ((self.ui).tex_ExtrCount):SetIndex(1, tostring(itemNum))
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UINMsgCommonItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (self.baseItem):Delete()
  ;
  (base.OnDelete)(self)
end

return UINMsgCommonItem

