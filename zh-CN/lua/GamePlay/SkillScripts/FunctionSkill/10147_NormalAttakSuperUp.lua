local bs_10147 = class("bs_10147", LuaSkillBase)
local base = LuaSkillBase
bs_10147.config = {buffId = 1028, buffTier = 1, effectId1 = 10252, effectId2 = 10253, effectId = 10336, effectIdAttack = 10254, 
hurt_config = {hit_formula = 0, basehurt_formula = 10032, crit_formula = 0}
}
bs_10147.ctor = function(self)
  -- function num : 0_0
end

bs_10147.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10147_3", 3, self.OnAfterPlaySkill)
  self:AddAfterHurtTrigger("bs_10147_3", 20, self.OnAfterHurt, self.caster)
  self:AddSelfTrigger(eSkillTriggerType.BeforePlaySkill, "bs_10147_1", 1, self.OnBeforePlaySkill)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10147_attackflag"] = false
end

bs_10147.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if skill.maker == self.caster and skill.isCommonAttack and ((self.caster).recordTable)["10147_attackflag"] and not isTriggerSet then
    local loopTime = (self.arglist)[1]
    local loopJiange = (self.arglist)[3] // (self.arglist)[1]
    local arriveCallBack = BindCallback(self, self.OnArriveAction, target)
    self.timer = LuaSkillCtrl:StartTimer(nil, loopJiange, arriveCallBack, self, loopTime, loopJiange)
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["10147_attackflag"] = false
  end
end

bs_10147.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  if skill.maker == self.caster and not skill.isCommonAttack then
    ((self.caster).recordTable)["10147_attackflag"] = true
  end
end

bs_10147.OnArriveAction = function(self, role)
  -- function num : 0_4 , upvalues : _ENV
  if self.timer ~= nil and (self.timer):IsOver() then
    self.timer = nil
  end
  if role.hp == 0 or role:ContainBuffFeature(eBuffFeatureType.NotBeSelected) or role:ContainBuffFeature(eBuffFeatureType.NotBeSelectedExceptSameBlong) then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
    if targetlist.Count < 1 then
      if self.timer ~= nil then
        (self.timer):Stop()
        self.timer = nil
      end
      return 
    end
    LuaSkillCtrl:CallEffect((targetlist[0]).targetRole, (self.config).effectIdAttack, self, self.SkillEventFunc)
  else
    do
      LuaSkillCtrl:CallEffect(role, (self.config).effectIdAttack, self, self.SkillEventFunc)
    end
  end
end

bs_10147.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
end

bs_10147.OnBeforePlaySkill = function(self, role, context)
  -- function num : 0_6
  local tier = (self.caster):GetBuffTier((self.config).buffId)
  if role == self.caster and (context.skill).isCommonAttack and tier > 0 then
    local passdata = {effectId = (self.config).effectId}
    context.passdata = passdata
  end
end

bs_10147.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10147

