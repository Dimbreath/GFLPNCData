-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202002 = class("bs_202002", LuaSkillBase)
local base = LuaSkillBase
bs_202002.config = {
hurtconfig = {basehurt_formula = 10031}
, effectId1 = nil, effectId2 = 10495, effectId3 = 10496, effectId4 = 10497, effectId5 = 10498}
bs_202002.ctor = function(self)
  -- function num : 0_0
end

bs_202002.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_202002_3", 1, self.OnAfterHurt)
end

bs_202002.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if target == self.caster and isMiss then
    if effectId1 ~= nil then
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
    end
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self)
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId3, self)
    LuaSkillCtrl:CallEffect(sender, (self.config).effectId4, self)
    LuaSkillCtrl:CallEffect(sender, (self.config).effectId5, self)
    LuaSkillCtrl:StartTimer(self, 9, function()
    -- function num : 0_2_0 , upvalues : _ENV, self, sender
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, sender)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurtconfig)
    skillResult:EndResult()
  end
, self)
  end
end

bs_202002.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_202002

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_202002 = class("bs_202002", LuaSkillBase)
local base = LuaSkillBase
bs_202002.config = {
    hurtconfig = {basehurt_formula = 10031},
    effectId1 = nil,
    effectId2 = 10495,
    effectId3 = 10496,
    effectId4 = 10497,
    effectId5 = 10498
}
bs_202002.ctor = function(self)
    -- function num : 0_0
end

bs_202002.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_202002_3", 1,
                    self.OnAfterHurt)
end

bs_202002.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                                 isCrit, isRealDmg)
    -- function num : 0_2 , upvalues : _ENV
    if target == self.caster and isMiss then
        if effectId1 ~= nil then
            LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
        end
        LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self)
        LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId3, self)
        LuaSkillCtrl:CallEffect(sender, (self.config).effectId4, self)
        LuaSkillCtrl:CallEffect(sender, (self.config).effectId5, self)
        LuaSkillCtrl:StartTimer(self, 9, function()
            -- function num : 0_2_0 , upvalues : _ENV, self, sender
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self,
                                                                     sender)
            LuaSkillCtrl:HurtResult(skillResult, (self.config).hurtconfig)
            skillResult:EndResult()
        end, self)
    end
end

bs_202002.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_202002

