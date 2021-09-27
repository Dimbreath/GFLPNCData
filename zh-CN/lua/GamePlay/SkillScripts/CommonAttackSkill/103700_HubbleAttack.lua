local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_103700 = class("bs_103700", bs_1)
local base = bs_1
bs_103700.config = {effectId_trail = 10325, effectId_start3 = 10327, effectId_start4 = 10328, audioId1 = 284, audioId2 = 285, audioId5 = 344}
bs_103700.config = setmetatable(bs_103700.config, {__index = base.config})
bs_103700.ctor = function(self)
  -- function num : 0_0
end

bs_103700.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_103700.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103700

