local DormNetworkCtrl = class("DormNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
DormNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self.send_DormPurchase = {}
  self.send_DormHouseEdit = {}
  self.send_DormFntEdit = {}
  self.send_DormBindHero = {}
  self.send_RenameRoom = {}
  self.send_RoomExchangePos = {}
  self.send_SaveHeroTalk = {}
  self.send_ComfortReward = {}
  self.message = {}
end

DormNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_GlobalDetail, self, proto_csmsg.SC_DORM_GlobalDetail, self.SC_DORM_GlobalDetail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_DormPurchase, self, proto_csmsg.SC_DORM_DormPurchase, self.SC_DORM_DormPurchase)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_HouseEdit, self, proto_csmsg.SC_DORM_HouseEdit, self.SC_DORM_HouseEdit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_RoomDecomposition, self, proto_csmsg.SC_DORM_RoomDecomposition, self.SC_DORM_RoomDecomposition)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_RoomEdit, self, proto_csmsg.SC_DORM_RoomEdit, self.SC_DORM_RoomEdit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_BindUnbindHero, self, proto_csmsg.SC_DORM_BindUnbindHero, self.SC_DORM_BindUnbindHero)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_RenameRoom, self, proto_csmsg.SC_DORM_RenameRoom, self.SC_DORM_RenameRoom)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_RoomExchangePos, self, proto_csmsg.SC_DORM_RoomExchangePos, self.SC_DORM_RoomExchangePos)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_SaveHeroTalk, self, proto_csmsg.SC_DORM_SaveHeroTalk, self.SC_DORM_SaveHeroTalk)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_PickConfortRewards, self, proto_csmsg.SC_DORM_PickConfortRewards, self.SC_DORM_PickConfortRewards)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_SystemOpenNtf, self, proto_csmsg.SC_DORM_SystemOpenNtf, self.SC_DORM_SystemOpenNtf)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_OneKeyUnBindBindHeroes, self, proto_csmsg.SC_DORM_OneKeyUnBindBindHeroes, self.SC_DORM_OneKeyBindUnbindHero)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_BriefDetailWhenUnlock, self, proto_csmsg.SC_DORM_BriefDetailWhenUnlock, self.SC_DORM_BriefDetailWhenUnlock)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_HouseRoomBindUnbind, self, proto_csmsg.SC_DORM_HouseRoomBindUnbind, self.SC_DORM_HouseRoomBindUnbind)
end

DormNetworkCtrl.CS_DORM_GlobalDetail = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_GlobalDetail, proto_csmsg.CS_DORM_GlobalDetail, table.emptytable)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_GlobalDetail, proto_csmsg_MSG_ID.MSG_SC_DORM_GlobalDetail)
end

DormNetworkCtrl.SC_DORM_GlobalDetail = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV
  (ControllerManager:GetController(ControllerTypeId.Dorm, true)):RecvDormDetailData(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

DormNetworkCtrl.CS_DORM_DormPurchase = function(self, houseId)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.send_DormPurchase).houseId = houseId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_DormPurchase, proto_csmsg.CS_DORM_DormPurchase, self.send_DormPurchase)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_DormPurchase, proto_csmsg_MSG_ID.MSG_SC_DORM_DormPurchase)
end

DormNetworkCtrl.SC_DORM_DormPurchase = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "DormNetworkCtrl SC_DORM_DormPurchase error:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(errorMsg)
      return 
    end
    ;
    (ControllerManager:GetController(ControllerTypeId.Dorm, true)):RecvPurchaseHouse((self.send_DormPurchase).houseId)
  end
end

DormNetworkCtrl.CS_DORM_HouseEdit = function(self, editHouseData)
  -- function num : 0_6 , upvalues : _ENV
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_HouseEdit, proto_csmsg.CS_DORM_HouseEdit, editHouseData)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_HouseEdit, proto_csmsg_MSG_ID.MSG_SC_DORM_HouseEdit)
end

DormNetworkCtrl.SC_DORM_HouseEdit = function(self, msg)
  -- function num : 0_7 , upvalues : _ENV
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  local success = false
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "DormNetworkCtrl SC_DORM_HouseEdit error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
  else
    do
      success = true
      local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
      if dormCtrl ~= nil and dormCtrl.houseCtrl ~= nil then
        (dormCtrl.houseCtrl):RecvHouseEdit(success, msg.data)
      end
      if PlayerDataCenter.dormBriefData ~= nil then
        (PlayerDataCenter.dormBriefData):UpdateHistoryMaxComfort(msg.comfort)
      end
    end
  end
end

DormNetworkCtrl.CS_DORM_RoomDecomposition = function(self, houseId, param, fromHouse)
  -- function num : 0_8 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

  (self.send_DormHouseEdit).houseId = houseId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.send_DormHouseEdit).param = param
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.send_DormHouseEdit).pos = fromHouse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomDecomposition, proto_csmsg.CS_DORM_RoomDecomposition, self.send_DormHouseEdit)
  ;
  ((CS.WaitNetworkResponse).Instance):StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomDecomposition, proto_csmsg_MSG_ID.MSG_SC_DORM_RoomDecomposition)
end

DormNetworkCtrl.SC_DORM_RoomDecomposition = function(self, msg)
  -- function num : 0_9 , upvalues : _ENV
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  local success = false
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "DormNetworkCtrl SC_DORM_RoomDecomposition error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
  else
    do
      success = true
      local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
      if dormCtrl ~= nil and dormCtrl.houseCtrl ~= nil then
        (dormCtrl.houseCtrl):RecvHouseRoomDecompose(success, msg.data)
      end
    end
  end
end

DormNetworkCtrl.CS_DORM_RoomEdit = function(self, houseId, roomPos, fntDataList, wallId, floorId, doorData, callBack)
  -- function num : 0_10 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R8 in 'UnsetPending'

  (self.send_DormFntEdit).houseId = houseId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self.send_DormFntEdit).roomPos = roomPos
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self.send_DormFntEdit).data = fntDataList
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self.send_DormFntEdit).wallId = wallId
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self.send_DormFntEdit).floorId = floorId
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self.send_DormFntEdit).door = doorData
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomEdit, proto_csmsg.CS_DORM_RoomEdit, self.send_DormFntEdit)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomEdit, callBack, proto_csmsg_MSG_ID.MSG_SC_DORM_RoomEdit)
end

DormNetworkCtrl.SC_DORM_RoomEdit = function(self, msg)
  -- function num : 0_11 , upvalues : _ENV, cs_WaitNetworkResponse
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "DormNetworkCtrl SC_DORM_RoomEdit erro:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(errorMsg)
      cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomEdit, false)
      cs_WaitNetworkResponse:WaitComplete(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomEdit)
    end
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomEdit, true)
    if PlayerDataCenter.dormBriefData ~= nil then
      (PlayerDataCenter.dormBriefData):UpdateHistoryMaxComfort(msg.comfort)
    end
  end
end

DormNetworkCtrl.CS_DORM_OneKeyBindUnbindHero = function(self, paramlist, callBack)
  -- function num : 0_12 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.message).data = paramlist
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_OneKeyUnBindBindHeroes, proto_csmsg.CS_DORM_OneKeyUnBindBindHeroes, self.message)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_OneKeyUnBindBindHeroes, callBack, proto_csmsg_MSG_ID.MSG_SC_DORM_OneKeyUnBindBindHeroes)
end

DormNetworkCtrl.SC_DORM_OneKeyBindUnbindHero = function(self, msg)
  -- function num : 0_13 , upvalues : _ENV, cs_WaitNetworkResponse
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "DormNetworkCtrl SC_DORM_OneKeyBindUnbindHero erro:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DORM_OneKeyUnBindBindHeroes)
  end
end

DormNetworkCtrl.CS_DORM_BindUnbindHero = function(self, heroId, bind, houseId, roomPos, elemIdx, callBack)
  -- function num : 0_14 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R7 in 'UnsetPending'

  (self.send_DormBindHero).heroId = heroId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (self.send_DormBindHero).bindHero = bind
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (self.send_DormBindHero).houseId = houseId
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (self.send_DormBindHero).roomPos = roomPos
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (self.send_DormBindHero).elemIdx = elemIdx
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_BindUnbindHero, proto_csmsg.CS_DORM_BindUnbindHero, self.send_DormBindHero)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_BindUnbindHero, callBack, proto_csmsg_MSG_ID.MSG_SC_DORM_BindUnbindHero)
end

DormNetworkCtrl.SC_DORM_BindUnbindHero = function(self, msg)
  -- function num : 0_15 , upvalues : _ENV, cs_WaitNetworkResponse
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "DormNetworkCtrl SC_DORM_BindUnbindHero erro:" .. tostring(msg.ret)
      self:ShowSCErrorMsg(errorMsg)
      cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_DORM_BindUnbindHero, false)
      cs_WaitNetworkResponse:WaitComplete(proto_csmsg_MSG_ID.MSG_CS_DORM_BindUnbindHero)
    end
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_DORM_BindUnbindHero, true)
  end
end

DormNetworkCtrl.CS_DORM_RenameRoom = function(self, houseId, roomPos, name, callBack)
  -- function num : 0_16 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R5 in 'UnsetPending'

  (self.send_RenameRoom).houseId = houseId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.send_RenameRoom).roomPos = roomPos
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.send_RenameRoom).name = name
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_RenameRoom, proto_csmsg.CS_DORM_RenameRoom, self.send_RenameRoom)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_RenameRoom, callBack, proto_csmsg_MSG_ID.MSG_SC_DORM_RenameRoom)
end

DormNetworkCtrl.SC_DORM_RenameRoom = function(self, msg)
  -- function num : 0_17 , upvalues : _ENV, cs_WaitNetworkResponse
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None or msg.ret == proto_csmsg_ErrorCode.INVALID_CHARACTER_INPUT then
    ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.name_Illegal))
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DORM_RenameRoom)
  else
    local errorMsg = "DormNetworkCtrl SC_DORM_RenameRoom erro:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DORM_RenameRoom)
  end
end

DormNetworkCtrl.CS_DORM_RoomExchangePos = function(self, houseId, posA, posB, callBack)
  -- function num : 0_18 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R5 in 'UnsetPending'

  (self.send_RoomExchangePos).houseId = houseId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.send_RoomExchangePos).posA = posA
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.send_RoomExchangePos).posB = posB
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomExchangePos, proto_csmsg.CS_DORM_RoomExchangePos, self.send_RoomExchangePos)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomExchangePos, callBack, proto_csmsg_MSG_ID.MSG_SC_DORM_RoomExchangePos)
end

DormNetworkCtrl.SC_DORM_RoomExchangePos = function(self, msg)
  -- function num : 0_19 , upvalues : _ENV, cs_WaitNetworkResponse
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "DormNetworkCtrl SC_DORM_RoomExchangePos erro:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomExchangePos)
  end
end

DormNetworkCtrl.CS_DORM_SaveHeroTalk = function(self, heroId, index)
  -- function num : 0_20 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.send_SaveHeroTalk).heroId = heroId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.send_SaveHeroTalk).index = index
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_SaveHeroTalk, proto_csmsg.CS_DORM_SaveHeroTalk, self.send_SaveHeroTalk)
end

DormNetworkCtrl.SC_DORM_SaveHeroTalk = function(self, msg)
  -- function num : 0_21 , upvalues : _ENV
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "DormNetworkCtrl SC_DORM_SaveHeroTalk erro:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
  end
end

DormNetworkCtrl.CS_DORM_PickConfortRewards = function(self, level, callBack)
  -- function num : 0_22 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.send_ComfortReward).id = level
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_PickConfortRewards, proto_csmsg.CS_DORM_PickConfortRewards, self.send_ComfortReward)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_PickConfortRewards, callBack, proto_csmsg_MSG_ID.MSG_SC_DORM_PickConfortRewards)
end

DormNetworkCtrl.SC_DORM_PickConfortRewards = function(self, msg)
  -- function num : 0_23 , upvalues : _ENV, cs_WaitNetworkResponse
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "DormNetworkCtrl:SC_DORM_PickConfortRewards erro:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DORM_PickConfortRewards)
  else
    do
      ;
      (PlayerDataCenter.dormBriefData):RecordComfortPicked((self.send_ComfortReward).id)
    end
  end
end

DormNetworkCtrl.SC_DORM_SystemOpenNtf = function(self, msg)
  -- function num : 0_24 , upvalues : _ENV
  PlayerDataCenter:UpdateDormBriefData(msg.brief)
end

DormNetworkCtrl.CS_DORM_BriefDetailWhenUnlock = function(self, callBack)
  -- function num : 0_25 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_BriefDetailWhenUnlock, proto_csmsg.CS_DORM_BriefDetailWhenUnlock, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_BriefDetailWhenUnlock, callBack, proto_csmsg_MSG_ID.MSG_SC_DORM_BriefDetailWhenUnlock)
end

DormNetworkCtrl.SC_DORM_BriefDetailWhenUnlock = function(self, msg)
  -- function num : 0_26 , upvalues : _ENV
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  PlayerDataCenter:UpdateDormBriefData(msg.brief)
end

DormNetworkCtrl.CS_DORM_HouseRoomBindUnbind = function(self, houseId, opDic)
  -- function num : 0_27 , upvalues : _ENV, cs_WaitNetworkResponse
  local sendMsg = {}
  sendMsg.houseId = houseId
  sendMsg.op = opDic
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_HouseRoomBindUnbind, proto_csmsg.CS_DORM_HouseRoomBindUnbind, sendMsg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_HouseRoomBindUnbind, proto_csmsg_MSG_ID.MSG_SC_DORM_HouseRoomBindUnbind)
end

DormNetworkCtrl.SC_DORM_HouseRoomBindUnbind = function(self, msg)
  -- function num : 0_28 , upvalues : _ENV, cs_WaitNetworkResponse
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "DormNetworkCtrl:SC_DORM_HouseRoomBindUnbind erro:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(errorMsg)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_DORM_HouseRoomBindUnbind)
  end
end

DormNetworkCtrl.Reset = function(self)
  -- function num : 0_29
end

return DormNetworkCtrl

