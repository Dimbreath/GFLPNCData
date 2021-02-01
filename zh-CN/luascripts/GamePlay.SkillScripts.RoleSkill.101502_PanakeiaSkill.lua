-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_101502 = class("bs_101502", LuaSkillBase)
local base = LuaSkillBase
bs_101502.config = {effectId_green = 10710, effectId_zong = 10656, effectId = 10661, 
HurtConfig = {hit_formula = 0, basehurt_formula = 10103, crit_formula = 0}
, 
HealConfig = {baseheal_formula = 10104}
}
bs_101502.ctor = function(self)
  -- function num : 0_0
end

bs_101502.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_101502.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, data)
  self:CallCasterWait(72)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1002, 1, 6, attackTrigger)
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, nil, nil, nil, true)
end

bs_101502.OnAttackTrigger = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local num = LuaSkillCtrl:CallRange((self.arglist)[1], (self.arglist)[2])
  local time = 40 // num
  LuaSkillCtrl:StartTimer(self, time, function()
    -- function num : 0_3_0 , upvalues : _ENV, self
    local select = nil
    local targets = LuaSkillCtrl:CallTargetSelect(self, 49, 10)
    if targets.Count == 0 then
      LuaSkillCtrl:CallBreakAllSkill(self.caster)
      return 
    end
    select = (targets[0]).targetRole
    if select.belongNum ~= (self.caster).belongNum then
      LuaSkillCtrl:CallEffect(select, (self.config).effectId_zong, self, self.SkillEventFunc)
    else
      LuaSkillCtrl:CallEffect(select, (self.config).effectId_green, self, self.SkillEventFunc)
    end
  end
, self, num, time - 1)
end

bs_101502.SkillEventFunc = function(self, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger and effect.dataId == (self.config).effectId_zong then
    local double = 1
    if (self.arglist)[5] > 0 and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[6] then
      double = 2
    end
    local skillResult = LuaSkillCtrl:CallSkillResult(effect, target)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).HurtConfig, {double})
    skillResult:EndResult()
  end
  do
    if eventId == eBattleEffectEvent.Trigger and effect.dataId == (self.config).effectId_green then
      local double = 1
      if (self.arglist)[5] > 0 and LuaSkillCtrl:CallRange(1, 1000) <= (self.arglist)[6] then
        double = 2
      end
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target)
      LuaSkillCtrl:HealResult(skillResult, (self.config).HealConfig, {double})
      skillResult:EndResult()
    end
  end
end

bs_101502.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_101502

