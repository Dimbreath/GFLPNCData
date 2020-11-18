-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10015 = class("bs_10015", LuaSkillBase)
local base = LuaSkillBase
bs_10015.config = {buffId = 68, effectId1 = 10166, effectId2 = 10167, effectId3 = 10168, buffTierFormula = 10036}
bs_10015.ctor = function(self)
  -- function num : 0_0
end

bs_10015.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : _ENV
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10015_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10015_3", 1, self.OnAfterHurt)
  self:AddTrigger(eSkillTriggerType.AfterHeal, "bs_10015_5", 1, self.OnAfterHeal)
end

bs_10015.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local buffTier = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).buffTierFormula, self.caster, self.caster, self)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, buffTier)
  if buffTier > 700 then
    if self.effect == nil then
      self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId3, self, self.SkillEventFunc)
    end
    if self.effect1 ~= nil then
      (self.effect1):Die()
      self.effect1 = nil
    end
    if self.effect2 ~= nil then
      (self.effect2):Die()
      self.effect2 = nil
    end
  else
    if buffTier > 400 then
      if self.effect1 == nil then
        self.effect1 = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self, self.SkillEventFunc)
      end
      if self.effect ~= nil then
        (self.effect):Die()
        self.effect = nil
      end
      if self.effect2 ~= nil then
        (self.effect2):Die()
        self.effect2 = nil
      end
    else
      if self.effect2 == nil then
        self.effect2 = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self, self.SkillEventFunc)
      end
      if self.effect ~= nil then
        (self.effect):Die()
        self.effect = nil
      end
      if self.effect1 ~= nil then
        (self.effect1):Die()
        self.effect1 = nil
      end
    end
  end
end

bs_10015.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_3 , upvalues : _ENV
  if target == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
    local buffTier = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).buffTierFormula, self.caster, self.caster, self)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, buffTier)
    if buffTier > 700 then
      if self.effect == nil then
        self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId3, self, self.SkillEventFunc)
      end
      if self.effect1 ~= nil then
        (self.effect1):Die()
        self.effect1 = nil
      end
      if self.effect2 ~= nil then
        (self.effect2):Die()
        self.effect2 = nil
      end
    else
      if buffTier > 400 then
        if self.effect1 == nil then
          self.effect1 = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self, self.SkillEventFunc)
        end
        if self.effect ~= nil then
          (self.effect):Die()
          self.effect = nil
        end
        if self.effect2 ~= nil then
          (self.effect2):Die()
          self.effect2 = nil
        end
      else
        if self.effect2 == nil then
          self.effect2 = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self, self.SkillEventFunc)
        end
        if self.effect ~= nil then
          (self.effect):Die()
          self.effect = nil
        end
        if self.effect1 ~= nil then
          (self.effect1):Die()
          self.effect1 = nil
        end
      end
    end
  end
end

bs_10015.OnAfterHeal = function(self, sender, target, skill, heal)
  -- function num : 0_4 , upvalues : _ENV
  if target == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
    local buffTier = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).buffTierFormula, self.caster, self.caster, self)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, buffTier)
    if buffTier < 400 then
      if self.effect2 == nil then
        self.effect2 = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self, self.SkillEventFunc)
      end
      if self.effect ~= nil then
        (self.effect):Die()
        self.effect = nil
      end
      if self.effect1 ~= nil then
        (self.effect1):Die()
        self.effect1 = nil
      end
    else
      if buffTier < 700 then
        if self.effect1 == nil then
          self.effect1 = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self, self.SkillEventFunc)
        end
        if self.effect ~= nil then
          (self.effect):Die()
          self.effect = nil
        end
        if self.effect2 ~= nil then
          (self.effect2):Die()
          self.effect2 = nil
        end
      else
        if self.effect == nil then
          self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId3, self, self.SkillEventFunc)
        end
        if self.effect1 ~= nil then
          (self.effect1):Die()
          self.effect1 = nil
        end
        if self.effect2 ~= nil then
          (self.effect2):Die()
          self.effect2 = nil
        end
      end
    end
  end
end

bs_10015.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10015

