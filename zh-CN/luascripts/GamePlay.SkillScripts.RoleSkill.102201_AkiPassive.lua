-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202201 = class("bs_202201", LuaSkillBase)
local base = LuaSkillBase
bs_202201.config = {buffId1 = 224, buffId2 = 225, buffId3 = 226}
bs_202201.ctor = function(self)
  -- function num : 0_0
end

bs_202201.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_202201_1", 1, self.OnAfterBattleStart)
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_202201_3", 1, self.OnAfterHurt)
end

bs_202201.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, 1)
end

bs_202201.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack then
    if not isCrit then
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, 1, nil, true)
    end
    if isCrit then
      if (self.caster):GetBuffTier((self.config).buffId2) > 0 then
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId2, 0, true)
      end
      if (self.arglist)[3] > 0 then
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId3, 1, (self.arglist)[5])
      end
    end
  end
end

bs_202201.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202201

