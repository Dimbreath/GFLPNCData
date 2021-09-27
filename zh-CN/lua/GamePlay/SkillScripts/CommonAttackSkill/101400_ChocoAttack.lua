local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_101400 = class("bs_101400", bs_1)
local base = bs_1
bs_101400.config = {effectId_trail = 101401, effectId_trail_ex = 101402, effectId_start1 = 101408, effectId_start2 = 101409, audioId1 = 101401, audioId2 = 101402}
bs_101400.config = setmetatable(bs_101400.config, {__index = base.config})
bs_101400.ctor = function(self)
  -- function num : 0_0
end

bs_101400.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_101400.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101400

