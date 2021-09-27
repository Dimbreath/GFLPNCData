local bs_100503 = class("bs_100503", LuaSkillBase)
local base = LuaSkillBase
bs_100503.config = {effectId_Ult = 100516, 
hurt_config = {hit_formula = 0, basehurt_formula = 100502, returndamage_formula = 0}
, 
hurt_configF = {hit_formula = 0, basehurt_formula = 100503, returndamage_formula = 0}
, 
series_0 = {1, 3, 9, 15, 18}
, 
series_1 = {2, 5, 8, 14, 17}
, 
series_2 = {4, 7, 10, 13, 19}
, 
series_3 = {1, 6, 10, 15, 21}
, 
series_4 = {5, 8, 12, 20, 22}
, 
aoe = {effect_shape = 3, aoe_select_code = 4, aoe_range = 10}
, audioIdStart = 100507, audioIdMovie = 100508, audioIdEnd = 100509, buffId_maim = 3001, buffId_stun = 3006, selectId = 9, select_Range = 10, skill_times = 5, movieEndRoleActionId = 1006, buffId_Super = 3003}
bs_100503.ctor = function(self)
  -- function num : 0_0
end

bs_100503.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self.hurt_config = {}
end

bs_100503.PlaySkill = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(20)
  local effectTarget = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  LuaSkillCtrl:CallEffect(effectTarget, (self.config).effectId_Ult, self)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, (self.config).aoe)
  if (skillResult.roleList).Count <= 0 then
    return 
  end
  for i = 0, (skillResult.roleList).Count - 1 do
    do
      if ((skillResult.roleList)[i]).belongNum == eBattleRoleBelong.enemy then
        LuaSkillCtrl:CallBuff(self, (skillResult.roleList)[i], (self.config).buffId_stun, 1, 1, true)
        LuaSkillCtrl:CallBuff(self, (skillResult.roleList)[i], (self.config).buffId_maim, (self.arglist)[3], (self.arglist)[2])
      end
      local series = i % 5
      for n = 1, (self.config).skill_times do
        LuaSkillCtrl:StartTimer(self, ((self.config)["series_" .. tostring(series)])[n], function()
    -- function num : 0_2_0 , upvalues : self, skillResult, i
    self:RealPlaySkill((skillResult.roleList)[i])
  end
, nil)
      end
    end
  end
end

bs_100503.RealPlaySkill = function(self, target)
  -- function num : 0_3 , upvalues : _ENV
  local skillResult = (LuaSkillCtrl:CallSkillResultNoEffect(self, target))
  -- DECOMPILER ERROR at PC5: Overwrote pending register: R3 in 'AssignReg'

  local hurtCfg = .end
  if self:IsConsumeSkill() then
    hurtCfg = (self.config).hurt_configF
  else
    hurtCfg = (self.config).hurt_config
  end
  LuaSkillCtrl:HurtResult(self, skillResult, hurtCfg, nil, false)
  skillResult:EndResult()
end

bs_100503.PlayUltEffect = function(self)
  -- function num : 0_4 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_Super, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_100503.OnUltRoleAction = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 15, self.PlayUltMovie)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_100503.OnSkipUltView = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnSkipUltView)(self)
end

bs_100503.OnMovieFadeOut = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnMovieFadeOut)(self)
end

bs_100503.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_100503.LuaDispose = function(self)
  -- function num : 0_9 , upvalues : base
  (base.LuaDispose)(self)
end

return bs_100503

