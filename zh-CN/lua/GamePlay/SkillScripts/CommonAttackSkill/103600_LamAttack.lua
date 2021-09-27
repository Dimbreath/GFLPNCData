local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_103600 = class("bs_103600", bs_1)
local base = bs_1
bs_103600.config = {GS_Id = 8000, effectId_trail = 10179, audioId1 = 111, time1 = 0, audioId2 = 112, time2 = 0, Imp = true}
bs_103600.config = setmetatable(bs_103600.config, {__index = base.config})
bs_103600.ctor = function(self)
  -- function num : 0_0
end

bs_103600.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_103600.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103600

