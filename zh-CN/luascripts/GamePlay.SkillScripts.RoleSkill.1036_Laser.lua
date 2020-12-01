-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1036 = class("bs_1036", LuaSkillBase)
local base = LuaSkillBase
bs_1036.config = {
hurt_config = {basehurt_formula = 10076}
, audioId1 = 31}
bs_1036.ctor = function(self)
  -- function num : 0_0
end

bs_1036.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_1036_1", 1, self.BeforeEndBattle)
end

bs_1036.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 10)
  if targetList.Count == 0 then
    return 
  end
  ;
  (self.caster):LookAtTarget((targetList[0]).targetRole)
  self:CallCasterWait(25)
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, (targetList[0]).targetRole, data, 1, 1002)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 8, attackTrigger)
end

bs_1036.OnAttackTrigger = function(self, target, data, atkSpeedRatio, atkActionId)
  -- function num : 0_3 , upvalues : _ENV
  self.Over = BindCallback(self, self.Onover)
  self.Over2 = BindCallback(self, self.Onover2)
  self.audio1 = ((self.caster).auSource):PlayAudioById((self.config).audioId1)
  local cusEffect = LuaSkillCtrl:CallEffect(target, 10033, self)
  if (self.arglist)[2] >= 1 then
    local collisionTrigger = BindCallback(self, self.OnCollision)
    local EmissionArrive = BindCallback(self, self.OnEmissionArrive)
    local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 40, 10, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, true, false, EmissionArrive)
    local cusEffect1 = LuaSkillCtrl:CallEffectWithEmission(skillEmission, 10034, self)
    local cusEffect2 = LuaSkillCtrl:CallEffectWithEmission(skillEmission, 10037, self)
  else
    do
      local collisionTrigger = BindCallback(self, self.OnCollision)
      local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self, self.caster, target, 40, 6, eColliderInfluenceType.Enemy, collisionTrigger, nil, nil, cusEffect, true, true, self.Over)
      local cusEffect1 = LuaSkillCtrl:CallEffectWithEmission(skillEmission, 10034, self)
      local cusEffect2 = LuaSkillCtrl:CallEffectWithEmission(skillEmission, 10037, self)
    end
  end
end

bs_1036.OnCollision = function(self, index, entity)
  -- function num : 0_4 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
  LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
  skillResult:EndResult()
end

bs_1036.OnEmissionArrive = function(self, skillEmission)
  -- function num : 0_5 , upvalues : _ENV
  if self.audio1 ~= nil then
    AudioManager:StopAudioByBack(self.audio1)
  end
  self.audio2 = ((self.caster).auSource):PlayAudioById((self.config).audioId1)
  LuaSkillCtrl:CallRestartEmit(self, skillEmission, 4, self.caster, true, true, self.Over2)
end

bs_1036.Onover = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.audio1 ~= nil then
    AudioManager:StopAudioByBack(self.audio1)
  end
end

bs_1036.Onover2 = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self.audio2 ~= nil then
    AudioManager:StopAudioByBack(self.audio2)
  end
end

bs_1036.BeforeEndBattle = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.audio1 ~= nil then
    AudioManager:StopAudioByBack(self.audio1)
    self.audio1 = nil
  end
  if self.audio2 ~= nil then
    AudioManager:StopAudioByBack(self.audio2)
    self.audio2 = nil
  end
end

bs_1036.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_1036

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1036 = class("bs_1036", LuaSkillBase)
local base = LuaSkillBase
bs_1036.config = {hurt_config = {basehurt_formula = 10076}, audioId1 = 31}
bs_1036.ctor = function(self)
    -- function num : 0_0
end

bs_1036.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : _ENV
    self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_1036_1", 1,
                    self.BeforeEndBattle)
end

bs_1036.PlaySkill = function(self, data)
    -- function num : 0_2 , upvalues : _ENV
    LuaSkillCtrl:CallBreakAllSkill(self.caster)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 10)
    if targetList.Count == 0 then return end
    (self.caster):LookAtTarget((targetList[0]).targetRole)
    self:CallCasterWait(25)
    local attackTrigger = BindCallback(self, self.OnAttackTrigger,
                                       (targetList[0]).targetRole, data, 1, 1002)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 8,
                                           attackTrigger)
end

bs_1036.OnAttackTrigger = function(self, target, data, atkSpeedRatio,
                                   atkActionId)
    -- function num : 0_3 , upvalues : _ENV
    self.Over = BindCallback(self, self.Onover)
    self.Over2 = BindCallback(self, self.Onover2)
    self.audio1 = ((self.caster).auSource):PlayAudioById((self.config).audioId1)
    local cusEffect = LuaSkillCtrl:CallEffect(target, 10033, self)
    if (self.arglist)[2] >= 1 then
        local collisionTrigger = BindCallback(self, self.OnCollision)
        local EmissionArrive = BindCallback(self, self.OnEmissionArrive)
        local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(self,
                                                                         self.caster,
                                                                         target,
                                                                         40, 10,
                                                                         eColliderInfluenceType.Enemy,
                                                                         collisionTrigger,
                                                                         nil,
                                                                         nil,
                                                                         cusEffect,
                                                                         true,
                                                                         false,
                                                                         EmissionArrive)
        local cusEffect1 = LuaSkillCtrl:CallEffectWithEmission(skillEmission,
                                                               10034, self)
        local cusEffect2 = LuaSkillCtrl:CallEffectWithEmission(skillEmission,
                                                               10037, self)
    else
        do
            local collisionTrigger = BindCallback(self, self.OnCollision)
            local skillEmission = LuaSkillCtrl:CallCircledEmissionStraightly(
                                      self, self.caster, target, 40, 6,
                                      eColliderInfluenceType.Enemy,
                                      collisionTrigger, nil, nil, cusEffect,
                                      true, true, self.Over)
            local cusEffect1 = LuaSkillCtrl:CallEffectWithEmission(
                                   skillEmission, 10034, self)
            local cusEffect2 = LuaSkillCtrl:CallEffectWithEmission(
                                   skillEmission, 10037, self)
        end
    end
end

bs_1036.OnCollision = function(self, index, entity)
    -- function num : 0_4 , upvalues : _ENV
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, entity)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config)
    skillResult:EndResult()
end

bs_1036.OnEmissionArrive = function(self, skillEmission)
    -- function num : 0_5 , upvalues : _ENV
    if self.audio1 ~= nil then AudioManager:StopAudioByBack(self.audio1) end
    self.audio2 = ((self.caster).auSource):PlayAudioById((self.config).audioId1)
    LuaSkillCtrl:CallRestartEmit(self, skillEmission, 4, self.caster, true,
                                 true, self.Over2)
end

bs_1036.Onover = function(self)
    -- function num : 0_6 , upvalues : _ENV
    if self.audio1 ~= nil then AudioManager:StopAudioByBack(self.audio1) end
end

bs_1036.Onover2 = function(self)
    -- function num : 0_7 , upvalues : _ENV
    if self.audio2 ~= nil then AudioManager:StopAudioByBack(self.audio2) end
end

bs_1036.BeforeEndBattle = function(self)
    -- function num : 0_8 , upvalues : _ENV
    if self.audio1 ~= nil then
        AudioManager:StopAudioByBack(self.audio1)
        self.audio1 = nil
    end
    if self.audio2 ~= nil then
        AudioManager:StopAudioByBack(self.audio2)
        self.audio2 = nil
    end
end

bs_1036.OnCasterDie = function(self)
    -- function num : 0_9 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_1036

