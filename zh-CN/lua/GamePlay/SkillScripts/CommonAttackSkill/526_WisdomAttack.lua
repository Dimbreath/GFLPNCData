local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_526 = class("bs_526", bs_1)
local base = bs_1
bs_526.config = {effectId_trail = 10445, effectIdPJ = 10513, 
HurtConfig = {hit_formula = 0, def_formula = 0, basehurt_formula = 10085}
, audioId1 = 317, audioId2 = 361}
bs_526.config = setmetatable(bs_526.config, {__index = base.config})
bs_526.ctor = function(self)
  -- function num : 0_0
end

bs_526.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_526.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId)
  -- function num : 0_2 , upvalues : _ENV
  if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, (self.caster).attackRange) then
    if data.effectId_trail ~= nil then
      if data.audioId4 ~= nil then
        LuaSkillCtrl:PlayAuSource(self.caster, data.audioId4)
      end
      local roll = ((self.caster).recordTable)["521_Roll"]
      if roll == nil then
        roll = 0
      end
      if LuaSkillCtrl:CallRange(1, 1000) <= roll then
        LuaSkillCtrl:CallEffectWithArg(target, data.effectIdPJ, self, true, false, self.SkillEventFunc, data, 1)
      else
        LuaSkillCtrl:CallEffectWithArg(target, data.effectId_trail, self, true, false, self.SkillEventFunc, data, 2)
      end
    end
    do
      -- DECOMPILER ERROR at PC63: Confused about usage of register: R5 in 'UnsetPending'

      if ((self.caster).recordTable).completeFirstComatk == nil then
        ((self.caster).recordTable).completeFirstComatk = true
      end
      self:BreakSkill()
      self:CancleCasterWait()
    end
  end
end

bs_526.SkillEventFunc = function(self, configData, num, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    if configData.audioId5 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, configData.audioId5)
    end
    if num == 1 then
      local arg = ((self.caster).recordTable)["521_arg2"]
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:PlayAuHit(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {arg})
      skillResult:EndResult()
    else
      do
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
        LuaSkillCtrl:PlayAuHit(self, target)
        LuaSkillCtrl:HurtResult(self, skillResult)
        skillResult:EndResult()
      end
    end
  end
end

bs_526.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_526

