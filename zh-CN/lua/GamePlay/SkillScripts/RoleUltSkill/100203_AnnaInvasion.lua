local bs_100203 = class("bs_100203", LuaSkillBase)
local base = LuaSkillBase
bs_100203.config = {effectId_start = 100210, effectId_self = 100213, effect_speed = 1, buffId_168 = 100201, buffId_muma = 3010, tier = 1, fronttime = 13, audioIdStart = 100204, audioIdMovie = 100205, audioIdEnd = 100206, selectId = 9, select_range = 10, action_start = 1005, movieEndRoleActionId = 1006}
bs_100203.ctor = function(self)
  -- function num : 0_0
end

bs_100203.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_100203.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId, (self.config).select_range)
  if targetList.Count <= 0 then
    return 
  end
  local effectTarget = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(effectTarget, (self.config).effectId_start, self, nil, nil, (self.config).effect_speed)
  for i = 0, targetList.Count - 1 do
    do
      local time = ((targetList[i]).targetRole).x * 2
      LuaSkillCtrl:StartTimer(nil, time, function()
    -- function num : 0_2_0 , upvalues : _ENV, self, targetList, i
    LuaSkillCtrl:CallBuff(self, (targetList[i]).targetRole, (self.config).buffId_168, (self.config).tier, (self.arglist)[1], false)
    if ((targetList[i]).targetRole).belongNum == eBattleRoleBelong.enemy then
    end
  end
, nil)
      LuaSkillCtrl:StartTimer(nil, time + (self.arglist)[1], function()
    -- function num : 0_2_1 , upvalues : _ENV, self, targetList, i
    LuaSkillCtrl:CallBuff(self, (targetList[i]).targetRole, (self.config).buffId_muma, (self.arglist)[2], nil, false)
  end
)
    end
  end
  if self.startEffect ~= nil then
    (self.startEffect):Die()
    self.startEffect = nil
  end
end

bs_100203.PlayUltEffect = function(self)
  -- function num : 0_3 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_100203.OnUltRoleAction = function(self)
  -- function num : 0_4 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, (self.config).fronttime, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).action_start)
  self.startEffect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_self, self)
end

bs_100203.OnSkipUltView = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnSkipUltView)(self)
end

bs_100203.OnMovieFadeOut = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnMovieFadeOut)(self)
end

bs_100203.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_100203.LuaDispose = function(self)
  -- function num : 0_8 , upvalues : base
  (base.LuaDispose)(self)
  self.startEffect = nil
end

return bs_100203

