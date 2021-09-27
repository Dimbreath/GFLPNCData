local gs_108 = class("gs_108", LuaGridBase)
gs_108.config = {damageDuration = 75, 
hurt_config = {hit_formula = 0, basehurt_formula = 502, crit_formula = 0}
, effectId = 10335, effectGridId = 10823, effectHitId = 10844, effectAtkId = 10254}
gs_108.ctor = function(self)
  -- function num : 0_0
end

gs_108.OnGridBattleStart = function(self, role)
  -- function num : 0_1 , upvalues : _ENV
  if role == nil then
    self:GridLoseEffect()
    return 
  end
  local arriveCallBack = BindCallback(self, self.OnArriveAction, role)
  LuaSkillCtrl:StartTimer(nil, (self.config).damageDuration, arriveCallBack, nil, -1)
end

gs_108.OnArriveAction = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 7, 20, role)
  if targetlist.Count < 1 then
    return 
  end
  local sl = role.skill_intensity * 50 // 100
  if role.career == 4 then
    sl = sl * 130 // 100
  end
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (targetlist[0]).targetRole)
  LuaSkillCtrl:CallEffect((targetlist[0]).targetRole, (self.config).effectId, self)
  LuaSkillCtrl:CallEffect(role, (self.config).effectGridId, self)
  LuaSkillCtrl:CallEffect((targetlist[0]).targetRole, (self.config).effectHitId, self)
  LuaSkillCtrl:CallEffect((targetlist[0]).targetRole, (self.config).effectAtkId, self)
  LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {sl}, true, true)
  skillResult:EndResult()
end

gs_108.OnGridEnterRole = function(self, role)
  -- function num : 0_3
end

gs_108.OnGridExitRole = function(self, role)
  -- function num : 0_4
end

gs_108.OnGridRoleDead = function(self, role)
  -- function num : 0_5
end

return gs_108

