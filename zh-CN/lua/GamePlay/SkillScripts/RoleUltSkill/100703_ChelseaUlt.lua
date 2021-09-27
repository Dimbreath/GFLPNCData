local bs_100703 = class("bs_100703", LuaSkillBase)
local base = LuaSkillBase
bs_100703.config = {effectId_start = 100706, effectId_Gun = 100707, 
hurt_config = {hit_formula = 0, basehurt_formula = 3024, returndamage_formula = 0}
, 
hurt_configF = {hit_formula = 0, basehurt_formula = 3027, returndamage_formula = 0}
, 
aoe_config = {effect_shape = 1, aoe_select_code = 4, aoe_range = 10}
, audioIdStart = 100704, audioIdMovie = 100705, audioIdEnd = 100706, fronttime = 15, movieEndRoleActionId = 1006, buffId_BingDong = 1178}
bs_100703.ctor = function(self)
  -- function num : 0_0
end

bs_100703.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self.hurt_config = {}
end

bs_100703.PlaySkill = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(20)
  local effectTarget = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(effectTarget, (self.config).effectId_start, self, self.SkillEventFunc, nil, 0.5)
  LuaSkillCtrl:CallBattleCamShake()
end

bs_100703.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:StartTimer(self, 5, function()
    -- function num : 0_3_0 , upvalues : _ENV, effect, target, self
    local skillResult = (LuaSkillCtrl:CallSkillResult(effect, target, (self.config).aoe_config))
    local hurtCfg = nil
    if self:IsConsumeSkill() then
      hurtCfg = (self.config).hurt_configF
    else
      hurtCfg = (self.config).hurt_config
    end
    LuaSkillCtrl:HurtResult(self, skillResult, hurtCfg, {(self.arglist)[1]})
    for i = 0, (skillResult.roleList).Count - 1 do
      if ((skillResult.roleList)[i]).belongNum == eBattleRoleBelong.enemy then
        LuaSkillCtrl:CallBuff(self, (skillResult.roleList)[i], (self.config).buffId_BingDong, (self.arglist)[2])
      end
    end
    skillResult:EndResult()
  end
, nil)
  end
end

bs_100703.PlayUltEffect = function(self)
  -- function num : 0_4 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_100703.OnUltRoleAction = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, (self.config).fronttime, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
  self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_Gun, self)
end

bs_100703.PlayUltMovie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.PlayUltMovie)(self)
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
end

bs_100703.OnSkipUltView = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnSkipUltView)(self)
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
end

bs_100703.OnMovieFadeOut = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnMovieFadeOut)(self)
end

bs_100703.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_100703.LuaDispose = function(self)
  -- function num : 0_10 , upvalues : base
  (base.LuaDispose)(self)
  self.effect = nil
end

return bs_100703

