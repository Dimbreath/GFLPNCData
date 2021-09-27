local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_79 = class("bs_79", bs_1)
local base = bs_1
bs_79.config = {effectId_taril = 132}
bs_79.config = setmetatable(bs_79.config, {__index = base.config})
bs_79.ctor = function(self)
  -- function num : 0_0
end

bs_79.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_79.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_79

