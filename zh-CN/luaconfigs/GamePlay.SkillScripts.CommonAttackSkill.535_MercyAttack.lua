-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_535 = class("bs_535", bs_1)
local base = bs_1
bs_535.config = {effectId_trail = 10769, effectId_action_1 = 10767, effectId_action_2 = 10767, effectId_start1 = 10768, effectId_start2 = 10768}
bs_535.config = setmetatable(bs_535.config, {__index = base.config})
bs_535.ctor = function(self)
  -- function num : 0_0
end

bs_535.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_535.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_535

