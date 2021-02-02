-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101802 = class("bs_101802", LuaSkillBase)
local base = LuaSkillBase
bs_101802.config = {buffId = 219, effectId = 10670, 
heal_config = {baseheal_formula = 10089}
, 
Hurt_Config = {hit_formula = 0, def_formula = 0, basehurt_formula = 502, minhurt_formula = 0, crit_formula = 0, crithur_ratio = 0, correct_formula = 0, lifesteal_formula = 0, spell_lifesteal_formula = 0, returndamage_formula = 0}
}
bs_101802.ctor = function(self)
  -- function num : 0_0
end

bs_101802.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_101802_2", 90, self.OnSetHurt)
  self:AddTrigger(eSkillTriggerType.BuffDie, "bs_101801_9", 1, self.OnBuffDie)
end

bs_101802.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local target = LuaSkillCtrl:CallTargetSelect(self, 30, 0)
  if target.Count > 0 then
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    ;
    (self.caster):LookAtTarget((target[0]).targetRole)
    self:CallCasterWait(34)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, (target[0]).targetRole)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 12, attackTrigger)
  end
end

bs_101802.OnAttackTrigger = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  if target.hp > 0 then
    LuaSkillCtrl:CallEffect(target, (self.config).effectId, self, self.SkillEventFunc)
  end
  if target.hp <= 0 then
    local target_new = LuaSkillCtrl:CallTargetSelect(self, 30, 0)
    if target_new.Count > 0 then
      LuaSkillCtrl:CallEffect((target_new[0]).targetRole, (self.config).effectId, self, self.SkillEventFunc)
    end
  end
end

bs_101802.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if effect.dataId == (self.config).effectId and eventId == eBattleEffectEvent.Trigger then
    if (target.targetRole):GetBuffTier((self.config).buffId) > 0 then
      LuaSkillCtrl:DispelBuff(target.targetRole, (self.config).buffId, 1, true)
    end
    LuaSkillCtrl:CallBuffRepeated(self, target.targetRole, (self.config).buffId, 1, (self.arglist)[1], true, self.OnBuffExecute)
    self.buffhurt = 0
  end
end

bs_101802.OnSetHurt = function(self, context)
  -- function num : 0_5
  if (context.target):GetBuffTier((self.config).buffId) > 0 and (context.target).belongNum == (self.caster).belongNum and (context.skill).dataId ~= 101802 then
    self.buffhurt = self.buffhurt + context.hurt * (1000 - (self.arglist)[4]) // 1000
    context.hurt = context.hurt * (self.arglist)[4] // 1000
  end
end

bs_101802.OnBuffExecute = function(self, buff, targetRole)
  -- function num : 0_6 , upvalues : _ENV
  if targetRole:GetBuffTier((self.config).buffId) > 0 then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config)
    skillResult:EndResult()
  end
end

bs_101802.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_7 , upvalues : _ENV
  if buff.dataId == (self.config).buffId then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).Hurt_Config, {self.buffhurt}, true)
    skillResult:EndResult()
  end
end

bs_101802.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101802

