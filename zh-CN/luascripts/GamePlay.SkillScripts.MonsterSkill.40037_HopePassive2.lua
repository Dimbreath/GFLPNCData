-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40037 = class("bs_40037", LuaSkillBase)
local base = LuaSkillBase
bs_40037.config = {}
bs_40037.ctor = function(self)
  -- function num : 0_0
end

bs_40037.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_40037_3", 1, self.OnAfterHurt)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_40037_10", 1, self.OnRoleDie)
end

bs_40037.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2
end

bs_40037.OnRoleDie = function(self, killer, role)
  -- function num : 0_3 , upvalues : _ENV
  if role == self.caster then
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 0, nil)
  end
end

bs_40037.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40037

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40037 = class("bs_40037", LuaSkillBase)
local base = LuaSkillBase
bs_40037.config = {}
bs_40037.ctor = function(self)
    -- function num : 0_0
end

bs_40037.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_40037_3", 1,
                    self.OnAfterHurt)
    self:AddTrigger(eSkillTriggerType.RoleDie, "bs_40037_10", 1, self.OnRoleDie)
end

bs_40037.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                                isCrit, isRealDmg)
    -- function num : 0_2
end

bs_40037.OnRoleDie = function(self, killer, role)
    -- function num : 0_3 , upvalues : _ENV
    if role == self.caster then
        LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 0,
                                               nil)
    end
end

bs_40037.OnCasterDie = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_40037

