-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10221 = class("bs_10221", LuaSkillBase)
local base = LuaSkillBase
bs_10221.config = {buffId1 = 1078, buffId2 = 1079, buffTier = 1, buffId = 195}
bs_10221.ctor = function(self)
  -- function num : 0_0
end

bs_10221.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10221_1", 1, self.OnAfterBattleStart)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_10221_2", 1, self.OnHurtResultStart)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultEnd, "bs_10221_15", 1, self.OnHurtResultEnd)
end

bs_10221.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, (self.config).buffTier, nil, true)
end

bs_10221.OnHurtResultStart = function(self, skill, context)
  -- function num : 0_3 , upvalues : _ENV
  if skill.maker == self.caster and not skill.isCommonAttack and not context.isTriggerSet then
    local restTier = (context.target):GetBuffTier((self.config).buffId)
    if restTier > 0 then
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, restTier, nil, true)
    end
  end
end

bs_10221.OnHurtResultEnd = function(self, skill, targetRole, hurtValue)
  -- function num : 0_4 , upvalues : _ENV
  if skill.maker == self.caster and not skill.isCommonAttack then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId2, 0, true)
  end
end

bs_10221.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10221

