-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40028 = class("bs_40028", LuaSkillBase)
local base = LuaSkillBase
bs_40028.config = {effectId = 10217, buffId_1036 = 1036, audioId1 = 82, audioId2 = 83, 
healConfig = {baseheal_formula = 10101}
, start_time = 13, startAnimId = 1008, start_time2 = 15, startAnimId2 = 1007, skill_time = 31, loopAnimId1 = 1009, quitAnimId = 100}
bs_40028.ctor = function(self)
  -- function num : 0_0
end

bs_40028.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_40028_3", 1, self.BeforeEndBattle)
end

bs_40028.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local time = 16 + (self.arglist)[1] + (self.config).skill_time
  self:CallCasterWait(time)
  local callback = BindCallback(self, self.Oncallback)
  LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  LuaSkillCtrl:StartShowSkillDurationTime(self, (self.arglist)[1] + (self.config).start_time + (self.config).start_time2)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).startAnimId, 1, (self.config).start_time, callback)
end

bs_40028.Oncallback = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self.loopaudio = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
  self.loop = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self, nil, nil, nil, true)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).startAnimId2)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_1036, 1, (self.arglist)[1] + 2)
  local is_loop = (self.arglist)[1] // (self.arglist)[3] - 1
  local callback2 = BindCallback(self, self.Oncallback2)
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[3], callback2, self, is_loop)
  LuaSkillCtrl:StartTimer(nil, (self.arglist)[1] - 1, function()
    -- function num : 0_3_0 , upvalues : self, _ENV
    if self.caster ~= nil and (self.caster):GetBuffTier((self.config).buffId_1036) > 0 then
      LuaSkillCtrl:StartTimer(nil, (self.config).start_time2, function()
      -- function num : 0_3_0_0 , upvalues : self
      (self.loop):Die()
    end
)
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_1036, 1)
      LuaSkillCtrl:CallRoleAction(self.caster, (self.config).loopAnimId1)
      LuaSkillCtrl:StartTimer(nil, (self.config).skill_time, function()
      -- function num : 0_3_0_1 , upvalues : _ENV, self
      LuaSkillCtrl:CallRoleAction(self.caster, (self.config).quitAnimId)
      LuaSkillCtrl:StopAudioByBack(self.loopaudio)
    end
)
    end
  end
)
end

bs_40028.Oncallback2 = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
  LuaSkillCtrl:HealResult(skillResult, (self.config).healConfig)
  skillResult:EndResult()
end

bs_40028.OnBreakSkill = function(self, role)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.OnBreakSkill)(self, role)
  LuaSkillCtrl:StopShowSkillDurationTime(self)
  if role == self.caster then
    LuaSkillCtrl:DispelBuff(role, (self.config).buffId_1036, 1)
    LuaSkillCtrl:CallRoleAction(self.caster, (self.config).quitAnimId)
    self:CancleCasterWait()
    if self.loop ~= nil then
      (self.loop):Die()
    end
  end
end

bs_40028.BeforeEndBattle = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.loopaudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopaudio)
    self.loopaudio = nil
  end
end

bs_40028.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  if self.loopaudio ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.loopaudio)
  end
  LuaSkillCtrl:StopShowSkillDurationTime(self)
end

bs_40028.LuaDispose = function(self)
  -- function num : 0_8 , upvalues : base
  (base.LuaDispose)(self)
  self.loopaudio = nil
  self.loop = nil
end

return bs_40028

