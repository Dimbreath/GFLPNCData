local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_103400 = class("bs_103400", bs_1)
local base = bs_1
bs_103400.config = {effectId_trail = 10798, effectId_start1 = 10453, effectId_start2 = 10453, action1 = 1021, action2 = 1021, audioId1 = 276, audioId2 = 276, audioId5 = 277}
bs_103400.config = setmetatable(bs_103400.config, {__index = base.config})
bs_103400.ctor = function(self)
  -- function num : 0_0
end

bs_103400.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_103400.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103400

