-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10041 = class("bs_10041", LuaSkillBase)
local base = LuaSkillBase
bs_10041.config = {buffId = 1011}
bs_10041.ctor = function(self)
    -- function num : 0_0
end

bs_10041.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId,
                          (self.arglist)[1])
end

bs_10041.OnCasterDie = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10041

