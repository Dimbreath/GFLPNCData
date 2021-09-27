local bs_203201 = class("bs_203201", LuaSkillBase)
local base = LuaSkillBase
bs_203201.config = {effectlineId = 10587, effecthealId = 10588}
bs_203201.ctor = function(self)
  -- function num : 0_0
end

bs_203201.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_203201_3", 1, self.OnAfterHurt, nil, nil, (self.caster).belongNum)
end

bs_203201.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender.camp == (self.caster).camp and sender.belongNum == (self.caster).belongNum and hurt > 0 and not skill.isCommonAttack then
    local heal = hurt * (self.arglist)[1] // 1000
    if heal <= 1 then
      heal = 1
    end
    LuaSkillCtrl:CallHeal(heal, self, sender, true)
    if sender ~= self.caster then
      LuaSkillCtrl:CallEffect(sender, (self.config).effectlineId, self)
    end
    LuaSkillCtrl:CallEffect(sender, (self.config).effecthealId, self)
  end
end

bs_203201.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_203201

