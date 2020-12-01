-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_11 = class("bs_11", bs_1)
local base = bs_1
bs_11.config = {effectId = 10186, effectStartId = nil, audioId1 = 57, audioId2 = 57}
bs_11.config = setmetatable(bs_11.config, {__index = base.config})
bs_11.ctor = function(self)
  -- function num : 0_0
end

bs_11.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_11.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_11

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_11 = class("bs_11", bs_1)
local base = bs_1
bs_11.config = {
    effectId = 10186,
    effectStartId = nil,
    audioId1 = 57,
    audioId2 = 57
}
bs_11.config = setmetatable(bs_11.config, {__index = base.config})
bs_11.ctor = function(self)
    -- function num : 0_0
end

bs_11.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_11.OnCasterDie = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_11

