local bs_30002 = class("bs_30002", LuaSkillBase)
local base = LuaSkillBase
bs_30002.config = {buffId = 1026, buffCF = 67, buffTier = 1, 
aoe_config = {effect_shape = 1, aoe_select_code = 4, aoe_range = 1}
, effectId = 10888}
bs_30002.ctor = function(self)
  -- function num : 0_0
end

bs_30002.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_30002_2", 10, self.OnAfterBattleStart)
end

bs_30002.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], arriveCallBack, self, -1)
end

bs_30002.OnArriveAction = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self:PlayChipEffect()
  local buffTier = (self.caster).return_damage
  if self.effect == nil then
    self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
    LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], function()
    -- function num : 0_3_0 , upvalues : self
    if self.effect ~= nil then
      (self.effect):Die()
      self.effect = nil
    end
  end
)
  end
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, buffTier, (self.arglist)[2], true)
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, (self.config).aoe_config)
  skillResult:BuffResult((self.config).buffCF, (self.config).buffTier, (self.arglist)[2])
  skillResult:EndResult()
end

bs_30002.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
end

return bs_30002

