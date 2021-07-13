-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_201904 = class("bs_201904", LuaSkillBase)
local base = LuaSkillBase
bs_201904.config = {buffIdShield = 1148, startAnimID = 1022, loopAnimID = 1023, endAnimID1 = 1026, endAnimID2 = 1027, effectId_start = 10809, effectId_end1 = 10810, effectId_end2 = 10811, effectId_attack = 10812, buffSC = 186, 
aoe_config = {effect_shape = 2, aoe_select_code = 4, aoe_range = 1}
, 
hurt_config = {basehurt_formula = 10080}
}
bs_201904.ctor = function(self)
  -- function num : 0_0
end

bs_201904.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.BuffDie, "bs_201904_2", 1, self.OnBuffDie)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).buffTime = (self.arglist)[7]
end

bs_201904.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(999)
  self:AbandonSkillCdAutoReset(true)
  LuaSkillCtrl:CallRoleAction(self.caster, 100)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffIdShield, 1, (self.arglist)[4], true)
  LuaSkillCtrl:StartShowSkillDurationTime(self, (self.arglist)[4])
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).startAnimID)
  self.mainEffect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_start, self)
end

bs_201904.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_3 , upvalues : _ENV
  if target == self.caster and buff.dataId == (self.config).buffIdShield then
    if removeType == eBuffRemoveType.Timeout then
      if self.mainEffect ~= nil then
        (self.mainEffect):Die()
        self.mainEffect = nil
      end
      LuaSkillCtrl:ClearShield(self.caster, eShieldType.Beelneith)
      LuaSkillCtrl:StopShowSkillDurationTime(self)
      LuaSkillCtrl:CallRoleAction(self.caster, (self.config).endAnimID2)
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_end2, self)
      LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_attack, self)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).aoe_config)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config)
      skillResult:BuffResult((self.config).buffSC, (self.arglist)[6])
      skillResult:EndResult()
      LuaSkillCtrl:StartTimer(nil, 32, function()
    -- function num : 0_3_0 , upvalues : self
    self:CancleCasterWait()
    self:CallNextBossSkill()
  end
)
    else
      do
        if self.mainEffect ~= nil then
          (self.mainEffect):Die()
          self.mainEffect = nil
        end
        LuaSkillCtrl:StopShowSkillDurationTime(self)
        LuaSkillCtrl:CallRoleAction(self.caster, (self.config).endAnimID1)
        LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_end1, self)
        LuaSkillCtrl:StartTimer(nil, 32, function()
    -- function num : 0_3_1 , upvalues : self
    self:CancleCasterWait()
    self:CallNextBossSkill()
  end
)
      end
    end
  end
end

bs_201904.OnSkillRemove = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnSkillRemove)(self)
  ;
  (self.caster):ClearHpTrigger()
end

bs_201904.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
  if self.mainEffect ~= nil then
    (self.mainEffect):Die()
    self.mainEffect = nil
  end
end

bs_201904.LuaDispose = function(self)
  -- function num : 0_6 , upvalues : base
  (base.LuaDispose)(self)
  self.mainEffect = nil
end

return bs_201904

