-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1064 = class("bs_1064", LuaSkillBase)
local base = LuaSkillBase
bs_1064.config = {action1 = 1008, action2 = 1007, action3 = 1009, effectId1 = 10272, effectId2 = 10271, buffId1 = 167, buffId2 = 166, buffId_CDstop = 70, audioId1 = 76}
bs_1064.ctor = function(self)
  -- function num : 0_0
end

bs_1064.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  if (self.arglist)[3] > 0 then
    self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_1064_3", 1, self.OnAfterHurt)
    self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_1064_1", 1, self.BeforeEndBattle)
  end
end

bs_1064.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  self:CallCasterWait(999)
  self.audioloop = ((self.caster).auSource):PlayAudioById((self.config).audioId1)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).action1, 1, 5, attackTrigger)
end

bs_1064.OnAttackTrigger = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
  LuaSkillCtrl:CallRoleAction(self.caster, 1007)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      LuaSkillCtrl:CallBuff(self, (targetlist[i]).targetRole, (self.config).buffId1, 1, (self.arglist)[4])
    end
  end
  do
    LuaSkillCtrl:StartTimer(self, (self.arglist)[4], function()
    -- function num : 0_3_0 , upvalues : self, _ENV
    self:CancleCasterWait()
    LuaSkillCtrl:CallRoleAction(self.caster, 1009)
    LuaSkillCtrl:DispelBuff(self.caster, 70, 1)
    if self.audioloop ~= nil then
      AudioManager:StopAudioByBack(self.audioloop)
    end
  end
)
  end
end

bs_1064.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, isRealDmg)
  -- function num : 0_4 , upvalues : _ENV
  if isMiss and target.roleType == 1 and target:GetBuffTier((self.config).buffId1) > 0 then
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId2, 1, (self.arglist)[5])
  end
end

bs_1064.OnBreakSkill = function(self, role)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.OnBreakSkill)(self, role)
  if role == self.caster then
    local targetOver = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
    if targetOver.Count > 0 then
      for i = 0, targetOver.Count - 1 do
        LuaSkillCtrl:DispelBuff((targetOver[i]).targetRole, (self.config).buffId1, 1)
      end
    end
    do
      LuaSkillCtrl:CallRoleAction(self.caster, 100)
      self:CancleCasterWait()
    end
  end
end

bs_1064.BeforeEndBattle = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.audioloop ~= nil then
    AudioManager:StopAudioByBack(self.audioloop)
    self.audioloop = nil
  end
end

bs_1064.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  local targetOver = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetOver.Count > 0 then
    for i = 0, targetOver.Count - 1 do
      LuaSkillCtrl:DispelBuff((targetOver[i]).targetRole, (self.config).buffId1, 1)
    end
  end
end

return bs_1064

-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_1064 = class("bs_1064", LuaSkillBase)
local base = LuaSkillBase
bs_1064.config = {
    action1 = 1008,
    action2 = 1007,
    action3 = 1009,
    effectId1 = 10272,
    effectId2 = 10271,
    buffId1 = 167,
    buffId2 = 166,
    buffId_CDstop = 70,
    audioId1 = 76
}
bs_1064.ctor = function(self)
    -- function num : 0_0
end

bs_1064.InitSkill = function(self, isMidwaySkill)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitSkill)(self, isMidwaySkill)
    if (self.arglist)[3] > 0 then
        self:AddTrigger(eSkillTriggerType.AfterHurt, "bs_1064_3", 1,
                        self.OnAfterHurt)
        self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_1064_1", 1,
                        self.BeforeEndBattle)
    end
end

bs_1064.PlaySkill = function(self, data)
    -- function num : 0_2 , upvalues : _ENV
    local attackTrigger = BindCallback(self, self.OnAttackTrigger)
    self:CallCasterWait(999)
    self.audioloop = ((self.caster).auSource):PlayAudioById(
                         (self.config).audioId1)
    LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster,
                                           (self.config).action1, 1, 5,
                                           attackTrigger)
end

bs_1064.OnAttackTrigger = function(self)
    -- function num : 0_3 , upvalues : _ENV
    LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
    LuaSkillCtrl:CallRoleAction(self.caster, 1007)
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
    if targetlist.Count > 0 then
        for i = 0, targetlist.Count - 1 do
            LuaSkillCtrl:CallBuff(self, (targetlist[i]).targetRole,
                                  (self.config).buffId1, 1, (self.arglist)[4])
        end
    end
    do
        LuaSkillCtrl:StartTimer(self, (self.arglist)[4], function()
            -- function num : 0_3_0 , upvalues : self, _ENV
            self:CancleCasterWait()
            LuaSkillCtrl:CallRoleAction(self.caster, 1009)
            LuaSkillCtrl:DispelBuff(self.caster, 70, 1)
            if self.audioloop ~= nil then
                AudioManager:StopAudioByBack(self.audioloop)
            end
        end)
    end
end

bs_1064.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss,
                               isCrit, isRealDmg)
    -- function num : 0_4 , upvalues : _ENV
    if isMiss and target.roleType == 1 and
        target:GetBuffTier((self.config).buffId1) > 0 then
        LuaSkillCtrl:CallBuff(self, target, (self.config).buffId2, 1,
                              (self.arglist)[5])
    end
end

bs_1064.OnBreakSkill = function(self, role)
    -- function num : 0_5 , upvalues : base, _ENV
    (base.OnBreakSkill)(self, role)
    if role == self.caster then
        local targetOver = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
        if targetOver.Count > 0 then
            for i = 0, targetOver.Count - 1 do
                LuaSkillCtrl:DispelBuff((targetOver[i]).targetRole,
                                        (self.config).buffId1, 1)
            end
        end
        do
            LuaSkillCtrl:CallRoleAction(self.caster, 100)
            self:CancleCasterWait()
        end
    end
end

bs_1064.BeforeEndBattle = function(self)
    -- function num : 0_6 , upvalues : _ENV
    if self.audioloop ~= nil then
        AudioManager:StopAudioByBack(self.audioloop)
        self.audioloop = nil
    end
end

bs_1064.OnCasterDie = function(self)
    -- function num : 0_7 , upvalues : base, _ENV
    (base.OnCasterDie)(self)
    local targetOver = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
    if targetOver.Count > 0 then
        for i = 0, targetOver.Count - 1 do
            LuaSkillCtrl:DispelBuff((targetOver[i]).targetRole,
                                    (self.config).buffId1, 1)
        end
    end
end

return bs_1064

