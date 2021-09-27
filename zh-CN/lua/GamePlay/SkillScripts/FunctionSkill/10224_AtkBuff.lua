local bs_10224 = class("bs_10224", LuaSkillBase)
local base = LuaSkillBase
bs_10224.config = {buffId = 1080, buffTier = 1, effectId1 = 10749, effectId2 = 10750, effectId3 = 10751, effectId4 = 10752}
bs_10224.ctor = function(self)
  -- function num : 0_0
end

bs_10224.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10224_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.RoleDie, "bs_10224_10", 2, self.OnRoleDie)
end

bs_10224.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:PlayChipEffect()
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier, nil, true)
  self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId3, self)
end

bs_10224.OnRoleDie = function(self, killer, role)
  -- function num : 0_3 , upvalues : _ENV
  if role.belongNum ~= 0 and role.belongNum ~= (self.caster).belongNum and not ((self.caster).recordTable)["30009_arg"] then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
    if self.effect ~= nil then
      (self.effect):Die()
      self.effect = nil
    end
  end
end

bs_10224.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
end

bs_10224.LuaDispose = function(self)
  -- function num : 0_5 , upvalues : base
  (base.LuaDispose)(self)
  self.effect = nil
end

return bs_10224

