-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_35 = class("bs_35", bs_1)
local base = bs_1
bs_35.config = {effectId = 10719}
bs_35.config = setmetatable(bs_35.config, {__index = base.config})
bs_35.ctor = function(self)
  -- function num : 0_0
end

bs_35.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_35.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_35

