-- params : ...
-- function num : 0 , upvalues : _ENV
local BuildingNetworkCtrl = class("BuildingNetworkCtrl", NetworkCtrlBase)
local BuildingData = require("Game.Oasis.Data.OasisBuildingData")
local BuildingDynData = require("Game.Oasis.Data.OasisBuildingDynData")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
local LastSendType = {BuildingConstruct = 1, BuildingUpgrade = 2, BuildingMove = 3, BuildingCancel = 4, BuildingConfirmOver = 5, BuildingAccelerate = 6}
BuildingNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self.lastSendDataList = {}
end

BuildingNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDING_Detail, self, proto_csmsg.SC_BUILDING_Detail, self.OnRecvBuildingDetail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDING_Construct, self, proto_csmsg.SC_BUILDING_Construct, self.OnRecvBuildingConstruct)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDING_SyncUpdateDiff, self, proto_csmsg.SC_BUILDING_SyncUpdateDiff, self.OnRecvBuildingSyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDING_Upgrade, self, proto_csmsg.SC_BUILDING_Upgrade, self.OnRecvBuildingUpgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDING_Move, self, proto_csmsg.SC_BUILDING_Move, self.OnRecvBuildingMove)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDING_Collect, self, proto_csmsg.SC_BUILDING_Collect, self.OnRecvBuildingCollect)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDING_CollectGroup, self, proto_csmsg.SC_BUILDING_CollectGroup, self.OnRecvBuildingCollectGroup)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDING_Cancel, self, proto_csmsg.SC_BUILDING_Cancel, self.OnRecvBuildingCancel)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDING_ConfirmOver, self, proto_csmsg.SC_BUILDING_ConfirmOver, self.OnRecvBuildingConfirmOver)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDIN_Accelerate, self, proto_csmsg.SC_BUILDIN_Accelerate, self.OnRecvBuildingAccelerate)
end

BuildingNetworkCtrl.SendBuildingDetail = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Detail, proto_csmsg.CS_BUILDING_Detail, {})
end

BuildingNetworkCtrl.OnRecvBuildingDetail = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV
  for _,v in pairs(msg.data) do
    self:UpdateBuildingData(v)
  end
  ;
  (PlayerDataCenter.playerBonus):CheckPlayerBonusBroadcast()
  ;
  (table.sort)((PlayerDataCenter.AllBuildingData).builtSort, function(a, b)
    -- function num : 0_3_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (PlayerDataCenter.AllBuildingData):UpdateData()
end

BuildingNetworkCtrl.UpdateBuildingData = function(self, buildingBase)
  -- function num : 0_4 , upvalues : _ENV, BuildingData
  local data = ((PlayerDataCenter.AllBuildingData).built)[buildingBase.id]
  if data == nil then
    data = (BuildingData.New)()
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((PlayerDataCenter.AllBuildingData).built)[buildingBase.id] = data
    ;
    (table.insert)((PlayerDataCenter.AllBuildingData).builtSort, data)
    local unbuiltData = ((PlayerDataCenter.AllBuildingData).unbuilt)[buildingBase.id]
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((PlayerDataCenter.AllBuildingData).unbuilt)[buildingBase.id] = nil
    ;
    (table.removebyvalue)((PlayerDataCenter.AllBuildingData).unbuiltSort, unbuiltData)
    data:Initialize(buildingBase, unbuiltData.stcData)
    return true
  else
    do
      if buildingBase.level < data.level then
        data:RemoveBuildingBonus()
      end
      data:Update(buildingBase)
      data:AddBuildingBonus()
      do return false end
    end
  end
end

BuildingNetworkCtrl.OnRecvBuildingSyncUpdateDiff = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, BuildingDynData, BuildingBelong, LastSendType
  local oasisCtroller = ControllerManager:GetController(ControllerTypeId.OasisController)
  local uiSectorBuilding = UIManager:GetWindow(UIWindowTypeID.SectorBuilding)
  local needSort = false
  local built = (PlayerDataCenter.AllBuildingData).built
  for k,v in pairs(msg.delete) do
    local builtData = built[k]
    built[k] = nil
    ;
    (table.removebyvalue)((PlayerDataCenter.AllBuildingData).builtSort, builtData)
    builtData:RemoveBuildingBonus()
    local unbuiltData = ((PlayerDataCenter.AllBuildingData).unbuilt)[builtData.id]
    if unbuiltData == nil then
      unbuiltData = (BuildingDynData.New)()
      unbuiltData:Initialize(builtData.stcData)
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R13 in 'UnsetPending'

      ;
      ((PlayerDataCenter.AllBuildingData).unbuilt)[builtData.id] = unbuiltData
      ;
      (table.insert)((PlayerDataCenter.AllBuildingData).unbuiltSort, unbuiltData)
      needSort = true
    end
  end
  if needSort then
    (table.sort)((PlayerDataCenter.AllBuildingData).unbuiltSort, function(a, b)
    -- function num : 0_5_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
  needSort = false
  for _,v in pairs(msg.update) do
    local addNew = self:UpdateBuildingData(v)
    if addNew then
      needSort = true
    end
  end
  ;
  (PlayerDataCenter.playerBonus):CheckPlayerBonusBroadcast()
  if needSort then
    (table.sort)((PlayerDataCenter.AllBuildingData).builtSort, function(a, b)
    -- function num : 0_5_1
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
  ;
  (PlayerDataCenter.AllBuildingData):UpdateData()
  if oasisCtroller ~= nil then
    oasisCtroller:UpdateOasisRuins()
  end
  if #self.lastSendDataList == 0 then
    for _,v in pairs(msg.update) do
      if (built[v.id]).belong == BuildingBelong.Oasis and oasisCtroller ~= nil then
        oasisCtroller:UpdateBuilding(v.id)
      else
        if (built[v.id]).belong == BuildingBelong.Sector and uiSectorBuilding ~= nil then
          uiSectorBuilding:UpdateBuilding(v.id)
        end
      end
    end
    return 
  end
  local updateRedDotBuildingBuildable = false
  local lastData = (table.remove)(self.lastSendDataList, 1)
  if lastData.type == LastSendType.BuildingConstruct then
    if (built[lastData.id]).belong == BuildingBelong.Oasis and oasisCtroller ~= nil then
      oasisCtroller:ConstructComplete(lastData.id)
    else
      if (built[lastData.id]).belong == BuildingBelong.Sector and uiSectorBuilding ~= nil then
        uiSectorBuilding:ConstructComplete(lastData.id)
      end
    end
    MsgCenter:Broadcast(eMsgEventId.BuildingSendUpgradeComplete, false)
    updateRedDotBuildingBuildable = true
  else
    if lastData.type == LastSendType.BuildingUpgrade then
      if (built[lastData.id]).belong == BuildingBelong.Oasis and oasisCtroller ~= nil then
        oasisCtroller:UpgradeComplete(lastData.id)
      else
        if (built[lastData.id]).belong == BuildingBelong.Sector and uiSectorBuilding ~= nil then
          uiSectorBuilding:UpgradeComplete(lastData.id)
        end
      end
      MsgCenter:Broadcast(eMsgEventId.BuildingSendUpgradeComplete, true)
      updateRedDotBuildingBuildable = true
    else
      -- DECOMPILER ERROR at PC224: Unhandled construct in 'MakeBoolean' P1

      if lastData.type == LastSendType.BuildingMove and (built[lastData.id]).belong == BuildingBelong.Oasis and oasisCtroller ~= nil then
        oasisCtroller:MoveComplete(lastData.id)
      end
    end
  end
  if lastData.type == LastSendType.BuildingCancel then
    if lastData.belong == BuildingBelong.Oasis and oasisCtroller ~= nil then
      oasisCtroller:CancelComplete(lastData.id, lastData.oldState)
    else
      if lastData.belong == BuildingBelong.Sector and uiSectorBuilding ~= nil then
        uiSectorBuilding:CancelComplete(lastData.id, lastData.oldState)
      end
    end
    updateRedDotBuildingBuildable = true
    MsgCenter:Broadcast(eMsgEventId.BuildingCancelComplete)
  else
    if lastData.type == LastSendType.BuildingConfirmOver then
      MsgCenter:Broadcast(eMsgEventId.BuildingUpgradeComplete, lastData.id)
      self:UpdateRedDotBuildingComplete()
      updateRedDotBuildingBuildable = true
    else
      if lastData.type == LastSendType.BuildingAccelerate then
        local progress, second, waitConfirmOver = (built[lastData.id]):GetProcess(PlayerDataCenter.timestamp)
        if progress >= 1 then
          MsgCenter:Broadcast(eMsgEventId.BuildingUpgradeComplete, lastData.id)
          self:UpdateRedDotBuildingComplete()
          updateRedDotBuildingBuildable = true
        end
      end
    end
  end
  do
    if updateRedDotBuildingBuildable then
      self:UpdateRedDotBuildingBuildable()
    end
  end
end

BuildingNetworkCtrl.SendBuildingConstruct = function(self, id, position, area)
  -- function num : 0_6 , upvalues : _ENV, LastSendType
  local tabMsg = {id = id, area = area}
  if position ~= nil then
    tabMsg.x = position.x
    tabMsg.y = position.y
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Construct, proto_csmsg.CS_BUILDING_Construct, tabMsg)
  local saveList = {}
  saveList.type = LastSendType.BuildingConstruct
  saveList.id = id
  ;
  (table.insert)(self.lastSendDataList, saveList)
end

BuildingNetworkCtrl.OnRecvBuildingConstruct = function(self, msg)
  -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    (table.remove)(self.lastSendDataList, 1)
    local err = "BuildingNetworkCtrl:OnRecvBuildingConstruct error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
  end
end

BuildingNetworkCtrl.SendBuildingUpgrade = function(self, id)
  -- function num : 0_8 , upvalues : _ENV, LastSendType
  local tabMsg = {id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Upgrade, proto_csmsg.CS_BUILDING_Upgrade, tabMsg)
  local saveList = {}
  saveList.type = LastSendType.BuildingUpgrade
  saveList.id = id
  ;
  (table.insert)(self.lastSendDataList, saveList)
end

BuildingNetworkCtrl.OnRecvBuildingUpgrade = function(self, msg)
  -- function num : 0_9 , upvalues : _ENV, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    (table.remove)(self.lastSendDataList, 1)
    local err = "LotteryNetworkCtrl:OnRecvBuildingUpgrade error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
  end
end

BuildingNetworkCtrl.SendBuildingMove = function(self, id, position, area)
  -- function num : 0_10 , upvalues : _ENV, LastSendType
  local tabMsg = {id = id, x = position.x, y = position.y, area = area}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Move, proto_csmsg.CS_BUILDING_Move, tabMsg)
  local saveList = {}
  saveList.type = LastSendType.BuildingMove
  saveList.id = id
  ;
  (table.insert)(self.lastSendDataList, saveList)
end

BuildingNetworkCtrl.OnRecvBuildingMove = function(self, msg)
  -- function num : 0_11 , upvalues : _ENV, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    (table.remove)(self.lastSendDataList, 1)
    local err = "LotteryNetworkCtrl:OnRecvBuildingMove error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
  end
end

BuildingNetworkCtrl.SendBuildingCollect = function(self, id)
  -- function num : 0_12 , upvalues : _ENV, cs_WaitNetworkResponse, BuildingBelong
  local tabMsg = {id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Collect, proto_csmsg.CS_BUILDING_Collect, tabMsg)
  local saveList = {}
  saveList.id = id
  ;
  (table.insert)(self.lastSendDataList, saveList)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Collect, function()
    -- function num : 0_12_0 , upvalues : _ENV, self, BuildingBelong
    local lastData = (table.remove)(self.lastSendDataList, 1)
    local built = (PlayerDataCenter.AllBuildingData).built
    local oasisCtroller = ControllerManager:GetController(ControllerTypeId.OasisController)
    if (built[lastData.id]).belong == BuildingBelong.Oasis and oasisCtroller ~= nil then
      oasisCtroller:CollectComplete(lastData.id, lastData.resTab)
    end
    self:UpdateRedDotSectorResMax()
  end
, proto_csmsg_MSG_ID.MSG_SC_BUILDING_Collect, proto_csmsg_MSG_ID.MSG_SC_EFFECTOR_RGSyncUpdateDiff)
end

BuildingNetworkCtrl.OnRecvBuildingCollect = function(self, msg)
  -- function num : 0_13 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret == proto_csmsg_ErrorCode.None then
    local lastData = (self.lastSendDataList)[1]
    lastData.resTab = {}
    if msg.data ~= nil then
      for k,v in pairs(msg.data) do
        local res = {id = k, count = v}
        ;
        (table.insert)(lastData.resTab, res)
      end
    end
    do
      do
        ;
        (table.sort)(lastData.resTab, function(a, b)
    -- function num : 0_13_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
        ;
        (table.remove)(self.lastSendDataList, 1)
        local err = "LotteryNetworkCtrl:OnRecvBuildingCollect error:" .. tostring(msg.ret)
        error(err)
        if isGameDev then
          (cs_MessageCommon.ShowMessageTips)(err)
        end
        cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Collect)
      end
    end
  end
end

BuildingNetworkCtrl.SendBuildingCollectGroup = function(self, buildingIdDic, callback)
  -- function num : 0_14 , upvalues : _ENV, cs_WaitNetworkResponse
  local tabMsg = {gruop = buildingIdDic}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDING_CollectGroup, proto_csmsg.CS_BUILDING_CollectGroup, tabMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_CollectGroup, callback, proto_csmsg_MSG_ID.MSG_SC_BUILDING_CollectGroup, proto_csmsg_MSG_ID.MSG_SC_EFFECTOR_RGSyncUpdateDiff)
end

BuildingNetworkCtrl.OnRecvBuildingCollectGroup = function(self, msg)
  -- function num : 0_15 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_BUILDING_CollectGroup, msg.data)
  else
    local err = "OnRecvBuildingCollectGroup error:" .. tostring(msg.ret)
    error(err)
    ;
    (cs_MessageCommon.ShowMessageTips)(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_CollectGroup)
  end
end

BuildingNetworkCtrl.SendBuildingCancel = function(self, id)
  -- function num : 0_16 , upvalues : _ENV, LastSendType
  local tabMsg = {id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Cancel, proto_csmsg.CS_BUILDING_Cancel, tabMsg)
  local saveList = {}
  saveList.type = LastSendType.BuildingCancel
  saveList.id = id
  local builtData = ((PlayerDataCenter.AllBuildingData).built)[id]
  saveList.oldState = builtData.state
  saveList.id = builtData.id
  saveList.belong = builtData.belong
  ;
  (table.insert)(self.lastSendDataList, saveList)
end

BuildingNetworkCtrl.OnRecvBuildingCancel = function(self, msg)
  -- function num : 0_17 , upvalues : _ENV, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    (table.remove)(self.lastSendDataList, 1)
    local err = "LotteryNetworkCtrl:OnRecvBuildingCancel error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
  end
end

BuildingNetworkCtrl.SendBuildingConfirmOver = function(self, id)
  -- function num : 0_18 , upvalues : _ENV, LastSendType, cs_WaitNetworkResponse
  local tabMsg = {id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDING_ConfirmOver, proto_csmsg.CS_BUILDING_ConfirmOver, tabMsg)
  local saveList = {}
  saveList.type = LastSendType.BuildingConfirmOver
  saveList.id = id
  ;
  (table.insert)(self.lastSendDataList, saveList)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_ConfirmOver, proto_csmsg_MSG_ID.MSG_SC_BUILDING_ConfirmOver, proto_csmsg_MSG_ID.MSG_SC_BUILDING_SyncUpdateDiff)
end

BuildingNetworkCtrl.OnRecvBuildingConfirmOver = function(self, msg)
  -- function num : 0_19 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    (table.remove)(self.lastSendDataList, 1)
    local err = "LotteryNetworkCtrl:OnRecvBuildingConfirmOver error:" .. tostring(msg.ret)
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_ConfirmOver)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
  end
end

BuildingNetworkCtrl.Reset = function(self)
  -- function num : 0_20
  self.lastSendDataList = {}
  self:StopBuildingRedDotTimer()
end

BuildingNetworkCtrl.InitBuildingRedDotOasis = function(self)
  -- function num : 0_21 , upvalues : _ENV
  local oasisBuildableCount = self:__GenOasisBuildableCount()
  local buildableNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.OasisBuildListPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.Oasis, RedDotStaticTypeId.OasisBuildList)
  buildableNode:SetRedDotCount(oasisBuildableCount)
  for _,id in ipairs((ConfigData.sector).id_sort_list) do
    local sectorCfg = (ConfigData.sector)[id]
    local sectorId = sectorCfg.id
    local sectorNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.SectorBuildingPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, RedDotStaticTypeId.SectorBuilding, sectorId)
    local sectorBuildableCount = self:__GenSectorBuildableCount(sectorCfg)
    sectorNode:SetRedDotCount(sectorBuildableCount)
  end
  local oasisCompleteCount, sectorCompleteCount = self:__GenCompleteCount()
  local osasisCompleteNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.OasisBuildQueuePath, RedDotStaticTypeId.Main, RedDotStaticTypeId.Oasis, RedDotStaticTypeId.OasisBuildQueue)
  osasisCompleteNode:SetRedDotCount(oasisCompleteCount)
  self:StartBuildingRedDotTimer()
end

BuildingNetworkCtrl.UpdateRedDotBuildingBuildable = function(self)
  -- function num : 0_22 , upvalues : _ENV
  local ok, buildableNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Oasis, RedDotStaticTypeId.OasisBuildList)
  do
    if ok then
      local oasisBuildableCount = self:__GenOasisBuildableCount()
      buildableNode:SetRedDotCount(oasisBuildableCount)
    end
    for _,id in ipairs((ConfigData.sector).id_sort_list) do
      local sectorCfg = (ConfigData.sector)[id]
      local sectorId = sectorCfg.id
      local ok, sectorNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, RedDotStaticTypeId.SectorBuilding, sectorId)
      if ok then
        local sectorBuildableCount = self:__GenSectorBuildableCount(sectorCfg)
        sectorNode:SetRedDotCount(sectorBuildableCount)
      end
    end
  end
end

BuildingNetworkCtrl.UpdateRedDotBuildingComplete = function(self)
  -- function num : 0_23 , upvalues : _ENV
  local oasisCompleteCount, sectorCompleteCount = self:__GenCompleteCount()
  local ok, completeNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Oasis, RedDotStaticTypeId.OasisBuildQueue)
  if ok then
    completeNode:SetRedDotCount(oasisCompleteCount)
  end
end

BuildingNetworkCtrl.UpdateRedDotSectorResMax = function(self)
  -- function num : 0_24
end

BuildingNetworkCtrl.OnRedDotBuildingTimerUpdate = function(self)
  -- function num : 0_25
  self:UpdateRedDotBuildingComplete()
  self:UpdateRedDotSectorResMax()
end

BuildingNetworkCtrl.StartBuildingRedDotTimer = function(self)
  -- function num : 0_26 , upvalues : _ENV
  self.redDotTimer = (TimerManager:GetTimer(5, (BindCallback(self, self.OnRedDotBuildingTimerUpdate)), nil, false, false, true)):Start()
end

BuildingNetworkCtrl.StopBuildingRedDotTimer = function(self)
  -- function num : 0_27
  if self.redDotTimer ~= nil then
    (self.redDotTimer):Stop()
    self.redDotTimer = nil
  end
end

BuildingNetworkCtrl.__GenOasisBuildableCount = function(self)
  -- function num : 0_28 , upvalues : _ENV, BuildingBelong
  local oasisBuildableCount = 0
  if not (PlayerDataCenter.AllBuildingData):FullBuildQue(BuildingBelong.Oasis) then
    for k,v in ipairs((PlayerDataCenter.AllBuildingData).unbuiltSort) do
      if v:Unlock() and v:CanBuild() and v.belong == BuildingBelong.Oasis then
        oasisBuildableCount = oasisBuildableCount + 1
      end
    end
    for k,v in pairs((PlayerDataCenter.AllBuildingData).oasisBuilt) do
      if v.state == proto_object_BuildingState.BuildingStateNormal and v:CanUpgrade() then
        oasisBuildableCount = oasisBuildableCount + 1
      end
    end
  end
  do
    return oasisBuildableCount
  end
end

BuildingNetworkCtrl.__GenSectorBuildableCount = function(self, sectorCfg)
  -- function num : 0_29 , upvalues : _ENV, BuildingBelong
  local unlock = (PlayerDataCenter.sectorStage):IsSectorUnlock(sectorCfg.id)
  local sectorBuildableCount = 0
  if not (PlayerDataCenter.AllBuildingData):FullBuildQue(BuildingBelong.Sector) and unlock and sectorCfg.building ~= nil then
    for _,buildingId in ipairs(sectorCfg.building) do
      local unbuiltData = ((PlayerDataCenter.AllBuildingData).unbuilt)[buildingId]
      if unbuiltData ~= nil and unbuiltData:Unlock() and unbuiltData:CanBuild() then
        sectorBuildableCount = sectorBuildableCount + 1
      end
      local builtData = ((PlayerDataCenter.AllBuildingData).sectorBuilt)[buildingId]
      if builtData ~= nil and builtData.state == proto_object_BuildingState.BuildingStateNormal and builtData:CanUpgrade() then
        sectorBuildableCount = sectorBuildableCount + 1
      end
    end
  end
  do
    return sectorBuildableCount
  end
end

BuildingNetworkCtrl.__GenSectorBuildingResCount = function(self, sectorCfg)
  -- function num : 0_30 , upvalues : _ENV
  local unlock = (PlayerDataCenter.sectorStage):IsSectorUnlock(sectorCfg.id)
  local count = 0
  if unlock and sectorCfg.building ~= nil then
    for _,buildingId in ipairs(sectorCfg.building) do
      local builtData = ((PlayerDataCenter.AllBuildingData).sectorBuilt)[buildingId]
      if builtData ~= nil and builtData.resDatas ~= nil then
        local resDatas = builtData:GetResDatas()
        if resDatas ~= nil then
          for k,v in pairs(resDatas) do
            if v.resMax then
              count = 1
              return count
            end
          end
        end
      end
    end
  end
  do
    return count
  end
end

BuildingNetworkCtrl.__GenCompleteCount = function(self)
  -- function num : 0_31 , upvalues : _ENV, BuildingBelong
  local timeStamp = PlayerDataCenter.timestamp
  local oasisCount = 0
  local sectorCount = 0
  for k,v in pairs((PlayerDataCenter.AllBuildingData).built) do
    if v.state == proto_object_BuildingState.BuildingStateCreate or v.state == proto_object_BuildingState.BuildingStateUpgrade then
      local progress = v:GetProcess(timeStamp)
      if progress >= 1 then
        if v.belong == BuildingBelong.Oasis then
          oasisCount = oasisCount + 1
        else
          sectorCount = sectorCount + 1
        end
      end
    end
  end
  return oasisCount, sectorCount
end

BuildingNetworkCtrl.SendBuildingAccelerate = function(self, id, cost)
  -- function num : 0_32 , upvalues : LastSendType, _ENV, cs_WaitNetworkResponse
  local tabMsg = {id = id, cost = cost}
  local saveList = {}
  saveList.type = LastSendType.BuildingAccelerate
  saveList.id = id
  ;
  (table.insert)(self.lastSendDataList, saveList)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDIN_Accelerate, proto_csmsg.CS_BUILDIN_Accelerate, tabMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BUILDIN_Accelerate, proto_csmsg_MSG_ID.MSG_SC_BUILDIN_Accelerate)
end

BuildingNetworkCtrl.OnRecvBuildingAccelerate = function(self, msg)
  -- function num : 0_33 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret == proto_csmsg_ErrorCode.None then
    (table.remove)(self.lastSendDataList, 1)
    local err = "LotteryNetworkCtrl:OnRecvBuildingAccelerate error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BUILDIN_Accelerate)
  end
end

return BuildingNetworkCtrl

