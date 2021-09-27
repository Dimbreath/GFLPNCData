local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_101000 = class("bs_101000", bs_1)
local base = bs_1
bs_101000.config = {effectId_3 = 101001, audioId1 = 101001, audioId2 = 101002, time1 = 6}
bs_101000.config = setmetatable(bs_101000.config, {__index = base.config})
bs_101000.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_101000.OnCasterDie = function(self)
  -- function num : 0_1 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101000

