-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_200602 = class("bs_200602", LuaSkillBase)
local base = LuaSkillBase
bs_200602.config = {effectId1 = 10109, effectId2 = 10110, effectId3 = 10111, effectId4 = 10112, rootEffectId = 10113, startAnimId = 1002, loopAnimId = 1007, audioId1 = 91, audioId2 = 92, effectlowId = 10607, effecthighId = 10606, 
HealConfig = {baseheal_formula = 10087}
, select_id = 6, select_range = 10, skill_time = 15, skill_speed = 1, start_time = 8}
bs_200602.ctor = function(self)
  -- function num : 0_0
end

bs_200602.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_200602_3", 1, self.BeforeEndBattle)
end

bs_200602.CallBack = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.damTimer ~= nil and (self.damTimer):IsOver() then
    self.damTimer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, (self.config).select_id, (self.config).select_range)
  for i = 0, targetlist.Count - 1 do
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (targetlist[i]).targetRole)
    LuaSkillCtrl:HealResult(skillResult, (self.config).HealConfig)
    skillResult:EndResult()
    if ((self.caster).recordTable).passive ~= nil then
      LuaSkillCtrl:CallEffect((targetlist[i]).targetRole, (self.config).effecthighId, self, nil, nil, nil, true)
    else
      LuaSkillCtrl:CallEffect((targetlist[i]).targetRole, (self.config).effectlowId, self, nil, nil, nil, true)
    end
  end
end

bs_200602.PlaySkill = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, self.caster, data)
  local waitTime = (self.config).skill_time + (self.arglist)[3]
  self:CallCasterWait(waitTime)
  self.loopaudio = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimId, (self.config).skill_speed, (self.config).start_time, attackTrigger)
end

bs_200602.CallBack1 = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.damTimer then
    (self.damTimer):Stop()
    self.damTimer = nil
  end
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
  if self.effect1 ~= nil then
    (self.effect1):Die()
    self.effect1 = nil
  end
  if self.effect2 ~= nil then
    (self.effect2):Die()
    self.effect2 = nil
  end
  if self.effect3 ~= nil then
    (self.effect3):Die()
    self.effect3 = nil
  end
  if self.effect4 ~= nil then
    (self.effect4):Die()
    self.effect4 = nil
  end
  LuaSkillCtrl:StopAudioByBack(self.loopaudio)
  LuaSkillCtrl:CallRoleAction(self.caster, 100, 1)
end

bs_200602.OnAttackTrigger = function(self, target, data)
  -- function num : 0_5 , upvalues : _ENV
  self.loopaudio = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
  self.damTimer = LuaSkillCtrl:StartTimer(self, (self.arglist)[2], self.CallBack, self, -1, (self.arglist)[2])
  LuaSkillCtrl:StartTimer(self, (self.arglist)[3], self.CallBack1, self, 0, 0)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).loopAnimId, 1)
  self.effect1 = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self, nil, nil, nil, true)
  self.effect2 = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId2, self, nil, nil, nil, true)
  self.effect3 = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId3, self, nil, nil, nil, true)
  self.effect4 = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId4, self, nil, nil, nil, true)
end

bs_200602.BeforeEndBattle = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.loopaudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopaudio)
    self.loopaudio = nil
  end
end

bs_200602.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  if self.loopaudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopaudio)
    self.loopaudio = nil
  end
  if self.damTimer then
    (self.damTimer):Stop()
    self.damTimer = nil
  end
end

bs_200602.LuaDispose = function(self)
  -- function num : 0_8 , upvalues : base
  (base.LuaDispose)(self)
  self.loopaudio = nil
  self.effect = nil
  self.effect1 = nil
  self.effect2 = nil
  self.effect3 = nil
  self.effect4 = nil
end

return bs_200602

