-- params : ...
-- function num : 0 , upvalues : _ENV
local gs_10 = class("gs_10", LuaGridBase)
gs_10.config = {effectId = 10374, leafEffectId = 10375, eatEffectId = 10376, buffId = 1049, buffTier = 300, caoTime = 60}
gs_10.ctor = function(self)
  -- function num : 0_0
end

gs_10.OnGridBattleStart = function(self, role)
  -- function num : 0_1 , upvalues : _ENV
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, (self.config).caoTime, arriveCallBack, nil, -1, 0)
  self.flag = false
  self.Char = false
  self.currentRole = role
end

gs_10.OnGridEnterRole = function(self, role)
  -- function num : 0_2 , upvalues : _ENV
  self.currentRole = role
  self.Char = true
  do
    if not self.flag then
      local target = LuaSkillCtrl:GetTargetWithGrid(self.x, self.y)
      LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
      self.effect = LuaSkillCtrl:CallEffect(target, (self.config).leafEffectId, self)
      self.flag = true
    end
    if self.flag then
      local skills = role:GetBattleSkillList()
      if skills ~= nil then
        local skillCount = skills.Count
        if skillCount > 0 then
          for j = 0, skillCount - 1 do
            local curTotalCd = (skills[j]).totalCDTime
            if not (skills[j]).isCommonAttack then
              LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
              self.flag = false
              LuaSkillCtrl:CallEffect(role, (self.config).eatEffectId, self)
              if self.effect ~= nil then
                (self.effect):Die()
                self.effect = nil
              end
            end
          end
          LuaSkillCtrl:CallDoodad(nil, role)
        end
      end
    end
  end
end

gs_10.OnArriveAction = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local role = self.currentRole
  do
    if not self.flag then
      local target = LuaSkillCtrl:GetTargetWithGrid(self.x, self.y)
      LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
      self.effect = LuaSkillCtrl:CallEffect(target, (self.config).leafEffectId, self)
      self.flag = true
    end
    if self.Char and self.flag and self.currentRole ~= nil then
      local skills = role:GetBattleSkillList()
      if skills ~= nil then
        local skillCount = skills.Count
        if skillCount > 0 then
          for j = 0, skillCount - 1 do
            local curTotalCd = (skills[j]).totalCDTime
            if not (skills[j]).isCommonAttack then
              LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
              self.flag = false
              LuaSkillCtrl:CallEffect(role, (self.config).eatEffectId, self)
              if self.effect ~= nil then
                (self.effect):Die()
                self.effect = nil
              end
            end
          end
          LuaSkillCtrl:CallDoodad(nil, role)
        end
      end
    end
  end
end

gs_10.OnGridExitRole = function(self, role)
  -- function num : 0_4
  self.Char = false
  self.currentRole = nil
end

gs_10.OnGridRoleDead = function(self, role)
  -- function num : 0_5
end

return gs_10

