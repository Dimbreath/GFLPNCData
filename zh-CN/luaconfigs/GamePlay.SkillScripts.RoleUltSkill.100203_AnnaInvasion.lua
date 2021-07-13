-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100203 = class("bs_100203", LuaSkillBase)
local base = LuaSkillBase
bs_100203.config = {effectId_start = 10316, effectId_end = 10318, effectId_self = 10341, effect_speed = 1, buffId_168 = 168, tier = 1, fronttime = 13, audioId_start = 93, audioId_action = 94, audioId_effect = 95, audioId_hit = 96, selectId = 9, select_range = 10, action_start = 1005, action_end = 1006}
bs_100203.ctor = function(self)
  -- function num : 0_0
end

bs_100203.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self.hurt_config = {}
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_100203_3", 1, self.BeforeEndBattle)
end

bs_100203.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId, (self.config).select_range)
  if targetList.Count <= 0 then
    return 
  end
  local effectTarget = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(effectTarget, (self.config).effectId_start, self, nil, nil, (self.config).effect_speed)
  for i = 0, targetList.Count - 1 do
    do
      local time = ((targetList[i]).targetRole).x * 2
      LuaSkillCtrl:StartTimer(nil, time, function()
    -- function num : 0_2_0 , upvalues : _ENV, targetList, i, self
    LuaSkillCtrl:CallEffect((targetList[i]).targetRole, (self.config).effectId_end, self)
    LuaSkillCtrl:CallBuff(self, (targetList[i]).targetRole, (self.config).buffId_168, (self.config).tier, (self.arglist)[1], false)
  end
, nil)
    end
  end
end

bs_100203.PlayUltEffect = function(self)
  -- function num : 0_3 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_start)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_100203_3", 1, self.OnMovieFadeOut)
end

bs_100203.OnUltRoleAction = function(self)
  -- function num : 0_4 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, (self.config).fronttime, self.OnRoleActionView)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).action_start)
  self.startEffect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_self, self)
end

bs_100203.OnRoleActionView = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self.roleActionAudio = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_action)
  LuaSkillCtrl:CallPlayUltMovie()
end

bs_100203.OnSkipUltView = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.OnSkipUltView)(self)
  if self.roleActionAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.roleActionAudio)
    self.roleActionAudio = nil
  end
end

bs_100203.OnMovieFadeOut = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self.startEffect ~= nil then
    (self.startEffect):Die()
    self.startEffect = nil
  end
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_effect)
  self.loopaudio = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId_hit)
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
    -- function num : 0_7_0 , upvalues : self, _ENV
    if self.loopaudio ~= nil then
      LuaSkillCtrl:StopAudioByBack(self.loopaudio)
      self.loopaudio = nil
    end
  end
)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).action_end)
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
end

bs_100203.BeforeEndBattle = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.loopaudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopaudio)
    self.loopaudio = nil
  end
end

bs_100203.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  if self.loopaudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopaudio)
    self.loopaudio = nil
  end
end

bs_100203.LuaDispose = function(self)
  -- function num : 0_10 , upvalues : base
  (base.LuaDispose)(self)
  self.startEffect = nil
  self.loopaudio = nil
end

return bs_100203

