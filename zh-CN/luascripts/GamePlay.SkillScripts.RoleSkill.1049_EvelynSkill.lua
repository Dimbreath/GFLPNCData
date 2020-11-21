-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1049 = class("bs_1049", LuaSkillBase)
local base = LuaSkillBase
bs_1049.config = {
    effectId = 10203,
    actionId = 1002,
    stunBuffId = 66,
    hitReduceBuffId = 115,
    hurtConfig = {
        hit_formula = 9991,
        basehurt_formula = 10031,
        crit_formula = 0,
        crithur_ratio = 0
    }
}
bs_1049.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_0 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_1049.PlaySkill = function(self, data)
    -- function num : 0_1 , upvalues : _ENV
    local belongNum = 2
    local grid = LuaSkillCtrl:CallFindGridMostRolesArounded(belongNum)
    if grid ~= nil then
        local target = LuaSkillCtrl:GetTargetWithGrid(grid.x, grid.y)
        self:CallCasterWait(32)
        local roles = LuaSkillCtrl:FindRolesAroundGrid(grid, belongNum)
        local triggerCallBack = BindCallback(self, self.OnActionCallBack,
                                             target, roles)
        LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster,
                                               (self.config).actionId, 1, 15,
                                               triggerCallBack)
    end
end

bs_1049.OnActionCallBack = function(self, target, roles)
    -- function num : 0_2 , upvalues : _ENV
    LuaSkillCtrl:CallEffectWithArg(target, (self.config).effectId, self, true,
                                   self.OnEffectTrigger, roles)
end

bs_1049.OnEffectTrigger = function(self, roles, effect, eventId, target)
    -- function num : 0_3 , upvalues : _ENV
    if effect.dataId == (self.config).effectId and eventId ==
        eBattleEffectEvent.Trigger and roles ~= nil and roles.Count > 0 then
        for i = 0, roles.Count - 1 do
            do
                local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self,
                                                                         roles[i],
                                                                         (self.config).hurtConfig)
                LuaSkillCtrl:HurtResult(skillResult, (self.config).hurtConfig)
                skillResult:EndResult()
                LuaSkillCtrl:CallBuff(self, roles[i], (self.config).stunBuffId,
                                      1, (self.arglist)[2])
                if (self.arglist)[4] > 0 then
                    LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], function()
                        -- function num : 0_3_0 , upvalues : _ENV, self, roles, i
                        LuaSkillCtrl:CallBuff(self, roles[i],
                                              (self.config).hitReduceBuffId, 1,
                                              (self.arglist)[3])
                    end)
                end
            end
        end
    end
end

bs_1049.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1049

