-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1020 = class("bs_1020", LuaSkillBase)
local base = LuaSkillBase
bs_1020.config = {buffId = 91}
bs_1020.ctor = function(self)
    -- function num : 0_0
end

bs_1020.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1
end

bs_1020.PlaySkill = function(self)
    -- function num : 0_2 , upvalues : _ENV
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId,
                          (self.arglist)[1])
end

bs_1020.OnAfterBattleStart = function(self)
    -- function num : 0_3
end

bs_1020.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1020

