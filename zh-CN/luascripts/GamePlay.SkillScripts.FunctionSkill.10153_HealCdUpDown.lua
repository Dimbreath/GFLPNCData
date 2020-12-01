-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10153 = class("bs_10153", LuaSkillBase)
local base = LuaSkillBase
bs_10153.config = {buffId1 = 1041, buffId2 = 1042}
bs_10153.ctor = function(self)
  -- function num : 0_0
end

bs_10153.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10153_1", 1, self.OnAfterBattleStart)
end

bs_10153.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, (self.arglist)[1])
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, (self.arglist)[2])
end

bs_10153.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10153

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10153 = class("bs_10153", LuaSkillBase)
local base = LuaSkillBase
bs_10153.config = {buffId1 = 1041, buffId2 = 1042}
bs_10153.ctor = function(self)
    -- function num : 0_0
end

bs_10153.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10153_1", 1,
                    self.OnAfterBattleStart)
end

bs_10153.OnAfterBattleStart = function(self)
    -- function num : 0_2 , upvalues : _ENV
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1,
                          (self.arglist)[1])
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2,
                          (self.arglist)[2])
end

bs_10153.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10153

