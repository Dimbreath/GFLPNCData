-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102701 = class("bs_102701", LuaSkillBase)
local base = LuaSkillBase
bs_102701.config = {effectBack = 1002, effectShield = 10381, effectShieldSj = 10382, 
real_Config = {basehurt_formula = 502}
}
bs_102701.ctor = function(self)
  -- function num : 0_0
end

bs_102701.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_102701_2", 1, self.OnSetHurt)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_102701_1", 1, self.OnAfterBattleStart)
  self.effectShield = nil
end

bs_102701.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.effectShield == nil then
    self.effectShield = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectShield, self)
  end
end

bs_102701.OnSetHurt = function(self, context)
  -- function num : 0_3 , upvalues : _ENV
  if context.target == self.caster and self:IsReadyToTake() then
    local conditionValue = (self.caster).maxHp * (self.arglist)[1] // 1000
    local backValue = 0
    if conditionValue < 1 then
      conditionValue = 1
    end
    if conditionValue < context.hurt then
      backValue = (context.hurt - conditionValue) * (self.arglist)[3] // 1000
      if backValue < 1 then
        backValue = 1
      end
      context.hurt = conditionValue
      if (self.arglist)[2] == 1 and context.sender ~= self.caster and context.sender ~= nil then
        LuaSkillCtrl:CallEffectWithArg(context.sender, (self.config).effectBack, self, false, self.SkillEventFunc, backValue)
      end
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectShieldSj, self)
      self:OnSkillTake()
    end
  end
end

bs_102701.SkillEventFunc = function(self, hurt, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallRealDamage(self, target, nil, (self.config).real_Config, {hurt}, true)
  end
end

bs_102701.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102701

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102701 = class("bs_102701", LuaSkillBase)
local base = LuaSkillBase
bs_102701.config = {
    effectBack = 1002,
    effectShield = 10381,
    effectShieldSj = 10382,
    real_Config = {basehurt_formula = 502}
}
bs_102701.ctor = function(self)
    -- function num : 0_0
end

bs_102701.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_102701_2", 1, self.OnSetHurt)
    self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_102701_1", 1,
                    self.OnAfterBattleStart)
    self.effectShield = nil
end

bs_102701.OnAfterBattleStart = function(self)
    -- function num : 0_2 , upvalues : _ENV
    if self.effectShield == nil then
        self.effectShield = LuaSkillCtrl:CallEffect(self.caster,
                                                    (self.config).effectShield,
                                                    self)
    end
end

bs_102701.OnSetHurt = function(self, context)
    -- function num : 0_3 , upvalues : _ENV
    if context.target == self.caster and self:IsReadyToTake() then
        local conditionValue = (self.caster).maxHp * (self.arglist)[1] // 1000
        local backValue = 0
        if conditionValue < 1 then conditionValue = 1 end
        if conditionValue < context.hurt then
            backValue = (context.hurt - conditionValue) * (self.arglist)[3] //
                            1000
            if backValue < 1 then backValue = 1 end
            context.hurt = conditionValue
            if (self.arglist)[2] == 1 and context.sender ~= self.caster and
                context.sender ~= nil then
                LuaSkillCtrl:CallEffectWithArg(context.sender,
                                               (self.config).effectBack, self,
                                               false, self.SkillEventFunc,
                                               backValue)
            end
            LuaSkillCtrl:CallEffect(self.caster, (self.config).effectShieldSj,
                                    self)
            self:OnSkillTake()
        end
    end
end

bs_102701.SkillEventFunc = function(self, hurt, effect, eventId, target)
    -- function num : 0_4 , upvalues : _ENV
    if eventId == eBattleEffectEvent.Trigger then
        LuaSkillCtrl:CallRealDamage(self, target, nil,
                                    (self.config).real_Config, {hurt}, true)
    end
end

bs_102701.OnCasterDie = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_102701

