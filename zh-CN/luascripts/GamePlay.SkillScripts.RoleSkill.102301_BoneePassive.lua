-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102301 = class("bs_102301", LuaSkillBase)
local base = LuaSkillBase
local ShieldSkillBase = require("GamePlay.SkillScripts.BaseSkill.ShieldSkillBase")
bs_102301.config = {shieldKey = "102301_HuDun", effectIdBoom = 10394, 
aoe_config = {effect_shape = 2, aoe_select_code = 4, aoe_range = 1}
, 
hurt_config = {basehurt_formula = 10079}
}
bs_102301.ctor = function(self)
  -- function num : 0_0
end

bs_102301.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_102301_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_102301_2", 1, self.OnSetHurt)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)[(self.config).shieldKey] = 0
end

bs_102301.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : ShieldSkillBase
  local shieldValue = (self.caster).skill_intensity * (self.arglist)[1] // 1000
  if shieldValue > 0 then
    (ShieldSkillBase.UpdateShieldView)(self.caster, (self.config).shieldKey, shieldValue)
  end
end

bs_102301.OnSetHurt = function(self, context)
  -- function num : 0_3 , upvalues : ShieldSkillBase, _ENV
  if context.target == self.caster and ((self.caster).recordTable)[(self.config).shieldKey] > 0 then
    local retHurt = (ShieldSkillBase.ShieldBaseFunc)(context.hurt, self.caster, (self.config).shieldKey)
    context.hurt = retHurt
    LuaSkillCtrl:CallFloatText(self.caster, 7)
    if ((self.caster).recordTable)[(self.config).shieldKey] <= 0 then
      self:Boom()
    end
  end
end

bs_102301.Boom = function(self)
  -- function num : 0_4 , upvalues : _ENV, ShieldSkillBase
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], function()
    -- function num : 0_4_0 , upvalues : self, ShieldSkillBase
    local shieldValue = (self.caster).skill_intensity * (self.arglist)[1] // 1000
    if shieldValue > 0 then
      (ShieldSkillBase.UpdateShieldView)(self.caster, (self.config).shieldKey, shieldValue)
    end
  end
)
  if (self.arglist)[3] == 1 then
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectIdBoom, self, self.SkillEventFunc)
  end
end

bs_102301.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if effect.dataId == (self.config).effectIdBoom and eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:StartTimer(self, 4, function()
    -- function num : 0_5_0 , upvalues : _ENV, self, target
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).aoe_config)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    skillResult:EndResult()
  end
)
  end
end

bs_102301.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102301

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102301 = class("bs_102301", LuaSkillBase)
local base = LuaSkillBase
local ShieldSkillBase = require(
                            "GamePlay.SkillScripts.BaseSkill.ShieldSkillBase")
bs_102301.config = {
    shieldKey = "102301_HuDun",
    effectIdBoom = 10394,
    aoe_config = {effect_shape = 2, aoe_select_code = 4, aoe_range = 1},
    hurt_config = {basehurt_formula = 10079}
}
bs_102301.ctor = function(self)
    -- function num : 0_0
end

bs_102301.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_102301_1", 1,
                    self.OnAfterBattleStart)
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_102301_2", 1, self.OnSetHurt) -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.caster).recordTable)[(self.config).shieldKey] = 0
end

bs_102301.OnAfterBattleStart = function(self)
    -- function num : 0_2 , upvalues : ShieldSkillBase
    local shieldValue = (self.caster).skill_intensity * (self.arglist)[1] //
                            1000
    if shieldValue > 0 then
        (ShieldSkillBase.UpdateShieldView)(self.caster, (self.config).shieldKey,
                                           shieldValue)
    end
end

bs_102301.OnSetHurt = function(self, context)
    -- function num : 0_3 , upvalues : ShieldSkillBase, _ENV
    if context.target == self.caster and
        ((self.caster).recordTable)[(self.config).shieldKey] > 0 then
        local retHurt = (ShieldSkillBase.ShieldBaseFunc)(context.hurt,
                                                         self.caster,
                                                         (self.config).shieldKey)
        context.hurt = retHurt
        LuaSkillCtrl:CallFloatText(self.caster, 7)
        if ((self.caster).recordTable)[(self.config).shieldKey] <= 0 then
            self:Boom()
        end
    end
end

bs_102301.Boom = function(self)
    -- function num : 0_4 , upvalues : _ENV, ShieldSkillBase
    LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], function()
        -- function num : 0_4_0 , upvalues : self, ShieldSkillBase
        local shieldValue = (self.caster).skill_intensity * (self.arglist)[1] //
                                1000
        if shieldValue > 0 then
            (ShieldSkillBase.UpdateShieldView)(self.caster,
                                               (self.config).shieldKey,
                                               shieldValue)
        end
    end)
    if (self.arglist)[3] == 1 then
        LuaSkillCtrl:CallEffect(self.caster, (self.config).effectIdBoom, self,
                                self.SkillEventFunc)
    end
end

bs_102301.SkillEventFunc = function(self, effect, eventId, target)
    -- function num : 0_5 , upvalues : _ENV
    if effect.dataId == (self.config).effectIdBoom and eventId ==
        eBattleEffectEvent.Trigger then
        LuaSkillCtrl:StartTimer(self, 4, function()
            -- function num : 0_5_0 , upvalues : _ENV, self, target
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self,
                                                                     target,
                                                                     (self.config).aoe_config)
            LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
            skillResult:EndResult()
        end)
    end
end

bs_102301.OnCasterDie = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_102301

