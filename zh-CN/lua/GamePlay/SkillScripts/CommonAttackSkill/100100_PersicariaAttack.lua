local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_100100 = class("bs_100100", bs_1)
local base = bs_1
bs_100100.config = {effectId_trail = 100101}
bs_100100.config = setmetatable(bs_100100.config, {__index = base.config})
bs_100100.ctor = function(self)
  -- function num : 0_0
end

bs_100100.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_100100.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100100

