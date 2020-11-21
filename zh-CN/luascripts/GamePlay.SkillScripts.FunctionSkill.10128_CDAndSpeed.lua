-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10128 = class("bs_10128", LuaSkillBase)
local base = LuaSkillBase
bs_10128.config = {buffId = 1009, effectId = 10164}
bs_10128.ctor = function(self)
    -- function num : 0_0
end

bs_10128.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10128_1", 1,
                    self.OnAfterBattleStart)
end

bs_10128.OnAfterBattleStart = function(self)
    -- function num : 0_2 , upvalues : _ENV
    self:PlayChipEffect()
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId,
                          (self.arglist)[1], (self.arglist)[2])
    local skills = (self.caster):GetBattleSkillList()
    if skills ~= nil then
        local skillCount = skills.Count
        if skillCount > 0 then
            for j = 0, skillCount - 1 do
                local curTotalCd = (skills[j]).totalCDTime
                LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
            end
        end
    end
end

bs_10128.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10128

