-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10247 = class("bs_10247", LuaSkillBase)
local base = LuaSkillBase
bs_10247.config = {damageFormular = 10123, effectId = 10785}
bs_10247.ctor = function(self)
  -- function num : 0_0
end

bs_10247.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10247_3", 1, self.OnAfterHurt, self.caster)
  self.damageTime = 0
end

bs_10247.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster then
    self.damageTime = self.damageTime + 1
    if (self.arglist)[1] <= self.damageTime and self:IsReadyToTake() then
      self:OnSkillTake()
      self.damageTime = 0
      LuaSkillCtrl:CallEffect(target, (self.config).effectId, self, self.SkillEventFunc)
      self:PlayChipEffect()
    end
  end
end

bs_10247.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_3 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target, (self.config).aoe_config)
    if (skillResult.roleList).Count < 1 then
      return 
    end
    local hurt = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).damageFormular, self.caster, (skillResult.roleList)[0], self)
    LuaSkillCtrl:RemoveLife(hurt, self, (skillResult.roleList)[0], true, true, nil, true)
    skillResult:EndResult()
  end
end

bs_10247.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10247

