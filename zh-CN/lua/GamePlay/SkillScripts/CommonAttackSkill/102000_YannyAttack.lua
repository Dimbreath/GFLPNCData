local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_102000 = class("bs_102000", bs_1)
local base = bs_1
bs_102000.config = {effectId_1 = 102001, effectId_2 = 102002, audioId1 = 102001, audioId2 = 102002}
bs_102000.config = setmetatable(bs_102000.config, {__index = base.config})
bs_102000.ctor = function(self)
  -- function num : 0_0
end

bs_102000.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_102000.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102000

