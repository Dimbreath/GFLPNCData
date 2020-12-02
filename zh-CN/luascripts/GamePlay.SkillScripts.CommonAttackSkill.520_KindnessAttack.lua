-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_520 = class("bs_520", bs_1)
local base = bs_1
bs_520.config = {}
bs_520.config = setmetatable(bs_520.config, {__index = base.config})
bs_520.ctor = function(self)
  -- function num : 0_0
end

bs_520.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_520.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_520

