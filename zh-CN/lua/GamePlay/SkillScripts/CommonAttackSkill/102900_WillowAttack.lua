local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_102900 = class("bs_102900", bs_1)
local base = bs_1
bs_102900.config = {effectId_start1 = 102901, effectId_start2 = 102901, effectId_trail = nil, effectId_hit_target = 102902, audioId1 = 102901, audioId2 = 102902, audioId5 = 102903}
bs_102900.config = setmetatable(bs_102900.config, {__index = base.config})
bs_102900.ctor = function(self)
  -- function num : 0_0
end

bs_102900.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_102900.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102900

