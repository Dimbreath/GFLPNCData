local gs_104 = class("gs_104", LuaGridBase)
gs_104.config = {buffDuration = 75, 
hurt_config = {hit_formula = 0, def_formula = 0, basehurt_formula = 502, crit_formula = 0, hurt_type = eHurtType.RealDmg}
, effectGridId = 10828, effectId = 10790}
gs_104.ctor = function(self)
  -- function num : 0_0
end

gs_104.OnGridBattleStart = function(self, role)
  -- function num : 0_1 , upvalues : _ENV
  if role == nil then
    self:GridLoseEffect()
    return 
  end
  local arriveCallBack = BindCallback(self, self.OnArriveAction, role)
  LuaSkillCtrl:StartTimer(nil, (self.config).buffDuration, arriveCallBack, self, -1, (self.config).buffDuration)
end

gs_104.OnArriveAction = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  local targetlist = LuaSkillCtrl:CallTargetSelect(self, 5, 20)
  if targetlist.Count < 1 then
    return 
  end
  local sl = role.skill_intensity * 1
  if role.career == 2 then
    sl = sl * 130 // 100
  end
  for i = 1, targetlist.Count - 1 do
    if ((targetlist[i]).targetRole).y == role.y and ((targetlist[i]).targetRole).belongNum ~= 1 and ((targetlist[i]).targetRole).intensity ~= 0 then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, (targetlist[i]).targetRole)
      LuaSkillCtrl:HurtResult(self, skillResult, (self.config).hurt_config, {sl}, true, true)
      skillResult:EndResult()
    end
  end
  local gridTarget = LuaSkillCtrl:GetTargetWithGrid(0, role.y)
  if gridTarget ~= nil then
    LuaSkillCtrl:CallEffect(gridTarget, (self.config).effectId, self)
  end
  LuaSkillCtrl:CallEffect(role, (self.config).effectGridId, self)
end

gs_104.OnGridEnterRole = function(self, role)
  -- function num : 0_3
end

gs_104.OnGridExitRole = function(self, role)
  -- function num : 0_4
end

gs_104.OnGridRoleDead = function(self, role)
  -- function num : 0_5
end

return gs_104

