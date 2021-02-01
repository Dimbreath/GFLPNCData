-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_509 = class("bs_509", bs_1)
local base = bs_1
bs_509.config = {effectId = 10088, effectStartId = nil, audioId4 = 28}
bs_509.config = setmetatable(bs_509.config, {__index = base.config})
bs_509.ctor = function(self)
  -- function num : 0_0
end

bs_509.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_509.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_509

