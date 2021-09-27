local bs_10289 = class("bs_10289", LuaSkillBase)
local base = LuaSkillBase
bs_10289.config = {buffId = 1059, buffTier = 1}
bs_10289.ctor = function(self)
  -- function num : 0_0
end

bs_10289.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10289_3", 3, self.OnAfterPlaySkill)
end

bs_10289.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if skill.maker == self.caster and not skill.isCommonAttack then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 45, 0)
    if targetlist.Count < 1 then
      return 
    end
    local targetRole = (targetlist[0]).targetRole
    if targetRole.hp > 0 then
      LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, (self.arglist)[1], (self.arglist)[2])
    end
  end
end

bs_10289.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10289

