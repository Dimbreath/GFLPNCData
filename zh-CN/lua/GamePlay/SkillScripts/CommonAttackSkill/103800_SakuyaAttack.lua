local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_103800 = class("bs_103800", bs_1)
local base = bs_1
bs_103800.config = {effectId_start1 = 10386, effectId_start2 = 10387, effectId_trail = 10796, effectId_trail_ex = 10805, audioId1 = 290, audioId2 = 291, audioId4 = 292}
bs_103800.config = setmetatable(bs_103800.config, {__index = base.config})
bs_103800.ctor = function(self)
  -- function num : 0_0
end

bs_103800.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_103800.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103800

