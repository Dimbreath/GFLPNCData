-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_521 = class("bs_521", bs_1)
local base = bs_1
bs_521.config = {}
bs_521.config = setmetatable(bs_521.config, {__index = base.config})
bs_521.ctor = function(self)
  -- function num : 0_0
end

bs_521.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_521.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_521

