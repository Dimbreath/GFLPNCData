local bs_101304 = class("bs_101304", LuaSkillBase)
local base = LuaSkillBase
bs_101304.config = {
hurt_config = {hit_formula = 0, basehurt_formula = 3000, crit_formula = 0, crithur_ratio = 0, returndamage_formula = 0}
, effectId = 101307, buffId = 195, audioIdStart = 101306, audioIdMovie = 101307, audioIdEnd = 101308, movieEndRoleActionId = 1006}
bs_101304.ctor = function(self)
  -- function num : 0_0
end

bs_101304.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_101304.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(13)
  LuaSkillCtrl:StartTimer(nil, 3, BindCallback(self, self.CallSkillExecute, selectRoles))
  if selectTargetCoord ~= nil then
    local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    ;
    (self.caster):LookAtTarget(inputTarget)
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.caster).recordTable).lastAttackRole = nil
    LuaSkillCtrl:CallEffect(inputTarget, (self.config).effectId, self)
  end
end

bs_101304.CallSkillExecute = function(self, selectRoles)
  -- function num : 0_3 , upvalues : _ENV
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

bs_101304.CallSelectExecute = function(self, role)
  -- function num : 0_4 , upvalues : _ENV
  if role ~= nil and role ~= nil and role.belongNum ~= (self.caster).belongNum and not role.unableSelect then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {(self.arglist)[1]})
    skillResult:EndResult()
    LuaSkillCtrl:CallBuff(self, role, (self.config).buffId, (self.arglist)[2], (self.arglist)[3])
  end
end

bs_101304.PlayUltEffect = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_101304.OnUltRoleAction = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_101304.OnSkipUltView = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnSkipUltView)(self)
end

bs_101304.OnMovieFadeOut = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnMovieFadeOut)(self)
end

bs_101304.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101304

