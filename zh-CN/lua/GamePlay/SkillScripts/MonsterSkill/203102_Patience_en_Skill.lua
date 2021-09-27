local bs_200303 = require("GamePlay.SkillScripts.MonsterSkill.200303_RN_GouDF")
local bs_203102 = class("bs_203102", bs_200303)
local base = bs_200303
bs_203102.config = {effectId = 10591, hurtEffectId = 10592, buffId = 1095}
bs_203102.config = setmetatable(bs_203102.config, {__index = base.config})
bs_203102.ctor = function(self)
  -- function num : 0_0
end

bs_203102.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_203102.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_203102

