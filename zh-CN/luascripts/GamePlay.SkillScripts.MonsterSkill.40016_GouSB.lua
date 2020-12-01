-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40016 = class("bs_40016", LuaSkillBase)
local base = LuaSkillBase
bs_40016.config = {buffId = 1008, buffId1 = 1030}
bs_40016.ctor = function(self)
  -- function num : 0_0
end

bs_40016.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_40016_1", 1, self.OnRoleDie)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_40016_2", 2, self.OnAfterBattleStart)
end

bs_40016.OnRoleDie = function(self, killer, role)
  -- function num : 0_2 , upvalues : _ENV
  if (self.caster).belongNum == role.belongNum then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[2])
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1, (self.arglist)[3])
  end
end

bs_40016.OnAfterBattleStart = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1])
end

bs_40016.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40016

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40016 = class("bs_40016", LuaSkillBase)
local base = LuaSkillBase
bs_40016.config = {buffId = 1008, buffId1 = 1030}
bs_40016.ctor = function(self)
    -- function num : 0_0
end

bs_40016.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.RoleDie, "bs_40016_1", 1, self.OnRoleDie)
    self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_40016_2", 2,
                    self.OnAfterBattleStart)
end

bs_40016.OnRoleDie = function(self, killer, role)
    -- function num : 0_2 , upvalues : _ENV
    if (self.caster).belongNum == role.belongNum then
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId,
                              (self.arglist)[2])
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId1,
                              (self.arglist)[3])
    end
end

bs_40016.OnAfterBattleStart = function(self)
    -- function num : 0_3 , upvalues : _ENV
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId,
                          (self.arglist)[1])
end

bs_40016.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_40016

