-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101801 = class("bs_101801", LuaSkillBase)
local base = LuaSkillBase
bs_101801.config = {buffId1 = 217, buffId2 = 25, buffId3 = 218, buffId4 = 220, effectId = 10669}
bs_101801.ctor = function(self)
  -- function num : 0_0
end

bs_101801.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterHurt, "bs_101801_3", 1, self.OnAfterHurt)
  self:AddTrigger(eSkillTriggerType.BuffDie, "bs_101801_9", 1, self.OnBuffDie)
end

bs_101801.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and not isMiss then
    local time = (self.arglist)[1]
    if target:GetBuffTier((self.config).buffId1) < time and target:GetBuffTier((self.config).buffId2) == 0 then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId1, 1, nil, true)
    end
    if target:GetBuffTier((self.config).buffId1) == time then
      LuaSkillCtrl:DispelBuff(target, (self.config).buffId1, 0)
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId2, 1, (self.arglist)[2])
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffId3, 1, (self.arglist)[2], true)
      LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
      if (self.arglist)[3] > 0 then
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId4, 1, nil, true)
      end
    end
  end
end

bs_101801.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_3 , upvalues : _ENV
  if buff.dataId == (self.config).buffId2 and target:GetBuffTier(self.buffId3) > 0 then
    LuaSkillCtrl:DispelBuff(target, (self.config).buffId3, 0)
  end
end

bs_101801.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101801

