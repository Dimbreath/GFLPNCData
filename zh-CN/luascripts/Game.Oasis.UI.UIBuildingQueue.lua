-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBuildingQueue = class("UIBuildingQueue", UIBaseWindow)
local base = UIBaseWindow
local UIBuildingQueueItem = require("Game.Oasis.UI.UIBuildingQueueItem")
local UIBuildingQueueNewItem = require("Game.Oasis.UI.UIBuildingQueueNewItem")
UIBuildingQueue.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UIBuildingQueueItem
  self.OnFinishBuildingEvent = nil
  ;
  ((self.ui).queueUnit):SetActive(false)
  self.allBuildingData = PlayerDataCenter.AllBuildingData
  self.queuePool = (UIItemPool.New)(UIBuildingQueueItem, (self.ui).queueUnit)
  self.__OnForceUpdateProcess = BindCallback(self, self.__ForceUpdateProcess)
  MsgCenter:AddListener(eMsgEventId.BuildingSendUpgradeComplete, self.__OnForceUpdateProcess)
  self:InitContructionQueue()
end

UIBuildingQueue.SetSectorType = function(self)
  -- function num : 0_1
  self.isSector = true
end

UIBuildingQueue.Update = function(self, timestamp, isSecond)
  -- function num : 0_2
  self.__timeStamp = timestamp
  if isSecond then
    self:UpdateBuildingQueue(timestamp)
  end
end

UIBuildingQueue.__ForceUpdateProcess = function(self)
  -- function num : 0_3
  self:UpdateBuildingQueue(self.__timeStamp)
end

UIBuildingQueue.UpdateBuildingQueue = function(self, timestamp)
  -- function num : 0_4 , upvalues : _ENV
  local builtDatas, queueCeiling = nil, nil
  if self.isSector then
    builtDatas = (self.allBuildingData).sectorBuilt
    queueCeiling = (PlayerDataCenter.playerBonus):GetBuildQueueCount(eBuildQueueType.Sector)
  else
    builtDatas = (self.allBuildingData).oasisBuilt
    queueCeiling = (PlayerDataCenter.playerBonus):GetBuildQueueCount(eBuildQueueType.Oasis)
  end
  ;
  (self.queuePool):HideAll()
  local inQueCount = 0
  for k,v in pairs(builtDatas) do
    if v.state == proto_object_BuildingState.BuildingStateCreate or v.state == proto_object_BuildingState.BuildingStateUpgrade then
      self:__GenProgress(v, timestamp)
      inQueCount = inQueCount + 1
      local sectorName = self:__GetSectorName(v)
      local queueItem = (self.queuePool):GetOne()
      queueItem:UpdateQueueProgress(v, sectorName)
      queueItem.OnFinishEvent = BindCallback(self, self.OnFinishBuilding)
    end
  end
  do
    if (queueCeiling <= inQueCount or self.ui ~= nil) and (self.ui).tex_FreeQueue ~= nil then
      ((self.ui).tex_FreeQueue):SetIndex(0, tostring(queueCeiling - (inQueCount)), tostring(queueCeiling))
    end
    self:UpdateContructionQueue(builtDatas)
  end
end

UIBuildingQueue.__UpdateNextCountUnlock = function(self, queueCeiling)
  -- function num : 0_5 , upvalues : _ENV
  local builtData = ((self.allBuildingData).built)[(ConfigData.game_config).buildQueBuildingId]
  if builtData == nil then
    error("Can\'t find buildQueBuildingId, id = " .. tostring((ConfigData.game_config).buildQueBuildingId))
    return 
  end
  if self.__buildQueBuildingLevel == builtData.level then
    return 
  end
  self.__buildQueBuildingLevel = builtData.level
  local isMaxLevel = builtData.maxLevel <= builtData.level
  local nextLevel = nil
  if not isMaxLevel then
    isMaxLevel = true
    if not self.isSector or not eBuildQueueType.Sector then
      local queType = eBuildQueueType.Oasis
    end
    for i = builtData.level + 1, builtData.maxLevel do
      local levelCfg = (builtData.levelConfig)[i]
      local queueParaIndex = nil
      for i = 1, #levelCfg.logic do
        if (levelCfg.logic)[i] == eBuildingLogic.BuildQueue and (levelCfg.para1)[i] == queType then
          queueParaIndex = i
          break
        end
      end
      if queueParaIndex ~= nil and queueCeiling < (levelCfg.para2)[queueParaIndex] then
        nextLevel = i
        isMaxLevel = false
        break
      end
    end
  end
  if isMaxLevel then
    (((self.ui).tex_UnlockInfo).gameObject):SetActive(false)
  else
    ((self.ui).tex_UnlockInfo):SetIndex(0, tostring(nextLevel), builtData.name)
  end
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

UIBuildingQueue.__GenProgress = function(self, builtData, timestamp)
  -- function num : 0_6 , upvalues : _ENV
  local progress, second, waitConfirmOver = builtData:GetProcess(timestamp)
  local remainTimeText = TimestampToTime(second)
  MsgCenter:Broadcast(eMsgEventId.UpdateBuildingProcess, builtData.id, progress, remainTimeText, waitConfirmOver, second)
end

UIBuildingQueue.OnFinishBuilding = function(self, id)
  -- function num : 0_7
  if self.OnFinishBuildingEvent ~= nil then
    (self.OnFinishBuildingEvent)(id)
  end
end

UIBuildingQueue.__GetSectorName = function(self, builtData)
  -- function num : 0_8 , upvalues : _ENV
  if not self.isSector then
    return nil
  end
  local sectorCfg = (ConfigData.sector)[builtData.sectorId]
  if sectorCfg ~= nil then
    return sectorCfg.name
  end
end

UIBuildingQueue.InitContructionQueue = function(self)
  -- function num : 0_9 , upvalues : _ENV, UIBuildingQueueNewItem
  self.constructionPool = (UIItemPool.New)(UIBuildingQueueNewItem, (self.ui).obj_queueItem)
  ;
  ((self.ui).obj_queueItem):SetActive(false)
  ;
  ((self.ui).obj_constructQueue):SetActive(false)
end

UIBuildingQueue.UpdateContructionQueue = function(self, builtDatas)
  -- function num : 0_10 , upvalues : _ENV
  local inConstructNum = 0
  if (table.count)(builtDatas) <= 0 then
    ((self.ui).obj_constructQueue):SetActive(false)
    return 
  end
  ;
  (self.constructionPool):HideAll()
  for k,v in pairs(builtDatas) do
    if v.state == proto_object_BuildingState.BuildingStateCreate or v.state == proto_object_BuildingState.BuildingStateUpgrade then
      local item = (self.constructionPool):GetOne()
      local sectorName = self:__GetSectorName(v)
      item:UpdateQueueProgress(v, sectorName)
      inConstructNum = inConstructNum + 1
    end
  end
  ;
  ((self.ui).obj_constructQueue):SetActive(inConstructNum > 0)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIBuildingQueue.SetUIPositionInOasis = function(self)
  -- function num : 0_11
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  if (self.ui).rectTrans ~= nil then
    ((self.ui).rectTrans).anchoredPosition3D = (self.ui).oasisPos
  end
end

UIBuildingQueue.OnDelete = function(self)
  -- function num : 0_12 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.BuildingSendUpgradeComplete, self.__OnForceUpdateProcess)
  ;
  (self.queuePool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UIBuildingQueue

