-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1054 = class("bs_1054", LuaSkillBase)
local base = LuaSkillBase
bs_1054.config = {
    effectX_numId1 = 10320,
    effectX_numId2 = 10321,
    effectX_numId3 = 10322,
    effectX_numId4 = 10323,
    effectX_numId5 = 10324,
    effectLoop = 10331,
    buffId1 = 169,
    Aoe = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1},
    HurtConfig = {
        hit_formula = 0,
        def_formula = 0,
        basehurt_formula = 10063,
        minhurt_formula = 9994,
        crit_formula = 0,
        crithur_ratio = 0,
        correct_formula = 9989,
        lifesteal_formula = 1001,
        spell_lifesteal_formula = 1002,
        returndamage_formula = 1000
    }
}
bs_1054.ctor = function(self)
    -- function num : 0_0
end

bs_1054.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_1054_12", 1,
                    self.OnAfterPlaySkill) -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.caster).recordTable).Passive = 0 -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.caster).recordTable).X_num = 0
    self.Passiveloop = nil
    self.loop = {} -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'
    ;
    (self.loop)[1] = nil -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'
    ;
    (self.loop)[2] = nil -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'
    ;
    (self.loop)[3] = nil -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'
    ;
    (self.loop)[4] = nil -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'
    ;
    (self.loop)[5] = nil
end

bs_1054.OnAfterPlaySkill = function(self, skill, role)
    -- function num : 0_2 , upvalues : _ENV
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

    if role == self.caster and skill.isCommonAttack then
        ((self.caster).recordTable).Passive =
            ((self.caster).recordTable).Passive + 1
        if (self.arglist)[1] <= ((self.caster).recordTable).Passive and
            ((self.caster).recordTable).X_num < 5 then
            local X_number = ((self.caster).recordTable).X_num + 1
            local X_effect =
                (self.config)["effectX_numId" .. tostring(X_number)] -- DECOMPILER ERROR at PC38: Confused about usage of register: R5 in 'UnsetPending'
            ;
            ((self.caster).recordTable).Passive = 0
            LuaSkillCtrl:CallEffect(self.caster, X_effect, self, nil, nil, nil,
                                    false)
            LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, 1) -- DECOMPILER ERROR at PC61: Confused about usage of register: R5 in 'UnsetPending'
            ;
            ((self.caster).recordTable).X_num =
                ((self.caster).recordTable).X_num + 1
            if self.Passiveloop == nil and (self.arglist)[5] > 0 then
                local CallBack = BindCallback(self, self.OnCallback)
                LuaSkillCtrl:CallEffect(self.caster, (self.config).effectLoop,
                                        self, nil, nil, nil, false)
                self.Passiveloop = LuaSkillCtrl:StartTimer(nil,
                                                           (self.arglist)[3],
                                                           CallBack, self, -1)
            end
        end
    end
end

bs_1054.OnCallback = function(self)
    -- function num : 0_3 , upvalues : _ENV
    local pro = ((self.caster).recordTable).X_num
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster,
                                                             (self.config).Aoe)
    if (skillResult.roleList).Count > 0 then
        for i = 0, (skillResult.roleList).Count - 1 do
            LuaSkillCtrl:CallEffect((skillResult.roleList)[i], 10332, self)
        end
    end
    do
        LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig, {pro})
        skillResult:EndResult()
    end
end

bs_1054.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1054

