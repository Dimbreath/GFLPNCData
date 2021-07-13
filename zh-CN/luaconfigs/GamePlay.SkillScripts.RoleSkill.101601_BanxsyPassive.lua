-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1044 = class("bs_1044", LuaSkillBase)
local base = LuaSkillBase
bs_1044.config = {audioId = 106, buffId_145 = 145, normalSkill = 101602, comAttackSkill = 11, buffId_254 = 254, effectId2 = 10190}
bs_1044.ctor = function(self)
  -- function num : 0_0
end

bs_1044.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_1044_3", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, (self.config).comAttackSkill)
end

bs_1044.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if sender == self.caster and not isMiss and skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_145, 1, (self.arglist)[1])
    LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId)
    if (self.arglist)[4] > 0 and self:IsReadyToTake() and (self.arglist)[3] <= target:GetBuffTier((self.config).buffId_145) then
      local effect = LuaSkillCtrl:CallEffect(target, (self.config).effectId2, self)
      local collisionEnter = BindCallback(self, self.OnCollisionEnter)
      local collisionExit = BindCallback(self, self.OnCollisionExit)
      LuaSkillCtrl:CallAddCircleColliderForEffect(effect, 100, eColliderInfluenceType.Enemy, nil, collisionEnter, collisionExit)
      LuaSkillCtrl:StartTimer(nil, (self.arglist)[5], BindCallback(self, function(table, effect)
    -- function num : 0_2_0
    if effect ~= nil then
      effect:Die()
      effect = nil
    end
  end
, effect))
      self:OnSkillTake()
    end
  end
end

bs_1044.OnCollisionEnter = function(self, collider, index, entity)
  -- function num : 0_3 , upvalues : _ENV
  if entity ~= nil and entity.hp > 0 and entity.belongNum ~= (self.caster).belongNum and not entity.unableSelect and entity.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:CallBuff(self, entity, (self.config).buffId_254, 1)
  end
end

bs_1044.OnCollisionExit = function(self, collider, entity)
  -- function num : 0_4 , upvalues : _ENV
  if entity ~= nil and entity.hp > 0 and entity:GetBuffTier((self.config).buffId_254) >= 1 and entity.belongNum ~= (self.caster).belongNum and not entity.unableSelect and entity.belongNum ~= eBattleRoleBelong.neutral then
    LuaSkillCtrl:DispelBuff(entity, (self.config).buffId_254, 1)
  end
end

bs_1044.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1044

