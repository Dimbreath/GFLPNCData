local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_103100 = class("bs_103100", bs_1)
local base = bs_1
bs_103100.config = {effectId_trail = 103107, audioId1 = 271, audioId2 = 272, audioId5 = 341}
bs_103100.config = setmetatable(bs_103100.config, {__index = base.config})
bs_103100.ctor = function(self)
  -- function num : 0_0
end

bs_103100.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_103100.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103100

