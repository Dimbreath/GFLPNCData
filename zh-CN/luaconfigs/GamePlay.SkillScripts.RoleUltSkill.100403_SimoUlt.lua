-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100403 = class("bs_100403", LuaSkillBase)
local base = LuaSkillBase
bs_100403.config = {effectId_start = 10536, effectId_end = 10537, buffId = 175, 
aoe_config = {effect_shape = 1, aoe_select_code = 3, aoe_range = 10}
, 
heal_config = {baseheal_formula = 10011, heal_number = 0, correct_formula = 9990}
, start_time = 5, skill_time = 15, selectId = 6, selectrange = 10, actionId_start = 1005, actionId_end = 1006}
bs_100403.ctor = function(self)
  -- function num : 0_0
end

bs_100403.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self.durTime = (self.arglist)[2]
  self.realTime = 0
  self.delay = 15
end

bs_100403.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait((self.config).skill_time)
  LuaSkillCtrl:StartTimer(self, (self.config).start_time, function()
    -- function num : 0_2_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_start, self)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId, (self.config).selectrange)
    if targetList ~= nil and targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        LuaSkillCtrl:CallEffect((targetList[i]).targetRole, (self.config).effectId_end, self, self.SkillEventFunc)
      end
    end
    do
      local targetList1 = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
      if targetList1 ~= nil and targetList1.Count > 0 then
        for i = 0, targetList1.Count - 1 do
          LuaSkillCtrl:CallBuff(self, (targetList1[i]).targetRole, 1, 1, 1, true)
        end
      end
      do
        self:RealPlaySkill()
      end
    end
  end
)
  LuaSkillCtrl:CallBattleCamShake()
end

bs_100403.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuff(self, target.targetRole, (self.config).buffId, 1, (self.arglist)[2])
  end
end

bs_100403.RealPlaySkill = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local targetList = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.player)
  for i = 0, targetList.Count - 1 do
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetList[i])
    LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, nil, false, false)
    skillResult:EndResult()
  end
  self.realTime = self.realTime + self.delay
  if self.durTime <= self.realTime then
    self.realTime = 0
  else
    LuaSkillCtrl:StartTimer(self, self.delay, function()
    -- function num : 0_4_0 , upvalues : self
    self:RealPlaySkill()
  end
)
  end
end

bs_100403.PlayUltEffect = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_100403_3", 1, self.OnMovieFadeOut)
end

bs_100403.OnUltRoleAction = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.OnRoleActionView)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).actionId_start)
end

bs_100403.OnRoleActionView = function(self)
  -- function num : 0_7 , upvalues : _ENV
  LuaSkillCtrl:CallPlayUltMovie()
end

bs_100403.OnMovieFadeOut = function(self)
  -- function num : 0_8 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).actionId_end)
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
end

bs_100403.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100403

