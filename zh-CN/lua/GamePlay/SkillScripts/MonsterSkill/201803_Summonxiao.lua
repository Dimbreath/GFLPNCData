local bs_201801 = require("GamePlay.SkillScripts.MonsterSkill.201801_ZYZ_RefactorSummon")
local bs_201803 = class("bs_201803", bs_201801)
local base = bs_201801
bs_201803.config = {maxHpPer = 180, powPer = 700}
bs_201803.config = setmetatable(bs_201803.config, {__index = base.config})
bs_201803.ctor = function(self)
  -- function num : 0_0
end

bs_201803.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_201803.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_201803

