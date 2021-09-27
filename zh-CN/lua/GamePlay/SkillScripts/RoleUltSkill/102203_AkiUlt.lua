local bs_102203 = class("bs_102203", LuaSkillBase)
local base = LuaSkillBase
bs_102203.config = {
hurt_config = {hit_formula = 0, basehurt_formula = 3000, def_formula = 9996, minhurt_formula = 9994, crit_formula = 0, crithur_ratio = 9995, correct_formula = 9989, lifesteal_formula = 1001, spell_lifesteal_formula = 1002, returndamage_formula = 1000, hurt_type = -1}
, effectUltID = 102201, select_Id = 7, selectRange = 10, audioIdStart = 102201, audioIdMovie = 102202, audioId_hit = 102203}
bs_102203.ctor = function(self)
  -- function num : 0_0
end

bs_102203.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self.hurteffect = nil
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_102203_1", 10, self.OnRoleDie)
end

bs_102203.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(20)
  do
    if selectTargetCoord ~= nil then
      local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
      ;
      (self.caster):LookAtTarget(inputTarget)
    end
    return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
  end
end

bs_102203.CallSelectExecute = function(self, role)
  -- function num : 0_3
  self:Hurt(role, self.caster)
end

bs_102203.Hurt = function(self, role, caster)
  -- function num : 0_4 , upvalues : _ENV
  if role ~= nil then
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_hit)
    self.hurteffect = LuaSkillCtrl:CallEffectWithArgOverride(role, (self.config).effectUltID, self, caster, false, nil, self.SkillEventFunc)
  end
end

bs_102203.OnRoleDie = function(self, killer, role)
  -- function num : 0_5 , upvalues : _ENV
  if role == self.target_skill and role.hp == 0 and role ~= nil then
    if self.hurteffect ~= nil then
      (self.hurteffect):Die()
      self.hurteffect = nil
    end
    LuaSkillCtrl:StartTimer(self, 5, function()
    -- function num : 0_5_0 , upvalues : _ENV, self, role
    local target = LuaSkillCtrl:CallTargetSelect(self, (self.config).select_Id, 10)
    if target.Count > 0 then
      local role_new = (target[0]).targetRole
      self:Hurt(role_new, role)
    end
  end
)
  end
end

bs_102203.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_6 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    self.target_skill = target.targetRole
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    local num = ((target.targetRole).maxHp - (target.targetRole).hp) * 1000 // (target.targetRole).maxHp // (self.arglist)[2] * (self.arglist)[3]
    local prob = (self.arglist)[1] * (1000 + num) // 1000
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {prob}, false)
    skillResult:EndResult()
    if target.HP ~= 0 then
      self.target_skill = nil
    end
  end
end

bs_102203.PlayUltEffect = function(self)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_102203.OnUltRoleAction = function(self)
  -- function num : 0_8 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

bs_102203.OnSkipUltView = function(self)
  -- function num : 0_9 , upvalues : base, _ENV
  (base.OnSkipUltView)(self)
  if self.roleActionAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.roleActionAudio)
    self.roleActionAudio = nil
  end
end

bs_102203.OnMovieFadeOut = function(self)
  -- function num : 0_10 , upvalues : _ENV, base
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  ;
  (base.OnMovieFadeOut)(self)
end

bs_102203.OnCasterDie = function(self)
  -- function num : 0_11 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_102203.LuaDispose = function(self)
  -- function num : 0_12 , upvalues : base
  (base.LuaDispose)(self)
  self.hurteffect = nil
end

return bs_102203

