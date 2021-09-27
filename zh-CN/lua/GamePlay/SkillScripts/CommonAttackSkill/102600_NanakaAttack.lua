local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_102600 = class("bs_102600", bs_1)
local base = bs_1
bs_102600.config = {effectId_trail = 10719, audioId1 = 254, audioId2 = 255, audioId5 = 342}
bs_102600.config = setmetatable(bs_102600.config, {__index = base.config})
bs_102600.ctor = function(self)
  -- function num : 0_0
end

bs_102600.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_102600.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102600

