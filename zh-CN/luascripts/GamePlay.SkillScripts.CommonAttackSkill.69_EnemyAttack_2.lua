-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_69 = class("bs_69", bs_1)
local base = bs_1
bs_69.config = {effectId = 88}
bs_69.config = setmetatable(bs_69.config, {__index = base.config})
bs_69.ctor = function(self)
  -- function num : 0_0
end

bs_69.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_69.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_69

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_69 = class("bs_69", bs_1)
local base = bs_1
bs_69.config = {effectId = 88}
bs_69.config = setmetatable(bs_69.config, {__index = base.config})
bs_69.ctor = function(self)
    -- function num : 0_0
end

bs_69.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_69.OnCasterDie = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_69

