local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_101200 = class("bs_101200", bs_1)
local base = bs_1
bs_101200.config = {effectId_trail = 101202, effectId_action_1 = 101201, effectId_action_2 = 101201, audioId1 = 101201, audioId2 = 101202, audioId5 = 101203}
bs_101200.config = setmetatable(bs_101200.config, {__index = base.config})
bs_101200.ctor = function(self)
  -- function num : 0_0
end

bs_101200.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_101200.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101200

