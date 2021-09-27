local bs_10206 = class("bs_10206", LuaSkillBase)
local base = LuaSkillBase
bs_10206.config = {buffId = 195, effectId = 134, 
realDamageConfig = {basehurt_formula = 10072}
, nEffectId = 10756, nEffectId2 = 10757}
bs_10206.ctor = function(self)
  -- function num : 0_0
end

bs_10206.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10206_3", 3, self.OnAfterPlaySkill)
  self.time = 0
end

bs_10206.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if skill.maker == self.caster and skill.isCommonAttack then
    if (self.arglist)[2] - 1 <= self.time then
      self.time = 0
      LuaSkillCtrl:CallBuff(self, ((self.caster).recordTable).lastAttackRole, (self.config).buffId, (self.arglist)[1], 75)
    else
      self.time = self.time + 1
    end
  end
end

bs_10206.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_10206.LuaDispose = function(self)
  -- function num : 0_4 , upvalues : base
  (base.LuaDispose)(self)
  self.effect = nil
end

return bs_10206

