local bs_10268 = class("bs_10268", LuaSkillBase)
local base = LuaSkillBase
bs_10268.config = {splitShootBuff = 1180}
bs_10268.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).splitShootBuff, 1, nil, true)
end

bs_10268.OnCasterDie = function(self)
  -- function num : 0_1 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10268

