local bs_204701 = class("bs_204701", LuaSkillBase)
local base = LuaSkillBase
bs_204701.config = {actionId_start = 1022, actionId_loop = 1023, actionId_end = 1024, effectId = 10921, effectIdDie = 10922, buffID_1158 = 1158, audioId2 = 88}
bs_204701.ctor = function(self)
  -- function num : 0_0
end

bs_204701.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base
  (base.InitSkill)(self, isMidwaySkill)
end

bs_204701.PlaySkill = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffID_1158, 1, 360, true)
  self:CallCasterWait(360)
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).actionId_start, 1)
  local arriveCallBack = BindCallback(self, self.CallBack)
  LuaSkillCtrl:StartTimer(nil, 12, arriveCallBack)
end

bs_204701.CallBack = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).actionId_loop, 1)
  local arriveCallBack = BindCallback(self, self.Damage)
  self.timer = LuaSkillCtrl:StartTimer(nil, 15, arriveCallBack, self, -1, 15)
  local target = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  self.effect = LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
  self.loopaudio = LuaSkillCtrl:PlayAuSource(self.caster, (self.config).audioId2)
  local arriveCallBack = BindCallback(self, self.CallBackEnd)
  LuaSkillCtrl:StartTimer(nil, 300, arriveCallBack)
end

bs_204701.Damage = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.timer ~= nil and (self.timer):IsOver() then
    self.timer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 9, 0)
  if targetlist.Count < 1 then
    return 
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = (targetlist[i]).targetRole
    local hurt1 = targetRole.maxHp // 3
    local hurt2 = targetRole.maxHp // 6
    if targetRole.roleDataId == 25006 then
      LuaSkillCtrl:RemoveLife(hurt2, self, targetRole, true, nil, true, true)
    else
      LuaSkillCtrl:RemoveLife(hurt1, self, targetRole, true, nil, true, true)
    end
  end
end

bs_204701.CallBackEnd = function(self)
  -- function num : 0_5 , upvalues : _ENV
  LuaSkillCtrl:CallRoleAction(self.caster, (self.config).actionId_end, 1)
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
  local target = LuaSkillCtrl:GetTargetWithGrid(3, 2)
  self.effect = LuaSkillCtrl:CallEffect(target, (self.config).effectIdDie, self)
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
  self:CancleCasterWait()
  LuaSkillCtrl:StopAudioByBack(self.loopaudio)
end

bs_204701.OnCasterDie = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.OnCasterDie)(self)
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
  LuaSkillCtrl:StopAudioByBack(self.loopaudio)
  self.loopaudio = nil
end

bs_204701.LuaDispose = function(self)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.LuaDispose)(self)
  if self.effect ~= nil then
    (self.effect):Die()
    self.effect = nil
  end
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
  LuaSkillCtrl:StopAudioByBack(self.loopaudio)
  self.loopaudio = nil
end

return bs_204701

