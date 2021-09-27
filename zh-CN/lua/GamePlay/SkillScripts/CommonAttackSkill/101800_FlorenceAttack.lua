local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_101800 = class("bs_101800", bs_1)
local base = bs_1
bs_101800.config = {effectId_trail = 101801, audioId1 = 101801, audioId2 = 101802}
bs_101800.config = setmetatable(bs_101800.config, {__index = base.config})
bs_101800.ctor = function(self)
  -- function num : 0_0
end

bs_101800.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_101800.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101800

