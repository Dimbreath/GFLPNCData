-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_7 = class("bs_7", bs_1)
local base = bs_1
bs_7.config = {buffId_114 = 114, effectId_1 = 10064, effectId_2 = 10065, audioId3 = 10}
bs_7.config = setmetatable(bs_7.config, {__index = base.config})
bs_7.ctor = function(self)
  -- function num : 0_0
end

bs_7.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_7.RealPlaySkill = function(self, target, data)
  -- function num : 0_2 , upvalues : base
  if (self.caster):GetBuffTier((self.config).buffId_114) ~= 0 then
    (self.caster):LookAtTarget(target)
    return 
  end
  ;
  (base.RealPlaySkill)(self, target, data)
end

bs_7.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_7

