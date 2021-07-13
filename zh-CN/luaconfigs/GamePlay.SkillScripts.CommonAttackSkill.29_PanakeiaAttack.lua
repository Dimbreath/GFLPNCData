-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_29 = class("bs_29", bs_1)
local base = bs_1
bs_29.config = {effectId_trail = 10656, effectId_trail_ex = 10653, effecId_action_1 = 10662, effecId_action_2 = 10663}
bs_29.config = setmetatable(bs_29.config, {__index = base.config})
bs_29.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_29.OnCasterDie = function(self)
  -- function num : 0_1 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_29

