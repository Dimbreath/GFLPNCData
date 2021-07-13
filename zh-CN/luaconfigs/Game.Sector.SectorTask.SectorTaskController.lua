-- params : ...
-- function num : 0 , upvalues : _ENV
local SectorTaskController = class("SectorTaskController", ControllerBase)
local TaskEnum = require("Game.Task.TaskEnum")
local SectorEnum = require("Game.Sector.SectorEnum")
local cs_MessageCommon = CS.MessageCommon
SectorTaskController.OnInit = function(self)
  -- function num : 0_0
end

SectorTaskController.GetSectorTaskDatas = function(self, sectorId)
  -- function num : 0_1 , upvalues : _ENV, TaskEnum
  local sectorCfg = (ConfigData.sector)[sectorId]
  local taskDatas = ((PlayerDataCenter.allTaskData).sectorTaskDatas)[sectorCfg.achievement]
  local taskDataKist = {}
  for _,taskData in pairs(taskDatas) do
    if taskData:CheckComplete() then
      taskData.state = (TaskEnum.eTaskState).Completed
    else
      if (PlayerDataCenter.sectorAchievementDatas):GetIsComplete(sectorId, taskData.id) then
        taskData.state = (TaskEnum.eTaskState).Picked
      else
        taskData.state = (TaskEnum.eTaskState).InProgress
      end
    end
    ;
    (table.insert)(taskDataKist, taskData)
  end
  local completedTasks = (PlayerDataCenter.sectorAchievementDatas):GetCompletedTask(sectorId)
  if completedTasks ~= nil then
    for taskId,_ in pairs(completedTasks) do
      local stcData = (ConfigData.task)[taskId]
      ;
      (table.insert)(taskDataKist, {state = (TaskEnum.eTaskState).Picked, stcData = stcData, id = taskId})
    end
  end
  do
    ;
    (table.sort)(taskDataKist, function(a, b)
    -- function num : 0_1_0 , upvalues : TaskEnum
    if a.id >= b.id then
      do return a.state ~= b.state end
      if a.state == (TaskEnum.eTaskState).Completed then
        return true
      elseif b.state == (TaskEnum.eTaskState).Completed then
        return false
      elseif a.state == (TaskEnum.eTaskState).InProgress then
        return true
      elseif b.state == (TaskEnum.eTaskState).InProgress then
        return false
      end
      -- DECOMPILER ERROR: 6 unprocessed JMP targets
    end
  end
)
    return taskDataKist
  end
end

SectorTaskController.GetSectorAchievementDatas = function(self, sectorId)
  -- function num : 0_2 , upvalues : _ENV, SectorEnum
  local sectorAchivDatas = {}
  local sectorAchieveCfgs = (ConfigData.sectorAchievement)[sectorId]
  if sectorAchieveCfgs == nil then
    return sectorAchivDatas
  end
  for id,cfg in pairs(sectorAchieveCfgs) do
    local state = nil
    if (PlayerDataCenter.sectorAchievementDatas):GetIsPicked(sectorId, id) then
      state = (SectorEnum.eSectorAchivState).Picked
    else
      if (PlayerDataCenter.sectorAchievementDatas):CheckAchivCondition(cfg) then
        state = (SectorEnum.eSectorAchivState).Completed
      else
        state = (SectorEnum.eSectorAchivState).Normal
      end
    end
    ;
    (table.insert)(sectorAchivDatas, {achiveCfg = cfg, state = state})
  end
  return sectorAchivDatas
end

SectorTaskController.GetSectorAchievementScore = function(self, sectorId)
  -- function num : 0_3 , upvalues : _ENV
  local sectorAchieveCfgs = (ConfigData.sectorAchievement)[sectorId]
  local starId = ((sectorAchieveCfgs[1]).conditionIds)[1]
  local starCount = PlayerDataCenter:GetItemCount(starId)
  local starTotalCount = ((sectorAchieveCfgs[#sectorAchieveCfgs]).conditionNums)[1]
  return starId, starCount, starTotalCount
end

SectorTaskController.OnDelete = function(self)
  -- function num : 0_4
end

return SectorTaskController

