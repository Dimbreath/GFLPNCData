-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_517 = class("bs_517", bs_1)
local base = bs_1
bs_517.config = {effectId1 = 10425, effectId2 = 10426}
bs_517.config = setmetatable(bs_517.config, {__index = base.config})
bs_517.ctor = function(self)
  -- function num : 0_0
end

bs_517.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_517.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_517

