-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_529 = class("bs_529", bs_1)
local base = bs_1
bs_529.config = {effectId_1 = 10567, effectId_2 = 10568}
bs_529.config = setmetatable(bs_529.config, {__index = base.config})
bs_529.ctor = function(self)
  -- function num : 0_0
end

bs_529.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_529.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_529

