-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10223 = class("bs_10223", LuaSkillBase)
local base = LuaSkillBase
bs_10223.config = {buffId = 1121, buffTier = 1, effectId = 10640}
bs_10223.ctor = function(self)
  -- function num : 0_0
end

bs_10223.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_10223_3", 1, self.OnAfterHurt)
  self.isDouble = false
  self.atknum = 0
end

bs_10223.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and not isTriggerSet then
    local restTier = sender:GetBuffTier((self.config).buffId)
    if LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] and not self.isDouble and restTier == 0 then
      self:PlayChipEffect()
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
      self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
      self.isDouble = true
      self.atknum = 2
    end
    if self.isDouble and restTier ~= 0 then
      if self.atknum > 0 then
        self.atknum = self.atknum - 1
      end
      if self.atknum == 0 then
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0, true)
        if self.effect ~= nil then
          (self.effect):Die()
          self.effect = nil
        end
        self.isDouble = false
      end
    end
  end
end

bs_10223.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10223

