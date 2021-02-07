-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_533 = class("bs_533", bs_1)
local base = bs_1
bs_533.config = {effectId1 = 10683, effectId2 = 10684, effectId3_die = 10699}
bs_533.config = setmetatable(bs_533.config, {__index = base.config})
bs_533.ctor = function(self)
  -- function num : 0_0
end

bs_533.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_533.OnCasterDie = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_533.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId)
  -- function num : 0_3 , upvalues : _ENV
  if (self.caster).attackRange == 1 then
    if data.audioId3 ~= nil then
      LuaSkillCtrl:PlayAuSource(self.caster, data.audioId3)
    end
    if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, (self.caster).attackRange) then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(skillResult, generalHurtConfig)
      skillResult:EndResult()
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R6 in 'UnsetPending'

      if ((self.caster).recordTable).completeFirstComatk == nil then
        ((self.caster).recordTable).completeFirstComatk = true
      end
    else
      do
        self:BreakSkill()
        if LuaSkillCtrl:IsAbleAttackTarget(self.caster, target, (self.caster).attackRange) then
          if data.effectStartId ~= nil then
            if atkActionId == data.action1 then
              LuaSkillCtrl:CallEffect(self.caster, data.effectStartId, self)
            else
              LuaSkillCtrl:CallEffect(self.caster, data.effectStartId3, self)
            end
          end
          if data.effectstartId4 ~= nil then
            if atkActionId == data.action1 then
              LuaSkillCtrl:CallEffect(target, data.effectstartId4, self, nil, nil, atkSpeedRatio)
            else
              LuaSkillCtrl:CallEffect(target, data.effectstartId5, self, nil, nil, atkSpeedRatio)
            end
          end
          if data.effectId ~= nil then
            if data.audioId4 ~= nil then
              LuaSkillCtrl:PlayAuSource(self.caster, data.audioId4)
            end
            LuaSkillCtrl:CallEffectWithArg(target, data.effectId, self, true, self.SkillEventFunc, data)
          end
          -- DECOMPILER ERROR at PC123: Confused about usage of register: R5 in 'UnsetPending'

          if ((self.caster).recordTable).completeFirstComatk == nil then
            ((self.caster).recordTable).completeFirstComatk = true
          end
        else
          self:BreakSkill()
        end
        self:CancleCasterWait()
      end
    end
  end
end

return bs_533

