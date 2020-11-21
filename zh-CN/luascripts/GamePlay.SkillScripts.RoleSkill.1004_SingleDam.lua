-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1004 = class("bs_1004", LuaSkillBase)
local base = LuaSkillBase
bs_1004.config = {
    hurt_config1 = {
        hit_formula = 0,
        basehurt_formula = 1051,
        crit_formula = 0,
        crithur_ratio = 0
    },
    hurt_config2 = {
        hit_formula = 0,
        def_formula = 0,
        basehurt_formula = 1066,
        crit_formula = 0,
        crithur_ratio = 0,
        correct_formula = 0
    },
    buffId = 0,
    buffTier = 0,
    buffDuration = 0
}
bs_1004.ctor = function(self)
    -- function num : 0_0
end

bs_1004.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1
end

bs_1004.PlaySkill = function(self)
    -- function num : 0_2 , upvalues : _ENV
    self:CallCasterWait(10)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
    self:CallCasterLookAt(targetList)
    LuaSkillCtrl:CallEffect(targetList, 1037, self, self.SkillEventFunc)
end

bs_1004.SkillEventFunc = function(self, effect, eventId, target)
    -- function num : 0_3 , upvalues : _ENV
    if eventId == eBattleEffectEvent.Trigger then
        local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
        LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config1)
        if (self.arglist)[3] == 1 then
            LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config2)
        end
        skillResult:EndResult()
    end
end

bs_1004.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1004

