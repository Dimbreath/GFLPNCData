-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_28 = class("bs_28", bs_1)
local base = bs_1
bs_28.config = {effectId_trail = 10791, effectId_trail_ex = 10814, effectId_start1 = 10645, effectId_start2 = 10646}
bs_28.config = setmetatable(bs_28.config, {__index = base.config})
bs_28.ctor = function(self)
  -- function num : 0_0
end

bs_28.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_28.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_28

