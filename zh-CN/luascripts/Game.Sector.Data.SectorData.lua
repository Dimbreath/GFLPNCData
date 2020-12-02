-- params : ...
-- function num : 0 , upvalues : _ENV
local SectorData = class("SectorData")
SectorData.CreateAll = function(data)
  -- function num : 0_0 , upvalues : SectorData, _ENV
  local sectorDatas = data
  sectorDatas.CheckAchivCondition = SectorData.CheckAchivCondition
  for _,sectorId in ipairs((ConfigData.sector).id_sort_list) do
    if sectorDatas[sectorId] == nil then
      sectorDatas[sectorId] = {}
    end
  end
  ;
  (SectorData.InitSectorAchivRedDot)(sectorDatas)
  return sectorDatas
end

SectorData.UpdateAchivData = function(msg)
  -- function num : 0_1 , upvalues : _ENV, SectorData
  local boxPicked = ((PlayerDataCenter.sectorDatas)[msg.sectorId]).boxPicked
  if boxPicked == nil then
    boxPicked = {}
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((PlayerDataCenter.sectorDatas)[msg.sectorId]).boxPicked = boxPicked
  end
  boxPicked[msg.id] = true
  ;
  (SectorData.UpdateSectorAchivRedDot)(msg.sectorId)
end

SectorData.UpdateCompleteTaskData = function(sectorId, taskId)
  -- function num : 0_2 , upvalues : _ENV, SectorData
  local completed = ((PlayerDataCenter.sectorDatas)[sectorId]).completed
  if completed == nil then
    completed = {}
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((PlayerDataCenter.sectorDatas)[sectorId]).completed = completed
  end
  completed[taskId] = true
  ;
  (SectorData.UpdateSectorAchivRedDot)(sectorId)
end

SectorData.InitSectorAchivRedDot = function(sectorDatas)
  -- function num : 0_3
end

SectorData.UpdateSectorAchivRedDot = function(sectorId)
  -- function num : 0_4
end

SectorData.CheckAchivCondition = function(achivCfg)
  -- function num : 0_5 , upvalues : _ENV
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

return SectorData

