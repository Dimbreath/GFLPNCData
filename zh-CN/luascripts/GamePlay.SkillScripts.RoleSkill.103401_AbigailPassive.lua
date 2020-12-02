-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103401 = class("bs_103401", LuaSkillBase)
local base = LuaSkillBase
bs_103401.config = {effectId = 10459, buffId = 179}
bs_103401.ctor = function(self)
  -- function num : 0_0
end

bs_103401.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_103401_1", 1, self.OnAfterBattleStart)
  self.effectHalo = nil
end

bs_103401.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.effectHalo == nil then
    self.effectHalo = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
  end
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 100, 0, eColliderInfluenceType.Player, collisionEnter, nil, collisionExit, self.effectHalo, false, false, nil, self.caster)
end

bs_103401.OnCollisionEnter = function(self, index, entity)
  -- function num : 0_3 , upvalues : _ENV
  if entity:GetBuffTier((self.config).buffId) < 1 then
    LuaSkillCtrl:CallBuff(self, entity, (self.config).buffId, 1)
  end
end

bs_103401.OnCollisionExit = function(self, entity)
  -- function num : 0_4 , upvalues : _ENV
  if entity:GetBuffTier((self.config).buffId) >= 1 then
    LuaSkillCtrl:DispelBuff(entity, (self.config).buffId, 0)
  end
end

bs_103401.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_103401

