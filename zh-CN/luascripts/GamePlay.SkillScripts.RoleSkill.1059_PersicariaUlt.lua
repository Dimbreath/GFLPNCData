-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1059 = class("bs_1059", LuaSkillBase)
local base = LuaSkillBase
bs_1059.config = {
    effectId1 = 10222,
    effectId3 = 10223,
    buffId = 162,
    aoe_config = {effect_shape = 1, aoe_select_code = 3, aoe_range = 10},
    heal_config = {
        baseheal_formula = 10011,
        heal_number = 0,
        correct_formula = 9990
    }
}
bs_1059.ctor = function(self)
    -- function num : 0_0
end

bs_1059.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1
    self.hurt_config = {}
    self.buff_during_time = (self.arglist)[2]
end

bs_1059.PlaySkill = function(self)
    -- function num : 0_2 , upvalues : _ENV
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self,
                            self.SkillEventFunc, nil, 0.5)
    LuaSkillCtrl:CallBattleCamShake()
end

bs_1059.SkillEventFunc = function(self, effect, eventId, target)
    -- function num : 0_3 , upvalues : _ENV
    if eventId == eBattleEffectEvent.Trigger then
        local skillResult = LuaSkillCtrl:CallSkillResult(effect, target,
                                                         (self.config).aoe_config)
        if (skillResult.roleList).Count >= 2 then
            for i = 0, (skillResult.roleList).Count - 1 do
                if i == (skillResult.roleList).Count - 1 then
                    LuaSkillCtrl:CallEffect((skillResult.roleList)[i],
                                            (self.config).effectId3, self, nil,
                                            (skillResult.roleList)[0])
                else
                    LuaSkillCtrl:CallEffect((skillResult.roleList)[i + 1],
                                            (self.config).effectId3, self, nil,
                                            (skillResult.roleList)[i])
                end
            end
        end
        do
            skillResult:BuffResult((self.config).buffId, 1,
                                   self.buff_during_time)
            skillResult:HealResult((self.config).heal_config)
            skillResult:EndResult()
        end
    end
end

bs_1059.PlayUltEffect = function(self)
    -- function num : 0_4 , upvalues : _ENV
    LuaSkillCtrl:CallFocusTimeLine(self.caster)
    self:AddTrigger(eSkillTriggerType.AfterSelfUltInTimeLineEnd, "bs_1059_1", 1,
                    self.AfterFocusTimeLine)
    self:AddTrigger(eSkillTriggerType.AfterSelfUltMovieEnd, "bs_1059_2", 1,
                    self.OnMovieEnd)
    self:AddTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut, "bs_1059_3", 1,
                    self.OnMovieFadeOut)
end

bs_1059.OnUltRoleAction = function(self)
    -- function num : 0_5 , upvalues : _ENV
    self:CallCasterWait(20)
    LuaSkillCtrl:CallRoleAction(self.caster, 1005)
end

bs_1059.AfterFocusTimeLine = function(self)
    -- function num : 0_6 , upvalues : _ENV
    LuaSkillCtrl:StartTimerInUlt(10, function()
        -- function num : 0_6_0 , upvalues : _ENV
        LuaSkillCtrl:CallPlayUltMovie()
    end, nil)
    self:RemoveTrigger(eSkillTriggerType.AfterSelfUltInTimeLineEnd)
end

bs_1059.OnMovieFadeOut = function(self)
    -- function num : 0_7 , upvalues : _ENV
    LuaSkillCtrl:CallRoleAction(self.caster, 1006)
    self:RemoveTrigger(eSkillTriggerType.OnSelfUltMovieFadeOut)
    LuaSkillCtrl:CallBackViewTimeLine(self.caster, true)
    self:RemoveTrigger(eSkillTriggerType.AfterSelfUltMovieEnd)
end

bs_1059.OnMovieEnd = function(self)
    -- function num : 0_8
end

bs_1059.OnCasterDie = function(self)
    -- function num : 0_9 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1059

