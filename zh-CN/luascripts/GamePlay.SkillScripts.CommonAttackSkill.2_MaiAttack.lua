-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_2 = class("bs_2", bs_1)
local base = bs_1
bs_2.config = {effectId = 10002, effectStartId = nil, audioId3 = 18}
bs_2.config = setmetatable(bs_2.config, {__index = base.config})
bs_2.ctor = function(self)
  -- function num : 0_0
end

bs_2.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_2.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId)
  -- function num : 0_2 , upvalues : _ENV
  if (self.config).audioId3 ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId3)
  end
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, (self.caster).attackRange) then
    if (self.config).effectStartId ~= nil then
      LuaSkillCtrl:CallEffect(target, data.effectStartId, self)
    end
    if (self.config).effectId ~= nil then
      LuaSkillCtrl:CallEffectWithArg(target, data.effectId, self, true, self.SkillEventFunc, data)
    end
  else
    self:BreakSkill()
  end
  self:CancleCasterWait()
end

bs_2.SkillEventFunc = function(self, configData, effect, eventId, target)
  -- function num : 0_3 , upvalues : base
  (base.SkillEventFunc)(self, configData, effect, eventId, target)
end

bs_2.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_2

