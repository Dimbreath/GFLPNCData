local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_505 = class("bs_505", bs_1)
local base = bs_1
bs_505.config = {effectId_1 = 10102, effectId_2 = 10102, action2 = 1001, audioId1 = 19, audioId2 = 19}
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

