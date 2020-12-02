-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_45 = class("bs_45", bs_1)
local base = bs_1
bs_45.config = {effectId = 52}
bs_45.config = setmetatable(bs_45.config, {__index = base.config})
bs_45.ctor = function(self)
  -- function num : 0_0
end

bs_45.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_45.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_45

