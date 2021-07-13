-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1059 = class("bs_1059", LuaSkillBase)
local base = LuaSkillBase
bs_1059.config = {effectId_end = 10222, effectId_line = 10223, effect_speed = 0.5, buffId_162 = 162, buff_tier = 1, 
heal_config = {baseheal_formula = 10011, heal_number = 0, correct_formula = 9990}
, 
heal_config2 = {baseheal_formula = 10089, heal_number = 0, correct_formula = 9990}
, audioId_start = 100, audioId_action = 101, audioId_end = 102, actionId_start = 1005, actionId_end = 1006}
bs_1059.ctor = function(self)
  -- function num : 0_0
end

bs_1059.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_1059.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_end, self, nil, nil, (self.config).effect_speed)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
  LuaSkillCtrl:CallBattleCamShake()
end

bs_1059.CallSelectExecute = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if role ~= nil and role.belongNum == (self.caster).belongNum then
    self.target = role
    LuaSkillCtrl:CallEffect(role, (self.config).effectId_line, self)
    LuaSkillCtrl:CallBuffRepeated(self, role, (self.config).buffId_162, (self.config).buff_tier, (self.arglist)[2], true, self.OnBuffExecute)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, nil, false, false)
    skillResult:EndResult()
  end
end

bs_1059.OnBuffExecute = function(self, buff, targetRole)
  -- function num : 0_4 , upvalues : _ENV
  if targetRole == nil or targetRole.hp <= 0 then
    return 
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config2)
  skillResult:EndResult()
end

bs_1059.PlayUltEffect = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_start)
  if selectRoles ~= nil and selectRoles.Count > 0 then
    self.target = selectRoles[0]
  end
  if self.target ~= nil then
    (self.caster):LookAtInstantly(self.target)
  end
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_1059_3", 1, self.OnMovieFadeOut)
end

bs_1059.OnUltRoleAction = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.OnUltView)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).actionId_start)
end

bs_1059.OnUltView = function(self)
  -- function num : 0_7 , upvalues : _ENV
  LuaSkillCtrl:CallPlayUltMovie()
  self.roleActionAudio = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_action)
end

bs_1059.OnSkipUltView = function(self)
  -- function num : 0_8 , upvalues : base, _ENV
  (base.OnSkipUltView)(self)
  if self.roleActionAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.roleActionAudio)
    self.roleActionAudio = nil
  end
end

bs_1059.OnMovieFadeOut = function(self)
  -- function num : 0_9 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_end)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).actionId_end)
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_end, self, nil, nil, (self.config).effect_speed)
end

bs_1059.OnCasterDie = function(self)
  -- function num : 0_10 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1059

