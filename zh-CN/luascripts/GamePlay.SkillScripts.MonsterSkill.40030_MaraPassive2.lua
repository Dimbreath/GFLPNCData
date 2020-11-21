-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40030 = class("bs_40030", LuaSkillBase)
local base = LuaSkillBase
bs_40030.config = {buffId = 163, effectId = 10229}
bs_40030.ctor = function(self)
    -- function num : 0_0
end

bs_40030.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    self.loop = nil;
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_40030_2", 1, self.OnSetHurt)
    self.timer = LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], function()
        -- function num : 0_1_0 , upvalues : self, _ENV
        if (self.caster).hp > 0 and
            (self.caster):GetBuffTier((self.config).buffId) < 10 then
            LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId,
                                  (self.arglist)[2])
            if self.loop == nil then
                self.loop = LuaSkillCtrl:CallEffect(self.caster,
                                                    (self.config).effectId,
                                                    self, nil, nil, nil, false)
            end
        end
    end, -1, (self.arglist)[1])
end

bs_40030.OnSetHurt = function(self, context)
    -- function num : 0_2 , upvalues : _ENV
    if context.target == self.caster and
        (self.caster):GetBuffTier((self.config).buffId) > 0 and context.sender ~=
        self.caster then
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 1)
        LuaSkillCtrl:RemoveLife(context.hurt, self, context.sender, true)
        context.hurt = 0
        LuaSkillCtrl:CallFloatText(self.caster, 7)
        if (self.caster):GetBuffTier((self.config).buffId) == 0 and self.loop ~=
            nil then
            (self.loop):Die()
            self.loop = nil
        end
    end
end

bs_40030.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
    if self.loop ~= nil then
        (self.loop):Die()
        self.loop = nil
    end
end

return bs_40030

