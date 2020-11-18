-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_306 = class("bs_306", LuaSkillBase)
local base = LuaSkillBase
bs_306.config = {effectId1 = 10138, buffId1 = 136}
bs_306.ctor = function(self)
  -- function num : 0_0
end

bs_306.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_306_1", 1, self.OnSetHurt)
  self:AddTrigger(eSkillTriggerType.BuffDie, "bs_306_2", 1, self.OnBuffDie)
end

bs_306.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(30)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20, attackTrigger)
end

bs_306.OnAttackTrigger = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, 1, (self.arglist)[1])
  self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
end

bs_306.OnSetHurt = function(self, context)
  -- function num : 0_4 , upvalues : _ENV
  if (self.caster):GetBuffTier((self.config).buffId1) ~= 0 and (context.skill).isCommonAttack and context.hurt > 0 and context.target == self.caster then
    context.hurt = 0
    LuaSkillCtrl:CallFloatText(self.caster, 7)
  end
  if context.sender == self.caster and (self.arglist)[3] >= 0 then
    LuaSkillCtrl:CallHeal(context.hurt * 300 // 1000, self, self.caster)
  end
end

bs_306.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_5
  if target == self.caster and buff.dataId == (self.config).buffId1 and self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
end

bs_306.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_306

