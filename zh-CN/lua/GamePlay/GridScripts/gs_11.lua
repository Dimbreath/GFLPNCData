local gs_11 = class("gs_11", LuaGridBase)
gs_11.config = {effectId = 10374, leafEffectId = 10734, eatEffectId = 10735, buffId = 1049, buffTier = 300, caoTime = 70, lineEffectId = 10728}
gs_11.ctor = function(self)
  -- function num : 0_0
end

gs_11.OnGridBattleStart = function(self, role)
  -- function num : 0_1
end

gs_11.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  if self.caoTimer ~= nil then
    (self.caoTimer):Stop()
    self.caoTimer = nil
  end
  self.currentRole = role
  local target = LuaSkillCtrl:GetTargetWithGrid(self.x, self.y)
  LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
  local arriveCallBack = BindCallback(self, self.OnArriveAction, role)
  self.caoTimer = LuaSkillCtrl:StartTimer(nil, (self.config).caoTime, arriveCallBack, nil, -1, (self.config).caoTime)
end

gs_11.SkillEventFunc1 = function(self, target, effect, eventId)
  -- function num : 0_3
end

gs_11.OnArriveAction = function(self, role)
  -- function num : 0_4 , upvalues : _ENV
  if self.caoTimer ~= nil and (self.caoTimer):IsOver() then
    self.caoTimer = nil
  end
  if self.currentRole ~= nil and (self.currentRole).hp > 0 then
    local targetRole = self.currentRole
    local target = LuaSkillCtrl:GetTargetWithGrid(self.x, self.y)
    LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
    LuaSkillCtrl:CallEffectWithArgOverride(target, (self.config).leafEffectId, self, targetRole, false, false, self.SkillEventFunc, targetRole)
  end
end

gs_11.SkillEventFunc = function(self, targetRole, effect, eventId, target)
  -- function num : 0_5 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skills = targetRole:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if skillCount > 0 then
        for j = 0, skillCount - 1 do
          local curTotalCd = (skills[j]).totalCDTime * 250 // 1000
          if not (skills[j]).isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
            LuaSkillCtrl:CallEffect(targetRole, (self.config).eatEffectId, self)
          end
        end
        LuaSkillCtrl:CallDoodad(nil, targetRole)
      end
    end
  end
end

gs_11.OnGridExitRole = function(self, role)
  -- function num : 0_6
end

gs_11.OnGridRoleDead = function(self, role)
  -- function num : 0_7
end

gs_11.LuaDispose = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self.currentRole = nil
  ;
  (LuaGridBase.LuaDispose)(self)
end

return gs_11

