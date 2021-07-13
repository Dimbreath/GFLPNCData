-- params : ...
-- function num : 0 , upvalues : _ENV
local bs_10201 = class("bs_10201", LuaSkillBase)
local base = LuaSkillBase
bs_10201.config = {buffId = 1037}
bs_10201.ctor = function(self)
  -- function num : 0_0
end

bs_10201.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.OnSelfAfterMove, "bs_10201_1", 1, self.OnAfterMove)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10201_2", 2, self.OnAfterBattleStart)
end

bs_10201.OnAfterBattleStart = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.blueCount = 0
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.neutral)
  if targetlist.Count <= 0 then
    return 
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i]
    if targetRole.roleDataId == 1002 and LuaSkillCtrl:GetRoleGridsDistance(self.caster, targetRole) == 1 then
      self.blueCount = self.blueCount + 1
    end
  end
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1] * self.blueCount, nil, true)
end

bs_10201.OnAfterMove = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self.blueCount = 0
  local targetlist = LuaSkillCtrl:GetSelectTeamRoles(eBattleRoleBelong.neutral)
  if targetlist.Count <= 0 then
    return 
  end
  for i = 0, targetlist.Count - 1 do
    local targetRole = targetlist[i]
    if targetRole.roleDataId == 1002 and LuaSkillCtrl:GetRoleGridsDistance(self.caster, targetRole) == 1 then
      self.blueCount = self.blueCount + 1
    end
  end
  LuaSkillCtrl:DispelBuff(self.caster, (self.config).buffId, 0)
  LuaSkillCtrl:CallBuff(self, self.caster, (self.config).buffId, (self.arglist)[1] * self.blueCount)
  self:PlayChipEffect()
end

bs_10201.OnCasterDie = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_10201

