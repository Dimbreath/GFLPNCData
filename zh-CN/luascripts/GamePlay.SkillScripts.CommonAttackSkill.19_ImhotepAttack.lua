-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_19 = class("bs_19", bs_1)
local base = bs_1
bs_19.config = {effectId = 10369}
bs_19.config = setmetatable(bs_19.config, {__index = base.config})
bs_19.ctor = function(self)
  -- function num : 0_0
end

bs_19.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_19.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_19

