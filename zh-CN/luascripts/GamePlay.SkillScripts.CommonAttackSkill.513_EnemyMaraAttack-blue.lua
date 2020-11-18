-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_512 = require("GamePlay.SkillScripts.CommonAttackSkill.512_EnemyMaraAttack")
local bs_513 = class("bs_513", bs_512)
local base = bs_512
bs_513.config = {effectId1 = 10231, effectId2 = 10232, effectId33 = 10233, effectId4 = 10234}
bs_513.config = setmetatable(bs_513.config, {__index = base.config})
bs_513.ctor = function(self)
  -- function num : 0_0
end

bs_513.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_513.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_513

