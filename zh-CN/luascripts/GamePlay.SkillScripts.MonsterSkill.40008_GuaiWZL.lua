-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40008 = class("bs_40008", LuaSkillBase)
local base = LuaSkillBase
bs_40008.config = {healEffectId = 10022}
bs_40008.ctor = function(self)
    -- function num : 0_0
end

bs_40008.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_40008_1", 1,
                    self.OnAfterBattleStart) -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.caster).recordTable).healTime = 1
end

bs_40008.OnAfterBattleStart = function(self)
    -- function num : 0_2 , upvalues : _ENV
    self.damTimer = LuaSkillCtrl:StartTimer(self, (self.arglist)[1],
                                            self.CallBack, self, -1)
end

bs_40008.CallBack = function(self)
    -- function num : 0_3 , upvalues : _ENV
    LuaSkillCtrl:CallHeal(20 * ((self.caster).recordTable).healTime, self,
                          self.caster)
    LuaSkillCtrl:CallEffect(self.caster, (self.config).healEffectId, self) -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.caster).recordTable).healTime =
        ((self.caster).recordTable).healTime + 1
end

bs_40008.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
    if self.damTimer then
        (self.damTimer):Stop()
        self.damTimer = nil
    end
end

return bs_40008

