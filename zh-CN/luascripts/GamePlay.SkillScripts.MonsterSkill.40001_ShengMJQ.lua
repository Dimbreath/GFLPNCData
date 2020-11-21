-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40001 = class("bs_40001", LuaSkillBase)
local base = LuaSkillBase
bs_40001.config = {
    damageNum = 0,
    damageEffectId = 10023,
    healEffectId = 10022,
    damageFormula = 10014
}
bs_40001.ctor = function(self)
    -- function num : 0_0
end

bs_40001.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_40001_1", 100,
                    self.OnAfterHurt)
end

bs_40001.PlaySkill = function(self, data)
    -- function num : 0_2 , upvalues : _ENV
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

    if targetList.Count > 0 then
        (self.config).damageNum = LuaSkillCtrl:CallFormulaNumber(
                                      (self.config).damageFormula, self.caster,
                                      (targetList[0]).targetRole)
        LuaSkillCtrl:RemoveLife((self.config).damageNum, self,
                                (targetList[0]).targetRole)
        LuaSkillCtrl:CallEffect((targetList[0]).targetRole,
                                (self.config).damageEffectId, self)
    end
end

bs_40001.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                                isCrit, isRealDmg)
    -- function num : 0_3 , upvalues : _ENV
    if sender == self.caster and skill.dataId == 40001 then
        local targetList = LuaSkillCtrl:CallTargetSelect(self, 14, 10)
        if targetList.Count > 0 then
            LuaSkillCtrl:CallHeal(hurt, self, (targetList[0]).targetRole)
            LuaSkillCtrl:CallEffect((targetList[0]).targetRole,
                                    (self.config).healEffectId, self)
        end
    end
end

bs_40001.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_40001

