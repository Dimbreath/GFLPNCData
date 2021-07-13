-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_23 = class("bs_23", bs_1)
local base = bs_1
bs_23.config = {effectId_start1 = 10386, effectId_start2 = 10387, effectId_trail = 10796, effectId_trail_ex = 10805}
bs_23.config = setmetatable(bs_23.config, {__index = base.config})
bs_23.ctor = function(self)
  -- function num : 0_0
end

bs_23.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_23.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_23

