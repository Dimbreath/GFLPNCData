-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_31 = class("bs_31", bs_1)
local base = bs_1
bs_31.config = {effectId_1 = 10680, effectId_2 = 10681}
bs_31.config = setmetatable(bs_31.config, {__index = base.config})
bs_31.ctor = function(self)
  -- function num : 0_0
end

bs_31.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_31.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_31

