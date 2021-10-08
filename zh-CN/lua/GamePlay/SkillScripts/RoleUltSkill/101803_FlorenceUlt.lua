local bs_10803 = class("bs_10803", LuaSkillBase)
local base = LuaSkillBase
bs_10803.config = {effectId_start = 101808, buff_Up = 101804, actionId_start = 1005, movieEndRoleActionId = 1002, audioIdStart = 101806, audioIdMovie = 101807, audioIdEnd = 101808}
bs_10803.ctor = function(self)
  -- function num : 0_0
end

bs_10803.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_10803.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  LuaSkillCtrl:CallBattleCamShake()
  if selectRoles == nil or selectRoles.Count <= 0 then
    return 
  end
  local role = selectRoles[0]
  LuaSkillCtrl:StartTimer(self, 3, function(selectRole)
    -- function num : 0_2_0 , upvalues : _ENV, self
    if selectRole ~= nil then
      LuaSkillCtrl:CallEffect(selectRole, (self.config).effectId_start, self)
    end
  end
, role)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

bs_10803.CallSelectExecute = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if role == nil or role.hp <= 0 then
    return 
  end
  if role.belongNum == (self.caster).belongNum then
    local hurt = role.hp * (self.arglist)[2] // 1000
    if hurt < role.hp and hurt ~= 0 then
      LuaSkillCtrl:RemoveLife(hurt, self, role, false, nil, false, true, eHurtType.RealDmg)
    end
    LuaSkillCtrl:CallBuff(self, role, (self.config).buff_Up, 1, (self.arglist)[1], false)
  end
end

bs_10803.PlayUltEffect = function(self)
  -- function num : 0_4 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_10803.OnUltRoleAction = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).actionId_start)
end

bs_10803.OnSkipUltView = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnSkipUltView)(self)
end

bs_10803.OnMovieFadeOut = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnMovieFadeOut)(self)
end

bs_10803.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10803

