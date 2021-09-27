local bs_102003 = class("bs_102003", LuaSkillBase)
local base = LuaSkillBase
bs_102003.config = {startEffect = 102007, buffId = 102003, fronttime = 7, movieEndRoleActionId = 1006, audioIdStart = 102006, audioIdMovie = 102007, audioIdEnd = 102008}
bs_102003.ctor = function(self)
  -- function num : 0_0
end

bs_102003.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_102003.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
  if targetList.Count <= 0 then
    return 
  end
  local effectTarget = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(effectTarget, (self.config).startEffect, self, nil, nil, 0.7)
  for i = 0, targetList.Count - 1 do
    do
      LuaSkillCtrl:StartTimer(self, 5, function()
    -- function num : 0_2_0 , upvalues : targetList, i, self, _ENV
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    (((targetList[i]).targetRole).recordTable)["102009_UltBuff"] = (self.arglist)[2]
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (targetList[i]).targetRole)
    LuaSkillCtrl:CallBuff(self, (targetList[i]).targetRole, (self.config).buffId, 1, (self.arglist)[1])
    skillResult:EndResult()
  end
)
    end
  end
end

bs_102003.PlayUltEffect = function(self)
  -- function num : 0_3 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_102003.OnUltRoleAction = function(self)
  -- function num : 0_4 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, (self.config).fronttime, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_102003.OnMovieFadeOut = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnMovieFadeOut)(self)
end

bs_102003.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102003

