local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_100500 = class("bs_100500", bs_1)
local base = bs_1
bs_100500.config = {effectId_1 = 100501, effectId_2 = 100502, audioId1 = 100501, audioId2 = 100502}
bs_100500.config = setmetatable(bs_100500.config, {__index = base.config})
bs_100500.ctor = function(self)
  -- function num : 0_0
end

bs_100500.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_100500.RealPlaySkill = function(self, target, data)
  -- function num : 0_2 , upvalues : base
  if ((self.caster).recordTable).skill == true then
    (self.caster):LookAtTarget(target)
    return 
  end
  ;
  (base.RealPlaySkill)(self, target, data)
end

bs_100500.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100500

