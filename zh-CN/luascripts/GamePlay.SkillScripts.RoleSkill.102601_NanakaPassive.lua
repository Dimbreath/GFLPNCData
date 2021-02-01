-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102601 = class("bs_102601", LuaSkillBase)
local base = LuaSkillBase
bs_102601.config = {effectId = 10725, effectId2 = 10726, buffId = 231}
bs_102601.ctor = function(self)
  -- function num : 0_0
end

bs_102601.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_102601_12", 1, self.OnAfterPlaySkill)
  self:AddSelfTrigger(eSkillTriggerType.BuffDie, "bs_102601_11", 1, self.OnBuffDie)
end

bs_102601.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if role == self.caster and skill.isCommonAttack then
    if self.effect == nil then
      self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
    end
    local tier = (self.caster):GetBuffTier((self.config).buffId)
    if tier > 0 then
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0, true)
    end
    tier = (Mathf.Min)(tier, (self.arglist)[4] - 1)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, tier + 1, (self.arglist)[5])
  end
end

bs_102601.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_3
  if target == self.caster and buff.dataId == (self.config).buffId and target:GetBuffTier((self.config).buffId) == 0 and self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
end

bs_102601.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102601

