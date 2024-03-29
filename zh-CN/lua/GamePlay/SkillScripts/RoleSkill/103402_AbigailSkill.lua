local bs_103402 = class("bs_103402", LuaSkillBase)
local base = LuaSkillBase
bs_103402.config = {effectId = 10455, buffId_180 = 103402, 
aoe_config = {effect_shape = 1, aoe_select_code = 3, aoe_range = 10}
, speed = 1, skill_time = 15, actionId = 1002, buffId_170 = 170, audioId1 = 278, audioId2 = 279}
bs_103402.ctor = function(self)
  -- function num : 0_0
end

bs_103402.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_103402.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait((self.config).skill_time)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).actionId, (self.config).speed)
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, self.SkillEventFunc, nil, (self.config).speed, nil, false)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_170, 1, (self.arglist)[1], true)
  LuaSkillCtrl:StartShowSkillDurationTime(self, (self.arglist)[1])
end

bs_103402.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).aoe_config)
    if (skillResult.roleList).Count > 0 then
      for i = 0, (skillResult.roleList).Count - 1 do
        LuaSkillCtrl:CallBuff(self, (skillResult.roleList)[i], (self.config).buffId_180, 1, (self.arglist)[1])
      end
      skillResult:EndResult()
    end
  end
end

bs_103402.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103402

