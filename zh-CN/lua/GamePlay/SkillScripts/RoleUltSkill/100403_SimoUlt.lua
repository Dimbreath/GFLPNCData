local bs_100403 = class("bs_100403", LuaSkillBase)
local base = LuaSkillBase
bs_100403.config = {effectId_start = 100405, effectId_end = 100406, buffId_Hiding_Simo = 100402, buffId_Dizz = 3006, 
heal_config = {baseheal_formula = 3022}
, start_time = 5, skill_time = 15, selectId = 6, selectrange = 10, actionId_start = 1005, movieEndRoleActionId = 1006, buffId_Super = 3003, audioIdStart = 100404, audioIdMovie = 100405, audioIdEnd = 100406}
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
          LuaSkillCtrl:CallBuff(self, (targetList1[i]).targetRole, (self.config).buffId_Dizz, 1, 1, true)
        end
      end
    end
  end
)
  LuaSkillCtrl:CallBattleCamShake()
end

bs_100403.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallBuffRepeated(self, target.targetRole, (self.config).buffId_Hiding_Simo, 1, (self.arglist)[2], nil, self.OnBuffExecute)
  end
end

bs_100403.OnBuffExecute = function(self, buff, targetRole)
  -- function num : 0_4 , upvalues : _ENV
  if targetRole == nil or targetRole.hp <= 0 then
    return 
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
  LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {(self.arglist)[1]}, true)
  skillResult:EndResult()
end

bs_100403.PlayUltEffect = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_100403.OnUltRoleAction = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).actionId_start)
end

bs_100403.OnSkipUltView = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnSkipUltView)(self)
end

bs_100403.OnMovieFadeOut = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnMovieFadeOut)(self)
end

bs_100403.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100403

