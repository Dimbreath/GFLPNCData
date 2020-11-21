-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10142 = class("bs_10142", LuaSkillBase)
local base = LuaSkillBase
bs_10142.config = {damageFormular = 10041, effectId = 10334, effectId2 = 10335}
bs_10142.ctor = function(self)
    -- function num : 0_0
end

bs_10142.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10142_1", 1,
                    self.OnAfterPlaySkill)
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10142_2", 2, self.OnSetHurt) -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.caster).recordTable)["10142_AttackTime"] = 0 -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.caster).recordTable).DamageFlag = false
end

bs_10142.OnAfterPlaySkill = function(self, skill, role)
    -- function num : 0_2
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

    if skill.maker == self.caster and skill.isCommonAttack then
        ((self.caster).recordTable)["10142_AttackTime"] =
            ((self.caster).recordTable)["10142_AttackTime"] + 1
        -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

        if ((self.caster).recordTable)["10142_AttackTime"] >= 3 then
            ((self.caster).recordTable).DamageFlag = true -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'
            ;
            ((self.caster).recordTable)["10142_AttackTime"] = 0
        end
    end
end

bs_10142.OnSetHurt = function(self, context)
    -- function num : 0_3 , upvalues : _ENV
    if context.sender == self.caster and (context.skill).isCommonAttack and
        not context.isTriggerSet and ((self.caster).recordTable).DamageFlag then
        local damageNum = LuaSkillCtrl:CallFormulaNumberWithSkill(
                              (self.config).damageFormular, self.caster, target,
                              self)
        if damageNum <= 1 then return end
        if (self.caster).hp <= 1 then return end
        local enemyDamage = damageNum * (self.arglist)[2] // 1000
        if ((self.caster).recordTable).lastAttackRole ~= nil then
            LuaSkillCtrl:RemoveLife(enemyDamage, self,
                                    ((self.caster).recordTable).lastAttackRole,
                                    true, true)
        end
        LuaSkillCtrl:RemoveLife(damageNum, self, self.caster, true, true)
        LuaSkillCtrl:CallEffect(context.target, (self.config).effectId, self)
        LuaSkillCtrl:CallEffect(context.target, (self.config).effectId2, self)
        LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self) -- DECOMPILER ERROR at PC82: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((self.caster).recordTable).DamageFlag = false
    end
end

bs_10142.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10142

