-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_27 = class("bs_27", bs_1)
local base = bs_1
bs_27.config = {effectId1 = 10598, effectId2 = 10599}
bs_27.config = setmetatable(bs_27.config, {__index = base.config})
bs_27.ctor = function(self)
  -- function num : 0_0
end

bs_27.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_27.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_27

