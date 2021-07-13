-- params : ...
-- function num : 0 , upvalues : _ENV
local gs_10 = class("gs_10", LuaGridBase)
local base = LuaGridBase
gs_10.config = {effectId = 10374, leafEffectId = 10733, eatEffectId = 10376, buffId = 1049, buffTier = 300, caoTime = 70, lineEffectId = 10728}
gs_10.ctor = function(self)
  -- function num : 0_0
end

gs_10.OnGridBattleStart = function(self, role)
  -- function num : 0_1
end

gs_10.OnGridEnterRole = function(self, role)
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

gs_10.OnArriveAction = function(self, role)
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

gs_10.SkillEventFunc = function(self, targetRole, effect, eventId, target)
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
      end
    end
  end
end

gs_10.OnGridExitRole = function(self, role)
  -- function num : 0_5
end

gs_10.OnGridRoleDead = function(self, role)
  -- function num : 0_6
end

gs_10.LuaDispose = function(self)
  -- function num : 0_7 , upvalues : base
  self.currentRole = nil
  ;
  (base.LuaDispose)(self)
end

return gs_10

