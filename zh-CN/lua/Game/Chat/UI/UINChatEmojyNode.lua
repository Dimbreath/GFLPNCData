local UINChatemojiNode = class("UINChatemojiNode", UIBaseNode)
local base = UIBaseNode
UINChatemojiNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINChatemojiNode.OnDelete = function(self)
  -- function num : 0_1 , upvalues : base
  (base.OnDelete)(self)
end

return UINChatemojiNode

