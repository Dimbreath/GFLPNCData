local bs_103003 = class("bs_103003", LuaSkillBase)
local base = LuaSkillBase
bs_103003.config = {effect_start = 103011, effect_loop = 103012, effect_hit = 103013, buff_AtkSpeed2 = 103002, shieldFormula = 3021, audioIdStart = 103005, audioIdMovie = 103006, audioIdEnd = 103007}
bs_103003.ctor = function(self)
  -- function num : 0_0
end

bs_103003.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnBreakShield, "bs_103003_1", 99, self.OnBreakShield)
  self.hudunEffect = {}
end

bs_103003.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
  self.realtarget = selectRoles[0]
end

bs_103003.CallSelectExecute = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if role ~= nil and role.belongNum == (self.caster).belongNum then
    local shieldValue = (self.caster).skill_intensity * (self.arglist)[1] // 1000
    if shieldValue > 0 then
      LuaSkillCtrl:AddRoleShield(role, eShieldType.Normal, shieldValue)
    end
    LuaSkillCtrl:StartTimer(self, 3, function()
    -- function num : 0_3_0 , upvalues : _ENV, role, self
    LuaSkillCtrl:CallEffect(role, (self.config).effect_start, self)
  end
)
    LuaSkillCtrl:StartTimer(self, 7, function()
    -- function num : 0_3_1 , upvalues : self, role, _ENV
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

    if (self.hudunEffect)[role] == nil then
      (self.hudunEffect)[role] = LuaSkillCtrl:CallEffect(role, (self.config).effect_loop, self)
    end
    LuaSkillCtrl:CallBuff(self, role, (self.config).buff_AtkSpeed2, 1, (self.arglist)[2], false)
  end
)
  end
end

bs_103003.OnBreakShield = function(self, shieldType, sender, target)
  -- function num : 0_4
  if shieldType == 0 and target == self.realtarget then
    self:Onover(target)
  end
end

bs_103003.Onover = function(self, target)
  -- function num : 0_5
  if (self.hudunEffect)[target] ~= nil then
    local effect = (self.hudunEffect)[target]
    effect:Die()
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.hudunEffect)[target] = nil
  end
end

bs_103003.PlayUltEffect = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
end

bs_103003.OnUltRoleAction = function(self)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, self.PlayUltMovie, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_103003.OnSkipUltView = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnSkipUltView)(self)
end

bs_103003.OnMovieFadeOut = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnMovieFadeOut)(self)
end

bs_103003.OnCasterDie = function(self)
  -- function num : 0_10 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_103003.LuaDispose = function(self)
  -- function num : 0_11 , upvalues : base
  (base.LuaDispose)(self)
  self.hudunEffect = nil
end

return bs_103003

