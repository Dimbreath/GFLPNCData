local bs_103103 = class("bs_103103", LuaSkillBase)
local base = LuaSkillBase
bs_103103.config = {buff_sleep = 103101, buff_strong = 103102, buff_heal = 103103, 
heal_config = {baseheal_formula = 3022}
, buffFeature_stun = 7, audioIdStart = 103105, audioIdMovie = 103106, audioIdEnd = 103107}
bs_103103.AbandonTakeFeature = {eBuffFeatureType.Stun, eBuffFeatureType.KnockOff}
bs_103103.ctor = function(self)
  -- function num : 0_0
end

bs_103103.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddBuffDieTrigger("bs_103103_1", 10, self.OnBuffDie, nil, nil, (self.config).buff_sleep)
end

bs_103103.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
  ;
  (self.caster):LookAtTarget(inputTarget)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

bs_103103.CallSelectExecute = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if role ~= nil and role.belongNum == (self.caster).belongNum then
    LuaSkillCtrl:CallBuff(self, role, (self.config).buff_sleep, 1, (self.arglist)[3], false)
    LuaSkillCtrl:CallBuffRepeated(self, role, (self.config).buff_heal, 1, (self.arglist)[3], false, self.OnBuffExecute)
  end
end

bs_103103.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_4 , upvalues : _ENV
  if buff.dataId == (self.config).buff_sleep then
    LuaSkillCtrl:CallBuff(self, target, (self.config).buff_strong, 1, (self.arglist)[2], false)
  end
end

bs_103103.OnBuffExecute = function(self, buff, targetRole)
  -- function num : 0_5 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {(self.arglist)[4]})
  skillResult:EndResult()
end

bs_103103.PlayUltEffect = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_6 , upvalues : base, _ENV
  if not self:Check(selectRoles) then
    return true
  end
  ;
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_103103.Check = function(self, selectRoles)
  -- function num : 0_7
  if selectRoles == nil or selectRoles.Count <= 0 then
    return false
  end
  return self:CheckManualSkillTakeAvailable(selectRoles[0])
end

bs_103103.OnUltRoleAction = function(self)
  -- function num : 0_8 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_103103.OnSkipUltView = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnSkipUltView)(self)
end

bs_103103.OnMovieFadeOut = function(self)
  -- function num : 0_10 , upvalues : base
  (base.OnMovieFadeOut)(self)
end

bs_103103.OnCasterDie = function(self)
  -- function num : 0_11 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103103

