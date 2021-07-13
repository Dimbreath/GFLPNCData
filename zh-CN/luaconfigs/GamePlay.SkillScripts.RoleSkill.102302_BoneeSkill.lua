-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_102302 = class("bs_102302", LuaSkillBase)
local base = LuaSkillBase
bs_102302.config = {effectId_Line = 10470, effectId_LineEnd = 10471, 
aoe_config = {effect_shape = 1, aoe_select_code = 3, aoe_range = 10}
, initHpKey = "102302_InitHp", action1 = 1002, buffId_272 = 272, actionId = 1002, action_speed = 1, skill_time = 15, start_time = 14}
bs_102302.ctor = function(self)
  -- function num : 0_0
end

bs_102302.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_102302_1", 1, self.OnAfterBattleStart)
  self.effect = {}
end

bs_102302.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targetList = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  for i = 0, targetList.Count - 1 do
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'

    (((targetList[i]).targetRole).recordTable)[(self.config).initHpKey] = ((targetList[i]).targetRole).hp
  end
end

bs_102302.PlaySkill = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallBreakAllSkill(self.caster)
  self:CallCasterWait((self.config).skill_time)
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
    do
      if realTarget ~= nil then
        local attackTrigger = BindCallback(self, self.OnAttackTrigger, realTarget)
        LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId, (self.config).action_speed, (self.config).start_time, attackTrigger)
        LuaSkillCtrl:StartTimer(self, 7, function()
    -- function num : 0_3_0 , upvalues : _ENV, self
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_Line, self, nil, nil, nil, true)
  end
)
      end
      skillResult:EndResult()
    end
  end
end

bs_102302.OnAttackTrigger = function(self, target)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:CallEffectWithArg(target, (self.config).effectId_LineEnd, self, false, false, self.SkillEventFunc, target)
  if (self.arglist)[5] > 0 and target ~= self.caster then
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId_LineEnd, self)
  end
end

bs_102302.SkillEventFunc = function(self, target_role, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local shieldValue = (self.caster).skill_intensity * (self.arglist)[1] // 1000
    do
      if shieldValue > 0 then
        local targetRole = target_role
        LuaSkillCtrl:AddRoleShield(targetRole, eShieldType.Normal, shieldValue)
        LuaSkillCtrl:CallFloatText(targetRole, 11, shieldValue)
      end
      if (self.arglist)[5] > 0 then
        LuaSkillCtrl:AddRoleShield(self.caster, eShieldType.Normal, shieldValue)
        LuaSkillCtrl:CallFloatText(self.caster, 11, shieldValue)
      end
      if (self.arglist)[5] == 0 then
        LuaSkillCtrl:CallBuff(self, target_role, (self.config).buffId_272, 1, (self.arglist)[2])
      else
        if (self.arglist)[5] > 0 and target_role ~= self.caster then
          LuaSkillCtrl:CallBuff(self, target_role, (self.config).buffId_272, 1, (self.arglist)[2])
          LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_272, 1, (self.arglist)[2])
          return 
        else
          if (self.arglist)[5] > 0 and target_role == self.caster then
            LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_272, 2, (self.arglist)[2])
          end
        end
      end
    end
  end
end

bs_102302.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_102302

