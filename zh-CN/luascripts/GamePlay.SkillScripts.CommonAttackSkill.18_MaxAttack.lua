-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_18 = class("bs_18", bs_1)
local base = bs_1
bs_18.config = {effectId = 10360, effectStartId = 10359, effectStartId3 = 10359}
bs_18.config = setmetatable(bs_18.config, {__index = base.config})
bs_18.ctor = function(self)
  -- function num : 0_0
end

bs_18.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_18.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_18

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_18 = class("bs_18", bs_1)
local base = bs_1
bs_18.config = {effectId = 10360, effectStartId = 10359, effectStartId3 = 10359}
bs_18.config = setmetatable(bs_18.config, {__index = base.config})
bs_18.ctor = function(self)
    -- function num : 0_0
end

bs_18.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_18.OnCasterDie = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_18

