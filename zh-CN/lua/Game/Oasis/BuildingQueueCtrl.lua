local BuildingQueueCtrl = class("BuildingQueueCtrl", ControllerBase)
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
BuildingQueueCtrl.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.__OnForceUpdateProcess = BindCallback(self, self.__ForceUpdateProcess)
  MsgCenter:AddListener(eMsgEventId.BuildingSendUpgradeComplete, self.__OnForceUpdateProcess)
end

BuildingQueueCtrl.InitBuildQueueCtrl = function(self, buildingBelong)
  -- function num : 0_1 , upvalues : _ENV
  self._buildBelong = buildingBelong
  self:UpdateBuildingQueue(PlayerDataCenter.timestamp)
end

BuildingQueueCtrl.UpdateBuildQueueSecond = function(self, timestamp, isSecond)
  -- function num : 0_2
  self.__timeStamp = timestamp
  if isSecond then
    self:UpdateBuildingQueue(timestamp)
  end
end

BuildingQueueCtrl.__ForceUpdateProcess = function(self)
  -- function num : 0_3
  self:UpdateBuildingQueue(self.__timeStamp)
end

BuildingQueueCtrl.UpdateBuildingQueue = function(self, timestamp)
  -- function num : 0_4 , upvalues : BuildingBelong, _ENV
  local builtDatas, queueCeiling = nil, nil
  if self._buildBelong == BuildingBelong.Sector then
    builtDatas = (PlayerDataCenter.AllBuildingData).sectorBuilt
    queueCeiling = (PlayerDataCenter.playerBonus):GetBuildQueueCount(eBuildQueueType.Sector)
  else
    builtDatas = (PlayerDataCenter.AllBuildingData).oasisBuilt
    queueCeiling = (PlayerDataCenter.playerBonus):GetBuildQueueCount(eBuildQueueType.Oasis)
  end
  local inQueCount = 0
  for k,v in pairs(builtDatas) do
    if v.state == proto_object_BuildingState.BuildingStateCreate or v.state == proto_object_BuildingState.BuildingStateUpgrade then
      self:__GenProgress(v, timestamp)
      inQueCount = inQueCount + 1
    end
  end
  do
    if queueCeiling > inQueCount then
    end
  end
end

BuildingQueueCtrl.__GenProgress = function(self, builtData, timestamp)
  -- function num : 0_5 , upvalues : _ENV
  local progress, second, waitConfirmOver = builtData:GetProcess(timestamp)
  local remainTimeText = TimestampToTime(second)
  MsgCenter:Broadcast(eMsgEventId.UpdateBuildingProcess, builtData.id, progress, remainTimeText, waitConfirmOver, second)
end

BuildingQueueCtrl.OnDelete = function(self)
  -- function num : 0_6 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.BuildingSendUpgradeComplete, self.__OnForceUpdateProcess)
end

return BuildingQueueCtrl

