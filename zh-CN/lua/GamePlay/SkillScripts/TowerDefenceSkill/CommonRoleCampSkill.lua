local CommonRoleCampSkill = class("CommonRoleCampSkill", LuaSkillBase)
local base = LuaSkillBase
CommonRoleCampSkill.config = {}
CommonRoleCampSkill.OnCasterDie = function(self)
  -- function num : 0_0 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  LuaSkillCtrl:ForceEndBattle(false)
end

return CommonRoleCampSkill

