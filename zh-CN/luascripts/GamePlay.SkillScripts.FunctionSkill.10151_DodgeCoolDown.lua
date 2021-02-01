-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10151 = class("bs_10151", LuaSkillBase)
local base = LuaSkillBase
bs_10151.config = {buffId = 1123, buffTier = 1}
bs_10151.ctor = function(self)
  -- function num : 0_0
end

bs_10151.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10151_1", 2, self.OnAfterPlaySkill)
end

bs_10151.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_2 , upvalues : _ENV
  if skill.maker == self.caster and not skill.isCommonAttack then
    local layer = (self.caster):GetBuffTier((self.config).buffId)
    if layer ~= (self.arglist)[2] then
      self:PlayChipEffect()
      if layer <= (self.arglist)[2] then
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
      else
        if (self.arglist)[2] < layer then
          LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
          LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[2], nil, true)
        end
      end
    end
  end
end

bs_10151.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10151

