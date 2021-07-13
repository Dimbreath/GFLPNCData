-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100503 = class("bs_100503", LuaSkillBase)
local base = LuaSkillBase
bs_100503.config = {effectId_Ult = 10262, 
hurt_config = {hit_formula = 10010, basehurt_formula = 10057}
, 
series_0 = {1, 3, 9, 15, 18}
, 
series_1 = {2, 5, 8, 14, 17}
, 
series_2 = {4, 7, 10, 13, 19}
, 
series_3 = {1, 6, 10, 15, 21}
, 
series_4 = {5, 8, 12, 20, 22}
, audioId1 = 97, audioId2 = 98, audioId3 = 99, selectId = 9, select_Range = 10, skill_times = 5}
bs_100503.ctor = function(self)
  -- function num : 0_0
end

bs_100503.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self.hurt_config = {}
end

bs_100503.PlaySkill = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(20)
  local effectTarget = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(effectTarget, (self.config).effectId_Ult, self)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId, (self.config).select_Range)
  if targetList.Count <= 0 then
    return 
  end
  for i = 0, targetList.Count - 1 do
    do
      local series = i % 5
      for n = 1, (self.config).skill_times do
        LuaSkillCtrl:StartTimer(self, ((self.config)["series_" .. tostring(series)])[n], function()
    -- function num : 0_2_0 , upvalues : self, targetList, i
    self:RealPlaySkill((targetList[i]).targetRole)
  end
, nil)
      end
    end
  end
end

bs_100503.RealPlaySkill = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, nil, false)
  skillResult:EndResult()
end

bs_100503.PlayUltEffect = function(self)
  -- function num : 0_4 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 10, self.DelayAuSource)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_100503_3", 1, self.OnMovieFadeOut)
end

bs_100503.DelayAuSource = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self.delayAudio = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
end

bs_100503.OnUltRoleAction = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 19, self.OnRoleActionDelay)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_100503.OnRoleActionDelay = function(self)
  -- function num : 0_7 , upvalues : _ENV
  LuaSkillCtrl:CallPlayUltMovie()
  self.actionAudio = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
end

bs_100503.OnSkipUltView = function(self)
  -- function num : 0_8 , upvalues : base, _ENV
  (base.OnSkipUltView)(self)
  if self.delayAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.delayAudio)
    self.delayAudio = nil
  end
  if self.actionAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.actionAudio)
    self.actionAudio = nil
  end
end

bs_100503.OnMovieFadeOut = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self.actionaudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.actionaudio)
    self.actionaudio = nil
  end
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId3)
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
end

bs_100503.OnCasterDie = function(self)
  -- function num : 0_10 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_100503.LuaDispose = function(self)
  -- function num : 0_11 , upvalues : base
  (base.LuaDispose)(self)
  self.actionaudio = nil
end

return bs_100503

