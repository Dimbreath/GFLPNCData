-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100703 = class("bs_100703", LuaSkillBase)
local base = LuaSkillBase
bs_100703.config = {effectId_start = 10004, 
hurt_config = {hit_formula = 0, basehurt_formula = 10090}
, 
aoe_config = {effect_shape = 1, aoe_select_code = 4, aoe_range = 10}
, audioId1 = 43, audioId2 = 44, audioId3 = 45, fronttime = 15}
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
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).aoe_config)
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, nil, false)
    skillResult:EndResult()
  end
, nil)
  end
end

bs_100703.PlayUltEffect = function(self)
  -- function num : 0_4 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_100703_3", 1, self.OnMovieFadeOut)
end

bs_100703.OnUltRoleAction = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, (self.config).fronttime, self.OnRoleActionDelay)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
  self.effect = LuaSkillCtrl:CallEffect(self.caster, 10020, self)
end

bs_100703.OnRoleActionDelay = function(self)
  -- function num : 0_6 , upvalues : _ENV
  self.actionAudio = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  LuaSkillCtrl:CallPlayUltMovie()
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
end

bs_100703.OnSkipUltView = function(self)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.OnSkipUltView)(self)
  if self.actionAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.actionAudio)
    self.actionAudio = nil
  end
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
end

bs_100703.OnMovieFadeOut = function(self)
  -- function num : 0_8 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
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

