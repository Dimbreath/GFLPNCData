-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_100803 = class("bs_100803", LuaSkillBase)
local base = LuaSkillBase
bs_100803.config = {effectId_start = 10552, effectId_line = 10553, buffId_204 = 204, 
aoe_config = {effect_shape = 1, aoe_select_code = 3, aoe_range = 10}
, 
heal_config = {baseheal_formula = 10087, heal_number = 0, correct_formula = 9990}
}
bs_100803.ctor = function(self)
  -- function num : 0_0
end

bs_100803.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self.hurt_config = {}
  self.buff_during_time = (self.arglist)[2]
end

bs_100803.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(20)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_start, self, self.SkillEventFunc, nil, 0.5)
  LuaSkillCtrl:CallBattleCamShake()
end

bs_100803.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).aoe_config)
    if (skillResult.roleList).Count >= 2 then
      for i = 0, (skillResult.roleList).Count - 1 do
        if i == (skillResult.roleList).Count - 1 then
          LuaSkillCtrl:CallEffect((skillResult.roleList)[i], (self.config).effectId_line, self, nil, (skillResult.roleList)[0])
        else
          LuaSkillCtrl:CallEffect((skillResult.roleList)[i + 1], (self.config).effectId_line, self, nil, (skillResult.roleList)[i])
        end
      end
    end
    do
      skillResult:HealResult((self.config).heal_config)
      skillResult:EndResult()
    end
  end
end

bs_100803.PlayUltEffect = function(self)
  -- function num : 0_4 , upvalues : base, _ENV
  (base.PlayUltEffect)(self)
  LuaSkillCtrl:CallFocusTimeLine(self.caster)
  LuaSkillCtrl:CallBuff(self, self.caster, 196, 1, 15, true)
  self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_100803_3", 1, self.OnMovieFadeOut)
end

bs_100803.OnUltRoleAction = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.OnUltRoleAction)(self)
  LuaSkillCtrl:StartTimerInUlt(self, 7, function()
    -- function num : 0_5_0 , upvalues : _ENV
    LuaSkillCtrl:CallPlayUltMovie()
  end
, nil)
  LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_100803.OnMovieFadeOut = function(self)
  -- function num : 0_6 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, 1006)
  self:RemoveSkillTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
  LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
end

bs_100803.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_100803

