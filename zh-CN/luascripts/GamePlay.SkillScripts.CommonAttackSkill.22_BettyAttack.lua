-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_22 = class("bs_22", bs_1)
local base = bs_1
bs_22.config = {effectId1 = 10523, effectId2 = 10524}
bs_22.config = setmetatable(bs_22.config, {__index = base.config})
bs_22.ctor = function(self)
  -- function num : 0_0
end

bs_22.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_22.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_22

