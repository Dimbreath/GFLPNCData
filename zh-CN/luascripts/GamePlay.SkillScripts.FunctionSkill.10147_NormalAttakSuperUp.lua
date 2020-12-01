-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10147 = class("bs_10147", LuaSkillBase)
local base = LuaSkillBase
bs_10147.config = {buffId = 1028, buffTier = 1, effectId1 = 10252, effectId2 = 10253, effectId = 10336}
bs_10147.ctor = function(self)
  -- function num : 0_0
end

bs_10147.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10147_2", 2, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10147_3", 3, self.OnAfterPlaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10147_4", 4, self.OnSetHurt)
  self:AddTrigger(eSkillTriggerType.BeforePlaySkill, "bs_10147_1", 1, self.OnBeforePlaySkill)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10147_attackflag"] = false
end

bs_10147.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local tier = (self.caster):GetBuffTier((self.config).buffId)
  if tier == 0 then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier)
    self.effect1 = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
  end
end

bs_10147.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_3 , upvalues : _ENV
  local tier = (self.caster):GetBuffTier((self.config).buffId)
  if tier == 0 and skill.maker == self.caster and not skill.isCommonAttack then
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.config).buffTier)
    self.effect1 = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
  end
end

bs_10147.OnSetHurt = function(self, context)
  -- function num : 0_4 , upvalues : _ENV
  local tier = (self.caster):GetBuffTier((self.config).buffId)
  if context.sender == self.caster and (context.skill).isCommonAttack and tier > 0 then
    context.hurt = context.hurt + context.hurt * (self.arglist)[1] // 1000
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
    self.effect2 = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self)
    if self.effect1 ~= nil then
      (self.effect1):Die()
      self.effect1 = nil
    end
  end
end

bs_10147.OnBeforePlaySkill = function(self, role, context)
  -- function num : 0_5
  local tier = (self.caster):GetBuffTier((self.config).buffId)
  if role == self.caster and (context.skill).isCommonAttack and tier > 0 then
    local passdata = {effectId = (self.config).effectId}
    context.passdata = passdata
  end
end

bs_10147.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10147

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10147 = class("bs_10147", LuaSkillBase)
local base = LuaSkillBase
bs_10147.config = {
    buffId = 1028,
    buffTier = 1,
    effectId1 = 10252,
    effectId2 = 10253,
    effectId = 10336
}
bs_10147.ctor = function(self)
    -- function num : 0_0
end

bs_10147.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10147_2", 2,
                    self.OnAfterBattleStart)
    self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_10147_3", 3,
                    self.OnAfterPlaySkill)
    self:AddTrigger(eSkillTriggerType.SetHurt, "bs_10147_4", 4, self.OnSetHurt)
    self:AddTrigger(eSkillTriggerType.BeforePlaySkill, "bs_10147_1", 1,
                    self.OnBeforePlaySkill) -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.caster).recordTable)["10147_attackflag"] = false
end

bs_10147.OnAfterBattleStart = function(self)
    -- function num : 0_2 , upvalues : _ENV
    local tier = (self.caster):GetBuffTier((self.config).buffId)
    if tier == 0 then
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId,
                              (self.config).buffTier)
        self.effect1 = LuaSkillCtrl:CallEffect(self.caster,
                                               (self.config).effectId1, self)
    end
end

bs_10147.OnAfterPlaySkill = function(self, skill, role)
    -- function num : 0_3 , upvalues : _ENV
    local tier = (self.caster):GetBuffTier((self.config).buffId)
    if tier == 0 and skill.maker == self.caster and not skill.isCommonAttack then
        LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId,
                              (self.config).buffTier)
        self.effect1 = LuaSkillCtrl:CallEffect(self.caster,
                                               (self.config).effectId1, self)
    end
end

bs_10147.OnSetHurt = function(self, context)
    -- function num : 0_4 , upvalues : _ENV
    local tier = (self.caster):GetBuffTier((self.config).buffId)
    if context.sender == self.caster and (context.skill).isCommonAttack and tier >
        0 then
        context.hurt = context.hurt + context.hurt * (self.arglist)[1] // 1000
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
        self.effect2 = LuaSkillCtrl:CallEffect(self.caster,
                                               (self.config).effectId2, self)
        if self.effect1 ~= nil then
            (self.effect1):Die()
            self.effect1 = nil
        end
    end
end

bs_10147.OnBeforePlaySkill = function(self, role, context)
    -- function num : 0_5
    local tier = (self.caster):GetBuffTier((self.config).buffId)
    if role == self.caster and (context.skill).isCommonAttack and tier > 0 then
        local passdata = {effectId = (self.config).effectId}
        context.passdata = passdata
    end
end

bs_10147.OnCasterDie = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_10147

