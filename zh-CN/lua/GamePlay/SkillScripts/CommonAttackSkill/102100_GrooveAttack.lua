local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_102100 = class("bs_102100", bs_1)
local base = bs_1
bs_102100.config = {effectId_trail = 10266, effectId_start1 = 10265, effectId_trail_ex = 10269, effectId_start2 = 10268, audioId1 = 63, audioId2 = 63}
bs_102100.config = setmetatable(bs_102100.config, {__index = base.config})
bs_102100.ctor = function(self)
  -- function num : 0_0
end

bs_102100.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_102100.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102100

