-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_2 = class("bs_2", bs_1)
local base = bs_1
bs_2.config = {effectId_trail = 10002, audioId4 = 18}
bs_2.config = setmetatable(bs_2.config, {__index = base.config})
bs_2.ctor = function(self)
  -- function num : 0_0
end

bs_2.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_2.SkillEventFunc = function(self, configData, effect, eventId, target)
  -- function num : 0_2 , upvalues : base
  (base.SkillEventFunc)(self, configData, effect, eventId, target)
end

bs_2.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_2

