-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_507 = class("bs_507", bs_1)
local base = bs_1
bs_507.config = {effectId_1 = 10114, effectId_2 = 10115, audioId1 = 27, audioId2 = 27}
bs_507.config = setmetatable(bs_507.config, {__index = base.config})
bs_507.ctor = function(self)
  -- function num : 0_0
end

bs_507.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_507.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_507

