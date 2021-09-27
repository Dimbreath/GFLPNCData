local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_512 = class("bs_512", bs_1)
local base = bs_1
bs_512.config = {effectId_trail = 10218, audioId1 = 64, audioId2 = 64, Imp = fasle, audioId5 = 81}
bs_512.config = setmetatable(bs_512.config, {__index = base.config})
bs_512.ctor = function(self)
  -- function num : 0_0
end

bs_512.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_512.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_512

