-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40017 = class("bs_40017", LuaSkillBase)
local base = LuaSkillBase
bs_40017.config = {buffId = 1009}
bs_40017.ctor = function(self)
    -- function num : 0_0
end

bs_40017.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.RoleDie, "bs_40017_10", 1, self.OnRoleDie)
end

bs_40017.OnRoleDie = function(self, role)
    -- function num : 0_2 , upvalues : _ENV
    if (self.caster).belongNum == role.belongNum then
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId,
                              (self.arglist)[1])
    end
end

bs_40017.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_40017

