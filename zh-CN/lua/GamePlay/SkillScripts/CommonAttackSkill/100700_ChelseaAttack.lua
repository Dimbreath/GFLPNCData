local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_100700 = class("bs_100700", bs_1)
local base = bs_1
bs_100700.config = {effectId_1 = 100702, effectId_2 = 100702, effectId_action_1 = 100701, effectId_action_2 = 100702}
bs_100700.config = setmetatable(bs_100700.config, {__index = base.config})
bs_100700.ctor = function(self)
  -- function num : 0_0
end

bs_100700.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_100700.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100700

