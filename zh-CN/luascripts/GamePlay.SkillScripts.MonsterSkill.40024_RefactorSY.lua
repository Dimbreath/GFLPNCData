-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40024 = class("bs_40024", LuaSkillBase)
local base = LuaSkillBase
bs_40024.config = {effectId = 10109, rootEffectId = 10113, healFormula = 10030, startAnimId = 1002, loopAnimId = 1007, audioId1 = 91, audioId2 = 92}
bs_40024.ctor = function(self)
  -- function num : 0_0
end

bs_40024.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_40024.CallBack = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  for i = 0, targetlist.Count - 1 do
    local healNum = LuaSkillCtrl:CallFormulaNumberWithSkill((self.config).healFormula, self.caster, (targetlist[i]).targetRole, self)
    LuaSkillCtrl:CallHeal(healNum, self, (targetlist[i]).targetRole)
  end
end

bs_40024.PlaySkill = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local attackTrigger = BindCallback(self, self.OnAttackTrigger, self.caster, data)
  local waitTime = 15 + (self.arglist)[3]
  self:CallCasterWait(waitTime)
  ;
  ((self.caster).auSource):PlayAudioById((self.config).audioId1)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimId, 1, 8, attackTrigger)
end

bs_40024.CallBack1 = function(self)
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
  AudioManager:StopAudioByBack(self.loopaudio)
  LuaSkillCtrl:CallRoleAction(self.caster, 100, 1)
end

bs_40024.OnAttackTrigger = function(self, target, data)
  -- function num : 0_5 , upvalues : _ENV
  self.loopaudio = ((self.caster).auSource):PlayAudioById((self.config).audioId2)
  self.damTimer = LuaSkillCtrl:StartTimer(self, (self.arglist)[2], self.CallBack, self, -1, (self.arglist)[2])
  self.damTimer1 = LuaSkillCtrl:StartTimer(self, (self.arglist)[3], self.CallBack1, self, 0, 0)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).loopAnimId, 1)
  self.effect1 = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
  self.effect2 = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId + 1, self)
  self.effect3 = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId + 2, self)
  self.effect4 = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId + 3, self)
end

bs_40024.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
  if self.damTimer then
    (self.damTimer):Stop()
    self.damTimer = nil
  end
end

return bs_40024

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40024 = class("bs_40024", LuaSkillBase)
local base = LuaSkillBase
bs_40024.config = {
    effectId = 10109,
    rootEffectId = 10113,
    healFormula = 10030,
    startAnimId = 1002,
    loopAnimId = 1007,
    audioId1 = 91,
    audioId2 = 92
}
bs_40024.ctor = function(self)
    -- function num : 0_0
end

bs_40024.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_40024.CallBack = function(self)
    -- function num : 0_2 , upvalues : _ENV
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
    for i = 0, targetlist.Count - 1 do
        local healNum = LuaSkillCtrl:CallFormulaNumberWithSkill(
                            (self.config).healFormula, self.caster,
                            (targetlist[i]).targetRole, self)
        LuaSkillCtrl:CallHeal(healNum, self, (targetlist[i]).targetRole)
    end
end

bs_40024.PlaySkill = function(self, data)
    -- function num : 0_3 , upvalues : _ENV
    local attackTrigger = BindCallback(self, self.OnAttackTrigger, self.caster,
                                       data)
    local waitTime = 15 + (self.arglist)[3]
    self:CallCasterWait(waitTime);
    ((self.caster).auSource):PlayAudioById((self.config).audioId1)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster,
                                           (self.config).startAnimId, 1, 8,
                                           attackTrigger)
end

bs_40024.CallBack1 = function(self)
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
    AudioManager:StopAudioByBack(self.loopaudio)
    LuaSkillCtrl:CallRoleAction(self.caster, 100, 1)
end

bs_40024.OnAttackTrigger = function(self, target, data)
    -- function num : 0_5 , upvalues : _ENV
    self.loopaudio = ((self.caster).auSource):PlayAudioById(
                         (self.config).audioId2)
    self.damTimer = LuaSkillCtrl:StartTimer(self, (self.arglist)[2],
                                            self.CallBack, self, -1,
                                            (self.arglist)[2])
    self.damTimer1 = LuaSkillCtrl:StartTimer(self, (self.arglist)[3],
                                             self.CallBack1, self, 0, 0)
    LuaSkillCtrl:CallRoleAction(self.caster, (self.config).loopAnimId, 1)
    self.effect1 = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId,
                                           self)
    self.effect2 = LuaSkillCtrl:CallEffect(self.caster,
                                           (self.config).effectId + 1, self)
    self.effect3 = LuaSkillCtrl:CallEffect(self.caster,
                                           (self.config).effectId + 2, self)
    self.effect4 = LuaSkillCtrl:CallEffect(self.caster,
                                           (self.config).effectId + 3, self)
end

bs_40024.OnCasterDie = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnCasterDie)(self)
    if self.damTimer then
        (self.damTimer):Stop()
        self.damTimer = nil
    end
end

return bs_40024

