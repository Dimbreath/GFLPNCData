-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_521 = class("bs_521", bs_1)
local base = bs_1
bs_521.config = {effectId = 10445, effectIdPJ = 10513, effectStartId = nil, effectStartId3 = nil, 
HurtConfig = {hit_formula = 0, def_formula = 0, basehurt_formula = 10085}
}
bs_521.config = setmetatable(bs_521.config, {__index = base.config})
bs_521.ctor = function(self)
  -- function num : 0_0
end

bs_521.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_521.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId)
  -- function num : 0_2 , upvalues : _ENV
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, (self.caster).attackRange) then
    if data.effectStartId ~= nil then
      if atkActionId == data.action1 then
        LuaSkillCtrl:CallEffect(self.caster, data.effectStartId, self)
      else
        LuaSkillCtrl:CallEffect(self.caster, data.effectStartId3, self)
      end
    end
    if data.effectId ~= nil then
      if data.audioId4 ~= nil then
        ((self.caster).auSource):PlayAudioById(data.audioId4)
      end
      local roll = ((self.caster).recordTable)["521_Roll"]
      if roll == nil then
        roll = 0
      end
      if LuaSkillCtrl:CallRange(1, 1000) <= roll then
        LuaSkillCtrl:CallEffectWithArg(target, data.effectIdPJ, self, true, self.SkillEventFunc, data, 1)
      else
        LuaSkillCtrl:CallEffectWithArg(target, data.effectId, self, true, self.SkillEventFunc, data, 2)
      end
    end
    do
      -- DECOMPILER ERROR at PC80: Confused about usage of register: R5 in 'UnsetPending'

      if ((self.caster).recordTable).completeFirstComatk == nil then
        ((self.caster).recordTable).completeFirstComatk = true
      end
      self:BreakSkill()
      self:CancleCasterWait()
    end
  end
end

bs_521.SkillEventFunc = function(self, configData, num, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    if configData.audioId5 ~= nil then
      ((self.caster).auSource):PlayAudioById(configData.audioId5)
    end
    if num == 1 then
      local arg = ((self.caster).recordTable)["521_arg2"]
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig, {arg})
      skillResult:EndResult()
    else
      do
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:HurtResult(skillResult)
        skillResult:EndResult()
      end
    end
  end
end

bs_521.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_521

