local gs_103 = class("gs_103", LuaGridBase)
gs_103.config = {healDuration = 75, 
heal_config = {baseheal_formula = 501, heal_number = 0, correct_formula = 9990}
, effectId = 10286, effectGridId = 10827, effectHitId = 10845}
gs_103.ctor = function(self)
  -- function num : 0_0
end

gs_103.OnGridBattleStart = function(self, role)
  -- function num : 0_1 , upvalues : _ENV
  if role == nil then
    self:GridLoseEffect()
    return 
  end
  local arriveCallBack = BindCallback(self, self.OnArriveAction, role)
  LuaSkillCtrl:StartTimer(nil, (self.config).healDuration, arriveCallBack, nil, -1)
end

gs_103.OnArriveAction = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 52, 20, role)
  if targetlist.Count < 1 then
    return 
  end
  local sl = role.skill_intensity * 50 // 100
  if role.career == 5 then
    sl = sl * 130 // 100
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (targetlist[0]).targetRole)
  LuaSkillCtrl:CallEffect((targetlist[0]).targetRole, (self.config).effectId, self)
  LuaSkillCtrl:HealResult(skillResult, (self.config).heal_config, {sl}, true, true)
  LuaSkillCtrl:CallEffect(role, (self.config).effectGridId, self)
  LuaSkillCtrl:CallEffect((targetlist[0]).targetRole, (self.config).effectHitId, self)
  skillResult:EndResult()
end

gs_103.OnGridEnterRole = function(self, role)
  -- function num : 0_3
end

gs_103.OnGridExitRole = function(self, role)
  -- function num : 0_4
end

gs_103.OnGridRoleDead = function(self, role)
  -- function num : 0_5
end

return gs_103

