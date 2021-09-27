local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_100400 = class("bs_100400", bs_1)
local base = bs_1
bs_100400.config = {effectId_trail = 100401}
bs_100400.config = setmetatable(bs_100400.config, {__index = base.config})
bs_100400.ctor = function(self)
  -- function num : 0_0
end

bs_100400.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_100400.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100400

