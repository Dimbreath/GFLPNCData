local bs_100303 = class("bs_100303", LuaSkillBase)
local base = LuaSkillBase
bs_100303.config = {
hurt_config = {hit_formula = 0, basehurt_formula = 3023, crit_formula = 0, returndamage_formula = 0, hurt_type = 1}
, 
real_Config = {basehurt_formula = 502, lifesteal_formula = 0, spell_lifesteal_formula = 0, returndamage_formula = 0, hurt_type = 2}
, effectId_start = 10310, effectId_hit = 10343, buffId = 3011, audioIdStart = 100309, audioIdMovie = 100310, audioIdEnd = 100311, actionId_start = 1005, movieEndRoleActionId = 1006}
bs_100303.ctor = function(self)
  -- function num : 0_0
end

bs_100303.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_100303.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(23)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
  if selectTargetCoord ~= nil then
    local inputTarget = LuaSkillCtrl:GetTargetWithGrid(selectTargetCoord.x, selectTargetCoord.y)
    ;
    (self.caster):LookAtTarget(inputTarget)
    LuaSkillCtrl:CallEffect(inputTarget, (self.config).effectId_start, self)
  end
end

bs_100303.CallSelectExecute = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if role ~= nil and role ~= nil and role.belongNum ~= (self.caster).belongNum and not role.unableSelect then
    LuaSkillCtrl:StartTimer(self, 5, BindCallback(self, self.CallSingleHurtEffect, role))
  end
end

bs_100303.CallSingleHurtEffect = function(self, role)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(role, (self.config).effectId_hit, self, self.SkillEventFunc1, nil, 1)
end

bs_100303.SkillEventFunc1 = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {(self.arglist)[1]}, false)
    skillResult:EndResult()
    local roleBuffTier = (target.targetRole):GetBuffTier((self.config).buffId)
    if roleBuffTier > 0 then
      local hurt = roleBuffTier * (self.caster).skill_intensity * (self.arglist)[2] // 1000
      if hurt <= 0 then
        hurt = 1
      end
      LuaSkillCtrl:CallRealDamage(self, target, nil, (self.config).real_Config, {hurt}, true)
    end
  end
end

bs_100303.PlayUltEffect = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_100303.OnUltRoleAction = function(self)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).actionId_start)
end

bs_100303.OnSkipUltView = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnSkipUltView)(self)
end

bs_100303.OnMovieFadeOut = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnMovieFadeOut)(self)
end

bs_100303.OnCasterDie = function(self)
  -- function num : 0_10 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100303

