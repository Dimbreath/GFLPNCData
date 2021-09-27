local bs_20110 = class("bs_20110", LuaSkillBase)
local base = LuaSkillBase
bs_20110.config = {timeDuration = 15, totalTime = 45}
bs_20110.ctor = function(self)
  -- function num : 0_0
end

bs_20110.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self.totalTime = (self.config).totalTime * 15
  self.timeValue = self.totalTime
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, (self.config).timeDuration, arriveCallBack, self, -1)
  local timeCallBack = BindCallback(self, self.TimeUp)
  LuaSkillCtrl:StartTimer(nil, self.totalTime, timeCallBack)
end

bs_20110.OnArriveAction = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.timeValue = self.timeValue - (self.config).timeDuration
  local showTime = (math.max)(0, self.timeValue // 15)
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
end

bs_20110.TimeUp = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:ForceEndBattle(true)
end

bs_20110.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_20110

