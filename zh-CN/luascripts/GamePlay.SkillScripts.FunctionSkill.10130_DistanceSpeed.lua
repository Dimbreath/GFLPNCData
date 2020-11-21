-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10130 = class("bs_10130", LuaSkillBase)
local base = LuaSkillBase
bs_10130.config = {buffId = 1009}
bs_10130.ctor = function(self)
    -- function num : 0_0
end

bs_10130.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.BeforePlaySkill, "bs_10130_1", 1,
                    self.OnBeforePlaySkill)
    self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10130_2", 1,
                    self.OnAfterBattleStart)
end

bs_10130.OnAfterBattleStart = function(self)
    -- function num : 0_2
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

    ((self.caster).recordTable)["10130_Initx"] = (self.caster).x -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.caster).recordTable)["10130_Inity"] = (self.caster).y -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.caster).recordTable)["10130_Distance"] = 0
end

bs_10130.OnBeforePlaySkill = function(self, role, context)
    -- function num : 0_3 , upvalues : _ENV
    local distance = LuaSkillCtrl:GetGridsDistance((self.caster).x,
                                                   (self.caster).y,
                                                   ((self.caster).recordTable)["10130_Initx"],
                                                   ((self.caster).recordTable)["10130_Inity"])
    if distance ~= ((self.caster).recordTable)["10130_Distance"] then
        self:PlayChipEffect()
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId,
                              (self.arglist)[1] * distance) -- DECOMPILER ERROR at PC39: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((self.caster).recordTable)["10130_Distance"] = distance
    end
end

bs_10130.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10130

