-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10136 = class("bs_10136", LuaSkillBase)
local base = LuaSkillBase
bs_10136.config = {effectId1 = 10243, effectId2 = 10244, buffAttackId = 1037, buffDefenceId = 1003}
bs_10136.ctor = function(self)
  -- function num : 0_0
end

bs_10136.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10136_1", 1, self.OnAfterBattleStart)
end

bs_10136.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.damTimer = LuaSkillCtrl:StartTimer(nil, 75, self.CallBack, self, 0, 75)
end

bs_10136.CallBack = function(self)
  -- function num : 0_3 , upvalues : _ENV
  LuaSkillCtrl:CallEffect(self.caster, (self.config).effectId1, self)
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 0)
  if targetlist.Count <= 0 then
    return 
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = (targetlist[i]).targetRole
    local healNum = targetRole.maxHp * (self.arglist)[1] // 1000
    local layer1 = targetRole:GetBuffTier((self.config).buffAttackId)
    local layer2 = targetRole:GetBuffTier((self.config).buffDefenceId)
    if layer1 < (self.arglist)[1] and layer2 < (self.arglist)[1] then
      LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffAttackId, (self.arglist)[1])
      LuaSkillCtrl:CallBuff(self, targetRole, (self.config).buffDefenceId, (self.arglist)[1])
      LuaSkillCtrl:CallEffect(targetRole, (self.config).effectId2, self)
      LuaSkillCtrl:CallHeal(healNum, self, targetRole)
    end
  end
end

bs_10136.CallBack1 = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 6, 0)
  if targetlist.Count <= 0 then
    return 
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = (targetlist[i]).targetRole
    LuaSkillCtrl:DispelBuff(targetRole, (self.config).buffAttackId, (self.arglist)[1])
    LuaSkillCtrl:DispelBuff(targetRole, (self.config).buffDefenceId, (self.arglist)[1])
  end
end

bs_10136.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
  if self.damTimer then
    (self.damTimer):Stop()
    self.damTimer = nil
  end
end

return bs_10136

