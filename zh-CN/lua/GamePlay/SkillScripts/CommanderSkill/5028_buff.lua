local bs_5028 = class("bs_5028", LuaSkillBase)
local base = LuaSkillBase
bs_5028.config = {
HurtConfig = {basehurt_formula = 10127}
}
bs_5028.ctor = function(self)
  -- function num : 0_0
end

bs_5028.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1
  self:AddAfterHurtTrigger("bs_5028_1", 1, self.OnAfterHurt, nil, self.caster)
  self.healTargetList = {}
end

bs_5028.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender.belongNum ~= (self.caster).belongNum and target ~= nil and target.hp > 0 and target == self.caster and skill.isCommonAttack and not isMiss then
    local buffId = LuaSkillCtrl:GetSkillBindBuffId(self)
    if (self.caster):GetBuffTier(buffId) >= 2 then
      local highAttRole = LuaSkillCtrl:CallTargetSelect(self, 54, 20)
      if highAttRole ~= nil and highAttRole.Count > 0 and highAttRole[0] ~= nil then
        local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
        LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig, {((highAttRole[0]).targetRole).skill_intensity}, true)
        skillResult:EndResult()
      end
    end
    do
      if self.caster ~= nil and (self.caster):GetBuffTier(buffId) >= 3 and (self.healTargetList)[sender] == nil then
        LuaSkillCtrl:CallHeal(sender.maxHp * (self.arglist)[2] // 1000, self, sender, true)
        -- DECOMPILER ERROR at PC87: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (self.healTargetList)[sender] = true
      end
    end
  end
end

bs_5028.OnCasterDie = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_5028.LuaDispose = function(self)
  -- function num : 0_4 , upvalues : base
  self.healTargetList = nil
  ;
  (base.LuaDispose)(self)
end

return bs_5028

