local bs_6003 = class("bs_6003", LuaSkillBase)
local base = LuaSkillBase
bs_6003.config = {}
bs_6003.ctor = function(self)
  -- function num : 0_0
end

bs_6003.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_6003_12", 1, self.OnAfterPlaySkill)
  self.attack_num = 0
end

bs_6003.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if skill.isCommonAttack and self.caster == role then
    self.attack_num = self.attack_num + 1
    local num = self.attack_num
    if self.attack_num % (self.arglist)[1] == 0 then
      LuaSkillCtrl:CallResetCDNumForRole(role, (self.arglist)[2])
    end
  end
end

bs_6003.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_6003

