local bs_60002 = class("bs_60002", LuaSkillBase)
local base = LuaSkillBase
bs_60002.config = {buffId1 = 175, buffId2 = 1033, buffId3 = 198, buffId = 3010, buffStun = 66, buffUndefeatable = 88, 
aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1}
, 
hurt_config = {basehurt_formula = 10157}
, effectId = 10504, effectId1 = 10507, effectId2 = 10508}
bs_60002.ctor = function(self)
  -- function num : 0_0
end

bs_60002.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_60002_1", 1, self.OnAfterBattleStart)
  self:AddAfterAddBuffTrigger("bs_60002_7", 1, self.OnAfterAddBuff, nil, nil, nil, nil, (self.config).buffId)
end

bs_60002.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId3, 1, nil, true)
  LuaSkillCtrl:StartTimer(self, (self.arglist)[2], self.CallBack, self, -1, 0)
end

bs_60002.CallBack = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, self.SkillEventFunc)
end

bs_60002.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).aoe_config)
    skillResult:BuffResult((self.config).buffId, (self.arglist)[3])
    skillResult:HurtResult((self.config).hurt_config)
    if (skillResult.roleList).Count > 0 then
      for i = 0, (skillResult.roleList).Count - 1 do
        local role = (skillResult.roleList)[i]
        LuaSkillCtrl:CallEffect(role, (self.config).effectId2, self)
      end
    end
    do
      skillResult:EndResult()
    end
  end
end

bs_60002.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_5 , upvalues : _ENV
  if buff.dataId == (self.config).buffId then
    local restTier = target:GetBuffTier((self.config).buffId)
    if restTier >= 6 then
      LuaSkillCtrl:CallBuff(self, target, (self.config).buffStun, 1, 30, true)
      LuaSkillCtrl:DispelBuff(target, (self.config).buffId, 0, true)
      restTier = 0
    end
  end
end

bs_60002.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
end

return bs_60002

