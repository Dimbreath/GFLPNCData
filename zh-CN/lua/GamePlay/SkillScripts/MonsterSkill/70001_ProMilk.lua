local bs_70001 = class("bs_70001", LuaSkillBase)
local base = LuaSkillBase
bs_70001.config = {timeDuration = 15}
bs_70001.ctor = function(self)
  -- function num : 0_0
end

bs_70001.InitSkill = function(self, isMidwaySkill)
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
  self:AddAfterHealTrigger("bs_70001_5", 2, self.OnAfterHeal, nil, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_70001_1", 1, self.OnAfterBattleStart)
  LuaSkillCtrl:RecordLimitTime(self.totalTime)
end

bs_70001.OnAfterBattleStart = function(self)
  -- function num : 0_2
  local damage = (self.caster).maxHp - (self.caster).maxHp // 5
  ;
  (self.caster):SubHp(damage)
end

bs_70001.OnAfterHeal = function(self, sender, target, skill, heal, isStealHeal, isCrit, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if target == self.caster and (self.caster).hp == (self.caster).maxHp then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    if targetlist.Count < 1 then
      return 
    end
    for i = 0, targetlist.Count - 1 do
      local targetRole = (targetlist[i]).targetRole
      LuaSkillCtrl:RemoveLife(99999, self, targetRole, true, nil, true, false, eHurtType.RealDmg)
      LuaSkillCtrl:SetFinalScoreValue(2, 1000)
      LuaSkillCtrl:ForceEndBattle(true)
    end
  end
end

bs_70001.OnArriveAction = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self.timeValue = self.timeValue - (self.config).timeDuration
  local showTime = self.timeValue // 15
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
end

bs_70001.TimeUp = function(self)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:SetFinalScoreValue(2, 1000)
  LuaSkillCtrl:ForceEndBattle(true)
end

bs_70001.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  local score = (self.totalTime - self.timeValue) * 1000 // self.totalTime
  LuaSkillCtrl:SetFinalScoreValue(2, score)
  LuaSkillCtrl:ForceEndBattle(true)
end

return bs_70001

