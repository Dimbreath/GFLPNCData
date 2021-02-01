-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_531 = class("bs_531", bs_1)
local base = bs_1
bs_531.config = {effectId1 = 10589, effectId2 = 10589, audioId1 = 21, audioId2 = 21}
bs_531.config = setmetatable(bs_531.config, {__index = base.config})
bs_531.ctor = function(self)
  -- function num : 0_0
end

bs_531.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_531.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_531

