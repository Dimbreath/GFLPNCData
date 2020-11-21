-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40011 = class("bs_40011", LuaSkillBase)
local base = LuaSkillBase
bs_40011.config = {
    aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1},
    monsterEffectId = 10221,
    effectId = 10219,
    attackdelay = 15,
    buffId = 1007,
    buffTier = 1,
    buffDuration = 45,
    buffDamageFormula = 10007
}
bs_40011.ctor = function(self)
    -- function num : 0_0
end

bs_40011.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self.damTimer = LuaSkillCtrl:StartTimer(self, (self.config).attackdelay,
                                            self.CallBack, self, -1)
    LuaSkillCtrl:CallEffect(self.caster, (self.config).monsterEffectId, self)
end

bs_40011.CallBack = function(self)
    -- function num : 0_2 , upvalues : _ENV
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster,
                                                             (self.config).aoe_config)
    if (skillResult.roleList).Count ~= 0 then
        for i = 0, (skillResult.roleList).Count - 1 do
            local role = (skillResult.roleList)[i]
            LuaSkillCtrl:CallEffect(role, (self.config).effectId, self)
            LuaSkillCtrl:CallBuffRepeated(self, role, (self.config).buffId,
                                          (self.config).buffTier,
                                          (self.config).buffDuration,
                                          self.OnBuffExecute)
        end
    end
    do skillResult:EndResult() end
end

bs_40011.OnBuffExecute = function(self, buff, targetRole)
    -- function num : 0_3 , upvalues : _ENV
    local damage = (math.max)(LuaSkillCtrl:CallFormulaNumberWithSkill(
                                  (self.config).buffDamageFormula, self.caster,
                                  targetRole, self), 1)
    damage = damage * buff.tier
    LuaSkillCtrl:RemoveLife(damage, self, targetRole)
end

bs_40011.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
    if self.damTimer then
        (self.damTimer):Stop()
        self.damTimer = nil
    end
    if self.loop ~= nil then
        (self.loop):Die()
        self.loop = nil
    end
end

return bs_40011

