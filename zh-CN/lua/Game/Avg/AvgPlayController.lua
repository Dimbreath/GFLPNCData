local AvgPlayController = class("AvgPlayController", ControllerBase)
local TaskEnum = require("Game.Task.TaskEnum")
local CheckerTypeId, CheckerGlobalConfig = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
AvgPlayController.ctor = function(self)
  -- function num : 0_0
end

AvgPlayController.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.__onRecvNewAvgTask = BindCallback(self, self.OnRecvNewAvgTask)
  MsgCenter:AddListener(eMsgEventId.TaskReceived, self.__onRecvNewAvgTask)
end

AvgPlayController.InitAllAvgPlayed = function(self, avgGroup)
  -- function num : 0_2
  if avgGroup == nil then
    self.avgPlayedDic = {}
  else
    self.avgPlayedDic = avgGroup.data
  end
end

AvgPlayController.RecordAvgPlayed = function(self, avgId)
  -- function num : 0_3 , upvalues : _ENV, CheckerTypeId
  if self.avgPlayedDic == nil then
    error("avgPlayedDic is not initialize")
    return 
  end
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.avgPlayedDic)[avgId] = true
  self:UpdateMainAvgState(avgId)
  local unlockDic = ((ConfigData.sector).avgUnlockDic)[avgId]
  if unlockDic ~= nil then
    for id,checkerTypeId in pairs(unlockDic) do
      if checkerTypeId == CheckerTypeId.CompleteStage then
        (PlayerDataCenter.sectorStage):UpdateSctStageItemState(id)
      else
        if checkerTypeId == CheckerTypeId.CompleteAvg then
          self:UpdateMainAvgState(id)
        end
      end
    end
  end
end

AvgPlayController.TryPlayTaskAvg = function(self, param1, callBack, onlyAvgCallBack)
  -- function num : 0_4 , upvalues : _ENV
  local avgCfg = self:CheckTaskAvgPlayable(param1)
  if avgCfg ~= nil then
    (ControllerManager:GetController(ControllerTypeId.Avg, true)):StartAvg(avgCfg.script_id, avgCfg.id, callBack)
  else
    if not onlyAvgCallBack and callBack ~= nil then
      callBack()
    end
  end
end

AvgPlayController.TryPlayAvg = function(self, avgTriggerType, place, param1, param2, callBack)
  -- function num : 0_5 , upvalues : _ENV
  if ExplorationManager.epCtrl ~= nil then
    -- DECOMPILER ERROR at PC14: Unhandled construct in 'MakeBoolean' P1

    if ((ExplorationManager.epCtrl).autoCtrl):IsAutoModeRunning() and callBack ~= nil then
      callBack()
    end
    return 
  end
  local avgCfg = self:CkeckAvgPlayable(avgTriggerType, place, param1, param2)
  if avgCfg ~= nil then
    (ControllerManager:GetController(ControllerTypeId.Avg, true)):StartAvg(avgCfg.script_id, nil, callBack)
    return true
  else
    if callBack ~= nil then
      callBack()
    end
  end
end

AvgPlayController.CheckTaskAvgPlayable = function(self, param1)
  -- function num : 0_6 , upvalues : _ENV
  local taskIdDic = ((ConfigData.story_avg).avgTaskParamDic)[param1]
  if taskIdDic == nil then
    return 
  end
  for taskId,avgId in pairs(taskIdDic) do
    local avgCfg = self:CkeckAvgPlayable(eAvgTriggerType.AvgTask, taskId, param1)
    if avgCfg ~= nil then
      return avgCfg
    end
  end
end

AvgPlayController.CkeckAvgPlayable = function(self, avgTriggerType, place, param1, param2)
  -- function num : 0_7 , upvalues : _ENV
  local avgCfg = self:TryGetAvgCfg(avgTriggerType, place, param1, param2)
  if avgCfg == nil then
    return 
  end
  if self:IsAvgPlayed(avgCfg.id) then
    return 
  end
  if not self:IsAvgUnlock(avgCfg.id) then
    return 
  end
  do
    if avgCfg.type == eAvgTriggerType.AvgTask then
      local taskData = ((PlayerDataCenter.allTaskData).taskDatas)[avgCfg.set_place]
      if taskData == nil or taskData:CheckComplete() then
        return 
      end
    end
    return avgCfg
  end
end

AvgPlayController.TryGetAvgCfg = function(self, avgTriggerType, place, param1, param2)
  -- function num : 0_8 , upvalues : _ENV
  local triggerCfg = ((ConfigData.story_avg).triggerTypeDic)[avgTriggerType]
  if triggerCfg == nil then
    return 
  end
  local triggerParam1Cfg = triggerCfg[place]
  if triggerParam1Cfg == nil then
    return 
  end
  local triggerParam2Cfg = triggerParam1Cfg[param1 or 0]
  if triggerParam2Cfg == nil then
    return 
  end
  local avgId = triggerParam2Cfg[param2 or 0]
  if avgId == nil then
    return 
  end
  local avgCfg = (ConfigData.story_avg)[avgId]
  if avgCfg == nil then
    error("Cant get avgCfg, avgId = " .. tostring(avgId))
    return 
  end
  return avgCfg
end

AvgPlayController.GetMainAvgPara2Num = function(self, place, param1)
  -- function num : 0_9 , upvalues : _ENV
  local para1Dic = ((ConfigData.story_avg).mainLineAvgPara2NumDic)[place]
  if para1Dic == nil then
    return 0
  end
  local para2Num = para1Dic[param1]
  return para2Num or 0
end

AvgPlayController.IsAvgPlayed = function(self, avgId)
  -- function num : 0_10 , upvalues : _ENV
  local avgCfg = (ConfigData.story_avg)[avgId]
  if avgCfg == nil then
    error("Cant get avgCfg, avgId = " .. tostring(avgId))
    return true
  end
  if self.avgPlayedDic == nil then
    error("avgPlayedDic is not initialize")
    return true
  end
  if (self.avgPlayedDic)[avgId] ~= nil then
    return true
  end
end

AvgPlayController.OnRecvNewAvgTask = function(self, newTaskDataList)
  -- function num : 0_11 , upvalues : _ENV, TaskEnum
  local avgTaskList = nil
  for k,taskData in ipairs(newTaskDataList) do
    if (taskData.stcData).type == (TaskEnum.eTaskType).AvgTask then
      if avgTaskList == nil then
        avgTaskList = {}
      end
      ;
      (table.insert)(avgTaskList, taskData)
    end
  end
  if avgTaskList == nil then
    return 
  end
  do
    for k,taskData in ipairs(avgTaskList) do
      local avgId = (taskData.stcData).story
      local story2guide_condition = (taskData.stcData).story2guide_condition
      local avgCfg = (ConfigData.story_avg)[avgId]
      if avgCfg == nil then
        error("Can\'t find avgCfg, avgId = " .. tostring(avgId))
      else
        if not self:IsAvgPlayed(avgId) and self:IsAvgUnlock(avgCfg.id) then
          self:TryPlayTaskAvg(0, function()
    -- function num : 0_11_0 , upvalues : story2guide_condition, _ENV
    if story2guide_condition > 0 then
      GuideManager:TryTriggerGuide(story2guide_condition)
    end
  end
, true)
        end
      end
    end
  end
end

AvgPlayController.IsAvgUnlock = function(self, avgId)
  -- function num : 0_12 , upvalues : _ENV
  local avgCfg = (ConfigData.story_avg)[avgId]
  if avgCfg == nil then
    error("Can\'t find avgCfg, avgId = " .. tostring(avgId))
    return true
  end
  return (CheckCondition.CheckLua)(avgCfg.pre_condition, avgCfg.pre_para1, avgCfg.pre_para2)
end

AvgPlayController.IsPlayedAllMainAvg = function(self, sectorId, difficulty, checkAvgId, isCheckPreSector)
  -- function num : 0_13 , upvalues : _ENV
  local SectorAvgCompleteCheckFunc = function(avgList, checkId)
    -- function num : 0_13_0 , upvalues : _ENV, self
    for _,avgId in ipairs(avgList) do
      if avgId ~= checkId then
        do
          if not self:IsAvgPlayed(avgId) then
            return avgId
          end
          -- DECOMPILER ERROR at PC13: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC13: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    return 0
  end

  if isCheckPreSector then
    local avgList = {}
    for _,preSectorId in ipairs((ConfigData.sector).id_sort_list) do
      if sectorId >= preSectorId then
        do
          local temp = ((ConfigData.story_avg).mainAvgDic)[preSectorId]
          if temp == nil then
            error(" mainAvgDic sector Miss id: " .. tostring(sectorId))
            return 0
          end
          temp = temp[difficulty]
          if temp == nil then
            error(" mainAvgDic difficulty Miss id: " .. tostring(difficulty))
            return 0
          end
          ;
          (table.insertto)(avgList, temp)
          -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    return SectorAvgCompleteCheckFunc(avgList, checkAvgId)
  else
    do
      local avgList = ((ConfigData.story_avg).mainAvgDic)[sectorId]
      if avgList == nil then
        error(" mainAvgDic sector Miss id: " .. tostring(sectorId))
        return 0
      end
      avgList = avgList[difficulty]
      if avgList == nil then
        error(" mainAvgDic difficulty Miss id: " .. tostring(difficulty))
        return 0
      end
      do return SectorAvgCompleteCheckFunc(avgList, checkAvgId) end
    end
  end
end

AvgPlayController.UpdateMainAvgState = function(self, avgId)
  -- function num : 0_14 , upvalues : _ENV
  local avgCfg = (ConfigData.story_avg)[avgId]
  if avgCfg == nil then
    error("Cant get avgCfg, avgId = " .. tostring(avgId))
    return 
  end
  if avgCfg.type ~= eAvgTriggerType.MainAvg then
    return 
  end
  local stageCfg = (ConfigData.sector_stage)[avgCfg.set_place]
  if stageCfg == nil then
    error("Cant find sector_stage cfg, id = " .. tostring(avgCfg.set_place))
    return 
  end
  MsgCenter:Broadcast(eMsgEventId.OnMainAvgStateChange, stageCfg.sector, stageCfg.difficulty, avgId)
end

AvgPlayController.OnDelete = function(self)
  -- function num : 0_15 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.TaskReceived, self.__onRecvNewAvgTask)
end

return AvgPlayController

