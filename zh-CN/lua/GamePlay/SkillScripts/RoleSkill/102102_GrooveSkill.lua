local bs_102102 = class("bs_102102", LuaSkillBase)
local base = LuaSkillBase
bs_102102.config = {effectId1 = 10272, effectId2 = 10271, buffId_167 = 167, buffId_166 = 166, buffId_170 = 170, audioId1 = 76, skill_time = 999, start_time = 5, actionId_start = 1008, actionId_loop = 1007, actionId_end = 1009, action_speed = 1}
bs_102102.ctor = function(self)
  -- function num : 0_0
end

bs_102102.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_102102_3", 1, self.OnAfterHurt, nil, nil, nil, nil, nil, eBattleRoleType.character)
  self:AddTrigger(eSkillTriggerType.BeforeBattleEnd, "bs_102102_1", 1, self.BeforeEndBattle)
end

bs_102102.OnAfterHurt = function(self, sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  -- function num : 0_2 , upvalues : _ENV
  if isMiss and target.roleType == 1 and target:GetBuffTier((self.config).buffId_167) > 0 then
    LuaSkillCtrl:CallBuff(self, target, (self.config).buffId_166, 1, (self.arglist)[5], true)
  end
end

bs_102102.PlaySkill = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local attackTrigger = BindCallback(self, self.OnAttackTrigger)
  self:CallCasterWait((self.config).skill_time)
  self.audioloop = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId1)
  LuaSkillCtrl:CallRoleActionWithTrigger(self, self.caster, (self.config).actionId_start, (self.config).action_speed, (self.config).start_time, attackTrigger)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId_170, 1, (self.config).start_time + (self.arglist)[4], true)
end

bs_102102.OnAttackTrigger = function(self)
  -- function num : 0_4 , upvalues : _ENV
  LuaSkillCtrl:StartShowSkillDurationTime(self, (self.arglist)[4])
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self, nil, nil, nil, true)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).actionId_loop)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetlist.Count > 0 then
    for i = 0, targetlist.Count - 1 do
      LuaSkillCtrl:CallBuff(self, (targetlist[i]).targetRole, (self.config).buffId_167, 1, (self.arglist)[4])
    end
  end
  do
    LuaSkillCtrl:StartTimer(self, (self.arglist)[4], function()
    -- function num : 0_4_0 , upvalues : self, _ENV
    self:CancleCasterWait()
    LuaSkillCtrl:CallRoleAction(self.caster, (self.config).actionId_end)
    LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_170, 0, true)
    if self.audioloop ~= nil then
      LuaSkillCtrl:StopAudioByBack(self.audioloop)
    end
  end
)
  end
end

bs_102102.OnBreakSkill = function(self, role)
  -- function num : 0_5 , upvalues : _ENV, base
  if role == self.caster then
    LuaSkillCtrl:StopShowSkillDurationTime(self)
    local targetOver = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
    if targetOver.Count > 0 then
      for i = 0, targetOver.Count - 1 do
        LuaSkillCtrl:DispelBuff((targetOver[i]).targetRole, (self.config).buffId_167, 1, true)
      end
    end
    do
      do
        LuaSkillCtrl:CallRoleAction(self.caster, 100)
        LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId_170, 0, true)
        self:CancleCasterWait()
        ;
        (base.OnBreakSkill)(self, role)
      end
    end
  end
end

bs_102102.BeforeEndBattle = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.audioloop ~= nil then
    LuaSkillCtrl:StopAudioByBack(self.audioloop)
    self.audioloop = nil
  end
end

bs_102102.OnCasterDie = function(self)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  local targetOver = LuaSkillCtrl:CallTargetSelect(self, 6, 10)
  if targetOver.Count > 0 then
    for i = 0, targetOver.Count - 1 do
      LuaSkillCtrl:DispelBuff((targetOver[i]).targetRole, (self.config).buffId_167, 1, true)
    end
  end
  do
    if self.audioloop ~= nil then
      LuaSkillCtrl:StopAudioByBack(self.audioloop)
      self.audioloop = nil
    end
  end
end

bs_102102.LuaDispose = function(self)
  -- function num : 0_8 , upvalues : base
  (base.LuaDispose)(self)
  self.audioloop = nil
end

return bs_102102

