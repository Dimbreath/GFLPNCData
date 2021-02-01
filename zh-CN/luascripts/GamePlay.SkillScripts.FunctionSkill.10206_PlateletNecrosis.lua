-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10206 = class("bs_10206", LuaSkillBase)
local base = LuaSkillBase
bs_10206.config = {buffId = 195, effectId = 134, 
realDamageConfig = {basehurt_formula = 10072}
, nEffectId = 10756, nEffectId2 = 10757}
bs_10206.ctor = function(self)
  -- function num : 0_0
end

bs_10206.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.SetHurt, "bs_10206_2", 1, self.OnSetHurt)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10206_3", 3, self.OnAfterPlaySkill)
  self.flag = false
end

bs_10206.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if skill.maker == self.caster and not skill.isCommonAttack then
    self.flag = true
    if self.caoTimer ~= nil then
      (self.caoTimer):Stop()
      self.caoTimer = nil
    end
    local arriveCallBack = BindCallback(self, self.OnArriveAction, self.caster)
    self.caoTimer = LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], arriveCallBack, nil, 1, 0)
    self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).nEffectId, self, self.SkillEventFunc)
  end
end

bs_10206.OnArriveAction = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
  LuaSkillCtrl:CallEffect(self.caster, (self.config).nEffectId2, self, self.SkillEventFunc)
  self.flag = false
end

bs_10206.OnSetHurt = function(self, context)
  -- function num : 0_4 , upvalues : _ENV
  if context.sender == self.caster and (context.skill).isCommonAttack and not context.isMiss and not context.isTriggerSet and self.flag and (self.arglist)[2] > 0 and (self.arglist)[3] > 0 then
    self:PlayChipEffect()
    local tier = (self.arglist)[2]
    local time = (self.arglist)[3]
    LuaSkillCtrl:CallBuff(self, context.target, (self.config).buffId, tier, time)
    LuaSkillCtrl:CallEffect(context.target, (self.config).effectId, self, nil)
  end
end

bs_10206.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10206

