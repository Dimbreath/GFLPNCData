-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_5 = class("bs_5", bs_1)
local base = bs_1
bs_5.config = {effectStartId = nil, effectId = 10038, audioId1 = 11, audioId2 = 11}
bs_5.config = setmetatable(bs_5.config, {__index = base.config})
bs_5.ctor = function(self)
  -- function num : 0_0
end

bs_5.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_5.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5

