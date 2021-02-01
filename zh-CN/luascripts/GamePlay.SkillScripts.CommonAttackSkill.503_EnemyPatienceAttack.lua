-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_502 = class("bs_502", bs_1)
local base = bs_1
bs_502.config = {effectId1 = 10093, effectId2 = 10093, audioId1 = 21, audioId2 = 21}
bs_502.config = setmetatable(bs_502.config, {__index = base.config})
bs_502.ctor = function(self)
  -- function num : 0_0
end

bs_502.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_502.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_502

