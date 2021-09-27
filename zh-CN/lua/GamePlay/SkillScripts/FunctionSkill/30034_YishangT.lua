local bs_30034 = class("bs_30034", LuaSkillBase)
local base = LuaSkillBase
bs_30034.config = {effectId = 10900, effectId2 = 10901, buffId = 1059, 
aoe_config = {effect_shape = 2, aoe_select_code = 5, aoe_range = 1}
, 
hurt_config = {hit_formula = 0, basehurt_formula = 10088, minhurt_formula = 9994, crit_formula = 0}
}
bs_30034.ctor = function(self)
  -- function num : 0_0
end

bs_30034.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_30034_3", 3, self.OnAfterPlaySkill)
  self:AddAfterHurtTrigger("bs_30034_2", 20, self.OnAfterHurt, self.caster)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["30034_attackflag"] = false
end

bs_30034.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if skill.maker == self.caster and skill.isCommonAttack and ((self.caster).recordTable)["30034_attackflag"] and not isTriggerSet then
    local loopTime = (self.arglist)[1]
    local loopJiange = (self.arglist)[3] // (self.arglist)[1]
    local arriveCallBack = BindCallback(self, self.OnArriveAction, target)
    local arriveCallBack1 = BindCallback(self, self.OnArriveAction1, target)
    if self.effect == nil then
      self.effect = LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
    end
    if self.timer == nil then
      self.timer = LuaSkillCtrl:StartTimer(nil, loopJiange, arriveCallBack, self, loopTime - 1, loopJiange)
    end
    LuaSkillCtrl:StartTimer(nil, (self.arglist)[3], arriveCallBack1, self)
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R13 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["30034_attackflag"] = false
  end
end

bs_30034.OnArriveAction1 = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
  LuaSkillCtrl:CallEffect(role, (self.config).effectId2, self)
end

bs_30034.OnArriveAction = function(self, role)
  -- function num : 0_4 , upvalues : _ENV
  if self.timer ~= nil and (self.timer):IsOver() then
    self.timer = nil
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role, (self.config).aoe_config)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config)
  skillResult:EndResult()
end

bs_30034.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  if skill.maker == self.caster and not skill.isCommonAttack then
    ((self.caster).recordTable)["30034_attackflag"] = true
  end
end

bs_30034.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_30034

