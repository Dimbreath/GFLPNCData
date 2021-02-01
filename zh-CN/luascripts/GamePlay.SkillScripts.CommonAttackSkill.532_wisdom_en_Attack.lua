-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_532 = class("bs_532", bs_1)
local base = bs_1
bs_532.config = {effectId = 10579}
bs_532.config = setmetatable(bs_532.config, {__index = base.config})
bs_532.ctor = function(self)
  -- function num : 0_0
end

bs_532.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_532.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_532

