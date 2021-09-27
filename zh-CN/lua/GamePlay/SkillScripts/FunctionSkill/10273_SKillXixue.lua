local bs_10273 = class("bs_10273", LuaSkillBase)
local base = LuaSkillBase
bs_10273.config = {buffId = 1187, buffTier = 1, effectId = 10892}
bs_10273.ctor = function(self)
  -- function num : 0_0
end

bs_10273.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10273_12", 1, self.OnAfterPlaySkill)
end

bs_10273.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if role == self.caster and not skill.isCommonAttack then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 59, 10)
    if targetlist.Count < 1 then
      return 
    end
    local targetRole = (targetlist[0]).targetRole
    if targetRole == self.caster and targetlist.Count > 1 then
      targetRole = (targetlist[1]).targetRole
    end
    LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, (self.config).buffTier, (self.arglist)[2], true)
    LuaSkillCtrl:CallChipSuitInvoke(self.caster, targetRole)
    LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId, self, self.SkillEventFunc)
    self:PlayChipEffect()
  end
end

bs_10273.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10273

