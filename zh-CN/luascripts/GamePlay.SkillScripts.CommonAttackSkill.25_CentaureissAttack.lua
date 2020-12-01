-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_25 = class("bs_25", bs_1)
local base = bs_1
bs_25.config = {effectId1 = 10462, effectId2 = 10463, effectId3 = 10464, baseActionSpd = 1.36}
bs_25.config = setmetatable(bs_25.config, {__index = base.config})
bs_25.ctor = function(self)
  -- function num : 0_0
end

bs_25.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_25.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_25

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_25 = class("bs_25", bs_1)
local base = bs_1
bs_25.config = {
    effectId1 = 10462,
    effectId2 = 10463,
    effectId3 = 10464,
    baseActionSpd = 1.36
}
bs_25.config = setmetatable(bs_25.config, {__index = base.config})
bs_25.ctor = function(self)
    -- function num : 0_0
end

bs_25.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_25.OnCasterDie = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_25

