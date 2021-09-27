local bs_202602 = require("GamePlay.SkillScripts.MonsterSkill.202602_WisdomPassive02")
local bs_203202 = class("bs_203202", bs_202602)
local base = bs_202602
bs_203202.config = {}
bs_203202.config = setmetatable(bs_203202.config, {__index = base.config})
bs_203202.ctor = function(self)
  -- function num : 0_0
end

bs_203202.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_203202.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_203202

