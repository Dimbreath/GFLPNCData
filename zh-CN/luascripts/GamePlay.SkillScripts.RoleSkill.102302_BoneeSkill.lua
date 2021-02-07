-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102302 = class("bs_102302", LuaSkillBase)
local base = LuaSkillBase
local ShieldSkillBase = require("GamePlay.SkillScripts.BaseSkill.ShieldSkillBase")
bs_102302.config = {shieldKey = "102302_HuDun", effectKey = "102302_EffectDun", effectIdBoom = 10394, effectDun = 10397, effectLineStart = 10470, effectLine = 10396, effectLineEnd = 10471, 
aoe_config = {effect_shape = 1, aoe_select_code = 3, aoe_range = 10}
, 
aoe_config_1 = {effect_shape = 2, aoe_select_code = 4, aoe_range = 1}
, 
hurt_config = {basehurt_formula = 10078}
, initHpKey = "102302_InitHp", action1 = 1002}
bs_102302.ctor = function(self)
  -- function num : 0_0
end

bs_102302.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.SetHurt, "bs_102302_2", 1, self.OnSetHurt)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_102302_1", 1, self.OnAfterBattleStart)
  self.effect = {}
end

bs_102302.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  for i = 0, targetList.Count - 1 do
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'

    (((targetList[i]).targetRole).recordTable)[(self.config).initHpKey] = ((targetList[i]).targetRole).hp
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (((targetList[i]).targetRole).recordTable)[(self.config).effectKey] = 0
  end
end

bs_102302.PlaySkill = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait(15)
  local hpOffSet = 999999
  local hpOffSetTemp, realTarget = nil, nil
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster, (self.config).aoe_config)
  if (skillResult.roleList).Count ~= 0 then
    for i = 0, (skillResult.roleList).Count - 1 do
      local roleRecord = ((skillResult.roleList)[i]).recordTable
      if ((skillResult.roleList)[i]).hp > 0 and roleRecord ~= nil and roleRecord[(self.config).initHpKey] ~= nil then
        hpOffSetTemp = ((skillResult.roleList)[i]).hp - roleRecord[(self.config).initHpKey]
        if hpOffSetTemp < hpOffSet then
          hpOffSet = hpOffSetTemp
          realTarget = (skillResult.roleList)[i]
        end
      end
    end
    if realTarget ~= nil then
      local attackTrigger = BindCallback(self, self.OnAttackTrigger, realTarget)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).action1, 1, 14, attackTrigger)
      LuaSkillCtrl:StartTimer(self, 7, function()
    -- function num : 0_3_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectLineStart, self, nil, nil, nil, true)
  end
)
    end
  end
  do
    skillResult:EndResult()
  end
end

bs_102302.OnAttackTrigger = function(self, target)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(target, (self.config).effectLineEnd, self, self.SkillEventFunc1)
end

bs_102302.SkillEventFunc1 = function(self, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV, ShieldSkillBase
  if eventId == eBattleEffectEvent.Trigger then
    local shieldValue = (self.caster).skill_intensity * (self.arglist)[1] // 1000
    if shieldValue > 0 then
      local targetRole = target.targetRole
      ;
      (ShieldSkillBase.UpdateShieldView)(targetRole, (self.config).shieldKey, shieldValue)
      if (self.effect)[targetRole] ~= nil then
        ((self.effect)[targetRole]):Die()
        -- DECOMPILER ERROR at PC28: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (self.effect)[targetRole] = nil
      end
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self.effect)[targetRole] = LuaSkillCtrl:CallEffect(target, (self.config).effectDun, self)
    end
  end
end

bs_102302.OnSetHurt = function(self, context)
  -- function num : 0_6 , upvalues : ShieldSkillBase, _ENV
  if ((context.target).recordTable)[(self.config).shieldKey] ~= nil and ((context.target).recordTable)[(self.config).shieldKey] > 0 then
    local retHurt = (ShieldSkillBase.ShieldBaseFunc)(context.hurt, context.target, (self.config).shieldKey)
    context.hurt = retHurt
    LuaSkillCtrl:CallFloatText(context.target, 7)
    if ((context.target).recordTable)[(self.config).shieldKey] <= 0 then
      self:Boom(context.target)
    end
  end
end

bs_102302.Boom = function(self, targetRole)
  -- function num : 0_7 , upvalues : _ENV
  if targetRole ~= nil and (self.effect)[targetRole] ~= nil then
    ((self.effect)[targetRole]):Die()
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self.effect)[targetRole] = nil
  end
  if (self.arglist)[2] == 1 then
    LuaSkillCtrl:CallEffect(targetRole, (self.config).effectIdBoom, self, self.SkillEventFunc2)
  end
end

bs_102302.SkillEventFunc2 = function(self, effect, eventId, target)
  -- function num : 0_8 , upvalues : _ENV
  if effect.dataId == (self.config).effectIdBoom and eventId == eBattleEffectEvent.Trigger then
    LuaSkillCtrl:StartTimer(self, 4, function()
    -- function num : 0_8_0 , upvalues : _ENV, self, target
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, target, (self.config).aoe_config_1)
    LuaSkillCtrl:HurtResult(skillResult, (self.config).hurt_config, nil, true)
    skillResult:EndResult()
  end
)
  end
end

bs_102302.OnCasterDie = function(self)
  -- function num : 0_9 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  if self.effect ~= nil then
    for k,v in pairs(self.effect) do
      if v ~= nil then
        v:Die()
      end
    end
    self.effect = nil
  end
end

return bs_102302

