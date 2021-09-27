local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_101600 = class("bs_101600", bs_1)
local base = bs_1
bs_101600.config = {effectId_trail = 101601, audioId1 = 57, audioId2 = 57}
bs_101600.config = setmetatable(bs_101600.config, {__index = base.config})
bs_101600.ctor = function(self)
  -- function num : 0_0
end

bs_101600.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_101600.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101600

