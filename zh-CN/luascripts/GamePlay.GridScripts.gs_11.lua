-- params : ...
-- function num : 0 , upvalues : _ENV
local gs_11 = class("gs_11", LuaGridBase)
gs_11.config = {effectId = 10474, leafEffectId = 10475, eatEffectId = 10476, buffId = 1049, buffTier = 300, caoTime = 60}
gs_11.ctor = function(self)
  -- function num : 0_0
end

gs_11.OnGridBattleStart = function(self, role)
  -- function num : 0_1 , upvalues : _ENV
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, (self.config).caoTime, arriveCallBack, nil, -1, 0)
  self.flag = false
  self.Char = false
  self.currentRole = role
  self.eatTime = 0
end

gs_11.OnGridEnterRole = function(self, role)
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
    if self.effect ~= nil then
      (self.effect):Die()
      self.effect = nil
    end
    if self.flag then
      self.eatTime = self.eatTime + 1
      self.flag = false
    end
    if self.flag and self.eatTime > 2 then
      local skills = role:GetBattleSkillList()
      if skills ~= nil then
        local skillCount = skills.Count
        if skillCount > 0 then
          for j = 0, skillCount - 1 do
            local curTotalCd = (skills[j]).totalCDTime
            if not (skills[j]).isCommonAttack then
              LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
              LuaSkillCtrl:CallEffect(role, (self.config).eatEffectId, self)
              if self.effect ~= nil then
                (self.effect):Die()
                self.effect = nil
              end
              self.eatTime = 0
            end
          end
          LuaSkillCtrl:CallDoodad(nil, role)
        end
      end
    end
  end
end

gs_11.OnArriveAction = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local role = self.currentRole
  do
    if not self.flag then
      local target = LuaSkillCtrl:GetTargetWithGrid(self.x, self.y)
      LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
      self.effect = LuaSkillCtrl:CallEffect(target, (self.config).leafEffectId, self)
      self.flag = true
    end
    if self.Char then
      if self.effect ~= nil then
        (self.effect):Die()
        self.effect = nil
      end
      if self.flag then
        self.eatTime = self.eatTime + 1
        self.flag = false
      end
      if self.currentRole ~= nil and self.eatTime > 2 then
        local skills = role:GetBattleSkillList()
        if skills ~= nil then
          local skillCount = skills.Count
          if skillCount > 0 then
            for j = 0, skillCount - 1 do
              local curTotalCd = (skills[j]).totalCDTime
              if not (skills[j]).isCommonAttack then
                LuaSkillCtrl:CallResetCDForSingleSkill(skills[j], curTotalCd)
                LuaSkillCtrl:CallEffect(role, (self.config).eatEffectId, self)
                if self.effect ~= nil then
                  (self.effect):Die()
                  self.effect = nil
                end
                self.eatTime = 0
              end
            end
            LuaSkillCtrl:CallDoodad(nil, role)
          end
        end
      end
    end
  end
end

gs_11.OnGridExitRole = function(self, role)
  -- function num : 0_4
  self.Char = false
  self.currentRole = nil
end

gs_11.OnGridRoleDead = function(self, role)
  -- function num : 0_5
end

return gs_11

-- params : ...
-- function num : 0 , upvalues : _ENV
local gs_11 = class("gs_11", LuaGridBase)
gs_11.config = {
    effectId = 10474,
    leafEffectId = 10475,
    eatEffectId = 10476,
    buffId = 1049,
    buffTier = 300,
    caoTime = 60
}
gs_11.ctor = function(self)
    -- function num : 0_0
end

gs_11.OnGridBattleStart = function(self, role)
    -- function num : 0_1 , upvalues : _ENV
    local arriveCallBack = BindCallback(self, self.OnArriveAction)
    LuaSkillCtrl:StartTimer(nil, (self.config).caoTime, arriveCallBack, nil, -1,
                            0)
    self.flag = false
    self.Char = false
    self.currentRole = role
    self.eatTime = 0
end

gs_11.OnGridEnterRole = function(self, role)
    -- function num : 0_2 , upvalues : _ENV
    self.currentRole = role
    self.Char = true
    do
        if not self.flag then
            local target = LuaSkillCtrl:GetTargetWithGrid(self.x, self.y)
            LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
            self.effect = LuaSkillCtrl:CallEffect(target,
                                                  (self.config).leafEffectId,
                                                  self)
            self.flag = true
        end
        if self.effect ~= nil then
            (self.effect):Die()
            self.effect = nil
        end
        if self.flag then
            self.eatTime = self.eatTime + 1
            self.flag = false
        end
        if self.flag and self.eatTime > 2 then
            local skills = role:GetBattleSkillList()
            if skills ~= nil then
                local skillCount = skills.Count
                if skillCount > 0 then
                    for j = 0, skillCount - 1 do
                        local curTotalCd = (skills[j]).totalCDTime
                        if not (skills[j]).isCommonAttack then
                            LuaSkillCtrl:CallResetCDForSingleSkill(skills[j],
                                                                   curTotalCd)
                            LuaSkillCtrl:CallEffect(role,
                                                    (self.config).eatEffectId,
                                                    self)
                            if self.effect ~= nil then
                                (self.effect):Die()
                                self.effect = nil
                            end
                            self.eatTime = 0
                        end
                    end
                    LuaSkillCtrl:CallDoodad(nil, role)
                end
            end
        end
    end
end

gs_11.OnArriveAction = function(self)
    -- function num : 0_3 , upvalues : _ENV
    local role = self.currentRole
    do
        if not self.flag then
            local target = LuaSkillCtrl:GetTargetWithGrid(self.x, self.y)
            LuaSkillCtrl:CallEffect(target, (self.config).effectId, self)
            self.effect = LuaSkillCtrl:CallEffect(target,
                                                  (self.config).leafEffectId,
                                                  self)
            self.flag = true
        end
        if self.Char then
            if self.effect ~= nil then
                (self.effect):Die()
                self.effect = nil
            end
            if self.flag then
                self.eatTime = self.eatTime + 1
                self.flag = false
            end
            if self.currentRole ~= nil and self.eatTime > 2 then
                local skills = role:GetBattleSkillList()
                if skills ~= nil then
                    local skillCount = skills.Count
                    if skillCount > 0 then
                        for j = 0, skillCount - 1 do
                            local curTotalCd = (skills[j]).totalCDTime
                            if not (skills[j]).isCommonAttack then
                                LuaSkillCtrl:CallResetCDForSingleSkill(
                                    skills[j], curTotalCd)
                                LuaSkillCtrl:CallEffect(role,
                                                        (self.config).eatEffectId,
                                                        self)
                                if self.effect ~= nil then
                                    (self.effect):Die()
                                    self.effect = nil
                                end
                                self.eatTime = 0
                            end
                        end
                        LuaSkillCtrl:CallDoodad(nil, role)
                    end
                end
            end
        end
    end
end

gs_11.OnGridExitRole = function(self, role)
    -- function num : 0_4
    self.Char = false
    self.currentRole = nil
end

gs_11.OnGridRoleDead = function(self, role)
    -- function num : 0_5
end

return gs_11

