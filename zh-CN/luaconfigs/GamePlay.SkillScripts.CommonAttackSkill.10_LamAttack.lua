-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_10 = class("bs_10", bs_1)
local base = bs_1
bs_10.config = {GS_Id = 8000, effectId_trail = 10179, audioId1 = 111, time1 = 0, audioId2 = 112, time2 = 0}
bs_10.config = setmetatable(bs_10.config, {__index = base.config})
bs_10.ctor = function(self)
  -- function num : 0_0
end

bs_10.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_10.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10

