-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40023 = class("bs_40023", LuaSkillBase)
local base = LuaSkillBase
bs_40023.config = {}
bs_40023.ctor = function(self)
    -- function num : 0_0
end

bs_40023.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_40023.OnCasterDie = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_40023

