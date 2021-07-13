-- params : ...
-- function num : 0 , upvalues : _ENV
local BuildingNetworkCtrl = class("BuildingNetworkCtrl", NetworkCtrlBase)
local BuildingData = require("Game.Oasis.Data.OasisBuildingData")
local BuildingDynData = require("Game.Oasis.Data.OasisBuildingDynData")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local CheckerTypeId, _ = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local NoticeData = require("Game.Notice.NoticeData")
local JumpManager = require("Game.Jump.JumpManager")
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
local LastSendType = {BuildingConstruct = 1, BuildingUpgrade = 2, BuildingMove = 3, BuildingCancel = 4, BuildingConfirmOver = 5, BuildingAccelerate = 6}
local HomeEnum = require("Game.Home.HomeEnum")
BuildingNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self.lastSendDataList = {}
  self._areaUnlockTab = {}
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
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_BUILDIN_AreaUnlock, self, proto_csmsg.SC_BUILDIN_AreaUnlock, self.SC_BUILDIN_AreaUnlock)
end

BuildingNetworkCtrl.SendBuildingDetail = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Detail, proto_csmsg.CS_BUILDING_Detail, {})
end

BuildingNetworkCtrl.OnRecvBuildingDetail = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, NoticeData, JumpManager
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  for _,v in pairs(msg.data) do
    do
      self:UpdateBuildingData(v)
    end
  end
  for _,data in pairs((PlayerDataCenter.AllBuildingData).unbuilt) do
    if not data:Unlock() then
      if data:IsSectorBuilding() then
        local level1Cfg = (data.levelConfig)[1]
        for index,pre_conditionId in ipairs(level1Cfg.pre_condition) do
          local pre_para1 = (level1Cfg.pre_para1)[index]
          local pre_para2 = (level1Cfg.pre_para2)[index]
          NoticeManager:Add2PreConditionDic(pre_conditionId, pre_para1, pre_para2, function()
    -- function num : 0_3_0 , upvalues : _ENV, level1Cfg, NoticeData
    if (CheckCondition.CheckLua)(level1Cfg.pre_condition, level1Cfg.pre_para1, level1Cfg.pre_para2) then
      NoticeManager:AddNotice((NoticeData.CreateNoticeData)(PlayerDataCenter.timestamp, (NoticeManager.eNoticeType).StrategyOverviewSkillUnlcok, nil, {(LanguageUtil.GetLocaleText)(level1Cfg.name)}, nil))
      return true
    end
  end
)
        end
      else
        do
          local level1Cfg = (data.levelConfig)[1]
          for index,pre_conditionId in ipairs(level1Cfg.pre_condition) do
            local pre_para1 = (level1Cfg.pre_para1)[index]
            local pre_para2 = (level1Cfg.pre_para2)[index]
            NoticeManager:Add2PreConditionDic(pre_conditionId, pre_para1, pre_para2, function()
    -- function num : 0_3_1 , upvalues : _ENV, level1Cfg, NoticeData, JumpManager, data
    if (CheckCondition.CheckLua)(level1Cfg.pre_condition, level1Cfg.pre_para1, level1Cfg.pre_para2) then
      NoticeManager:AddNotice((NoticeData.CreateNoticeData)(PlayerDataCenter.timestamp, (NoticeManager.eNoticeType).OasisBuildingUnlock, {jumpType = (JumpManager.eJumpTarget).Oasis, argList = nil}, {(LanguageUtil.GetLocaleText)(level1Cfg.name)}, {buildingId = data.id}))
      return true
    end
  end
)
          end
          do
            -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  ;
  (PlayerDataCenter.playerBonus):CheckPlayerBonusBroadcast()
  ;
  (table.sort)((PlayerDataCenter.AllBuildingData).builtSort, function(a, b)
    -- function num : 0_3_2
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (PlayerDataCenter.AllBuildingData):UpdateData()
  ;
  (PlayerDataCenter.AllBuildingData):InitOasisAreaData(msg.areaData)
  GuideManager:UncompleteCollectResGuide(((PlayerDataCenter.AllBuildingData).built)[1003] == nil)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
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
  -- function num : 0_5 , upvalues : _ENV, BuildingDynData, BuildingBelong, CheckerTypeId, LastSendType
  for areaId,_ in pairs(msg.areaUpdate) do
    (PlayerDataCenter.AllBuildingData):UpdateOasisAreaData(areaId, true)
  end
  local oasisCtroller = ControllerManager:GetController(ControllerTypeId.OasisController)
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
      -- DECOMPILER ERROR at PC53: Confused about usage of register: R12 in 'UnsetPending'

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
  local stOCtrl = ControllerManager:GetController(ControllerTypeId.StrategyOverview)
  if #self.lastSendDataList == 0 then
    for _,v in pairs(msg.update) do
      if (built[v.id]).belong == BuildingBelong.Oasis and oasisCtroller ~= nil then
        oasisCtroller:UpdateBuilding(v.id)
      else
        if (built[v.id]).belong == BuildingBelong.Sector and stOCtrl ~= nil then
          stOCtrl:UpdateStOBuilding(v.id)
        end
      end
    end
    if isGameDev then
      MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.BuildingLevel)
    end
    return 
  end
  local updateRedDotBuildingBuildable = false
  local lastData = (table.remove)(self.lastSendDataList, 1)
  if lastData.type == LastSendType.BuildingConstruct then
    if (built[lastData.id]).belong == BuildingBelong.Oasis and oasisCtroller ~= nil then
      oasisCtroller:ConstructComplete(lastData.id)
    end
    MsgCenter:Broadcast(eMsgEventId.BuildingSendUpgradeComplete, false)
    MsgCenter:Broadcast(eMsgEventId.BuildingUpgradeComplete, lastData.id)
    updateRedDotBuildingBuildable = true
    local sideNoticeList = NoticeManager:GetSideNoticeList()
    for _,noticeData in pairs(sideNoticeList) do
      if noticeData.type == (NoticeManager.eNoticeType).OasisBuildingUnlock and lastData.id == (noticeData.extraData).buildingId then
        NoticeManager:DeleteNotice(noticeData)
        break
      end
    end
  else
    do
      if lastData.type == LastSendType.BuildingUpgrade then
        if (built[lastData.id]).belong == BuildingBelong.Oasis and oasisCtroller ~= nil then
          oasisCtroller:UpgradeComplete(lastData.id)
        end
        MsgCenter:Broadcast(eMsgEventId.BuildingSendUpgradeComplete, true)
        MsgCenter:Broadcast(eMsgEventId.BuildingUpgradeComplete, lastData.id)
        updateRedDotBuildingBuildable = true
        MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.BuildingLevel)
      else
        -- DECOMPILER ERROR at PC260: Unhandled construct in 'MakeBoolean' P1

        if lastData.type == LastSendType.BuildingMove and (built[lastData.id]).belong == BuildingBelong.Oasis and oasisCtroller ~= nil then
          oasisCtroller:MoveComplete(lastData.id)
        end
      end
      if lastData.type == LastSendType.BuildingCancel then
        if lastData.belong == BuildingBelong.Oasis and oasisCtroller ~= nil then
          oasisCtroller:CancelComplete(lastData.id, lastData.oldState)
        end
        updateRedDotBuildingBuildable = true
        MsgCenter:Broadcast(eMsgEventId.BuildingCancelComplete)
      else
        if lastData.type == LastSendType.BuildingConfirmOver then
          MsgCenter:Broadcast(eMsgEventId.BuildingUpgradeComplete, lastData.id)
          updateRedDotBuildingBuildable = true
          MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.BuildingLevel)
        else
          if lastData.type == LastSendType.BuildingAccelerate then
            local progress, second, waitConfirmOver = (built[lastData.id]):GetProcess(PlayerDataCenter.timestamp)
            if progress >= 1 then
              MsgCenter:Broadcast(eMsgEventId.BuildingUpgradeComplete, lastData.id)
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
  end
end

BuildingNetworkCtrl.SendBuildingConstruct = function(self, id, position, area, callback)
  -- function num : 0_6 , upvalues : _ENV, LastSendType, cs_WaitNetworkResponse
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
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Construct, callback, proto_csmsg_MSG_ID.MSG_SC_BUILDING_Construct)
end

BuildingNetworkCtrl.OnRecvBuildingConstruct = function(self, msg)
  -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret == proto_csmsg_ErrorCode.None then
    (table.remove)(self.lastSendDataList, 1)
    do
      local err = "BuildingNetworkCtrl:OnRecvBuildingConstruct error:" .. tostring(msg.ret)
      error(err)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Construct)
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
    end
  end
end

BuildingNetworkCtrl.SendBuildingUpgrade = function(self, id, callback)
  -- function num : 0_8 , upvalues : _ENV, LastSendType, cs_WaitNetworkResponse
  local tabMsg = {id = id}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Upgrade, proto_csmsg.CS_BUILDING_Upgrade, tabMsg)
  local saveList = {}
  saveList.type = LastSendType.BuildingUpgrade
  saveList.id = id
  ;
  (table.insert)(self.lastSendDataList, saveList)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Upgrade, callback, proto_csmsg_MSG_ID.MSG_SC_BUILDING_Upgrade)
end

BuildingNetworkCtrl.OnRecvBuildingUpgrade = function(self, msg)
  -- function num : 0_9 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret == proto_csmsg_ErrorCode.None then
    (table.remove)(self.lastSendDataList, 1)
    do
      local err = "BuildingNetworkCtrl:OnRecvBuildingUpgrade error:" .. tostring(msg.ret)
      error(err)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Upgrade)
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
    end
  end
end

BuildingNetworkCtrl.SendBuildingMove = function(self, id, position, area)
  -- function num : 0_10 , upvalues : _ENV, LastSendType, cs_WaitNetworkResponse
  local tabMsg = {id = id, x = position.x, y = position.y, area = area}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Move, proto_csmsg.CS_BUILDING_Move, tabMsg)
  local saveList = {}
  saveList.type = LastSendType.BuildingMove
  saveList.id = id
  ;
  (table.insert)(self.lastSendDataList, saveList)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Move, proto_csmsg_MSG_ID.MSG_SC_BUILDING_Move)
end

BuildingNetworkCtrl.OnRecvBuildingMove = function(self, msg)
  -- function num : 0_11 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret == proto_csmsg_ErrorCode.None then
    (table.remove)(self.lastSendDataList, 1)
    do
      local err = "BuildingNetworkCtrl:OnRecvBuildingMove error:" .. tostring(msg.ret)
      error(err)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Move)
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
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
    self:UpdateRedDotOasisResMax()
  end
, proto_csmsg_MSG_ID.MSG_SC_BUILDING_Collect)
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
        do
          local err = "BuildingNetworkCtrl:OnRecvBuildingCollect error:" .. tostring(msg.ret)
          error(err)
          if isGameDev then
            (cs_MessageCommon.ShowMessageTips)(err)
          end
          cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Collect)
          NetworkManager:HandleDiff(msg.syncUpdateDiff)
        end
      end
    end
  end
end

BuildingNetworkCtrl.SendBuildingCollectGroup = function(self, buildingIdDic, callback)
  -- function num : 0_14 , upvalues : _ENV, cs_WaitNetworkResponse
  local tabMsg = {gruop = buildingIdDic}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDING_CollectGroup, proto_csmsg.CS_BUILDING_CollectGroup, tabMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_CollectGroup, callback, proto_csmsg_MSG_ID.MSG_SC_BUILDING_CollectGroup)
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
  do
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

BuildingNetworkCtrl.SendBuildingCancel = function(self, id)
  -- function num : 0_16 , upvalues : _ENV, LastSendType, cs_WaitNetworkResponse
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
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Cancel, proto_csmsg_MSG_ID.MSG_SC_BUILDING_Cancel)
end

BuildingNetworkCtrl.OnRecvBuildingCancel = function(self, msg)
  -- function num : 0_17 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret == proto_csmsg_ErrorCode.None then
    (table.remove)(self.lastSendDataList, 1)
    do
      local err = "BuildingNetworkCtrl:OnRecvBuildingCancel error:" .. tostring(msg.ret)
      error(err)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_Cancel)
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
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
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_ConfirmOver, proto_csmsg_MSG_ID.MSG_SC_BUILDING_ConfirmOver)
end

BuildingNetworkCtrl.OnRecvBuildingConfirmOver = function(self, msg)
  -- function num : 0_19 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    (table.remove)(self.lastSendDataList, 1)
    do
      local err = "BuildingNetworkCtrl:OnRecvBuildingConfirmOver error:" .. tostring(msg.ret)
      error(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BUILDING_ConfirmOver)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
    end
  end
end

BuildingNetworkCtrl.CS_BUILDIN_AreaUnlock = function(self, areaId, callback)
  -- function num : 0_20 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self._areaUnlockTab).areaId = areaId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDIN_AreaUnlock, proto_csmsg.CS_BUILDIN_AreaUnlock, self._areaUnlockTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BUILDIN_AreaUnlock, callback, proto_csmsg_MSG_ID.MSG_SC_BUILDIN_AreaUnlock)
end

BuildingNetworkCtrl.SC_BUILDIN_AreaUnlock = function(self, msg)
  -- function num : 0_21 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "SC_BUILDIN_AreaUnlock error:" .. tostring(msg.ret)
      error(err)
      ;
      (cs_MessageCommon.ShowMessageTips)(err)
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BUILDIN_AreaUnlock)
    end
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

BuildingNetworkCtrl.Reset = function(self)
  -- function num : 0_22
  self.lastSendDataList = {}
  self:StopBuildingRedDotTimer()
end

BuildingNetworkCtrl.InitBuildingRedDotOasis = function(self)
  -- function num : 0_23 , upvalues : _ENV
  for _,id in ipairs((ConfigData.sector).id_sort_list) do
    local sectorCfg = (ConfigData.sector)[id]
    local sectorId = sectorCfg.id
    local sectorNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.SectorBuildingPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.Sector, RedDotStaticTypeId.SectorBuilding, sectorId)
    local sectorBuildableCount = self:__GenSectorBuildableCount(sectorCfg)
    sectorNode:SetRedDotCount(sectorBuildableCount)
  end
  local oasisResMaxCount = self:__GenOasisBuildingResMaxCount()
  local oasisResMaxNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.OasisResMaxPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.Oasis, RedDotStaticTypeId.OasisBuildResMax)
  oasisResMaxNode:SetRedDotCount(oasisResMaxCount)
  self:StartBuildingRedDotTimer()
end

BuildingNetworkCtrl.UpdateRedDotBuildingBuildable = function(self)
  -- function num : 0_24 , upvalues : _ENV
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

BuildingNetworkCtrl.UpdateRedDotOasisResMax = function(self)
  -- function num : 0_25 , upvalues : _ENV
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Oasis, RedDotStaticTypeId.OasisBuildResMax)
  if ok then
    local count = self:__GenOasisBuildingResMaxCount()
    node:SetRedDotCount(count)
  end
end

BuildingNetworkCtrl.OnRedDotBuildingTimerUpdate = function(self)
  -- function num : 0_26
  self:UpdateRedDotOasisResMax()
end

BuildingNetworkCtrl.StartBuildingRedDotTimer = function(self)
  -- function num : 0_27 , upvalues : _ENV
  self.redDotTimer = (TimerManager:GetTimer(5, (BindCallback(self, self.OnRedDotBuildingTimerUpdate)), nil, false, false, true)):Start()
end

BuildingNetworkCtrl.StopBuildingRedDotTimer = function(self)
  -- function num : 0_28
  if self.redDotTimer ~= nil then
    (self.redDotTimer):Stop()
    self.redDotTimer = nil
  end
end

BuildingNetworkCtrl.__GenSectorBuildableCount = function(self, sectorCfg)
  -- function num : 0_29 , upvalues : _ENV, BuildingBelong
  local unlock = (PlayerDataCenter.sectorStage):IsSectorUnlock(sectorCfg.id)
  local isSectorBuildingUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding)
  local sectorBuildableCount = 0
  if not (PlayerDataCenter.AllBuildingData):FullBuildQue(BuildingBelong.Sector) and unlock and isSectorBuildingUnlock and sectorCfg.building ~= nil then
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

BuildingNetworkCtrl.__GenOasisBuildingResMaxCount = function(self)
  -- function num : 0_30 , upvalues : _ENV
  local count = 0
  for k,buildData in pairs((PlayerDataCenter.AllBuildingData).oasisBuilt) do
    if buildData.resDatas ~= nil then
      local resDatas = buildData:GetResDatas()
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
  return count
end

BuildingNetworkCtrl.SendBuildingAccelerate = function(self, id, cost, callback)
  -- function num : 0_31 , upvalues : LastSendType, _ENV, cs_WaitNetworkResponse
  local tabMsg = {id = id, cost = cost}
  local saveList = {}
  saveList.type = LastSendType.BuildingAccelerate
  saveList.id = id
  ;
  (table.insert)(self.lastSendDataList, saveList)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_BUILDIN_Accelerate, proto_csmsg.CS_BUILDIN_Accelerate, tabMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_BUILDIN_Accelerate, callback, proto_csmsg_MSG_ID.MSG_SC_BUILDIN_Accelerate)
end

BuildingNetworkCtrl.OnRecvBuildingAccelerate = function(self, msg)
  -- function num : 0_32 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret == proto_csmsg_ErrorCode.None then
    (table.remove)(self.lastSendDataList, 1)
    do
      local err = "BuildingNetworkCtrl:OnRecvBuildingAccelerate error:" .. tostring(msg.ret)
      error(err)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_BUILDIN_Accelerate)
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
    end
  end
end

return BuildingNetworkCtrl

