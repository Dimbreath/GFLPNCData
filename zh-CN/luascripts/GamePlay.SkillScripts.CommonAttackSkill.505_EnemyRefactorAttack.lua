-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_505 = class("bs_505", bs_1)
local base = bs_1
bs_505.config = {effectId = 10107}
bs_505.config = setmetatable(bs_505.config, {__index = base.config})
bs_505.ctor = function(self)
  -- function num : 0_0
end

bs_505.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_505.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_505

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_505 = class("bs_505", bs_1)
local base = bs_1
bs_505.config = {effectId = 10107}
bs_505.config = setmetatable(bs_505.config, {__index = base.config})
bs_505.ctor = function(self)
    -- function num : 0_0
end

bs_505.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_505.OnCasterDie = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_505

