-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_4 = class("bs_4", bs_1)
local base = bs_1
bs_4.config = {effectId2 = 10027, effectStartId2 = 10029, effectId1 = 10035, effectStartId1 = 10036, effectStartId3 = 10028, audioId6 = 9}
bs_4.config = setmetatable(bs_4.config, {__index = base.config})
bs_4.ctor = function(self)
  -- function num : 0_0
end

bs_4.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_4.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId)
  -- function num : 0_2 , upvalues : _ENV
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, (self.caster).attackRange) then
    if atkActionId == (self.config).action1 then
      if (self.config).audioId6 ~= nil then
        ((self.caster).auSource):PlayAudioById((self.config).audioId6)
      end
      LuaSkillCtrl:CallEffect(self.caster, data.effectStartId1, self)
      LuaSkillCtrl:CallEffectWithArg(target, (self.config).effectId1, self, true, self.SkillEventFunc, data)
    else
      if (self.config).audioId6 ~= nil then
        ((self.caster).auSource):PlayAudioById((self.config).audioId6)
      end
      LuaSkillCtrl:CallEffect(target, (self.config).effectStartId3, self)
      LuaSkillCtrl:CallEffect(self.caster, data.effectStartId2, self)
      LuaSkillCtrl:CallEffectWithArg(target, (self.config).effectId2, self, true, self.SkillEventFunc, data)
    end
  else
    self:BreakSkill()
  end
  self:CancleCasterWait()
end

bs_4.SkillEventFunc = function(self, configData, effect, eventId, target)
  -- function num : 0_3 , upvalues : base
  (base.SkillEventFunc)(self, configData, effect, eventId, target)
end

bs_4.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_4

