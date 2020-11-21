-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40013 = class("bs_40013", LuaSkillBase)
local base = LuaSkillBase
bs_40013.config = {
    hurt_config1 = {basehurt_formula = 10019},
    hurt_config2 = {basehurt_formula = 10025},
    aoe_config = {effect_shape = 3, aoe_select_code = 4, aoe_range = 1},
    effectId = 10099,
    buffId = 66,
    buffTier = 1,
    buffDuration = 30,
    startAnimID = 1004,
    audioId1 = 25
}
bs_40013.ctor = function(self)
    -- function num : 0_0
end

bs_40013.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.BeforePlaySkill, "bs_40013_1", 1,
                    self.OnBeforePlaySkill)
end

bs_40013.OnBeforePlaySkill = function(self, role, context)
    -- function num : 0_2 , upvalues : _ENV
    if (context.skill).maker == self.caster and (context.skill).dataId == 503 and
        LuaSkillCtrl:CallRange(1, 100) < (self.arglist)[1] then
        local targetRole = ((self.caster).recordTable).lastAttackRole
        do
            if targetRole == nil then
                local targetlist = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
                if targetlist.Count > 0 then
                    targetRole = (targetlist[0]).targetRole
                else
                    return
                end
            end
            if LuaSkillCtrl:IsAbleAttackTarget(self.caster, targetRole, 1) then
                context.active = false;
                (self.caster):LookAtTarget(targetRole)
                local attackTrigger = BindCallback(self, self.OnAttackTrigger,
                                                   targetRole, data)
                self:CallCasterWait(40)
                LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId, self)
                LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster,
                                                       (self.config).startAnimID,
                                                       1, 13, attackTrigger);
                ((self.caster).auSource):PlayAudioById((self.config).audioId1)
            end
        end
    end
end

bs_40013.OnAttackTrigger = function(self, target, data)
    -- function num : 0_3 , upvalues : _ENV
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config2)
    skillResult:BuffResult((self.config).buffId, (self.config).buffTier,
                           (self.arglist)[2])
    skillResult:EndResult()
    local skillResult1 = LuaSkillCtrl:CallSkillResultNoEffect(self, target,
                                                              (self.config).aoe_config)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config1)
    skillResult1:EndResult()
end

bs_40013.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_40013

