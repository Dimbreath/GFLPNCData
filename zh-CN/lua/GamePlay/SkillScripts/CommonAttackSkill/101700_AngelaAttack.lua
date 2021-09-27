local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_101700 = class("bs_101700", bs_1)
local base = bs_1
bs_101700.config = {effectId_trail = 101706, audioId1 = 202, audioId2 = 203, audioId5 = 204}
bs_101700.config = setmetatable(bs_101700.config, {__index = base.config})
bs_101700.ctor = function(self)
  -- function num : 0_0
end

bs_101700.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_101700.RealPlaySkill = function(self, target, data)
  -- function num : 0_2 , upvalues : base
  do
    if ((self.caster).recordTable).Open == true and ((self.caster).recordTable).Skill_target ~= nil then
      local target1 = ((self.caster).recordTable).Skill_target
      ;
      (self.caster):LookAtTarget(target1)
      return 
    end
    ;
    (base.RealPlaySkill)(self, target, data)
  end
end

bs_101700.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101700

