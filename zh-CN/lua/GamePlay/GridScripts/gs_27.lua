local gs_27 = class("gs_27", LuaGridBase)
local base = LuaGridBase
gs_27.config = {effectId = 10374, leafEffectId = 10733, eatEffectId = 10376, buffId = 1049, buffTier = 300, caoTime = 45, lineEffectId = 10728, buff280 = 280}
gs_27.ctor = function(self)
  -- function num : 0_0
end

gs_27.OnGridBattleStart = function(self, role)
  -- function num : 0_1
end

gs_27.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  LuaSkillCtrl:CallBuff(self, role, (self.config).buff280, 1, nil, true)
  if self.caoTimer ~= nil then
    (self.caoTimer):Stop()
    self.caoTimer = nil
  end
  self.currentRole = role
  local target = LuaSkillCtrl:GetTargetWithGrid(self.x, self.y)
  LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
  local arriveCallBack = BindCallback(self, self.OnArriveAction, role)
  self.caoTimer = LuaSkillCtrl:StartTimer(nil, (self.config).caoTime, arriveCallBack, nil, -1, (self.config).caoTime)
  self.damage = 100
end

gs_27.OnArriveAction = function(self, role)
  -- function num : 0_3 , upvalues : _ENV
  if self.caoTimer ~= nil and (self.caoTimer):IsOver() then
    self.caoTimer = nil
  end
  if self.currentRole ~= nil and (self.currentRole).hp > 0 then
    local targetRole = self.currentRole
    local target = LuaSkillCtrl:GetTargetWithGrid(self.x, self.y)
    LuaSkillCtrl:CallEffect(target, (self.config).lineEffectId, self, nil, role)
    LuaSkillCtrl:CallEffectWithArgOverride(target, (self.config).leafEffectId, self, targetRole, false, false, self.SkillEventFunc, targetRole)
  end
end

gs_27.SkillEventFunc = function(self, targetRole, effect, eventId, target)
  -- function num : 0_4 , upvalues : _ENV
  if eventId == eBattleEffectEvent.Trigger then
    local skills = targetRole:GetBattleSkillList()
    if skills ~= nil then
      local skillCount = skills.Count
      if skillCount > 0 then
        for j = 0, skillCount - 1 do
          local curTotalCd = (skills[j]).totalCDTime
          if not (skills[j]).isCommonAttack then
            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
          end
        end
        LuaSkillCtrl:CallDoodad(nil, targetRole)
        local hurt = targetRole.maxHp * self.damage // 1000
        LuaSkillCtrl:RemoveLife(hurt, self, targetRole, true, nil, nil, true)
        self.damage = self.damage + 100
      end
    end
  end
end

gs_27.OnGridExitRole = function(self, role)
  -- function num : 0_5
end

gs_27.OnGridRoleDead = function(self, role)
  -- function num : 0_6
end

gs_27.LuaDispose = function(self)
  -- function num : 0_7 , upvalues : base
  self.currentRole = nil
  ;
  (base.LuaDispose)(self)
end

return gs_27

