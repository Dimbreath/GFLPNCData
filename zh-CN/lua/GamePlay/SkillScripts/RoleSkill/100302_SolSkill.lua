local bs_100302 = class("bs_100302", LuaSkillBase)
local base = LuaSkillBase
bs_100302.config = {buffId_lz1 = 100301, buffId_lz2 = 100601, buffId_fire = 3011, effectId_fire = 100304, effectId_lz = 100307, effectId_firehit = 100305, 
HurtConfig = {hit_formula = 0, basehurt_formula = 3010, crit_formula = 0}
, 
HurtConfig2 = {hit_formula = 0, def_formula = 0, basehurt_formula = 3010, crit_formula = 0, returndamage_formula = 0, hurt_type = 2}
, skill_time = 33, start_time = 9, actionId = 1004, action_speed = 1}
bs_100302.ctor = function(self)
  -- function num : 0_0
end

bs_100302.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_100302_8", 1, self.OnAfterAddBuff, nil, nil, nil, nil, (self.config).buffId_lz1)
  self:AddBeforeBuffDispelTrigger("bs_100302_10", 1, self.OnBeforBuffDispel, nil, nil, (self.config).buffId_lz1)
end

bs_100302.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local last_target = ((self.caster).recordTable).lastAttackRole
  local target = nil
  if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral and LuaSkillCtrl:IsAbleAttackTarget(self.caster, last_target, 1) then
    target = last_target
  else
    local tempTarget = self:GetMoveSelectTarget()
    if tempTarget == nil then
      return 
    end
    target = tempTarget.targetRole
  end
  do
    if target ~= nil then
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, target)
      ;
      (self.caster):LookAtTarget(target)
      self:CallCasterWait((self.config).skill_time)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, attackTrigger)
      LuaSkillCtrl:CallEffect(target, (self.config).effectId_fire, self, nil, nil, nil, true)
    end
  end
end

bs_100302.OnAttackTrigger = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(target, (self.config).effectId_firehit, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {(self.arglist)[1]})
  skillResult:EndResult()
  LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_lz1, 1)
  LuaSkillCtrl:StartTimer(self, 10, function()
    -- function num : 0_3_0 , upvalues : _ENV, target, self
    LuaSkillCtrl:CallEffect(target, (self.config).effectId_firehit, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {(self.arglist)[1]})
    skillResult:EndResult()
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_lz1, 1)
  end
)
end

bs_100302.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_4 , upvalues : _ENV
  if buff.dataId == (self.config).buffId_lz1 and target ~= nil and target.hp > 0 and target:GetBuffTier((self.config).buffId_lz1) + target:GetBuffTier((self.config).buffId_lz2) == 4 then
    local buffs = LuaSkillCtrl:GetRoleBuffs(target)
    if buffs.Count <= 0 then
      return 
    end
    local _1tier = target:GetBuffTier((self.config).buffId_lz1)
    local _2tier = 0
    for i = 0, buffs.Count - 1 do
      if (buffs[i]).dataId == (self.config).buffId_lz2 and (buffs[i]).maker ~= nil and ((buffs[i]).maker).hp > 0 then
        _2tier = target:GetBuffTier((self.config).buffId_lz2)
      end
    end
    if _2tier == 0 then
      _1tier = 4
    end
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    local hurt_arg = 400 * _1tier
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig2, {hurt_arg})
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(target, (self.config).effectId_lz, self)
    LuaSkillCtrl:DispelBuff(target, (self.config).buffId_lz1, 0, true)
    LuaSkillCtrl:DispelBuff(target, (self.config).buffId_lz2, 0)
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_fire, 1)
  end
end

bs_100302.OnBeforBuffDispel = function(self, target, context)
  -- function num : 0_5 , upvalues : _ENV
  if context.buffId == (self.config).buffId_lz1 then
    local _1tier = target:GetBuffTier((self.config).buffId_lz1)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    local hurt_arg = 400 * _1tier
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig2, {hurt_arg})
    skillResult:EndResult()
  end
end

bs_100302.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100302

