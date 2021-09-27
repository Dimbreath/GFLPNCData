local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_522 = class("bs_522", bs_1)
local base = bs_1
bs_522.config = {effectId_1 = 10425, effectId_2 = 10426, audioId1 = 302, audioId3 = 303}
bs_522.config = setmetatable(bs_522.config, {__index = base.config})
bs_522.ctor = function(self)
  -- function num : 0_0
end

bs_522.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_522.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_522

