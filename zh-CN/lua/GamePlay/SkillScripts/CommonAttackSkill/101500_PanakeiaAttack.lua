local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_101500 = class("bs_101500", bs_1)
local base = bs_1
bs_101500.config = {effectId_trail = 101502, effectId_trail_ex = 101501, effecId_action_1 = 101503, effecId_action_2 = 101504, audioId1 = 101501, audioId2 = 101503}
bs_101500.config = setmetatable(bs_101500.config, {__index = base.config})
bs_101500.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_101500.OnCasterDie = function(self)
  -- function num : 0_1 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101500

