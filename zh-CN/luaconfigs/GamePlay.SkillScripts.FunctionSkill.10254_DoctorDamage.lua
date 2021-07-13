-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10254 = class("bs_10254", LuaSkillBase)
local base = LuaSkillBase
bs_10254.config = {
hurt_config = {basehurt_formula = 10087}
, effectId_start = 10802, effectId_line = 10804, effectId_end = 10803}
bs_10254.ctor = function(self)
  -- function num : 0_0
end

bs_10254.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10254_12", 1, self.OnAfterPlaySkill)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_10254_1", 1, self.OnHurtResultStart)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultEnd, "bs_10254_15", 1, self.OnHurtResultEnd)
  self.flag = false
end

bs_10254.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if role == self.caster and not skill.isCommonAttack and not self.flag then
    self.flag = true
    self:SelectMinHpTarget()
    LuaSkillCtrl:CallAddRoleProperty(self.caster, eHeroAttr.attackRange, 10, eHeroAttrType.Origin)
  end
end

bs_10254.SelectMinHpTarget = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 7, 10)
  if targetlist.Count < 1 then
    self.flag = false
    return 
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).lastAttackRole = (targetlist[0]).targetRole
end

bs_10254.OnHurtResultStart = function(self, skill, context)
  -- function num : 0_4 , upvalues : _ENV
  if context.sender == self.caster and skill.isCommonAttack and self.flag then
    context.new_config = (self.config).hurt_config
    context.skill = self.cskill
    setmetatable(context.new_config, {__index = context.config})
    self:PlayChipEffect()
    self.flag = false
  end
end

bs_10254.OnHurtResultEnd = function(self, skill, targetRole, hurtValue)
  -- function num : 0_5 , upvalues : _ENV
  if skill.maker == self.caster and skill == self.cskill then
    LuaSkillCtrl:CallAddRoleProperty(self.caster, eHeroAttr.attackRange, -10, eHeroAttrType.Origin)
    LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId_start, self)
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 14, 10)
    if targetlist.Count < 1 then
      return 
    end
    self.heal = hurtValue * (self.arglist)[2] // 1000
    if self.heal < 1 then
      self.heal = 1
    end
    LuaSkillCtrl:CallEffect((targetlist[0]).targetRole, (self.config).effectId_line, self, self.SkillEventFunc, targetRole)
  end
end

bs_10254.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_6 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallHeal(self.heal, self, target, true)
  end
end

bs_10254.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10254

