-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_500 = class("bs_500", bs_1)
local base = bs_1
bs_500.config = {effectId1 = 10081, effectId2 = 10082, audioId1 = 22, audioId2 = 22}
bs_500.config = setmetatable(bs_500.config, {__index = base.config})
bs_500.ctor = function(self)
  -- function num : 0_0
end

bs_500.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_500.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_500

