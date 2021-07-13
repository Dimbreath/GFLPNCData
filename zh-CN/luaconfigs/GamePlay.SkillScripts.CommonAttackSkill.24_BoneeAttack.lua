-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_24 = class("bs_24", bs_1)
local base = bs_1
bs_24.config = {effectId_1 = 10391, effectId_2 = 10392}
bs_24.config = setmetatable(bs_24.config, {__index = base.config})
bs_24.ctor = function(self)
  -- function num : 0_0
end

bs_24.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_24.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_24

