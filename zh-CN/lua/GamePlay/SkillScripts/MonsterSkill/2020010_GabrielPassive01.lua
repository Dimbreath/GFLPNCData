local bs_2000010 = require("GamePlay.SkillScripts.MonsterSkill.200001_Boss_mianyi")
local bs_2020010 = class("bs_2020010", bs_2000010)
local base = bs_2000010
bs_2020010.config = {timeDuration = 15}
bs_2020010.config = setmetatable(bs_2020010.config, {__index = base.config})
bs_2020010.ctor = function(self)
  -- function num : 0_0
end

bs_2020010.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["520_arg1"] = (self.arglist)[1]
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["520_arg2"] = (self.arglist)[2]
  self.totalTime = 1800
  self.timeValue = self.totalTime
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, (self.config).timeDuration, arriveCallBack, self, -1)
  local timeCallBack = BindCallback(self, self.TimeUp)
  LuaSkillCtrl:StartTimer(nil, self.totalTime, timeCallBack)
  LuaSkillCtrl:RecordLimitTime(self.totalTime)
end

bs_2020010.OnArriveAction = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.timeValue = self.timeValue - (self.config).timeDuration
  local showTime = self.timeValue // 15
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
end

bs_2020010.TimeUp = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:ForceEndBattle(false)
end

bs_2020010.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_2020010

