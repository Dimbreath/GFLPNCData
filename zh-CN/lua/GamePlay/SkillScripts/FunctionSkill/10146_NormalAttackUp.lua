local bs_10146 = class("bs_10146", LuaSkillBase)
local base = LuaSkillBase
bs_10146.config = {buffId = 1028, buffTier = 1, atkBuffId = 1030}
bs_10146.ctor = function(self)
  -- function num : 0_0
end

bs_10146.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10146_1", 2, self.OnAfterPlaySkill)
  self:AddSetHurtTrigger("bs_10146_3", 3, self.OnSetHurt, self.caster)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10146_NormalAttakTime"] = 0
end

bs_10146.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  if skill.maker == self.caster and skill.isCommonAttack then
    ((self.caster).recordTable)["10146_NormalAttakTime"] = ((self.caster).recordTable)["10146_NormalAttakTime"] + 1
  end
end

bs_10146.OnSetHurt = function(self, context)
  -- function num : 0_3 , upvalues : _ENV
  if context.sender == self.caster and (context.skill).isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).atkBuffId, (self.arglist)[1], nil, true)
  end
end

bs_10146.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10146

