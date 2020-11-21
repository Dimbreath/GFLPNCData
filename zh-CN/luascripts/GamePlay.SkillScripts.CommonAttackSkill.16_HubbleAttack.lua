-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_16 = class("bs_16", bs_1)
local base = bs_1
bs_16.config = {effectId = 10325, effectStartId = 10327, effectStartId3 = 10328}
bs_16.config = setmetatable(bs_16.config, {__index = base.config})
bs_16.ctor = function(self)
    -- function num : 0_0
end

bs_16.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_16.OnCasterDie = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_16

