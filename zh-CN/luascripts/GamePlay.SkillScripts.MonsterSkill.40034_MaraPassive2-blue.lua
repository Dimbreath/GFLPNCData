-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40030 = require("GamePlay.SkillScripts.MonsterSkill.40030_MaraPassive2")
local bs_40034 = class("bs_40034", bs_40030)
local base = bs_40030
bs_40034.config = {effectId = 10235}
bs_40034.config = setmetatable(bs_40034.config, {__index = base.config})
bs_40034.ctor = function(self)
  -- function num : 0_0
end

bs_40034.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_40034.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40034

