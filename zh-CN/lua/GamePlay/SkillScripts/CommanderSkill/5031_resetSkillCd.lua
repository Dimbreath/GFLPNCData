local bs_5031 = class("bs_5031", LuaSkillBase)
local base = LuaSkillBase
bs_5031.config = {effectId_reset = 503101}
bs_5031.InitSkill = function(self, isMidwaySkill)
  -- function num : 0_0 , upvalues : base, _ENV
  (base.InitSkill)(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterPlaySkill, "bs_5031_3", 1, self.OnAfterPlaySkill)
end

bs_5031.CheckManualSkillTakeAvailable = function(self, role)
  -- function num : 0_1 , upvalues : _ENV, base
  if role.roleType ~= eBattleRoleType.character then
    return false
  end
  return (base.CheckManualSkillTakeAvailable)(self, role)
end

bs_5031.PlaySkill = function(self, data, selectTargetCoord, selectRoles)
  -- function num : 0_2 , upvalues : _ENV
  return self:GetSelectTargetAndExecute(selectRoles, BindCallback(self, self.CallSelectExecute))
end

bs_5031.CallSelectExecute = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if role.hp <= 0 then
    return 
  end
  if role.belongNum == eBattleRoleBelong.player then
    self.role = role
    self.curCd = role:GetMainSkillCurCd()
    LuaSkillCtrl:CallEffect(role, (self.config).effectId_reset, self)
    LuaSkillCtrl:CallReFillMainSkillCdForRole(role)
  end
end

bs_5031.OnAfterPlaySkill = function(self, skill, role)
  -- function num : 0_4 , upvalues : _ENV
  if role == self.role and skill.skillTag == eSkillTag.normalSkill and self.curCd ~= nil then
    LuaSkillCtrl:CallResetCDNumForRole(role, self.curCd)
    self.role = nil
    self.curCd = nil
  end
end

bs_5031.OnCasterDie = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnCasterDie)(self)
end

return bs_5031

