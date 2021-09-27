local bs_102501 = class("bs_102501", LuaSkillBase)
local base = LuaSkillBase
bs_102501.config = {
HurtConfig = {hit_formula = 0, basehurt_formula = 3000, crit_formula = 0, crithur_ratio = 0, returndamage_formula = 0}
, buffId_CH = 102501}
bs_102501.ctor = function(self)
  -- function num : 0_0
end

bs_102501.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_102501_3", 90, self.OnAfterHurt, self.caster)
  self:AddBuffDieTrigger("bs_102501_5", 99, self.OnBuffDie, nil, 2, (self.config).buffId_CH)
end

bs_102501.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and target.belongNum ~= (self.caster).belongNum and isTriggerSet ~= true and (skill.dataId == 102500 or skill.dataId == 102502) then
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_CH, 1)
  end
end

bs_102501.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_3 , upvalues : _ENV
  if target.belongNum ~= (self.caster).belongNum then
    local num = buff.tier
    if num > 0 then
      local hurt = num * (self.arglist)[1]
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {hurt})
      skillResult:EndResult()
    end
  end
end

bs_102501.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102501

