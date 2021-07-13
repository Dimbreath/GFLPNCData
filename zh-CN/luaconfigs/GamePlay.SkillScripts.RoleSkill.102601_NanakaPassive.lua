-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102601 = class("bs_102601", LuaSkillBase)
local base = LuaSkillBase
bs_102601.config = {effectId_pass = 10725, effectId_pass_ex = 10726, effectId_pass_old = 10856, buffId_232 = 232, buffId_231 = 231, selectId = 47, 
heal_config = {baseheal_formula = 10088}
}
bs_102601.ctor = function(self)
  -- function num : 0_0
end

bs_102601.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.BuffDie, "bs_102601_11", 1, self.OnBuffDie)
  self:AddAfterAddBuffTrigger("bs_102601_13", 1, self.OnAfterAddBuff, nil, nil, nil, nil, (self.config).buffId_232)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_102601_1", 1, self.OnAfterBattleStart)
end

bs_102601.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.effectHalo == nil then
    self.effectHalo = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_pass, self)
  end
  local heal = BindCallback(self, self.Onheal)
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], heal, self, -1)
  if (self.arglist)[3] > 0 then
    local collisionEnter = BindCallback(self, self.OnCollisionEnter)
    local collisionExit = BindCallback(self, self.OnCollisionExit)
    self.halo = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, self.caster, 100, 0, eColliderInfluenceType.Player, collisionEnter, nil, collisionExit, self.effectHalo, false, false, nil, self.caster)
  end
end

bs_102601.Onheal = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local num = 1 - (self.caster).attackRange
  if (self.caster):GetBuffTier((self.config).buffId_232) > 0 then
    num = 2 - (self.caster).attackRange
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, (self.config).selectId, num)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      local target = (targetlist[i]).targetRole
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config)
      skillResult:EndResult()
    end
  end
end

bs_102601.OnCollisionEnter = function(self, collider, index, entity)
  -- function num : 0_4 , upvalues : _ENV
  if entity:GetBuffTier((self.config).buffId_231) < 1 then
    LuaSkillCtrl:CallBuff(self, entity, (self.config).buffId_231, 1)
  end
end

bs_102601.OnCollisionExit = function(self, collider, entity)
  -- function num : 0_5 , upvalues : _ENV
  if entity:GetBuffTier((self.config).buffId_231) >= 1 then
    LuaSkillCtrl:DispelBuff(entity, (self.config).buffId_231, 0)
  end
end

bs_102601.OnAfterAddBuff = function(self, buff, target)
  -- function num : 0_6 , upvalues : _ENV
  if buff.dataId == (self.config).buffId_232 and target == self.caster then
    if self.effectHalo ~= nil then
      (self.effectHalo):Die()
      self.effectHalo = nil
      self.effectHalo = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_pass_ex, self)
    end
    if (self.arglist)[3] > 0 then
      LuaSkillCtrl:SetCircleColliderAndEffectRadius((self.halo).collider, 175, nil)
    end
  end
end

bs_102601.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_7 , upvalues : _ENV
  if buff.dataId == (self.config).buffId_232 and target == self.caster then
    if self.effectHalo ~= nil then
      (self.effectHalo):Die()
      self.effectHalo = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_pass_old, self)
    end
    if (self.arglist)[3] > 0 then
      LuaSkillCtrl:SetCircleColliderAndEffectRadius((self.halo).collider, 100, nil)
    end
  end
end

bs_102601.OnCasterDie = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnCasterDie)(self)
end

bs_102601.LuaDispose = function(self)
  -- function num : 0_9 , upvalues : base
  (base.LuaDispose)(self)
  self.effectHalo = nil
  self.halo = nil
end

return bs_102601

