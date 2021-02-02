-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102402 = class("bs_102402", LuaSkillBase)
local base = LuaSkillBase
local ShieldSkillBase = require("GamePlay.SkillScripts.BaseSkill.ShieldSkillBase")
bs_102402.config = {buffId = 236, buffId196 = 196, buffId170 = 170, time = 20, effectId_DDL = 10744, effectId_DDR = 10745, 
Aoe = {effect_shape = 3, aoe_select_code = 5, aoe_range = 1}
, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10081, crit_formula = 0}
}
bs_102402.ctor = function(self)
  -- function num : 0_0
end

bs_102402.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
  self.DD = 0
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.caster).recordTable).skill_arg1 = (self.arglist)[1]
end

bs_102402.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  self:CallCasterWait((self.config).time)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, (self.config).time, attackTrigger)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId170, 1, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId196, 1, nil, true)
end

bs_102402.OnAttackTrigger = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local over = BindCallback(self, self.Onover)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, (self.arglist)[2], true)
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[2], over)
  if (self.arglist)[4] > 0 then
    self.time2 = LuaSkillCtrl:StartTimer(nil, (self.arglist)[5], function()
    -- function num : 0_3_0 , upvalues : self, _ENV
    if (self.caster):GetBuffTier((self.config).buffId) > 0 then
      local last_target = ((self.caster).recordTable).lastAttackRole
      local target = nil
      if last_target ~= nil and last_target.hp > 0 and last_target.belongNum ~= eBattleRoleBelong.neutral then
        target = last_target
      else
        local targetList = LuaSkillCtrl:CallTargetSelect(self, 1001, 0)
        if targetList.Count > 0 then
          target = (targetList[0]).targetRole
        end
      end
      do
        do
          if target ~= nil then
            if self.DD == 0 then
              LuaSkillCtrl:CallEffect(target, (self.config).effectId_DDL, self, self.SkillEventFunc)
              self.DD = 1
            else
              LuaSkillCtrl:CallEffect(target, (self.config).effectId_DDR, self, self.SkillEventFunc)
              self.DD = 0
            end
          end
          if self.time2 ~= nil then
            (self.time2):Stop()
            self.time2 = nil
          end
        end
      end
    end
  end
, self, -1)
  end
end

bs_102402.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target.targetRole, (self.config).Aoe)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig)
    skillResult:EndResult()
  end
end

bs_102402.Onover = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.time2 ~= nil then
    (self.time2):Stop()
    self.time2 = nil
  end
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId196, 1, true)
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId170, 1, true)
  self:CallCasterWait(32)
  LuaSkillCtrl:CallRoleAction(self.caster, 1009)
end

bs_102402.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102402

