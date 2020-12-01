-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10206 = class("bs_10206", LuaSkillBase)
local base = LuaSkillBase
bs_10206.config = {buffId = 195, effectId = 134, 
realDamageConfig = {basehurt_formula = 10072}
}
bs_10206.ctor = function(self)
  -- function num : 0_0
end

bs_10206.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10206_3", 1, self.OnAfterHurt)
end

bs_10206.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and not isMiss and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] and (self.arglist)[2] > 0 and (self.arglist)[3] > 0 then
    self:PlayChipEffect()
    local tier = (self.arglist)[2]
    local time = (self.arglist)[3]
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, tier, time)
  end
end

bs_10206.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10206

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10206 = class("bs_10206", LuaSkillBase)
local base = LuaSkillBase
bs_10206.config = {
    buffId = 195,
    effectId = 134,
    realDamageConfig = {basehurt_formula = 10072}
}
bs_10206.ctor = function(self)
    -- function num : 0_0
end

bs_10206.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10206_3", 1,
                    self.OnAfterHurt)
end

bs_10206.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                                isCrit, isRealDmg)
    -- function num : 0_2 , upvalues : _ENV
    if sender == self.caster and skill.isCommonAttack and not isMiss and
        LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[1] and
        (self.arglist)[2] > 0 and (self.arglist)[3] > 0 then
        self:PlayChipEffect()
        local tier = (self.arglist)[2]
        local time = (self.arglist)[3]
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId, tier, time)
    end
end

bs_10206.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10206

