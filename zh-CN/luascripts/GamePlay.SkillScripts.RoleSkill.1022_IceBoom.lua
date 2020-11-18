-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1022 = class("bs_1022", LuaSkillBase)
local base = LuaSkillBase
bs_1022.config = {effectId = 10004, 
hurt_config = {hit_formula = 10010, basehurt_formula = 10015}
, 
aoe_config = {effect_shape = 1, aoe_select_code = 4, aoe_range = 10}
, audioId1 = 43, audioId2 = 44, audioId3 = 45}
bs_1022.ctor = function(self)
  -- function num : 0_0
end

bs_1022.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self.hurt_config = {}
end

bs_1022.PlaySkill = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local effectTarget = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(effectTarget, (self.config).effectId, self, self.SkillEventFunc, nil, 0.5)
  LuaSkillCtrl:CallBattleCamShake()
end

bs_1022.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:StartTimer(self, 5, function()
    -- function num : 0_3_0 , upvalues : _ENV, effect, target, self
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).aoe_config)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
, nil)
  end
end

bs_1022.PlayUltEffect = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((self.caster).auSource):PlayAudioById((self.config).audioId3)
  LuaSkillCtrl:StartTimerInUlt(35, function()
    -- function num : 0_4_0 , upvalues : self
    ((self.caster).auSource):PlayAudioById((self.config).audioId1)
  end
, self)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  self:AddTrigger(eSkillTriggerType.AfterSelfUltInTimeLineEnd, "bs_1022_1", 1, self.AfterFocusTimeLine)
  self:AddTrigger(eSkillTriggerType.AfterSelfUltMovieEnd, "bs_1022_2", 1, self.OnMovieEnd)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_1022_3", 1, self.OnMovieFadeOut)
end

bs_1022.OnUltRoleAction = function(self)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
  self.effect = LuaSkillCtrl:CallEffect(self.caster, 10020, self)
end

bs_1022.AfterFocusTimeLine = function(self)
  -- function num : 0_6 , upvalues : _ENV
  LuaSkillCtrl:StartTimerInUlt(11, function()
    -- function num : 0_6_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallPlayUltMovie()
    if self.effect ~= nil then
      (self.effect):Die()
      self.effect = nil
    end
  end
, nil)
  self:RemoveTrigger(eSkillTriggerType.AfterSelfUltInTimeLineEnd)
end

bs_1022.OnMovieFadeOut = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((self.caster).auSource):PlayAudioById((self.config).audioId2)
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  self:RemoveTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  self:RemoveTrigger(eSkillTriggerType.AfterSelfUltMovieEnd)
end

bs_1022.OnMovieEnd = function(self)
  -- function num : 0_8
end

bs_1022.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1022

