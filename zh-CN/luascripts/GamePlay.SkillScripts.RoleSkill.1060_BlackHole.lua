-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1060 = class("bs_1060", LuaSkillBase)
local base = LuaSkillBase
bs_1060.config = {effectId = 10293, buffId = 66, 
hurt_config = {hit_formula = 10010, basehurt_formula = 10034}
}
bs_1060.ctor = function(self)
  -- function num : 0_0
end

bs_1060.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self.hurt_config = {}
  self.skillEffect = nil
  self.durTime = (self.arglist)[2]
  self.realTime = 0
  self.delay = 15
end

bs_1060.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local gridTemp = LuaSkillCtrl:CallFindGridMostRolesArounded(2)
  local gridTarget = LuaSkillCtrl:GetTargetWithGrid(gridTemp.x, gridTemp.y)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  self.skillEffect = LuaSkillCtrl:CallEffect(gridTarget, (self.config).effectId, self, self.SkillEventFunc, nil, 1)
  self:RealPlaySkill(gridTarget)
end

bs_1060.RealPlaySkill = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  for i = 0, targetList.Count - 1 do
    local emptyGrid = LuaSkillCtrl:CallFindEmptyGridClosedToTarget(target.x, target.y, (targetList[i]).targetRole)
    if emptyGrid ~= nil and LuaSkillCtrl:GetGridsDistance(emptyGrid.x, emptyGrid.y, target.x, target.y) < LuaSkillCtrl:GetGridsDistance(((targetList[i]).targetRole).x, ((targetList[i]).targetRole).y, target.x, target.y) then
      ((targetList[i]).targetRole):ResetRoleState()
      LuaSkillCtrl:CallPhaseMoveWithoutTurn(self, (targetList[i]).targetRole, emptyGrid.x, emptyGrid.y, 5)
    end
    LuaSkillCtrl:CallBuff(self, (targetList[i]).targetRole, 66, 1, self.delay)
    LuaSkillCtrl:CallRealDamage(self, (targetList[i]).targetRole, nil, (self.config).hurt_config, nil, true)
  end
  self.realTime = self.realTime + self.delay
  if self.durTime <= self.realTime then
    self:RealSkillEnd()
  else
    LuaSkillCtrl:StartTimer(self, self.delay, function()
    -- function num : 0_3_0 , upvalues : self, target
    self:RealPlaySkill(target)
  end
)
  end
end

bs_1060.RealSkillEnd = function(self)
  -- function num : 0_4
  self.realTime = 0
  if self.skillEffect ~= nil then
    (self.skillEffect):Die()
    self.skillEffect = nil
  end
end

bs_1060.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
  end
end

bs_1060.PlayUltEffect = function(self)
  -- function num : 0_6 , upvalues : _ENV
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  self:AddTrigger(eSkillTriggerType.AfterSelfUltInTimeLineEnd, "bs_1060_1", 1, self.AfterFocusTimeLine)
  self:AddTrigger(eSkillTriggerType.AfterSelfUltMovieEnd, "bs_1060_2", 1, self.OnMovieEnd)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_1060_3", 1, self.OnMovieFadeOut)
end

bs_1060.OnUltRoleAction = function(self)
  -- function num : 0_7 , upvalues : _ENV
  self:CallCasterWait(20)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
  LuaSkillCtrl:CallRoleAction(self.caster, 1101)
  self.startEffect = LuaSkillCtrl:CallEffect(self.caster, 10342, self)
end

bs_1060.AfterFocusTimeLine = function(self)
  -- function num : 0_8 , upvalues : _ENV
  LuaSkillCtrl:StartTimerInUlt(6, function()
    -- function num : 0_8_0 , upvalues : _ENV
    LuaSkillCtrl:CallPlayUltMovie()
  end
, nil)
  self:RemoveTrigger(eSkillTriggerType.AfterSelfUltInTimeLineEnd)
end

bs_1060.OnMovieFadeOut = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self.startEffect ~= nil then
    (self.startEffect):Die()
    self.startEffect = nil
  end
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  LuaSkillCtrl:CallRoleAction(self.caster, 1102)
  self:RemoveTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  self:RemoveTrigger(eSkillTriggerType.AfterSelfUltMovieEnd)
end

bs_1060.OnMovieEnd = function(self)
  -- function num : 0_10
end

bs_1060.OnCasterDie = function(self)
  -- function num : 0_11 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1060

