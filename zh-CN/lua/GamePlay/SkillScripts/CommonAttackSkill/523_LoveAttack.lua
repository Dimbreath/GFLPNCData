local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_523 = class("bs_523", bs_1)
local base = bs_1
bs_523.config = {effectId_action_1 = 10489, effectId_action_2 = 10490, effectId_trail = 10487}
bs_523.config = setmetatable(bs_523.config, {__index = base.config})
bs_523.ctor = function(self)
  -- function num : 0_0
end

bs_523.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_523.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_523

