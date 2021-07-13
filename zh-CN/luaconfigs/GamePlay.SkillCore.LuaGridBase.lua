-- params : ...
-- function num : 0 , upvalues : _ENV
local LuaGridBase = class("LuaGridBase")
LuaGridBase.ctor = function(self)
  -- function num : 0_0
end

LuaGridBase.__InitGridInternal = function(self, cEffectGrid, x, y)
  -- function num : 0_1
  self.x = x
  self.y = y
  self.cEffectGrid = cEffectGrid
end

LuaGridBase.__OnGridBattleStartInit = function(self, role)
  -- function num : 0_2
  self:__OnGridSkillInit()
  self:OnGridBattleStart(role)
end

LuaGridBase.__OnGridSkillInit = function(self)
  -- function num : 0_3
  self.cskill = (self.cEffectGrid).battleSkill
  self.caster = (self.cskill).maker
end

LuaGridBase.OnGridBattleStart = function(self, role)
  -- function num : 0_4
end

LuaGridBase.OnGridEnterRole = function(self, role)
  -- function num : 0_5
end

LuaGridBase.OnGridExitRole = function(self, role)
  -- function num : 0_6
end

LuaGridBase.OnGridRoleDead = function(self, role)
  -- function num : 0_7
end

LuaGridBase.GridLoseEffect = function(self)
  -- function num : 0_8
  (self.cEffectGrid):GridLoseEffect()
end

LuaGridBase.OnGridBattleEnd = function(self, role)
  -- function num : 0_9
end

LuaGridBase.AddGridTrigger = function(self, triggerType, name, priority, eventFunc)
  -- function num : 0_10 , upvalues : _ENV
  local bindFunc = BindCallback(self, eventFunc)
  LuaSkillCtrl:AddSkillTrigger(triggerType, self.cEffectGrid, eTriggerSkillType.GridSkill, name, priority, bindFunc, false)
end

LuaGridBase.RemoveGridTrigger = function(self, triggerType)
  -- function num : 0_11 , upvalues : _ENV
  LuaSkillCtrl:RemoveTrigger(self.cEffectGrid, triggerType)
end

LuaGridBase.LuaDispose = function(self)
  -- function num : 0_12
  self.cskill = nil
  self.caster = nil
  self.cEffectGrid = nil
end

return LuaGridBase

