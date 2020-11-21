-- params : ...
-- function num : 0 , upvalues : _ENV
local ShieldSkillBase = require(
                            "GamePlay.SkillScripts.BaseSkill.ShieldSkillBase")
local bs_6001 = class("bs_6001", LuaSkillBase)
local base = LuaSkillBase
bs_6001.config = {buffId = 103, shieldKey = "6001_Shield"}
bs_6001.ctor = function(self)
    -- function num : 0_0
end

bs_6001.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.SetHeal, "bs_6001_4", 1, self.OnSetHeal)
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_6001_2", 2, self.OnSetHurt) -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.caster).recordTable)[(self.config).shieldKey] = 0
end

bs_6001.OnSetHeal = function(self, context)
    -- function num : 0_2 , upvalues : _ENV
    if context.sender == self.caster then
        local heal1 = (context.target).maxHp - (context.target).hp
        if heal1 < context.heal then
            local shield = (context.heal - heal1) * (self.arglist)[1] // 100 -- DECOMPILER ERROR at PC31: Confused about usage of register: R4 in 'UnsetPending'
            ;
            ((context.target).recordTable)[(self.config).shieldKey] =
                (((context.target).recordTable)[(self.config).shieldKey] or 0) +
                    shield
            if shield > 0 and (context.target):GetBuffTier((self.config).buffId) ==
                0 then
                LuaSkillCtrl:CallBuff(self, context.target,
                                      (self.config).buffId, 1)
            end
        end
    end
end

bs_6001.OnSetHurt = function(self, context)
    -- function num : 0_3 , upvalues : ShieldSkillBase, _ENV
    local shield = ((context.target).recordTable)[(self.config).shieldKey]
    if shield ~= nil and shield >= 0 then
        local retHurt = (ShieldSkillBase.ShieldBaseFunc)(self, context.hurt,
                                                         context.target)
        if retHurt ~= context.hurt then context.hurt = retHurt end
        if ((context.target).recordTable)[(self.config).shieldKey] == 0 and
            (context.target):GetBuffTier((self.config).buffId) > 0 then
            LuaSkillCtrl:DispelBuff(context.target, (self.config).buffId)
        end
    end
end

bs_6001.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_6001

