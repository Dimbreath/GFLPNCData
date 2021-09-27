local bs_10271 = class("bs_10271", LuaSkillBase)
local base = LuaSkillBase
bs_10271.config = {buffId = 1186, buffTier = 1, effectId = 10892}
bs_10271.ctor = function(self)
  -- function num : 0_0
end

bs_10271.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10271_1", 1, self.OnAfterBattleStart)
end

bs_10271.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.timer == nil then
    self.timer = LuaSkillCtrl:StartTimer(nil, (self.arglist)[1], self.CallBack, self, -1)
  end
end

bs_10271.CallBack = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.timer ~= nil and (self.timer):IsOver() then
    self.timer = nil
  end
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 59, 10)
  if targetlist.Count < 1 then
    return 
  end
  local targetRole = (targetlist[0]).targetRole
  if targetRole == self.caster and targetlist.Count > 1 and ((targetlist[1]).targetRole).roleType == 1 then
    targetRole = (targetlist[1]).targetRole
  end
  if targetRole.roleType ~= 1 then
    return 
  end
  LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffId, (self.config).buffTier, nil, true)
  LuaSkillCtrl:CallChipSuitInvoke(self.caster, targetRole)
  LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId, self)
  self:PlayChipEffect()
end

bs_10271.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
end

return bs_10271

