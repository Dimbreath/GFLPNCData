-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_26 = class("bs_26", bs_1)
local base = bs_1
bs_26.config = {effectId1 = 10400, effectId2 = 10400, action1 = 1004, action2 = 1004}
bs_26.config = setmetatable(bs_26.config, {__index = base.config})
bs_26.ctor = function(self)
  -- function num : 0_0
end

bs_26.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_26.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_26

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_26 = class("bs_26", bs_1)
local base = bs_1
bs_26.config = {
    effectId1 = 10400,
    effectId2 = 10400,
    action1 = 1004,
    action2 = 1004
}
bs_26.config = setmetatable(bs_26.config, {__index = base.config})
bs_26.ctor = function(self)
    -- function num : 0_0
end

bs_26.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_26.OnCasterDie = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_26

