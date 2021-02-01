-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_203101 = class("bs_203101", LuaSkillBase)
local base = LuaSkillBase
bs_203101.config = {effectId = 10594, buffId = 208}
bs_203101.ctor = function(self)
  -- function num : 0_0
end

bs_203101.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_203101_11", 1, self.OnAfterPlaySkill)
end

bs_203101.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if role.camp == (self.caster).camp and role.belongNum == (self.caster).belongNum and not skill.isCommonAttack then
    if role ~= self.caster then
      LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
    end
    LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, 1, (self.arglist)[1])
  end
end

bs_203101.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_203101

