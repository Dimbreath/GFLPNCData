local bs_10170 = class("bs_10170", LuaSkillBase)
local base = LuaSkillBase
bs_10170.config = {buffId = 1205, buffTier = 1}
bs_10170.ctor = function(self)
  -- function num : 0_0
end

bs_10170.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10170_2", 1, self.OnSetHurt, self.caster, nil, nil, eBattleRoleBelong.neutral)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10170_1", 2, self.OnRoleDie)
end

bs_10170.OnSetHurt = function(self, context)
  -- function num : 0_2
  if context.sender == self.caster and (context.target).belongNum == 0 and (context.target).intensity == 0 then
    context.hurt = context.hurt + (context.target).maxHp
  end
end

bs_10170.OnRoleDie = function(self, killer, role)
  -- function num : 0_3 , upvalues : _ENV
  if role.intensity == 0 and role.belongNum == 0 and killer == self.caster then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
  end
end

bs_10170.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10170

