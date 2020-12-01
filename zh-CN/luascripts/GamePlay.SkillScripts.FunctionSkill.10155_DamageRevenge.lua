-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10155 = class("bs_10155", LuaSkillBase)
local base = LuaSkillBase
bs_10155.config = {buffId = 1026}
bs_10155.ctor = function(self)
  -- function num : 0_0
end

bs_10155.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10155_3", 1, self.OnAfterHurt)
end

bs_10155.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and not isMiss and not skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1])
  end
end

bs_10155.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10155

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10155 = class("bs_10155", LuaSkillBase)
local base = LuaSkillBase
bs_10155.config = {buffId = 1026}
bs_10155.ctor = function(self)
    -- function num : 0_0
end

bs_10155.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10155_3", 1,
                    self.OnAfterHurt)
end

bs_10155.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                                isCrit, isRealDmg)
    -- function num : 0_2 , upvalues : _ENV
    if sender == self.caster and not isMiss and not skill.isCommonAttack then
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId,
                              (self.arglist)[1])
    end
end

bs_10155.OnCasterDie = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10155

