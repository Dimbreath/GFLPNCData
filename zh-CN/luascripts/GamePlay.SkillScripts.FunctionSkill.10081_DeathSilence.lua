-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10081 = class("bs_10081", LuaSkillBase)
local base = LuaSkillBase
bs_10081.config = {buffId = 26, buffTier = 1}
bs_10081.ctor = function(self)
    -- function num : 0_0
end

bs_10081.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10081_1", 1, self.OnRoleDie)
end

bs_10081.OnRoleDie = function(self, role)
    -- function num : 0_2
    if self.caster == role then end
end

bs_10081.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : _ENV, base
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 10)
    for i = 0, targetlist.Count - 1 do
        LuaSkillCtrl:CallBuff(self, (targetlist[i]).targetRole,
                              (self.config).buffId, (self.config).buffTier,
                              (self.arglist)[1])
    end
    (base.OnCasterDie)(self)
end

return bs_10081

