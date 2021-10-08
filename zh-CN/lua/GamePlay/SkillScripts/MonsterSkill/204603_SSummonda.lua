local bs_201801 = require("GamePlay.SkillScripts.MonsterSkill.201801_ZYZ_RefactorSummon")
local bs_204603 = class("bs_204603", bs_201801)
local base = bs_201801
bs_204603.config = {
middleMonsterId = {20, 22, 23}
, maxHpPer = 250, powPer = 800}
bs_204603.config = setmetatable(bs_204603.config, {__index = base.config})
bs_204603.ctor = function(self)
  -- function num : 0_0
end

bs_204603.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_204603.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_204603

