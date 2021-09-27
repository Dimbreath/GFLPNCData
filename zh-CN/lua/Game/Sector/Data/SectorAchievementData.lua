local SectorAchievementData = class("SectorAchievementData")
SectorAchievementData.CreateAchivSectorData = function(sectorData)
  -- function num : 0_0 , upvalues : SectorAchievementData
  local data = (SectorAchievementData.New)()
  data.sectorDataDic = sectorData
  data:InitSectorAchivRedDot()
  return data
end

SectorAchievementData.ctor = function(self)
  -- function num : 0_1
  self.sectorDataDic = nil
end

SectorAchievementData.GetIsPicked = function(self, sectorId, achivId)
  -- function num : 0_2
  if self.sectorDataDic == nil or (self.sectorDataDic)[sectorId] == nil or ((self.sectorDataDic)[sectorId]).boxPicked == nil then
    return false
  end
  return (((self.sectorDataDic)[sectorId]).boxPicked)[achivId]
end

SectorAchievementData.GetIsComplete = function(self, sectorId, taskId)
  -- function num : 0_3
  if self.sectorDataDic == nil or (self.sectorDataDic)[sectorId] == nil or ((self.sectorDataDic)[sectorId]).completed == nil then
    return false
  end
  return (((self.sectorDataDic)[sectorId]).completed)[taskId]
end

SectorAchievementData.GetCompletedTask = function(self, sectorId)
  -- function num : 0_4
  if self.sectorDataDic == nil or (self.sectorDataDic)[sectorId] == nil then
    return 
  end
  return ((self.sectorDataDic)[sectorId]).completed
end

SectorAchievementData.UpdateCompleteTaskData = function(self, sectorId, taskId)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  if (self.sectorDataDic)[sectorId] == nil then
    (self.sectorDataDic)[sectorId] = {}
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  if ((self.sectorDataDic)[sectorId]).completed == nil then
    ((self.sectorDataDic)[sectorId]).completed = {}
  end
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.sectorDataDic)[sectorId]).completed)[taskId] = true
end

SectorAchievementData.UpdateAchivData = function(self, msg)
  -- function num : 0_6
  local sectorId = msg.sectorId
  local achivId = msg.id
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  if (self.sectorDataDic)[sectorId] == nil then
    (self.sectorDataDic)[sectorId] = {}
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

  if ((self.sectorDataDic)[sectorId]).boxPicked == nil then
    ((self.sectorDataDic)[sectorId]).boxPicked = {}
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((self.sectorDataDic)[sectorId]).boxPicked)[achivId] = true
  self:UpdateSectorAchivRedDot(sectorId)
end

SectorAchievementData.InitSectorAchivRedDot = function(self)
  -- function num : 0_7 , upvalues : _ENV
  for _,id in ipairs((ConfigData.sector).id_sort_list) do
    local sectorCfg = (ConfigData.sector)[id]
    local achivCfgs = (ConfigData.sectorAchievement)[sectorCfg.id]
    local sectorId = sectorCfg.id
    local node = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.SectorItemTaskAchivPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, sectorId, RedDotStaticTypeId.SectorTaskBtn, RedDotStaticTypeId.SectorTaskAchiv)
    local count = 0
    if achivCfgs ~= nil then
      for i = 1, #achivCfgs do
        local achivCfg = achivCfgs[i]
        if not self:GetIsPicked(sectorId, achivCfg.id) and self:CheckAchivCondition(achivCfg) then
          count = count + 1
        end
      end
    end
    do
      do
        node:SetRedDotCount(count)
        -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

SectorAchievementData.UpdateSectorAchivRedDot = function(self, sectorId)
  -- function num : 0_8 , upvalues : _ENV
  local OK, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, sectorId, RedDotStaticTypeId.SectorTaskBtn, RedDotStaticTypeId.SectorTaskAchiv)
  if OK then
    local sectorCfg = (ConfigData.sector)[sectorId]
    local achivCfgs = (ConfigData.sectorAchievement)[sectorCfg.id]
    local count = 0
    if achivCfgs ~= nil then
      for i = 1, #achivCfgs do
        local achivCfg = achivCfgs[i]
        if not self:GetIsPicked(sectorId, achivCfg.id) and self:CheckAchivCondition(achivCfg) then
          count = count + 1
        end
      end
    end
    do
      node:SetRedDotCount(count)
    end
  end
end

SectorAchievementData.CheckAchivCondition = function(self, achivCfg)
  -- function num : 0_9 , upvalues : _ENV
  for i = 1, #achivCfg.conditionIds do
    local conditionId = (achivCfg.conditionIds)[i]
    local conditionNum = (achivCfg.conditionNums)[i]
    local itemCount = PlayerDataCenter:GetItemCount(conditionId)
    if itemCount < conditionNum then
      return false
    end
  end
  return true
end

return SectorAchievementData

