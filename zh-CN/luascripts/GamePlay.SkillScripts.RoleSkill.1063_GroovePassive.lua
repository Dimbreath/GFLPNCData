-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1063 = class("bs_1063", LuaSkillBase)
local base = LuaSkillBase
bs_1063.config = {
    buffId = 171,
    AOE = {effect_shape = 3, aoe_select_code = 4, aoe_range = 10},
    HurtConfig = {
        basehurt_formula = 10058,
        minhurt_formula = 9994,
        correct_formula = 9989
    }
}
bs_1063.ctor = function(self)
    -- function num : 0_0
end

bs_1063.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.BuffDie, "bs_1063_1", 10, self.OnBuffDie)
    self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1063_2", 10,
                    self.OnAfterBattleStart)
end

bs_1063.OnAfterBattleStart = function(self)
    -- function num : 0_2 , upvalues : _ENV
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1)
    self.timerhurt = LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
        -- function num : 0_2_0 , upvalues : self, _ENV
        local tier = 0
        do
            if (self.arglist)[4] > 0 then
                local targetList = LuaSkillCtrl:CallTargetSelect(self, 2, 10)
                tier = targetList.Count * (self.arglist)[3]
            end
            local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self,
                                                                     self.caster,
                                                                     (self.config).AOE)
            LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig,
                                    {tier})
            skillResult:EndResult()
        end
    end, self, -1)
end

bs_1063.OnBuffDie = function(self, buff, target, removeType)
    -- function num : 0_3
end

bs_1063.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
    if self.timerhurt ~= nil then
        (self.timerhurt):Stop()
        self.timerhurt = nil
    end
end

return bs_1063

