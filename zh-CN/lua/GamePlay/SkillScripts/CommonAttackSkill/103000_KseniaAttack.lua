local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_103000 = class("bs_103000", bs_1)
local base = bs_1
bs_103000.config = {effectId_trail = 103001, effectId_trail_ex = 103003, audioId1 = 103001, audioId2 = 103002, audioId5 = 103003}
bs_103000.config = setmetatable(bs_103000.config, {__index = base.config})
bs_103000.ctor = function(self)
  -- function num : 0_0
end

bs_103000.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_103000.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103000

