-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10134 = class("bs_10134", LuaSkillBase)
local base = LuaSkillBase
bs_10134.config = {buffId = 1019}
bs_10134.ctor = function(self)
  -- function num : 0_0
end

bs_10134.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforePlaySkill, "bs_10134_1", 1, self.OnBeforePlaySkill)
end

bs_10134.OnBeforePlaySkill = function(self, role, context)
  -- function num : 0_2 , upvalues : _ENV
  if role == self.caster then
    local tier = (self.caster).def * (self.arglist)[1] // 1000
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, tier)
  end
end

bs_10134.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10134

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10134 = class("bs_10134", LuaSkillBase)
local base = LuaSkillBase
bs_10134.config = {buffId = 1019}
bs_10134.ctor = function(self)
    -- function num : 0_0
end

bs_10134.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.BeforePlaySkill, "bs_10134_1", 1,
                    self.OnBeforePlaySkill)
end

bs_10134.OnBeforePlaySkill = function(self, role, context)
    -- function num : 0_2 , upvalues : _ENV
    if role == self.caster then
        local tier = (self.caster).def * (self.arglist)[1] // 1000
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, tier)
    end
end

bs_10134.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10134

