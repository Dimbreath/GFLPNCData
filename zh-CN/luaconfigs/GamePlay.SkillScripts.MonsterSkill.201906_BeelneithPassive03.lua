-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_201906 = class("bs_201906", LuaSkillBase)
local base = LuaSkillBase
bs_201906.config = {buffIdShield = 1148, startAnimID = 1022, loopAnimID = 1023, endAnimID1 = 1026, endAnimID2 = 1027, effectId_start = 10809, effectId_end1 = 10810, effectId_end2 = 10811, effectId_attack = 10812, buffSC = 186, 
aoe_config = {effect_shape = 2, aoe_select_code = 4, aoe_range = 1}
, 
hurt_config = {basehurt_formula = 10080}
}
bs_201906.ctor = function(self)
  -- function num : 0_0
end

bs_201906.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  LuaSkillCtrl:RegisterRoleHpCostEvent(self, self.caster, {800, 600, 400, 200}, self.OnHpSubCost, false)
  self:AddSelfTrigger(eSkillTriggerType.BuffDie, "bs_201906s_2", 1, self.OnBuffDie)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).buffTime = (self.arglist)[7]
end

bs_201906.OnHpSubCost = function(self, curHp, TargetValue)
  -- function num : 0_2 , upvalues : _ENV
  self:CallCasterWait(999)
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  LuaSkillCtrl:CallRoleAction(self.caster, 100)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffIdShield, 1, (self.arglist)[4], true)
  LuaSkillCtrl:StartShowSkillDurationTime(self, (self.arglist)[4])
  local buffAction = BindCallback(self, self.OnbuffActionTrigger)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimID, 1, 20, buffAction)
  self.mainEffect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_start, self)
end

bs_201906.OnbuffActionTrigger = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).loopAnimID)
end

bs_201906.OnBuffDie = function(self, buff, target, removeType)
  -- function num : 0_4 , upvalues : _ENV
  if target == self.caster and buff.dataId == (self.config).buffIdShield then
    if removeType == eBuffRemoveType.Timeout then
      LuaSkillCtrl:StartTimer(nil, 32, function()
    -- function num : 0_4_0 , upvalues : self
    self:CancleCasterWait()
  end
)
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
    else
      do
        LuaSkillCtrl:StartTimer(nil, 32, function()
    -- function num : 0_4_1 , upvalues : self
    self:CancleCasterWait()
  end
)
        if self.mainEffect ~= nil then
          (self.mainEffect):Die()
          self.mainEffect = nil
        end
        LuaSkillCtrl:StopShowSkillDurationTime(self)
        LuaSkillCtrl:CallRoleAction(self.caster, (self.config).endAnimID1)
        LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_end1, self)
      end
    end
  end
end

bs_201906.OnSkillRemove = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnSkillRemove)(self)
  ;
  (self.caster):ClearHpTrigger()
end

bs_201906.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
  if self.mainEffect ~= nil then
    (self.mainEffect):Die()
    self.mainEffect = nil
  end
end

bs_201906.LuaDispose = function(self)
  -- function num : 0_7 , upvalues : base
  (base.LuaDispose)(self)
  self.mainEffect = nil
end

return bs_201906

