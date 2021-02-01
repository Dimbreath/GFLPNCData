-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1030 = class("bs_1030", LuaSkillBase)
local base = LuaSkillBase
bs_1030.config = {
heal_config = {baseheal_formula = 10060, heal_number = 0, correct_formula = 9990}
, buffId = 109, effectId1 = 10040, effectId2 = 10041, audioId1 = 36, audioId2 = 37}
bs_1030.ctor = function(self)
  -- function num : 0_0
end

bs_1030.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.caster).recordTable)["1030_Time"] = 0
end

bs_1030.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ((self.caster).recordTable)["1030_Time"] = (self.arglist)[2] + 1
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 24, 10)
  if targetList.Count == 0 then
    return 
  end
  if ((self.caster).recordTable)["1030_Time"] > 0 and (targetList[0]).targetRole ~= nil then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    ;
    (self.caster):LookAtTarget((targetList[0]).targetRole)
    self:CallCasterWait(12)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, (targetList[0]).targetRole, data)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 6, attackTrigger)
  end
end

bs_1030.OnAttackTrigger = function(self, target, data)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  self:RealPlaySkill(nil, target, 1)
end

bs_1030.RealPlaySkill = function(self, sender, target, healId)
  -- function num : 0_4 , upvalues : _ENV
  if sender == nil then
    LuaSkillCtrl:CallEffectWithArg(target, (self.config).effectId2, self, false, self.SkillEventFunc, healId)
  else
    LuaSkillCtrl:CallEffectWithArgOverride(target, (self.config).effectId2, self, sender, false, self.SkillEventFunc, healId)
  end
  LuaSkillCtrl:CallEffect(target, (self.config).effectId1, self, nil, sender)
end

bs_1030.SkillEventFunc = function(self, healId, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if effect.dataId == (self.config).effectId2 and eventId == eBattleEffectEvent.Trigger then
    if healId == 1 and (self.arglist)[4] > 0 then
      LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).buffId, 1, nil, true)
    end
    LuaSkillCtrl:StartTimer(nil, 2, BindCallback(self, self.CallBack, target.targetRole, healId))
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["1030_Time"] = ((self.caster).recordTable)["1030_Time"] - 1
    if ((self.caster).recordTable)["1030_Time"] > 0 then
      local targetList = LuaSkillCtrl:CallTargetSelect(self, 24, 10)
      if targetList.Count == 0 then
        return 
      end
      for i = 0, targetList.Count - 1 do
        if (targetList[i]).targetRole ~= nil and (targetList[i]).targetRole ~= target.targetRole then
          self:RealPlaySkill(target.targetRole, (targetList[i]).targetRole, healId + 1)
        end
      end
    end
  end
end

bs_1030.CallBack = function(self, targetRole, healId)
  -- function num : 0_6 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(targetRole, (self.config).audioId1)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {healId}, false, false)
  skillResult:EndResult()
end

bs_1030.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1030

