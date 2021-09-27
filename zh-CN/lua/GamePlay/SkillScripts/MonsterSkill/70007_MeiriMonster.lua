local bs_70007 = class("bs_70007", LuaSkillBase)
local base = LuaSkillBase
bs_70007.config = {timeDuration = 15}
bs_70007.ctor = function(self)
  -- function num : 0_0
end

bs_70007.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self.totalTime = (self.arglist)[1]
  self.timeValue = self.totalTime
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, (self.config).timeDuration, arriveCallBack, self, -1)
  local timeCallBack = BindCallback(self, self.TimeUp)
  LuaSkillCtrl:StartTimer(nil, self.totalTime, timeCallBack)
end

bs_70007.OnArriveAction = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.timeValue = self.timeValue - (self.config).timeDuration
  local showTime = self.timeValue // 15
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
end

bs_70007.TimeUp = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:ForceEndBattle(false)
end

bs_70007.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_70007

