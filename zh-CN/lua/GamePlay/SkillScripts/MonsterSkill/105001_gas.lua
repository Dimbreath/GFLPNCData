local bs_105001 = class("bs_105001", LuaSkillBase)
local base = LuaSkillBase
bs_105001.config = {effectId = 10911, rootEffectId = 10113, startAnimId = 1002, buffID_1158 = 1158, 
HurtConfig = {basehurt_formula = 10087, hit_formula = 0, crit_formula = 0}
, select_id = 5, select_range = 10, skill_time = 15, skill_speed = 1, start_time = 8}
bs_105001.ctor = function(self)
  -- function num : 0_0
end

bs_105001.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_105001", 1, self.BeforeEndBattle)
end

bs_105001.CallBack = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.damTimer ~= nil and (self.damTimer):IsOver() then
    self.damTimer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, (self.config).select_id, (self.config).select_range)
  for i = 0, targetlist.Count - 1 do
    if ((targetlist[i]).targetRole).belongNum ~= 0 then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (targetlist[i]).targetRole)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).HurtConfig)
      skillResult:EndResult()
    end
  end
end

bs_105001.PlaySkill = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local waitTime = (self.config).skill_time + (self.arglist)[3]
  self:CallCasterWait(waitTime)
  if self.effect == nil then
    self.effect = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
  end
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).startAnimId, 1)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffID_1158, 1)
  LuaSkillCtrl:StartShowSkillDurationTime(self, (self.arglist)[3])
  if self.damTimer == nil then
    self.damTimer = LuaSkillCtrl:StartTimer(self, (self.arglist)[2], self.CallBack, self, -1, (self.arglist)[2])
  end
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[3], self.CallBack1, self, 0, 0)
end

bs_105001.CallBack1 = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
  if self.damTimer then
    (self.damTimer):Stop()
    self.damTimer = nil
  end
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffID_1158, 0)
end

bs_105001.BeforeEndBattle = function(self)
  -- function num : 0_5
end

bs_105001.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : _ENV, base
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffID_1158, 0)
  LuaSkillCtrl:StopShowSkillDurationTime(self)
  ;
  (base.OnCasterDie)(self)
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
  if self.damTimer then
    (self.damTimer):Stop()
    self.damTimer = nil
  end
end

bs_105001.OnBreakSkill = function(self, role)
  -- function num : 0_7 , upvalues : _ENV
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
  if self.damTimer then
    (self.damTimer):Stop()
    self.damTimer = nil
  end
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffID_1158, 0)
  LuaSkillCtrl:StopShowSkillDurationTime(self)
end

bs_105001.LuaDispose = function(self)
  -- function num : 0_8 , upvalues : base
  (base.LuaDispose)(self)
  self.effect = nil
end

return bs_105001

