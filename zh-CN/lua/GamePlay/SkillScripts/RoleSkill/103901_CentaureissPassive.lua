local bs_103901 = class("bs_103901", LuaSkillBase)
local base = LuaSkillBase
bs_103901.config = {buffId_151 = 151, buffId_66 = 66, 
hurt_config = {hit_formula = 0, basehurt_formula = 3000, crit_formula = 0, crithur_ratio = 0}
, audioId1 = 103901, 
Aoe = {effect_shape = 3, aoe_select_code = 5, aoe_range = 1}
, effectId_high = 103904}
bs_103901.ctor = function(self)
  -- function num : 0_0
end

bs_103901.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_103901_3", 1, self.OnAfterHurt, self.caster)
  self.attackNum = 0
end

bs_103901.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if skill.isCommonAttack and self:IsReadyToTake() then
    LuaSkillCtrl:CallEffect(target, (self.config).effectId_high, self)
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).Aoe)
    for i = 0, (skillResult.roleList).Count - 1 do
      LuaSkillCtrl:CallBuff(self, (skillResult.roleList)[i], (self.config).buffId_66, 1, (self.arglist)[2])
    end
    LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {(self.arglist)[1]})
    skillResult:EndResult()
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
    self:OnSkillTake()
  end
end

bs_103901.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103901

