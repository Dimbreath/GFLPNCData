-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_20 = class("bs_20", bs_1)
local base = bs_1
bs_20.config = {effectId_1 = 10378, effectId_2 = 10379}
bs_20.config = setmetatable(bs_20.config, {__index = base.config})
bs_20.ctor = function(self)
  -- function num : 0_0
end

bs_20.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_20.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20

