-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10039 = class("bs_10039", LuaSkillBase)
local base = LuaSkillBase
bs_10039.config = {buffId = 26, buffTier = 1}
bs_10039.ctor = function(self)
    -- function num : 0_0
end

bs_10039.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId,
                          (self.config).buffTier, (self.arglist)[1])
end

bs_10039.OnCasterDie = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10039

