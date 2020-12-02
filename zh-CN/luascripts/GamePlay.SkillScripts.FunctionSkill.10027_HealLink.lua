-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10027 = class("bs_10027", LuaSkillBase)
local base = LuaSkillBase
bs_10027.config = {effectId = 1004}
bs_10027.ctor = function(self)
  -- function num : 0_0
end

bs_10027.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterHeal, "bs_10027_5", 1, self.OnAfterHeal)
end

bs_10027.OnAfterHeal = function(self, sender, target, skill, heal)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and target ~= self.caster then
    local realHeal = heal * (self.arglist)[1] // 1000
    if realHeal > 0 then
      self:PlayChipEffect()
      LuaSkillCtrl:CallEffectWithArg(self.caster, (self.config).effectId, self, true, self.SkillBack, realHeal)
    end
  end
end

bs_10027.SkillBack = function(self, realHeal, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:CallHeal(realHeal, self, self.caster)
  end
end

bs_10027.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10027

