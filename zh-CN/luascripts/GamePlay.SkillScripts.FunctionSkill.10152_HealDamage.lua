-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10152 = class("bs_10152", LuaSkillBase)
local base = LuaSkillBase
bs_10152.config = {
realDamageConfig = {basehurt_formula = 10046}
, 
aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1}
, effectId = 10257, effectId2 = 10256}
bs_10152.ctor = function(self)
  -- function num : 0_0
end

bs_10152.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHeal, "bs_10152_5", 1, self.OnAfterHeal)
end

bs_10152.OnAfterHeal = function(self, sender, target, skill, heal)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R5 in 'UnsetPending'

  if sender == self.caster then
    ((self.caster).recordTable)["10152_targetPow"] = target.skill_intensity
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.caster).recordTable)["10152_targetSunder"] = target.sunder
    LuaSkillCtrl:CallEffect(target, (self.config).effectId, self, self.SkillEventFunc)
  end
end

bs_10152.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local targetPow = ((self.caster).recordTable)["10152_targetPow"]
    local targetSunder = ((self.caster).recordTable)["10152_targetSunder"]
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).aoe_config)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).realDamageConfig, {targetPow, targetSunder})
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

bs_10152.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10152

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10152 = class("bs_10152", LuaSkillBase)
local base = LuaSkillBase
bs_10152.config = {
    realDamageConfig = {basehurt_formula = 10046},
    aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1},
    effectId = 10257,
    effectId2 = 10256
}
bs_10152.ctor = function(self)
    -- function num : 0_0
end

bs_10152.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterHeal, "bs_10152_5", 1,
                    self.OnAfterHeal)
end

bs_10152.OnAfterHeal = function(self, sender, target, skill, heal)
    -- function num : 0_2 , upvalues : _ENV
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R5 in 'UnsetPending'

    if sender == self.caster then
        ((self.caster).recordTable)["10152_targetPow"] = target.skill_intensity -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'
        ;
        ((self.caster).recordTable)["10152_targetSunder"] = target.sunder
        LuaSkillCtrl:CallEffect(target, (self.config).effectId, self,
                                self.SkillEventFunc)
    end
end

bs_10152.SkillEventFunc = function(self, effect, eventId, target)
    -- function num : 0_3 , upvalues : _ENV
    if eventId == eBattleEffectEvent.Trigger then
        local targetPow = ((self.caster).recordTable)["10152_targetPow"]
        local targetSunder = ((self.caster).recordTable)["10152_targetSunder"]
        local skillResult = LuaSkillCtrl:CallSkillResult(effect, target,
                                                         (self.config).aoe_config)
        LuaSkillCtrl:HurtResult(skillResult, (self.config).realDamageConfig,
                                {targetPow, targetSunder})
        if (skillResult.roleList).Count > 0 then
            for i = 0, (skillResult.roleList).Count - 1 do
                local role = (skillResult.roleList)[i]
                LuaSkillCtrl:CallEffect(role, (self.config).effectId2, self)
            end
        end
        do skillResult:EndResult() end
    end
end

bs_10152.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10152

