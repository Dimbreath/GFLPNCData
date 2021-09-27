local bs_101503 = class("bs_101503", LuaSkillBase)
local base = LuaSkillBase
bs_101503.config = {buff_keyan = 101501, effect_start = 101515, effect_loop = 101516, audioIdStart = 101508, audioIdMovie = 101509, audioIdEnd = 101510}
bs_101503.ctor = function(self)
  -- function num : 0_0
end

bs_101503.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
end

bs_101503.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(20)
  LuaSkillCtrl:StartTimer(self, 7, function()
    -- function num : 0_2_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effect_start, self)
  end
, nil)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buff_keyan, 1, (self.arglist)[1], false)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.caster).recordTable).Ult_skill_up = (self.arglist)[3]
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.caster).recordTable).Ult_pass_up = (self.arglist)[2]
end

bs_101503.PlayUltEffect = function(self)
  -- function num : 0_3 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_101503.OnUltRoleAction = function(self)
  -- function num : 0_4 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005, 1)
end

bs_101503.OnSkipUltView = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.OnSkipUltView)(self)
  if self.roleActionAudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.roleActionAudio)
    self.roleActionAudio = nil
  end
end

bs_101503.OnMovieFadeOut = function(self)
  -- function num : 0_6 , upvalues : _ENV, base
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
  ;
  (base.OnMovieFadeOut)(self)
end

bs_101503.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_101503.LuaDispose = function(self)
  -- function num : 0_8 , upvalues : base
  (base.LuaDispose)(self)
end

return bs_101503

