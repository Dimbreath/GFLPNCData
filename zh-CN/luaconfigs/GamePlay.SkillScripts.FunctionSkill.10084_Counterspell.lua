-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10084 = class("bs_10084", LuaSkillBase)
local base = LuaSkillBase
bs_10084.config = {healFormula = 10048, audioId2 = 71, buffId_253 = 253}
bs_10084.ctor = function(self)
  -- function num : 0_0
end

bs_10084.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddBeforeAddBuffTrigger("bs_10084_beforeBuff", 1, self.OnBeforeAddBuff, nil, self.caster, nil, nil, nil, eBuffType.Debeneficial)
  self:AddSelfTrigger(eSkillTriggerType.BuffDie, "bs_10084_buffDie", 1, self.OnBuffDie)
  local buff_time = ((self.caster).recordTable).basebufftime
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_253, 1, buff_time, true)
end

bs_10084.OnBeforeAddBuff = function(self, target, context)
  -- function num : 0_2 , upvalues : _ENV
  if (context.buff).buffType == 2 and target == self.caster and self:IsReadyToTake() and target:GetBuffTier((self.config).buffId_253) == 0 then
    if ((self.caster).recordTable).CounterSpellCount ~= nil and ((self.caster).recordTable).CounterSpellCount > 0 then
      local counterSpellBuffId = (target.recordTable).CounterSpellBuffId
      if counterSpellBuffId ~= nil then
        local buffTier = (self.caster):GetBuffTier(counterSpellBuffId)
        context.active = false
        -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'

        ;
        ((self.caster).recordTable).CounterSpellCount = ((self.caster).recordTable).CounterSpellCount - 1
        if ((self.caster).recordTable).CounterSpellCount <= 0 then
          LuaSkillCtrl:DispelBuff(self.caster, counterSpellBuffId, buffTier)
          -- DECOMPILER ERROR at PC56: Confused about usage of register: R5 in 'UnsetPending'

          ;
          ((self.caster).recordTable).CounterSpellCount = nil
        end
      end
    end
    do
      self:OnSkillTake()
    end
  end
end

bs_10084.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
  if (removeType == eBuffRemoveType.Timeout or removeType == eBuffRemoveType.Conflict) and buff.dataId == (self.config).buffId_253 then
    local healValue = LuaSkillCtrl:CallFormulaNumber((self.config).healFormula, target, target)
    ;
    (LuaSkillCtrl.battleCtrl):SetRoleHeal(healValue, self.cskill, buff.maker, target, false, nil, false, false)
  end
end

bs_10084.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10084

