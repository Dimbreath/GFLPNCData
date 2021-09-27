local base = require("GamePlay.SkillScripts.CommanderSkill.5131_focusOnFiring")
local bs_5132 = class("bs_5132", base)
bs_5132.config = {buffId = 513101, buffId_ex = 513201}
bs_5132.config = setmetatable(bs_5132.config, {__index = base.config})
bs_5132.AbandonTakeFeature = {eBuffFeatureType.BeatBack}
bs_5132.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_5132_1", 1, self.OnSetHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.normalSkill)
end

bs_5132.OnSetHurt = function(self, context)
  -- function num : 0_1
  if (context.target).hp <= 0 or (context.target):GetBuffTier((self.config).buffId_ex) < 1 then
    return 
  end
  context.hurt = context.hurt * ((self.arglist)[2] + 1000) // 1000
end

bs_5132.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5132

