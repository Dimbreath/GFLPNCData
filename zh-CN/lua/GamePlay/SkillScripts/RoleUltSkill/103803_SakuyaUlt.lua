local bs_103803 = class("bs_103803", LuaSkillBase)
local base = LuaSkillBase
bs_103803.config = {
hurt_config = {hit_formula = 0, basehurt_formula = 3000, def_formula = 9996, minhurt_formula = 9994, crit_formula = 0, crithur_ratio = 9995, correct_formula = 9989, lifesteal_formula = 1001, spell_lifesteal_formula = 1002, returndamage_formula = 1000, hurt_type = -1}
, effect_start = 103801, effect_end = 103802, effect_hit = 103803, buffId_195 = 195, audioIdStart = 103801, audioIdMovie = 103802, audioIdEnd = 103803}
bs_103803.ctor = function(self)
  -- function num : 0_0
end

bs_103803.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_103803.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(13)
  if selectTargetCoord ~= nil then
    local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    ;
    (self.caster):LookAtTarget(inputTarget)
    LuaSkillCtrl:StartTimer(nil, 3, BindCallback(self, self.CallSkillExecute, selectRoles))
    LuaSkillCtrl:CallEffect(inputTarget, (self.config).effect_end, self)
  end
end

bs_103803.CallSkillExecute = function(self, selectRoles)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:StartTimer(self, 3, function()
    -- function num : 0_3_0 , upvalues : self, selectRoles, _ENV
    self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
  end
)
end

bs_103803.CallSelectExecute = function(self, role)
  -- function num : 0_4 , upvalues : _ENV
  if role ~= nil and role ~= nil and role.belongNum ~= (self.caster).belongNum then
    local skillResult = LuaSkillCtrl:CallEffect(role, (self.config).effect_hit, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
    local prob = (self.arglist)[1]
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {prob}, false)
    local tier = LuaSkillCtrl:CallRange((self.arglist)[2], (self.arglist)[3])
    LuaSkillCtrl:CallBuff(self, role, (self.config).buffId_195, tier, (self.arglist)[4])
    skillResult:EndResult()
  end
end

bs_103803.OnUltRoleAction = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

bs_103803.PlayUltEffect = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effect_start, self)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_103803.OnSkipUltView = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnSkipUltView)(self)
end

bs_103803.OnMovieFadeOut = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnMovieFadeOut)(self)
end

bs_103803.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103803

