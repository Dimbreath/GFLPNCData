-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10161 = class("bs_10161", LuaSkillBase)
local base = LuaSkillBase
bs_10161.config = {buffId = 1043}
bs_10161.ctor = function(self)
  -- function num : 0_0
end

bs_10161.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHeal, "bs_10161_5", 1, self.OnAfterHeal)
end

bs_10161.OnAfterHeal = function(self, sender, target, skill, heal)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and LuaSkillCtrl:CallRange(1, 1000) < (self.arglist)[3] then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1], (self.arglist)[2])
  end
end

bs_10161.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10161

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10161 = class("bs_10161", LuaSkillBase)
local base = LuaSkillBase
bs_10161.config = {buffId = 1043}
bs_10161.ctor = function(self)
    -- function num : 0_0
end

bs_10161.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterHeal, "bs_10161_5", 1,
                    self.OnAfterHeal)
end

bs_10161.OnAfterHeal = function(self, sender, target, skill, heal)
    -- function num : 0_2 , upvalues : _ENV
    if sender == self.caster and LuaSkillCtrl:CallRange(1, 1000) <
        (self.arglist)[3] then
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId,
                              (self.arglist)[1], (self.arglist)[2])
    end
end

bs_10161.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10161

