-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102201 = class("bs_102201", LuaSkillBase)
local base = LuaSkillBase
bs_102201.config = {buffId_224 = 224, buffId_225 = 225, buffId_226 = 226}
bs_102201.ctor = function(self)
  -- function num : 0_0
end

bs_102201.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_102201_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_102201_3", 1, self.OnAfterHurt, self.caster)
end

bs_102201.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_224, 1)
end

bs_102201.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack then
    if not isCrit then
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_225, 1, nil, true)
    end
    if isCrit then
      if (self.caster):GetBuffTier((self.config).buffId_225) > 0 then
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_225, 0, true)
      end
      if (self.arglist)[3] > 0 then
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_226, 1, (self.arglist)[4])
      end
    end
  end
end

bs_102201.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102201

