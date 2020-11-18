-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_504 = class("bs_504", bs_1)
local base = bs_1
bs_504.config = {effectId1 = 10102, effectId2 = 10102, action2 = 1001, audioId1 = 19, audioId2 = 19}
bs_504.config = setmetatable(bs_504.config, {__index = base.config})
bs_504.ctor = function(self)
  -- function num : 0_0
end

bs_504.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_504.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_504

