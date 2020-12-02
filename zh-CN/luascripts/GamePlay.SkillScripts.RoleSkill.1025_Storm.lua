-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1025 = class("bs_1025", LuaSkillBase)
local base = LuaSkillBase
bs_1025.config = {effectId = 10004, buffId = 115, 
hurt_config = {hit_formula = 10010, basehurt_formula = 10090}
}
bs_1025.ctor = function(self)
  -- function num : 0_0
end

bs_1025.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self.hurt_config = {}
end

bs_1025.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count <= 0 then
    return 
  end
  for i = 0, targetList.Count - 1 do
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (targetList[i]).targetRole)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    skillResult:BuffResult((self.config).buffId, (self.arglist)[3], (self.arglist)[2])
    skillResult:EndResult()
  end
end

bs_1025.PlayUltEffect = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  self:AddTrigger(eSkillTriggerType.AfterSelfUltMovieEnd, "bs_1025_2", 1, self.OnMovieEnd)
end

bs_1025.OnUltRoleAction = function(self)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:StartTimerInUlt(15, function()
    -- function num : 0_4_0 , upvalues : _ENV
    LuaSkillCtrl:CallPlayUltMovie()
  end
, nil)
  self:CallCasterWait(20)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_1025.OnMovieEnd = function(self)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, 1002)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  self:RemoveTrigger(eSkillTriggerType.AfterSelfUltMovieEnd)
end

bs_1025.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1025

