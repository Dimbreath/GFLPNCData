local bs_104003 = class("bs_104003", LuaSkillBase)
local base = LuaSkillBase
bs_104003.config = {buff_xinruo2 = 104002, buff_shenghua3 = 104003, effect_ZD = 104006, audioIdStart = 104004, audioIdMovie = 104005, audioIdEnd = 104006}
bs_104003.ctor = function(self)
  -- function num : 0_0
end

bs_104003.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_104003.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
  ;
  (self.caster):LookAtTarget(inputTarget)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

bs_104003.CallSelectExecute = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if role ~= nil then
    if role.belongNum == eBattleRoleBelong.player then
      LuaSkillCtrl:CallEffect(role, (self.config).effect_ZD, self, self.SkillEventFuncPlayer)
    end
    if role.belongNum == eBattleRoleBelong.enemy then
      LuaSkillCtrl:CallEffect(role, (self.config).effect_ZD, self, self.SkillEventFuncEnemy)
    end
  end
end

bs_104003.SkillEventFuncPlayer = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).buff_shenghua3, 1, (self.arglist)[1], false)
  end
end

bs_104003.SkillEventFuncEnemy = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).buff_xinruo2, 1, (self.arglist)[2], false)
  end
end

bs_104003.PlayUltEffect = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_104003.OnUltRoleAction = function(self)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

bs_104003.OnSkipUltView = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnSkipUltView)(self)
end

bs_104003.OnMovieFadeOut = function(self)
  -- function num : 0_9 , upvalues : _ENV, base
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  ;
  (base.OnMovieFadeOut)(self)
end

bs_104003.OnCasterDie = function(self)
  -- function num : 0_10 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_104003

