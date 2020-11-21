-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1019 = class("bs_1019", LuaSkillBase)
local base = LuaSkillBase
bs_1019.config = {buffId = 94, effectId = 1034, selectId = 23}
bs_1019.ctor = function(self)
    -- function num : 0_0
end

bs_1019.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_1019_1", 1,
                    self.OnAfterBattleStart)
end

bs_1019.OnAfterBattleStart = function(self)
    -- function num : 0_2 , upvalues : _ENV
    local targetList = LuaSkillCtrl:CallTargetSelect(self,
                                                     (self.config).selectId, 0)
    self:CallCasterLookAt(targetList)
    LuaSkillCtrl:CallEffect(targetList, (self.config).effectId, self)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId,
                          (self.arglist)[1])
end

bs_1019.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1019

