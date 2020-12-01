-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103101 = class("bs_103101", LuaSkillBase)
local base = LuaSkillBase
bs_103101.config = {buffId1 = 172, buffId2 = 173}
bs_103101.ctor = function(self)
  -- function num : 0_0
end

bs_103101.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_103101_3", 1, self.OnAfterHurt)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_103101_12", 1, self.OnAfterPlaySkill)
end

bs_103101.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and skill.isCommonAttack and not isMiss then
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId1, 1, (self.arglist)[3])
    if (self.arglist)[2] > 0 then
      LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, 1, (self.arglist)[3])
    end
  end
end

bs_103101.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_3
end

bs_103101.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103101

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103101 = class("bs_103101", LuaSkillBase)
local base = LuaSkillBase
bs_103101.config = {buffId1 = 172, buffId2 = 173}
bs_103101.ctor = function(self)
    -- function num : 0_0
end

bs_103101.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_103101_3", 1,
                    self.OnAfterHurt)
    self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_103101_12", 1,
                    self.OnAfterPlaySkill)
end

bs_103101.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                                 isCrit, isRealDmg)
    -- function num : 0_2 , upvalues : _ENV
    if sender == self.caster and skill.isCommonAttack and not isMiss then
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId1, 1,
                              (self.arglist)[3])
        if (self.arglist)[2] > 0 then
            LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, 1,
                                  (self.arglist)[3])
        end
    end
end

bs_103101.OnAfterPlaySkill = function(self, skill, role)
    -- function num : 0_3
end

bs_103101.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_103101

