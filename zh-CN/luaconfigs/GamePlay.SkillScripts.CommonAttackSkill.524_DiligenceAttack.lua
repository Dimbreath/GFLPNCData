-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_524 = class("bs_524", bs_1)
local base = bs_1
bs_524.config = {effectId_1 = 10435, effectId_2 = 10436}
bs_524.config = setmetatable(bs_524.config, {__index = base.config})
bs_524.ctor = function(self)
  -- function num : 0_0
end

bs_524.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_524.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_524

