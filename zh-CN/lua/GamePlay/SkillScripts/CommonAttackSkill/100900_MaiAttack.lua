local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_100900 = class("bs_100900", bs_1)
local base = bs_1
bs_100900.config = {effectId_trail = 100901, audioId1 = 100903, audioId2 = 100904, audioId4 = 100905}
bs_100900.config = setmetatable(bs_100900.config, {__index = base.config})
bs_100900.ctor = function(self)
  -- function num : 0_0
end

bs_100900.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_100900.SkillEventFunc = function(self, configData, effect, eventId, target)
  -- function num : 0_2 , upvalues : base
  (base.SkillEventFunc)(self, configData, effect, eventId, target)
end

bs_100900.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100900

