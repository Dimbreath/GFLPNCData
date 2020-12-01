-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_508 = class(" bs_508", bs_1)
local base = bs_1
bs_508.config = {effectId1 = 10121, effectId2 = 10122, audioId1 = 26, audioId2 = 26}
bs_508.config = setmetatable(bs_508.config, {__index = base.config})
bs_508.ctor = function(self)
  -- function num : 0_0
end

bs_508.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_508.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_508

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_508 = class(" bs_508", bs_1)
local base = bs_1
bs_508.config = {
    effectId1 = 10121,
    effectId2 = 10122,
    audioId1 = 26,
    audioId2 = 26
}
bs_508.config = setmetatable(bs_508.config, {__index = base.config})
bs_508.ctor = function(self)
    -- function num : 0_0
end

bs_508.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_508.OnCasterDie = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_508

