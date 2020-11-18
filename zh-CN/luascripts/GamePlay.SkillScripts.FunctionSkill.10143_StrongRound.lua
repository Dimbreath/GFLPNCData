-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10143 = class("bs_10143", LuaSkillBase)
local base = LuaSkillBase
bs_10143.config = {buffId = 1039, buffTier = 1, damageBuffId = 1026, effectId1 = 10338, effectId2 = 10339, effectId3 = 10340}
bs_10143.ctor = function(self)
  -- function num : 0_0
end

bs_10143.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_10143_1", 1, self.OnAfterHurt)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10143_2", 1, self.OnAfterBattleStart)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable)["10143_effectFlag"] = true
end

bs_10143.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if (self.caster).hp * 1000 // (self.caster).maxHp <= (self.arglist)[1] and self:IsReadyToTake() then
    if ((self.caster).recordTable)["10143_effectFlag"] then
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
    end
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).damageBuffId, (self.arglist)[3])
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId3, self)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 0)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        if ((self.caster).recordTable)["10143_effectFlag"] and (targetList[i]).targetRole ~= self.caster then
          LuaSkillCtrl:CallEffect((targetList[i]).targetRole, (self.config).effectId2, self)
        end
        LuaSkillCtrl:CallBuff(self, (targetList[i]).targetRole, (self.config).buffId, (self.config).buffTier)
      end
    end
    do
      -- DECOMPILER ERROR at PC87: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.caster).recordTable)["10143_effectFlag"] = false
      self:OnSkillTake()
    end
  end
end

bs_10143.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_3 , upvalues : _ENV
  if target == self.caster and (self.caster).hp * 1000 // (self.caster).maxHp <= (self.arglist)[1] and self:IsReadyToTake() then
    if ((self.caster).recordTable)["10143_effectFlag"] then
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
    end
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).damageBuffId, (self.arglist)[3])
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId3, self)
    local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 0)
    if targetList.Count > 0 then
      for i = 0, targetList.Count - 1 do
        if ((self.caster).recordTable)["10143_effectFlag"] and (targetList[i]).targetRole ~= self.caster then
          LuaSkillCtrl:CallEffect((targetList[i]).targetRole, (self.config).effectId2, self)
        end
        LuaSkillCtrl:CallBuff(self, (targetList[i]).targetRole, (self.config).buffId, (self.config).buffTier)
      end
    end
    do
      -- DECOMPILER ERROR at PC90: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((self.caster).recordTable)["10143_effectFlag"] = false
      self:OnSkillTake()
    end
  end
end

bs_10143.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10143

