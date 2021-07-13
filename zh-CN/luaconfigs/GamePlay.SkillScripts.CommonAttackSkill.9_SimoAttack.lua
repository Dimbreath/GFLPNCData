-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_9 = class("bs_9", bs_1)
local base = bs_1
bs_9.config = {effectId_trail = 10052, audioId4 = 16}
bs_9.config = setmetatable(bs_9.config, {__index = base.config})
bs_9.ctor = function(self)
  -- function num : 0_0
end

bs_9.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_9.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_9

