-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101801 = class("bs_101801", LuaSkillBase)
local base = LuaSkillBase
bs_101801.config = {buffId_25 = 25, buffId_218 = 218, buffId_220 = 220, effectId_pas = 10669, buffId_248 = 248}
bs_101801.ctor = function(self)
  -- function num : 0_0
end

bs_101801.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_101801_3", 1, self.OnAfterHurt, self.caster)
  self:AddTrigger(eSkillTriggerType.BuffDie, "bs_101801_9", 1, self.OnBuffDie)
  self.time = 0
end

bs_101801.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack then
    self.time = self.time + 1
  end
  if (self.arglist)[1] <= self.time and LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, (self.caster).attackRange) then
    self.time = 0
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_25, 1, (self.arglist)[2])
    LuaSkillCtrl:StartTimer(self, 1, function()
    -- function num : 0_2_0 , upvalues : target, self, _ENV
    if target:GetBuffTier((self.config).buffId_25) > 0 then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_218, 1, (self.arglist)[2] + 2, true)
      if (self.arglist)[3] > 0 then
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_248, 1, (self.arglist)[2] + 2, true)
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_220, 1, nil, true)
      end
    end
  end
)
  end
end

bs_101801.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_3 , upvalues : _ENV
  if buff.dataId == (self.config).buffId_25 and target:GetBuffTier(self.buffId_218) > 0 then
    LuaSkillCtrl:DispelBuff(target, (self.config).buffId_218, 0)
    LuaSkillCtrl:DispelBuff(target, (self.config).buffId_248, 0)
  end
end

bs_101801.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101801

