-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_518 = class("bs_518", bs_1)
local base = bs_1
bs_518.config = {effectStartId = 10489, effectStartId3 = 10490, effectId = 10487}
bs_518.config = setmetatable(bs_518.config, {__index = base.config})
bs_518.ctor = function(self)
  -- function num : 0_0
end

bs_518.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_518.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_518

