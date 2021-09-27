local bs_201801 = require("GamePlay.SkillScripts.MonsterSkill.201801_ZYZ_RefactorSummon")
local bs_201805 = class("bs_201805", bs_201801)
local base = bs_201801
bs_201805.config = {
middleMonsterId = {9, 10, 19}
, maxHpPer = 250, powPer = 800}
bs_201805.config = setmetatable(bs_201805.config, {__index = base.config})
bs_201805.ctor = function(self)
  -- function num : 0_0
end

bs_201805.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_201805.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_201805

