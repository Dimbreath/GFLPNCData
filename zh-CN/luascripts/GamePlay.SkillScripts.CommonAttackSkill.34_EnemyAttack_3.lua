-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_34 = class("bs_34", bs_1)
local base = bs_1
bs_34.config = {targetSelect = 10}
bs_34.config = setmetatable(bs_34.config, {__index = base.config})
bs_34.ctor = function(self)
    -- function num : 0_0
end

bs_34.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_34.OnCasterDie = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_34

