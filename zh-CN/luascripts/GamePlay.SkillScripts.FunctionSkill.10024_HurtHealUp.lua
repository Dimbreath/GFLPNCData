-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10024 = class("bs_10024", LuaSkillBase)
local base = LuaSkillBase
bs_10024.config = {healBuffId = 72, injuredBuffId = 73}
bs_10024.ctor = function(self)
  -- function num : 0_0
end

bs_10024.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10024_1", 1, self.OnAfterBattleStart)
end

bs_10024.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).healBuffId, (self.arglist)[1])
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).injuredBuffId, (self.arglist)[2])
end

bs_10024.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10024

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10024 = class("bs_10024", LuaSkillBase)
local base = LuaSkillBase
bs_10024.config = {healBuffId = 72, injuredBuffId = 73}
bs_10024.ctor = function(self)
    -- function num : 0_0
end

bs_10024.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10024_1", 1,
                    self.OnAfterBattleStart)
end

bs_10024.OnAfterBattleStart = function(self)
    -- function num : 0_2 , upvalues : _ENV
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).healBuffId,
                          (self.arglist)[1])
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).injuredBuffId,
                          (self.arglist)[2])
end

bs_10024.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10024

