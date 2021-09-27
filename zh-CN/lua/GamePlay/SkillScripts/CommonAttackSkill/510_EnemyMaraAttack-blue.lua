local bs_512 = require("GamePlay.SkillScripts.CommonAttackSkill.509_EnemyMaraAttack")
local bs_510 = class("bs_510", bs_512)
local base = bs_512
bs_510.config = {effectId_1 = 10231, effectId_2 = 10232, effectId33 = 10233, effectId4 = 10234}
bs_510.config = setmetatable(bs_510.config, {__index = base.config})
bs_510.ctor = function(self)
  -- function num : 0_0
end

bs_510.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_510.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_510

