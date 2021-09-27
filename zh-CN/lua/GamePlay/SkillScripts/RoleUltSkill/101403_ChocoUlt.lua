local bs_10803 = class("bs_10803", LuaSkillBase)
local base = LuaSkillBase
bs_10803.config = {effectId_start = 10859}
bs_10803.ctor = function(self)
  -- function num : 0_0
end

bs_10803.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_10803.PlaySkill = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  LuaSkillCtrl:StartTimer(self, 3, function()
    -- function num : 0_2_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_start, self)
  end
, nil)
  LuaSkillCtrl:CallBattleCamShake()
end

bs_10803.PlayUltEffect = function(self)
  -- function num : 0_3 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_10803.OnUltRoleAction = function(self)
  -- function num : 0_4 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).actionId_start)
end

bs_10803.OnMovieFadeOut = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnMovieFadeOut)(self)
end

bs_10803.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10803

