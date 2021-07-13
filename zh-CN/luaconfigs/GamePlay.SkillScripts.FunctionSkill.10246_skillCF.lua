-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10246 = class("bs_10246", LuaSkillBase)
local base = LuaSkillBase
bs_10246.config = {buffId = 1025, buffId2 = 1133, buffTier = 1}
bs_10246.ctor = function(self)
  -- function num : 0_0
end

bs_10246.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10246_12", 1, self.OnAfterPlaySkill)
end

bs_10246.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if skill.maker == self.caster and not skill.isCommonAttack then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 21, 10)
    if targetlist.Count < 1 then
      return 
    end
    LuaSkillCtrl:CallBuff(self, (targetlist[0]).targetRole, (self.config).buffId, (self.config).buffTier, (self.arglist)[2])
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId2, (self.config).buffTier, nil, true)
    self:PlayChipEffect()
  end
end

bs_10246.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10246

