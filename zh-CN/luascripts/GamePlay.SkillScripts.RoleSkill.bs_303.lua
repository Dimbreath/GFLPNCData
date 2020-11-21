-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_303 = class("bs_303", LuaSkillBase)
local base = LuaSkillBase
bs_303.config = {
    buffId1 = 135,
    buffId2 = 66,
    effectId3 = 10134,
    effectId2 = 10135,
    effectId1 = 10136,
    effectId0 = 10090
}
bs_303.ctor = function(self)
    -- function num : 0_0
end

bs_303.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_303_1", 1, self.OnSetHurt)
end

bs_303.PlaySkill = function(self, data)
    -- function num : 0_2 , upvalues : _ENV
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

    ((self.caster).recordTable)["303_HD"] = 3
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    self:CallCasterWait(30)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 20,
                                           attackTrigger)
end

bs_303.OnAttackTrigger = function(self, date)
    -- function num : 0_3 , upvalues : _ENV
    self.Effect_303_3 = LuaSkillCtrl:CallEffect(self.caster,
                                                (self.config).effectId3, self)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, 1)
end

bs_303.OnSetHurt = function(self, context)
    -- function num : 0_4 , upvalues : _ENV
    if (self.caster):GetBuffTier((self.config).buffId1) ~= 0 and context.target ==
        self.caster and context.hurt > 0 and LuaSkillCtrl:CallRange(1, 1000) <=
        (self.arglist)[3] then
        LuaSkillCtrl:CallEffectWithArg(context.sender, (self.config).effectId0,
                                       self, true, self.SkillEventFunc, context)
        context.hurt = 0
        LuaSkillCtrl:CallFloatText(self.caster, 7) -- DECOMPILER ERROR at PC45: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.caster).recordTable)["303_HD"] =
            ((self.caster).recordTable)["303_HD"] - 1
        -- DECOMPILER ERROR at PC56: Unhandled construct in 'MakeBoolean' P1

        if ((self.caster).recordTable)["303_HD"] == 2 and self.Effect_303_3 ~=
            nil then
            (self.Effect_303_3):Die()
            self.Effect_303_2 = LuaSkillCtrl:CallEffect(self.caster,
                                                        (self.config).effectId2,
                                                        self)
        end
    end
    -- DECOMPILER ERROR at PC76: Unhandled construct in 'MakeBoolean' P1

    if ((self.caster).recordTable)["303_HD"] == 1 and self.Effect_303_2 ~= nil then
        (self.Effect_303_2):Die()
        self.Effect_303_1 = LuaSkillCtrl:CallEffect(self.caster,
                                                    (self.config).effectId1,
                                                    self)
    end
    if ((self.caster).recordTable)["303_HD"] == 0 and self.Effect_303_1 ~= nil then
        (self.Effect_303_1):Die()
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId1, 1)
    end
end

bs_303.SkillEventFunc = function(self, context, effect, eventId, target)
    -- function num : 0_5 , upvalues : _ENV
    if effect.dataId == (self.config).effectId0 and eventId ==
        eBattleEffectEvent.Trigger then
        LuaSkillCtrl:CallBuff(self, context.sender, (self.config).buffId2, 1,
                              (self.arglist)[1])
        if (self.arglist)[2] >= 0 then
            LuaSkillCtrl:RemoveLife(20, self, context.sender)
        end
    end
end

bs_303.OnCasterDie = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_303

