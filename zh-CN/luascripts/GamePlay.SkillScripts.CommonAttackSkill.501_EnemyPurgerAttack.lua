-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_501 = class("bs_501", bs_1)
local base = bs_1
bs_501.config = {effectId = 10088, targetSelect = 15, action1 = 1002, action2 = 1002, effectStartId = nil, audioId4 = 28}
bs_501.config = setmetatable(bs_501.config, {__index = base.config})
bs_501.ctor = function(self)
  -- function num : 0_0
end

bs_501.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_501.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC21: Unhandled construct in 'MakeBoolean' P1

  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, (self.caster).attackRange) and (self.config).effectId ~= nil then
    if data.audioId4 ~= nil then
      ((self.caster).auSource):PlayAudioById((self.config).audioId4)
    end
    LuaSkillCtrl:CallEffectWithArg(target, (self.config).effectId, self, true, self.SkillEventFunc, data)
  end
  self:BreakSkill()
  self:CancleCasterWait()
end

bs_501.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_501

