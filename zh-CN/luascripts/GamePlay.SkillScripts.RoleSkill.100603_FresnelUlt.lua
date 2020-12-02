-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100603 = class("bs_100603", LuaSkillBase)
local base = LuaSkillBase
bs_100603.config = {startEffect = 10517, buffId = 115, 
hurt_config = {basehurt_formula = 10076}
}
bs_100603.ctor = function(self)
  -- function num : 0_0
end

bs_100603.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_100603.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count <= 0 then
    return 
  end
  local effectTarget = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(effectTarget, (self.config).startEffect, self, nil, nil, 1)
  LuaSkillCtrl:StartTimer(nil, 5, function()
    -- function num : 0_2_0 , upvalues : targetList, _ENV, self
    for i = 0, targetList.Count - 1 do
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (targetList[i]).targetRole)
      LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
      skillResult:BuffResult((self.config).buffId, 1, (self.arglist)[2])
      skillResult:EndResult()
    end
  end
, nil)
  LuaSkillCtrl:CallBattleCamShake()
end

bs_100603.PlayUltEffect = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15)
  self:AddTrigger(eSkillTriggerType.AfterSelfUltMovieEnd, "bs_100603_2", 1, self.OnMovieEnd)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_100603_3", 1, self.OnMovieFadeOut)
end

bs_100603.OnUltRoleAction = function(self)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:StartTimerInUlt(8, function()
    -- function num : 0_4_0 , upvalues : _ENV
    LuaSkillCtrl:CallPlayUltMovie()
  end
, nil)
  self:CallCasterWait(20)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_100603.OnMovieFadeOut = function(self)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  self:RemoveTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  self:RemoveTrigger(eSkillTriggerType.AfterSelfUltMovieEnd)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
end

bs_100603.OnMovieEnd = function(self)
  -- function num : 0_6
end

bs_100603.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100603

