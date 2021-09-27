local bs_10282 = class("bs_10282", LuaSkillBase)
local base = LuaSkillBase
bs_10282.config = {effectId = 10905, effectId2 = 10908, buffDefenceId = 1192}
bs_10282.ctor = function(self)
  -- function num : 0_0
end

bs_10282.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10282_1", 1, self.OnAfterBattleStart)
  self.defence = (self.caster).def
end

bs_10282.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local emissionRadius = 100
  if ((self.caster).recordTable)["30021_Flag"] then
    emissionRadius = 10000
    self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self)
  else
    self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
  end
  local collisionEnter = BindCallback(self, self.OnCollisionEnter)
  local collisionExit = BindCallback(self, self.OnCollisionExit)
  LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, emissionRadius, 0, eColliderInfluenceType.Player, collisionEnter, nil, collisionExit, self.effect, false, false, nil, self.caster)
end

bs_10282.OnCollisionEnter = function(self, collider, index, entity)
  -- function num : 0_3 , upvalues : _ENV
  if entity.belongNum ~= (self.caster).belongNum or entity.roleType ~= 1 then
    return 
  end
  local buffTier = (math.max)(1, self.defence * (self.arglist)[1] // 1000)
  if entity ~= self.caster then
    LuaSkillCtrl:CallBuff(self, entity, (self.config).buffDefenceId, buffTier, nil, true)
  end
end

bs_10282.OnCollisionExit = function(self, collider, entity)
  -- function num : 0_4 , upvalues : _ENV
  if entity.belongNum ~= (self.caster).belongNum then
    return 
  end
  LuaSkillCtrl:DispelBuff(entity, (self.config).buffDefenceId, 0, nil, true)
end

bs_10282.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
end

return bs_10282

