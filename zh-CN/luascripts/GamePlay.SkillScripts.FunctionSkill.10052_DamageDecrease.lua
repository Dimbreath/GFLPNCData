-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10052 = class("bs_10052", LuaSkillBase)
local base = LuaSkillBase
bs_10052.config = {buffId = 1015}
bs_10052.ctor = function(self)
  -- function num : 0_0
end

bs_10052.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10052_1", 1, self.OnAfterBattleStart)
end

bs_10052.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1])
end

bs_10052.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10052

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10052 = class("bs_10052", LuaSkillBase)
local base = LuaSkillBase
bs_10052.config = {buffId = 1015}
bs_10052.ctor = function(self)
    -- function num : 0_0
end

bs_10052.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10052_1", 1,
                    self.OnAfterBattleStart)
end

bs_10052.OnAfterBattleStart = function(self)
    -- function num : 0_2 , upvalues : _ENV
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId,
                          (self.arglist)[1])
end

bs_10052.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10052

