-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_13 = class("bs_13", bs_1)
local base = bs_1
bs_13.config = {effectId3 = 10201}
bs_13.config = setmetatable(bs_13.config, {__index = base.config})
bs_13.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_0 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_13.OnCasterDie = function(self)
    -- function num : 0_1 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_13

