-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10084 = class("bs_10084", LuaSkillBase)
local base = LuaSkillBase
bs_10084.config = {healFormula = 10048, audioId2 = 71}
bs_10084.ctor = function(self)
  -- function num : 0_0
end

bs_10084.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeAddBuff, "bs_10084_beforeBuff", 1, self.OnBeforeAddBuff)
  self:AddTrigger(eSkillTriggerType.BuffDie, "bs_10084_buffDie", 1, self.OnBuffDie)
end

bs_10084.OnBeforeAddBuff = function(self, target, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.buff).buffType == 2 and target == self.caster and self:IsReadyToTake() then
    if ((self.caster).recordTable).CounterSpellCount ~= nil and ((self.caster).recordTable).CounterSpellCount > 0 then
      local counterSpellBuffId = (target.recordTable).CounterSpellBuffId
      if counterSpellBuffId ~= nil then
        local buffTier = (self.caster):GetBuffTier(counterSpellBuffId)
        if buffTier >= 2 then
          local buff = context.buff
          if not buff:ContainFeature(eBuffFeatureType.Taunt) and not LuaSkillCtrl:RoleContainsBuffFeature(buff.maker, eBuffFeatureType.Exiled) and not LuaSkillCtrl:RoleContainsBuffFeature(buff.maker, eBuffFeatureType.NotBeSelected) then
            local time = buff.durationTime
            if time == 0 then
              time = 75
            end
            LuaSkillCtrl:CallBuffWithOriginSkill(buff.battleSkill, buff.maker, buff.dataId, buff.tier, time)
          end
        end
        do
          do
            context.active = false
            -- DECOMPILER ERROR at PC73: Confused about usage of register: R5 in 'UnsetPending'

            ;
            ((self.caster).recordTable).CounterSpellCount = ((self.caster).recordTable).CounterSpellCount - 1
            if ((self.caster).recordTable).CounterSpellCount <= 0 then
              LuaSkillCtrl:DispelBuff(self.caster, counterSpellBuffId, buffTier)
              -- DECOMPILER ERROR at PC87: Confused about usage of register: R5 in 'UnsetPending'

              ;
              ((self.caster).recordTable).CounterSpellCount = nil
            end
            self:OnSkillTake()
          end
        end
      end
    end
  end
end

bs_10084.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_3 , upvalues : _ENV
  ((self.caster).auSource):PlayAudioById((self.config).audioId2)
  if target ~= self.caster or (target.recordTable).CounterSpellBuffId == nil or (target.recordTable).buffDieHealRatio == nil or (target.recordTable).CounterSpellCount <= 0 then
    return 
  end
  if removeType == eBuffRemoveType.Timeout and buff.dataId == (target.recordTable).CounterSpellBuffId then
    local healValue = LuaSkillCtrl:CallFormulaNumber((self.config).healFormula, target, target, (target.recordTable).buffDieHealRatio)
    LuaSkillCtrl:CallHeal(healValue, self, target)
  end
end

bs_10084.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10084

