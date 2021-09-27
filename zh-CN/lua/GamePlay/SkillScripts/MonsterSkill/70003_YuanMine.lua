local bs_70003 = class("bs_70003", LuaSkillBase)
local base = LuaSkillBase
bs_70003.config = {buffId = 66, buffTier = 1, timeDuration = 15, action1 = 1008, action2 = 1007, action3 = 1025, formula1 = 10153, formula2 = 10154, formula3 = 10155}
bs_70003.ctor = function(self)
  -- function num : 0_0
end

bs_70003.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self.totalTime = (self.arglist)[2]
  self.timeValue = self.totalTime
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  LuaSkillCtrl:SetGameScoreAcitve(3, true)
  LuaSkillCtrl:SetGameScoreValue(3, 0)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, (self.config).timeDuration, arriveCallBack, self, -1)
  local timeCallBack = BindCallback(self, self.TimeUp)
  LuaSkillCtrl:StartTimer(nil, self.totalTime, timeCallBack)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_70003_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_70003_3", 2, self.OnAfterHurt, nil, self.caster)
  LuaSkillCtrl:RegisterRoleHpCostEvent(self, self.caster, {900, 800, 700, 600}, self.OnHpSubCost, false)
  self.isAction = 0
  LuaSkillCtrl:RecordLimitTime(self.totalTime)
end

bs_70003.OnHpSubCost = function(self, curHp, TargetValue)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).action3)
end

bs_70003.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_3 , upvalues : _ENV
  if target == self.caster and not isMiss and (self.caster).hp * 2 < (self.caster).maxHp and self.isAction == 0 then
    self:CallCasterWait(999)
    LuaSkillCtrl:CallRoleAction(self.caster, (self.config).action1)
    LuaSkillCtrl:StartTimer(nil, 35, function()
    -- function num : 0_3_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallRoleAction(self.caster, (self.config).action2)
  end
)
    self.isAction = 1
  end
end

bs_70003.OnAfterBattleStart = function(self)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, 198, 1, nil, true)
end

bs_70003.TimeUp = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local score = ((self.caster).maxHp - (self.caster).hp) * 1000 // (self.caster).maxHp
  LuaSkillCtrl:SetFinalScoreValue(2, score)
  LuaSkillCtrl:ForceEndBattle(true)
end

bs_70003.OnArriveAction = function(self)
  -- function num : 0_6 , upvalues : _ENV
  self.timeValue = self.timeValue - (self.config).timeDuration
  local showTime = self.timeValue // 15
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
  local score = ((self.caster).maxHp - (self.caster).hp) * 1000 // (self.caster).maxHp
  local showScore = score
  if score > 600 then
    showScore = LuaSkillCtrl:CallFormulaNumber((self.config).formula1, self.caster, self.caster, score)
  else
    if score > 200 then
      showScore = LuaSkillCtrl:CallFormulaNumber((self.config).formula2, self.caster, self.caster, score)
    else
      showScore = LuaSkillCtrl:CallFormulaNumber((self.config).formula3, self.caster, self.caster, score)
    end
  end
  LuaSkillCtrl:SetGameScoreValue(3, showScore)
  LuaSkillCtrl:BattlegroundDrop((self.caster).curCoord, 3, "FXP_Common_diaoluo_JYS")
end

bs_70003.PlaySkill = function(self, data)
  -- function num : 0_7
end

bs_70003.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  ;
  (base.OnCasterDie)(self)
  LuaSkillCtrl:SetFinalScoreValue(2, 1000)
  LuaSkillCtrl:ForceEndBattle(true)
end

return bs_70003

