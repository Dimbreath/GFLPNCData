local bs_1 = require("GamePlay.SkillScripts.CommonAttackSkill.1_CommonAttack_1")
local bs_100800 = class("bs_100800", bs_1)
local base = bs_1
bs_100800.config = {effectId_trail = 100801, buffIdBJ = 100801, 
heal_config = {baseheal_formula = 3021, heal_number = 0, crit_formula = 9992, crithur_ratio = 9995, correct_formula = 9990}
, audioId1 = 100801, audioId2 = 100802}
bs_100800.config = setmetatable(bs_100800.config, {__index = base.config})
bs_100800.ctor = function(self)
  -- function num : 0_0
end

bs_100800.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_100800.PlaySkill = function(self, passdata)
  -- function num : 0_2 , upvalues : _ENV
  self:CheckAndRecordIsDoubleAttack(passdata)
  local data = nil
  if passdata ~= nil then
    data = setmetatable(passdata, {__index = self.config})
  else
    data = self.config
  end
  local targetRole = nil
  local rangeOffset = 0
  if (self.caster):GetBuffTier((self.config).buffIdBJ) > 0 then
    rangeOffset = 10
  end
  if ((self.caster).recordTable).BJ == true then
    targetRole = self:FindEnemy(3, rangeOffset)
    if targetRole == nil then
      targetRole = self:FindEnemy(10001)
    end
  else
    targetRole = self:FindEnemy(10001)
  end
  if targetRole ~= nil and targetRole.hp > 0 then
    self:RealPlaySkill(targetRole, data)
    ;
    (self.caster):LookAtTarget(targetRole)
  end
end

bs_100800.FindEnemy = function(self, selectId, rangeOffset)
  -- function num : 0_3 , upvalues : _ENV
  if not rangeOffset then
    rangeOffset = 0
  end
  local targetList = LuaSkillCtrl:CallTargetSelect(self, selectId, rangeOffset)
  if targetList.Count > 0 then
    return (targetList[0]).targetRole
  end
end

bs_100800.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
  -- function num : 0_4 , upvalues : _ENV, base
  if target.belongNum == (self.caster).belongNum and ((self.caster).recordTable).BJ == true then
    if (self.caster):GetBuffTier((self.config).buffIdBJ) > 0 then
      local targetListAll = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
      if targetListAll.Count > 0 then
        for i = 0, targetListAll.Count - 1 do
          LuaSkillCtrl:CallEffect((targetListAll[i]).targetRole, (self.config).effectId_trail, self, self.SkillEventFunc2)
        end
      end
    else
      do
        LuaSkillCtrl:CallEffect(target, (self.config).effectId_trail, self, self.SkillEventFunc2)
        do
          local extraTarget = self:CheckAndGetExtraEffectTarget(target, 34)
          if extraTarget ~= nil then
            LuaSkillCtrl:CallEffect(extraTarget, (self.config).effectId_trail, self, self.SkillEventFunc2)
          end
          -- DECOMPILER ERROR at PC71: Confused about usage of register: R6 in 'UnsetPending'

          if ((self.caster).recordTable).completeFirstComatk == nil then
            ((self.caster).recordTable).completeFirstComatk = true
          end
          if self.isDoubleAttack then
            local attackTrigger = BindCallback(self, self.OnAttackTrigger, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
            self:CheckAndExecuteSecondAttack(data, target, atkTriggerFrame, atkSpeedRatio, atkActionId, attackTrigger)
          else
            do
              self:CancleCasterWait()
              ;
              (base.OnAttackTrigger)(self, target, data, atkSpeedRatio, atkActionId, atkTriggerFrame)
            end
          end
        end
      end
    end
  end
end

bs_100800.SkillEventFunc2 = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  local miss = LuaSkillCtrl:CallFormulaBoolWithSkill(10051, self.caster, self.caster, self)
  if miss and eventId == eBattleEffectEvent.Trigger and effect.dataId == (self.config).effectId_trail then
    local arg = ((self.caster).recordTable)["arglist[1]"]
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {arg}, false)
    skillResult:EndResult()
  end
end

bs_100800.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100800

