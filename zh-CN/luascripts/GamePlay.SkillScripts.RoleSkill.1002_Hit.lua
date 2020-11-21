-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1002 = class("bs_1002", LuaSkillBase)
local base = LuaSkillBase
bs_1002.config = {
    hurt_config = {
        hit_formula = 0,
        basehurt_formula = 1048,
        crit_formula = 0,
        crithur_ratio = 0
    },
    hurt_config2 = {hit_formula = 0, def_formula = 0, basehurt_formula = 1048},
    effectId = 1043,
    buffId = 66,
    buffTier = 1
}
bs_1002.ctor = function(self)
    -- function num : 0_0
end

bs_1002.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1
end

bs_1002.PlaySkill = function(self, data)
    -- function num : 0_2 , upvalues : _ENV
    self:CallCasterWait(15)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
    self:CallCasterLookAt(targetList)
    LuaSkillCtrl:CallEffect(targetList, (self.config).effectId, self)
    if targetList.Count == 0 then return end
    for i = 1, (self.arglist)[1] do
        do
            LuaSkillCtrl:StartTimer(self, i * 2, function()
                -- function num : 0_2_0 , upvalues : _ENV, self, targetList, i
                local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self,
                                                                         targetList[0])
                LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config,
                                        {i})
                skillResult:EndResult()
            end)
        end
    end
    if (self.arglist)[5] == 1 then
        LuaSkillCtrl:CallBuff(self, (targetList[0]).targetRole,
                              (self.config).buffId, (self.config).buffTier,
                              (self.arglist)[4])
    end
end

bs_1002.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1002

