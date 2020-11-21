-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10157 = class("bs_10157", LuaSkillBase)
local base = LuaSkillBase
bs_10157.config = {}
bs_10157.ctor = function(self)
    -- function num : 0_0
end

bs_10157.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10157_3", 1,
                    self.OnAfterHurt)
    self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10157_2", 2,
                    self.OnAfterBattleStart)
end

bs_10157.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                                isCrit, isRealDmg)
    -- function num : 0_2 , upvalues : _ENV
    if target == self.caster and (self.caster).hp <= (self.caster).maxHp *
        (self.arglist)[1] // 1000 and self:IsReadyToTake() then
        self:PlayChipEffect()
        local skills = (self.caster):GetBattleSkillList()
        if skills ~= nil then
            local skillCount = skills.Count
            if skillCount > 0 then
                for j = 0, skillCount - 1 do
                    local curTotalCd = (skills[j]).totalCDTime
                    if not (skills[j]).isCommonAttack then
                        LuaSkillCtrl:CallResetCDForSingleSkill(skills[j],
                                                               curTotalCd)
                    end
                end
            end
        end
        do self:OnSkillTake() end
    end
end

bs_10157.OnAfterBattleStart = function(self)
    -- function num : 0_3 , upvalues : _ENV
    if (self.caster).hp <= (self.caster).maxHp * (self.arglist)[1] // 1000 and
        self:IsReadyToTake() then
        self:PlayChipEffect()
        local skills = (self.caster):GetBattleSkillList()
        if skills ~= nil then
            local skillCount = skills.Count
            if skillCount > 0 then
                for j = 0, skillCount - 1 do
                    local curTotalCd = (skills[j]).totalCDTime
                    if not (skills[j]).isCommonAttack then
                        LuaSkillCtrl:CallResetCDForSingleSkill(skills[j],
                                                               curTotalCd)
                    end
                end
            end
        end
        do self:OnSkillTake() end
    end
end

bs_10157.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10157

