-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLevelEnemyNode = class("UINLevelEnemyNode", UIBaseNode)
local base = UIBaseNode
UINLevelEnemyNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINLevelEnemyNode.InitInfoNode = function(self, LevelDtail)
  -- function num : 0_1
end

UINLevelEnemyNode.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINLevelEnemyNode

