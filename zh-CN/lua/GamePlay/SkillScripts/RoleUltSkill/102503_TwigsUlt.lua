local bs_102503 = class("bs_102503", LuaSkillBase)
local base = LuaSkillBase
bs_102503.config = {
hurt_config = {hit_formula = 0, basehurt_formula = 3000, crit_formula = 0}
, effect_start = 102501, effect_end = 102502, effect_hit = 102512, buff_fanhua = 102502, buffId_170 = 170, audioIdStart = 102501, audioIdMovie = 102502, audioIdEnd = 102503}
bs_102503.ctor = function(self)
  -- function num : 0_0
end

bs_102503.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_102503.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(13)
  LuaSkillCtrl:StartTimer(nil, 3, BindCallback(self, self.CallSkillExecute, selectRoles))
  if selectTargetCoord ~= nil then
    local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    ;
    (self.caster):LookAtTarget(inputTarget)
    local buff_fanhua = LuaSkillCtrl:GetRoleBuffById(self.caster, (self.config).buff_fanhua)
    do
      if buff_fanhua ~= nil then
        local duration = buff_fanhua.curDurationTime
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buff_fanhua, 1, duration + (self.arglist)[2], true)
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_170, 1, duration + (self.arglist)[2], true)
        LuaSkillCtrl:StopShowSkillDurationTime(self)
        LuaSkillCtrl:StartShowSkillDurationTime(self, duration + (self.arglist)[2])
      end
      LuaSkillCtrl:StartTimerInUlt(self, 12, function()
    -- function num : 0_2_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effect_start, self)
  end
)
      LuaSkillCtrl:CallEffect(inputTarget, (self.config).effect_end, self)
    end
  end
end

bs_102503.CallSkillExecute = function(self, selectRoles)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:StartTimer(self, 3, function()
    -- function num : 0_3_0 , upvalues : self, selectRoles, _ENV
    self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
  end
)
end

bs_102503.CallSelectExecute = function(self, role)
  -- function num : 0_4 , upvalues : _ENV
  if role ~= nil and role ~= nil and role.belongNum ~= (self.caster).belongNum then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {(self.arglist)[1]})
    skillResult:EndResult()
    LuaSkillCtrl:CallEffect(role, (self.config).effect_hit, self)
  end
end

bs_102503.OnUltRoleAction = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

bs_102503.PlayUltEffect = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_102503.OnSkipUltView = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnSkipUltView)(self)
end

bs_102503.OnMovieFadeOut = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  ;
  (base.OnMovieFadeOut)(self)
end

bs_102503.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102503

