local bs_201801 = require("GamePlay.SkillScripts.MonsterSkill.201801_ZYZ_RefactorSummon")
local bs_204602 = class("bs_204602", bs_201801)
local base = bs_201801
bs_204602.config = {
middleMonsterId = {21, 22, 23}
, maxHpPer = 210, powPer = 750}
bs_204602.config = setmetatable(bs_204602.config, {__index = base.config})
bs_204602.ctor = function(self)
  -- function num : 0_0
end

bs_204602.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_204602.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_204602

