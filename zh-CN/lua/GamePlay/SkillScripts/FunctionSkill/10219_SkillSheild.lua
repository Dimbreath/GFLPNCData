local bs_10219 = class("bs_10219", LuaSkillBase)
local base = LuaSkillBase
bs_10219.config = {buffId = 1027, buffTier = 1, effectId = 10251}
bs_10219.ctor = function(self)
  -- function num : 0_0
end

bs_10219.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10219_1", 2, self.OnAfterPlaySkill)
end

bs_10219.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if skill.maker == self.caster and not skill.isCommonAttack then
    self:PlayChipEffect()
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 30, 10)
    if targetlist.Count <= 0 then
      return 
    end
    LuaSkillCtrl:CallBuff(self, (targetlist[0]).targetRole, (self.config).buffId, (self.config).buffTier, (self.arglist)[1])
  end
end

bs_10219.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10219

