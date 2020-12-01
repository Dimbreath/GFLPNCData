-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40028 = class("bs_40028", LuaSkillBase)
local base = LuaSkillBase
bs_40028.config = {effectId = 10217, buffId = 1036, audioId1 = 82, audioId2 = 83}
bs_40028.ctor = function(self)
  -- function num : 0_0
end

bs_40028.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_40028.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local time = 16 + (self.arglist)[1] + 31
  self:CallCasterWait(time)
  local callback = BindCallback(self, self.Oncallback)
  ;
  ((self.caster).auSource):PlayAudioById((self.config).audioId1)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1008, 1, 13, callback)
end

bs_40028.Oncallback = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self.loopaudio = ((self.caster).auSource):PlayAudioById((self.config).audioId2)
  self.loop = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1007)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1, (self.arglist)[1] + 2)
  local is_loop = (self.arglist)[1] // (self.arglist)[3] - 1
  local callback2 = BindCallback(self, self.Oncallback2)
  LuaSkillCtrl:StartTimer(self, (self.arglist)[3], callback2, self, is_loop)
  LuaSkillCtrl:StartTimer(self, (self.arglist)[1] - 1, function()
    -- function num : 0_3_0 , upvalues : self, _ENV
    if (self.caster):GetBuffTier((self.config).buffId) > 0 then
      (self.loop):Die()
      LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 1)
      LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1009, 1, 31, function()
      -- function num : 0_3_0_0 , upvalues : _ENV, self
      LuaSkillCtrl:CallRoleAction(self.caster, 100)
      AudioManager:StopAudioByBack(self.loopaudio)
    end
)
    end
  end
)
end

bs_40028.Oncallback2 = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local true_heal = (self.caster).maxHp * (self.arglist)[4] // 1000
  LuaSkillCtrl:CallHeal(true_heal, self, self.caster, false)
end

bs_40028.OnBreakSkill = function(self, role)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.OnBreakSkill)(self, role)
  if role == self.caster then
    LuaSkillCtrl:DispelBuff(role, (self.config).buffId, 1)
    LuaSkillCtrl:CallRoleAction(self.caster, 100)
    self:CancleCasterWait()
    if self.loop ~= nil then
      (self.loop):Die()
    end
  end
end

bs_40028.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_40028

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_40028 = class("bs_40028", LuaSkillBase)
local base = LuaSkillBase
bs_40028.config = {
    effectId = 10217,
    buffId = 1036,
    audioId1 = 82,
    audioId2 = 83
}
bs_40028.ctor = function(self)
    -- function num : 0_0
end

bs_40028.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base
    (base.InitSkill)(self, isMidwaySkill)
end

bs_40028.PlaySkill = function(self, data)
    -- function num : 0_2 , upvalues : _ENV
    local time = 16 + (self.arglist)[1] + 31
    self:CallCasterWait(time)
    local callback = BindCallback(self, self.Oncallback);
    ((self.caster).auSource):PlayAudioById((self.config).audioId1)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1008, 1, 13,
                                           callback)
end

bs_40028.Oncallback = function(self)
    -- function num : 0_3 , upvalues : _ENV
    self.loopaudio = ((self.caster).auSource):PlayAudioById(
                         (self.config).audioId2)
    self.loop = LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId,
                                        self)
    LuaSkillCtrl:CallRoleAction(self.caster, 1007)
    LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, 1,
                          (self.arglist)[1] + 2)
    local is_loop = (self.arglist)[1] // (self.arglist)[3] - 1
    local callback2 = BindCallback(self, self.Oncallback2)
    LuaSkillCtrl:StartTimer(self, (self.arglist)[3], callback2, self, is_loop)
    LuaSkillCtrl:StartTimer(self, (self.arglist)[1] - 1, function()
        -- function num : 0_3_0 , upvalues : self, _ENV
        if (self.caster):GetBuffTier((self.config).buffId) > 0 then
            (self.loop):Die()
            LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 1)
            LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, 1009, 1,
                                                   31, function()
                -- function num : 0_3_0_0 , upvalues : _ENV, self
                LuaSkillCtrl:CallRoleAction(self.caster, 100)
                AudioManager:StopAudioByBack(self.loopaudio)
            end)
        end
    end)
end

bs_40028.Oncallback2 = function(self)
    -- function num : 0_4 , upvalues : _ENV
    local true_heal = (self.caster).maxHp * (self.arglist)[4] // 1000
    LuaSkillCtrl:CallHeal(true_heal, self, self.caster, false)
end

bs_40028.OnBreakSkill = function(self, role)
    -- function num : 0_5 , upvalues : base, _ENV
    (base.OnBreakSkill)(self, role)
    if role == self.caster then
        LuaSkillCtrl:DispelBuff(role, (self.config).buffId, 1)
        LuaSkillCtrl:CallRoleAction(self.caster, 100)
        self:CancleCasterWait()
        if self.loop ~= nil then (self.loop):Die() end
    end
end

bs_40028.OnCasterDie = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnCasterDie)(self)
end

return bs_40028

