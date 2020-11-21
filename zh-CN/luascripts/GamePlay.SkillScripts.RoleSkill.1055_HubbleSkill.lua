-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1055 = class("bs_1055", LuaSkillBase)
local base = LuaSkillBase
bs_1055.config = {
    effectStartId = 10329,
    effectId = 10330,
    effectHitId = nil,
    HurtConfig1 = {
        hit_formula = 0,
        def_formula = 0,
        basehurt_formula = 10064,
        minhurt_formula = 9994,
        crit_formula = 0,
        crithur_ratio = 0,
        correct_formula = 9989,
        lifesteal_formula = 1001,
        spell_lifesteal_formula = 1002,
        returndamage_formula = 1000
    },
    HurtConfig2 = {
        hit_formula = 0,
        def_formula = 0,
        basehurt_formula = 10065,
        minhurt_formula = 9994,
        crit_formula = 0,
        crithur_ratio = 0,
        correct_formula = 9989,
        lifesteal_formula = 1001,
        spell_lifesteal_formula = 1002,
        returndamage_formula = 1000
    },
    Aoe = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1}
}
bs_1055.ctor = function(self)
    -- function num : 0_0
end

bs_1055.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_1055.PlaySkill = function(self, data)
    -- function num : 0_2 , upvalues : _ENV
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 15, 20)
    if targetList.Count < 0 then return end
    self:CallCasterWait(30)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger,
                                       (targetList[0]).targetRole);
    (self.caster):LookAtTarget((targetList[0]).targetRole)
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectStartId, self)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 15,
                                           attackTrigger)
end

bs_1055.OnAttackTrigger = function(self, target)
    -- function num : 0_3 , upvalues : _ENV
    LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
    local pro = 0
    LuaSkillCtrl:StartTimer(self, 11, function()
        -- function num : 0_3_0 , upvalues : self, pro, _ENV, target
        do
            if (self.arglist)[4] > 0 and ((self.caster).recordTable).X_num > 0 then
                local number = ((self.caster).recordTable).X_num
                pro = number * (self.arglist)[3]
            end
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self,
                                                                     target)
            LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig1,
                                    {pro})
            skillResult:EndResult()
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self,
                                                                     target,
                                                                     (self.config).Aoe)
            LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig2,
                                    {pro})
            skillResult:EndResult()
        end
    end)
end

bs_1055.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1055

