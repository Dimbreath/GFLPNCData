local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_525 = class("bs_525", bs_1)
local base = bs_1
bs_525.config = {effectId_1 = 10440, effectId_2 = 10441, audioId1 = 314, audioId2 = 315, audioId3 = 360}
bs_525.config = setmetatable(bs_525.config, {__index = base.config})
bs_525.ctor = function(self)
  -- function num : 0_0
end

bs_525.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_525.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_525

