-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_103401 = class("bs_103401", LuaSkillBase)
local base = LuaSkillBase
bs_103401.config = {effectId = 10459, buffId_179 = 179, buffId_258 = 258}
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
  self.times = 0
  self.halo_em = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 100, 0, eColliderInfluenceType.Player, collisionEnter, nil, collisionExit, self.effectHalo, false, false, nil, self.caster)
end

bs_103401.OnCollisionEnter = function(self, collider, index, entity)
  -- function num : 0_3 , upvalues : _ENV
  if entity:GetBuffTier((self.config).buffId_179) < 1 then
    LuaSkillCtrl:CallBuff(self, entity, (self.config).buffId_179, 1, nil, true)
    if (self.arglist)[2] > 0 then
      LuaSkillCtrl:StartTimer(nil, 1, function()
    -- function num : 0_3_0 , upvalues : _ENV, collider, self
    local coll_list = LuaSkillCtrl:GetOnCollisionRole(collider)
    if coll_list.Count > 0 then
      for i = 0, coll_list.Count - 1 do
        local _target = coll_list[i]
        local num = _target:GetBuffTier((self.config).buffId_258)
        if num ~= coll_list.Count then
          local _num = coll_list.Count - num
          LuaSkillCtrl:CallBuff(self, _target, (self.config).buffId_258, _num, nil, true)
          self.times = coll_list.Count
        end
      end
    end
  end
)
    end
  end
end

bs_103401.OnCollisionExit = function(self, collider, entity)
  -- function num : 0_4 , upvalues : _ENV
  if entity:GetBuffTier((self.config).buffId_179) >= 1 then
    LuaSkillCtrl:DispelBuff(entity, (self.config).buffId_179, 0, true)
    if (self.arglist)[2] > 0 then
      LuaSkillCtrl:DispelBuff(entity, (self.config).buffId_258, 0, true)
      self.times = self.times - 1
      local coll_list = LuaSkillCtrl:GetOnCollisionRole(collider)
      if coll_list.Count > 0 then
        for i = 0, coll_list.Count - 1 do
          local _target = coll_list[i]
          LuaSkillCtrl:DispelBuff(_target, (self.config).buffId_258, 1, true)
        end
      end
    end
  end
end

bs_103401.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
  if self.halo_em ~= nil then
    (self.halo_em):EndAndDisposeEmission()
    self.halo_em = nil
  end
  if self.effectHalo ~= nil then
    (self.effectHalo):Die()
    self.effectHalo = nil
  end
end

bs_103401.LuaDispose = function(self)
  -- function num : 0_6 , upvalues : base
  (base.LuaDispose)(self)
  self.effectHalo = nil
  self.halo_em = nil
end

return bs_103401

