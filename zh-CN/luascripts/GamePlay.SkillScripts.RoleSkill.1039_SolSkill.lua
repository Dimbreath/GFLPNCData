-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1039 = class("bs_1039", LuaSkillBase)
local base = LuaSkillBase
bs_1039.config = {buffId1 = 112, buffId2 = 113, buffId3 = 119, effectId1 = 10087, effectId2 = 10086, effectId3 = 10165, audioId1 = 38, 
realDamageConfig = {basehurt_formula = 10062}
}
bs_1039.ctor = function(self)
  -- function num : 0_0
end

bs_1039.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_1039_3", 1, self.OnAfterHurt)
end

bs_1039.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  ((self.caster).auSource):PlayAudioById((self.config).audioId1)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self, nil, nil, nil, nil)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self, nil, nil, nil, nil)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, 1)
  self:CallCasterWait(17)
  LuaSkillCtrl:CallRoleAction(self.caster, 1002)
end

bs_1039.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_3 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and not isMiss and (self.caster):GetBuffTier((self.config).buffId1) ~= 0 then
    LuaSkillCtrl:CallBuffRepeated(self, target, 113, 1, (self.arglist)[4], self.OnBuffExecute)
  end
end

bs_1039.OnBuffExecute = function(self, buff, targetRole)
  -- function num : 0_4 , upvalues : _ENV
  local solhurt = (self.caster).skill_intensity * (self.arglist)[5] // 1000
  if solhurt < 1 then
    solhurt = 1
  end
  LuaSkillCtrl:CallRealDamage(self, targetRole, nil, (self.config).realDamageConfig, {buff.tier}, true)
  LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId3, self)
end

bs_1039.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1039

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1039 = class("bs_1039", LuaSkillBase)
local base = LuaSkillBase
bs_1039.config = {
    buffId1 = 112,
    buffId2 = 113,
    buffId3 = 119,
    effectId1 = 10087,
    effectId2 = 10086,
    effectId3 = 10165,
    audioId1 = 38,
    realDamageConfig = {basehurt_formula = 10062}
}
bs_1039.ctor = function(self)
    -- function num : 0_0
end

bs_1039.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_1039_3", 1,
                    self.OnAfterHurt)
end

bs_1039.PlaySkill = function(self, data)
    -- function num : 0_2 , upvalues : _ENV
    ((self.caster).auSource):PlayAudioById((self.config).audioId1)
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self, nil,
                            nil, nil, nil)
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self, nil,
                            nil, nil, nil)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, 1)
    self:CallCasterWait(17)
    LuaSkillCtrl:CallRoleAction(self.caster, 1002)
end

bs_1039.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                               isCrit, isRealDmg)
    -- function num : 0_3 , upvalues : _ENV
    if sender == self.caster and skill.isCommonAttack and not isMiss and
        (self.caster):GetBuffTier((self.config).buffId1) ~= 0 then
        LuaSkillCtrl:CallBuffRepeated(self, target, 113, 1, (self.arglist)[4],
                                      self.OnBuffExecute)
    end
end

bs_1039.OnBuffExecute = function(self, buff, targetRole)
    -- function num : 0_4 , upvalues : _ENV
    local solhurt = (self.caster).skill_intensity * (self.arglist)[5] // 1000
    if solhurt < 1 then solhurt = 1 end
    LuaSkillCtrl:CallRealDamage(self, targetRole, nil,
                                (self.config).realDamageConfig, {buff.tier},
                                true)
    LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId3, self)
end

bs_1039.OnCasterDie = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1039

