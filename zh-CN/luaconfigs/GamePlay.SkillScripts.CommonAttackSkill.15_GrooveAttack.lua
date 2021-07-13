-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_15 = class("bs_15", bs_1)
local base = bs_1
bs_15.config = {effectId_trail = 10266, effectId_start1 = 10265, effectId_trail_ex = 10269, effectId_start2 = 10268, audioId1 = 63, audioId2 = 63}
bs_15.config = setmetatable(bs_15.config, {__index = base.config})
bs_15.ctor = function(self)
  -- function num : 0_0
end

bs_15.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_15.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_15

