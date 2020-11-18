-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1062 = class("bs_1062", LuaSkillBase)
local base = LuaSkillBase
bs_1062.config = {startEffect = 10316, buffId = 168, 
hurt_config = {hit_formula = 10010, basehurt_formula = 10015}
}
bs_1062.ctor = function(self)
  -- function num : 0_0
end

bs_1062.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self.hurt_config = {}
end

bs_1062.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count <= 0 then
    return 
  end
  local effectTarget = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(effectTarget, (self.config).startEffect, self, nil, nil, 1)
  for i = 0, targetList.Count - 1 do
    do
      LuaSkillCtrl:StartTimer(nil, ((targetList[i]).targetRole).x * 2, function()
    -- function num : 0_2_0 , upvalues : _ENV, targetList, i, self
    LuaSkillCtrl:CallEffect((targetList[i]).targetRole, 10318, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (targetList[i]).targetRole)
    skillResult:BuffResult((self.config).buffId, 1, (self.arglist)[1])
    skillResult:EndResult()
  end
, nil)
    end
  end
end

bs_1062.PlayUltEffect = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  self:AddTrigger(eSkillTriggerType.AfterSelfUltInTimeLineEnd, "bs_1062_1", 1, self.AfterFocusTimeLine)
  self:AddTrigger(eSkillTriggerType.AfterSelfUltMovieEnd, "bs_1062_2", 1, self.OnMovieEnd)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_1062_3", 1, self.OnMovieFadeOut)
end

bs_1062.OnUltRoleAction = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self:CallCasterWait(20)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
  self.startEffect = LuaSkillCtrl:CallEffect(self.caster, 10341, self)
end

bs_1062.AfterFocusTimeLine = function(self)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:StartTimerInUlt(8, function()
    -- function num : 0_5_0 , upvalues : _ENV
    LuaSkillCtrl:CallPlayUltMovie()
  end
, nil)
  self:RemoveTrigger(eSkillTriggerType.AfterSelfUltInTimeLineEnd)
end

bs_1062.OnMovieFadeOut = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.startEffect ~= nil then
    (self.startEffect):Die()
    self.startEffect = nil
  end
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  self:RemoveTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  self:RemoveTrigger(eSkillTriggerType.AfterSelfUltMovieEnd)
end

bs_1062.OnMovieEnd = function(self)
  -- function num : 0_7
end

bs_1062.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1062

