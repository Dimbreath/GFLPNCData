-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_6008 = class("bs_6008", LuaSkillBase)
local base = LuaSkillBase
bs_6008.config = {buffId1 = 128, buffId2 = 129, buffId3 = 197}
bs_6008.ctor = function(self)
  -- function num : 0_0
end

bs_6008.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_6008_3", 1, self.OnAfterHurt)
end

bs_6008.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if target.hp <= 0 and hurt > 0 and sender == self.caster then
    local add_hp = (self.arglist)[1] * target.maxHp // 100
    local add_pow = (self.arglist)[2] * target.pow // 100
    local add_skill_intensity = (self.arglist)[2] * target.skill_intensity // 100
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, add_hp)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, add_pow)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId3, add_skill_intensity)
    LuaSkillCtrl:CallHeal(add_hp, self, self.caster)
  end
end

bs_6008.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_6008

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_6008 = class("bs_6008", LuaSkillBase)
local base = LuaSkillBase
bs_6008.config = {buffId1 = 128, buffId2 = 129, buffId3 = 197}
bs_6008.ctor = function(self)
    -- function num : 0_0
end

bs_6008.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_6008_3", 1,
                    self.OnAfterHurt)
end

bs_6008.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                               isCrit, isRealDmg)
    -- function num : 0_2 , upvalues : _ENV
    if target.hp <= 0 and hurt > 0 and sender == self.caster then
        local add_hp = (self.arglist)[1] * target.maxHp // 100
        local add_pow = (self.arglist)[2] * target.pow // 100
        local add_skill_intensity =
            (self.arglist)[2] * target.skill_intensity // 100
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, add_hp)
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, add_pow)
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId3,
                              add_skill_intensity)
        LuaSkillCtrl:CallHeal(add_hp, self, self.caster)
    end
end

bs_6008.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_6008

