local bs_100903 = class("bs_100903", LuaSkillBase)
local base = LuaSkillBase
bs_100903.config = {movieEndRoleActionId = 1002}
bs_100903.ctor = function(self)
  -- function num : 0_0
end

bs_100903.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_100903.PlaySkill = function(self, data)
  -- function num : 0_2
  self:CallCasterWait(20)
end

bs_100903.PlayUltEffect = function(self)
  -- function num : 0_3 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_100903.OnUltRoleAction = function(self)
  -- function num : 0_4 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 15, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_100903.OnMovieFadeOut = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnMovieFadeOut)(self)
end

bs_100903.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100903

