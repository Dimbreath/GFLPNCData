-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_4005 = class("bs_4005", LuaSkillBase)
local base = LuaSkillBase
bs_4005.config = {buffId = 81, buffTier = 18}
bs_4005.ctor = function(self)
    -- function num : 0_0
end

bs_4005.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_4005_1", 1,
                    self.OnAfterBattleStart)
end

bs_4005.OnAfterBattleStart = function(self)
    -- function num : 0_2 , upvalues : _ENV
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId,
                          (self.config).buffTier)
end

bs_4005.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_4005

