-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_3 = class("bs_3", bs_1)
local base = bs_1
bs_3.config = {effectId1 = 10012, effectId2 = 10012, audioId1 = 17, audioId2 = 17}
bs_3.config = setmetatable(bs_3.config, {__index = base.config})
bs_3.ctor = function(self)
  -- function num : 0_0
end

bs_3.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_3.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_3

