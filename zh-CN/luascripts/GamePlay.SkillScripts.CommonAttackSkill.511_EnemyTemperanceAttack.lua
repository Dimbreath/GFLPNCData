-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_511 = class("bs_511", bs_1)
local base = bs_1
bs_511.config = {effectId = 10218}
bs_511.config = setmetatable(bs_511.config, {__index = base.config})
bs_511.ctor = function(self)
    -- function num : 0_0
end

bs_511.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_511.OnCasterDie = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_511

