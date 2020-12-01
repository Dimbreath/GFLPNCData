-- params : ...
-- function num : 0 , upvalues : _ENV
local DormNetworkCtrl = class("DormNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
local cs_MessageCommon = CS.MessageCommon
DormNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self.send_DormPurchase = {}
  self.send_DormHouseEdit = {}
  self.send_DormFntEdit = {}
  self.send_DormBindHero = {}
end

DormNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_GlobalDetail, self, proto_csmsg.SC_DORM_GlobalDetail, self.SC_DORM_GlobalDetail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_DormPurchase, self, proto_csmsg.SC_DORM_DormPurchase, self.SC_DORM_DormPurchase)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_HouseEdit, self, proto_csmsg.SC_DORM_HouseEdit, self.SC_DORM_HouseEdit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_RoomDecomposition, self, proto_csmsg.SC_DORM_RoomDecomposition, self.SC_DORM_RoomDecomposition)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_RoomEdit, self, proto_csmsg.SC_DORM_RoomEdit, self.SC_DORM_RoomEdit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_BindUnbindHero, self, proto_csmsg.SC_DORM_BindUnbindHero, self.SC_DORM_BindUnbindHero)
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
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "DormNetworkCtrl SC_DORM_DormPurchase error:" .. tostring(msg.ret)
      error(errorMsg)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(errorMsg)
      end
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
  -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon
  local success = false
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "DormNetworkCtrl SC_DORM_HouseEdit error:" .. tostring(msg.ret)
    error(errorMsg)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(errorMsg)
    end
  else
    do
      success = true
      local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
      if dormCtrl ~= nil and dormCtrl.houseCtrl ~= nil then
        (dormCtrl.houseCtrl):RecvHouseEdit(success, msg.data)
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
  -- function num : 0_9 , upvalues : _ENV, cs_MessageCommon
  local success = false
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local errorMsg = "DormNetworkCtrl SC_DORM_RoomDecomposition error:" .. tostring(msg.ret)
    error(errorMsg)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(errorMsg)
    end
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

DormNetworkCtrl.CS_DORM_RoomEdit = function(self, houseId, roomPos, fntDataList, callBack)
  -- function num : 0_10 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R5 in 'UnsetPending'

  (self.send_DormFntEdit).houseId = houseId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.send_DormFntEdit).roomPos = roomPos
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.send_DormFntEdit).data = fntDataList
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomEdit, proto_csmsg.CS_DORM_RoomEdit, self.send_DormFntEdit)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomEdit, callBack, proto_csmsg_MSG_ID.MSG_SC_DORM_RoomEdit)
end

DormNetworkCtrl.SC_DORM_RoomEdit = function(self, msg)
  -- function num : 0_11 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "DormNetworkCtrl SC_DORM_RoomEdit erro:" .. tostring(msg.ret)
      error(errorMsg)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(errorMsg)
      end
      cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomEdit, false)
      cs_WaitNetworkResponse:WaitComplete(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomEdit)
    end
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomEdit, true)
  end
end

DormNetworkCtrl.CS_DORM_BindUnbindHero = function(self, heroId, bind, houseId, roomPos, elemIdx, callBack)
  -- function num : 0_12 , upvalues : _ENV, cs_WaitNetworkResponse
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
  -- function num : 0_13 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local errorMsg = "DormNetworkCtrl SC_DORM_BindUnbindHero erro:" .. tostring(msg.ret)
      error(errorMsg)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(errorMsg)
      end
      cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_DORM_BindUnbindHero, false)
      cs_WaitNetworkResponse:WaitComplete(proto_csmsg_MSG_ID.MSG_CS_DORM_BindUnbindHero)
    end
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_DORM_BindUnbindHero, true)
  end
end

DormNetworkCtrl.Reset = function(self)
  -- function num : 0_14
end

return DormNetworkCtrl

-- params : ...
-- function num : 0 , upvalues : _ENV
local DormNetworkCtrl = class("DormNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
local cs_MessageCommon = CS.MessageCommon
DormNetworkCtrl.ctor = function(self)
    -- function num : 0_0
    self.send_DormPurchase = {}
    self.send_DormHouseEdit = {}
    self.send_DormFntEdit = {}
    self.send_DormBindHero = {}
end

DormNetworkCtrl.InitNetwork = function(self)
    -- function num : 0_1 , upvalues : _ENV
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_GlobalDetail, self,
                         proto_csmsg.SC_DORM_GlobalDetail,
                         self.SC_DORM_GlobalDetail)
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_DormPurchase, self,
                         proto_csmsg.SC_DORM_DormPurchase,
                         self.SC_DORM_DormPurchase)
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_HouseEdit, self,
                         proto_csmsg.SC_DORM_HouseEdit, self.SC_DORM_HouseEdit)
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_RoomDecomposition, self,
                         proto_csmsg.SC_DORM_RoomDecomposition,
                         self.SC_DORM_RoomDecomposition)
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_RoomEdit, self,
                         proto_csmsg.SC_DORM_RoomEdit, self.SC_DORM_RoomEdit)
    self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_DORM_BindUnbindHero, self,
                         proto_csmsg.SC_DORM_BindUnbindHero,
                         self.SC_DORM_BindUnbindHero)
end

DormNetworkCtrl.CS_DORM_GlobalDetail = function(self)
    -- function num : 0_2 , upvalues : _ENV
    self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_GlobalDetail,
                 proto_csmsg.CS_DORM_GlobalDetail, table.emptytable);
    ((CS.WaitNetworkResponse).Instance):StartWait(
        proto_csmsg_MSG_ID.MSG_CS_DORM_GlobalDetail,
        proto_csmsg_MSG_ID.MSG_SC_DORM_GlobalDetail)
end

DormNetworkCtrl.SC_DORM_GlobalDetail = function(self, msg)
    -- function num : 0_3 , upvalues : _ENV
    (ControllerManager:GetController(ControllerTypeId.Dorm, true)):RecvDormDetailData(
        msg)
end

DormNetworkCtrl.CS_DORM_DormPurchase = function(self, houseId)
    -- function num : 0_4 , upvalues : _ENV
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

    (self.send_DormPurchase).houseId = houseId
    self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_DormPurchase,
                 proto_csmsg.CS_DORM_DormPurchase, self.send_DormPurchase);
    ((CS.WaitNetworkResponse).Instance):StartWait(
        proto_csmsg_MSG_ID.MSG_CS_DORM_DormPurchase,
        proto_csmsg_MSG_ID.MSG_SC_DORM_DormPurchase)
end

DormNetworkCtrl.SC_DORM_DormPurchase = function(self, msg)
    -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
    do
        if msg.ret ~= proto_csmsg_ErrorCode.None then
            local errorMsg = "DormNetworkCtrl SC_DORM_DormPurchase error:" ..
                                 tostring(msg.ret)
            error(errorMsg)
            if isGameDev then
                (cs_MessageCommon.ShowMessageTips)(errorMsg)
            end
            return
        end
        (ControllerManager:GetController(ControllerTypeId.Dorm, true)):RecvPurchaseHouse(
            (self.send_DormPurchase).houseId)
    end
end

DormNetworkCtrl.CS_DORM_HouseEdit = function(self, editHouseData)
    -- function num : 0_6 , upvalues : _ENV
    self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_HouseEdit,
                 proto_csmsg.CS_DORM_HouseEdit, editHouseData);
    ((CS.WaitNetworkResponse).Instance):StartWait(
        proto_csmsg_MSG_ID.MSG_CS_DORM_HouseEdit,
        proto_csmsg_MSG_ID.MSG_SC_DORM_HouseEdit)
end

DormNetworkCtrl.SC_DORM_HouseEdit = function(self, msg)
    -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon
    local success = false
    if msg.ret ~= proto_csmsg_ErrorCode.None then
        local errorMsg = "DormNetworkCtrl SC_DORM_HouseEdit error:" ..
                             tostring(msg.ret)
        error(errorMsg)
        if isGameDev then (cs_MessageCommon.ShowMessageTips)(errorMsg) end
    else
        do
            success = true
            local dormCtrl = ControllerManager:GetController(
                                 ControllerTypeId.Dorm)
            if dormCtrl ~= nil and dormCtrl.houseCtrl ~= nil then
                (dormCtrl.houseCtrl):RecvHouseEdit(success, msg.data)
            end
        end
    end
end

DormNetworkCtrl.CS_DORM_RoomDecomposition =
    function(self, houseId, param, fromHouse)
        -- function num : 0_8 , upvalues : _ENV
        -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

        (self.send_DormHouseEdit).houseId = houseId -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'
        ;
        (self.send_DormHouseEdit).param = param -- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'
        ;
        (self.send_DormHouseEdit).pos = fromHouse
        self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomDecomposition,
                     proto_csmsg.CS_DORM_RoomDecomposition,
                     self.send_DormHouseEdit);
        ((CS.WaitNetworkResponse).Instance):StartWait(
            proto_csmsg_MSG_ID.MSG_CS_DORM_RoomDecomposition,
            proto_csmsg_MSG_ID.MSG_SC_DORM_RoomDecomposition)
    end

DormNetworkCtrl.SC_DORM_RoomDecomposition =
    function(self, msg)
        -- function num : 0_9 , upvalues : _ENV, cs_MessageCommon
        local success = false
        if msg.ret ~= proto_csmsg_ErrorCode.None then
            local errorMsg =
                "DormNetworkCtrl SC_DORM_RoomDecomposition error:" ..
                    tostring(msg.ret)
            error(errorMsg)
            if isGameDev then
                (cs_MessageCommon.ShowMessageTips)(errorMsg)
            end
        else
            do
                success = true
                local dormCtrl = ControllerManager:GetController(
                                     ControllerTypeId.Dorm)
                if dormCtrl ~= nil and dormCtrl.houseCtrl ~= nil then
                    (dormCtrl.houseCtrl):RecvHouseRoomDecompose(success,
                                                                msg.data)
                end
            end
        end
    end

DormNetworkCtrl.CS_DORM_RoomEdit = function(self, houseId, roomPos, fntDataList,
                                            callBack)
    -- function num : 0_10 , upvalues : _ENV, cs_WaitNetworkResponse
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R5 in 'UnsetPending'

    (self.send_DormFntEdit).houseId = houseId -- DECOMPILER ERROR at PC3: Confused about usage of register: R5 in 'UnsetPending'
    ;
    (self.send_DormFntEdit).roomPos = roomPos -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'
    ;
    (self.send_DormFntEdit).data = fntDataList
    self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomEdit,
                 proto_csmsg.CS_DORM_RoomEdit, self.send_DormFntEdit)
    cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_DORM_RoomEdit,
                                     callBack,
                                     proto_csmsg_MSG_ID.MSG_SC_DORM_RoomEdit)
end

DormNetworkCtrl.SC_DORM_RoomEdit = function(self, msg)
    -- function num : 0_11 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
    do
        if msg.ret ~= proto_csmsg_ErrorCode.None then
            local errorMsg = "DormNetworkCtrl SC_DORM_RoomEdit erro:" ..
                                 tostring(msg.ret)
            error(errorMsg)
            if isGameDev then
                (cs_MessageCommon.ShowMessageTips)(errorMsg)
            end
            cs_WaitNetworkResponse:AddWaitData(
                proto_csmsg_MSG_ID.MSG_CS_DORM_RoomEdit, false)
            cs_WaitNetworkResponse:WaitComplete(
                proto_csmsg_MSG_ID.MSG_CS_DORM_RoomEdit)
        end
        cs_WaitNetworkResponse:AddWaitData(
            proto_csmsg_MSG_ID.MSG_CS_DORM_RoomEdit, true)
    end
end

DormNetworkCtrl.CS_DORM_BindUnbindHero =
    function(self, heroId, bind, houseId, roomPos, elemIdx, callBack)
        -- function num : 0_12 , upvalues : _ENV, cs_WaitNetworkResponse
        -- DECOMPILER ERROR at PC1: Confused about usage of register: R7 in 'UnsetPending'

        (self.send_DormBindHero).heroId = heroId -- DECOMPILER ERROR at PC3: Confused about usage of register: R7 in 'UnsetPending'
        ;
        (self.send_DormBindHero).bindHero = bind -- DECOMPILER ERROR at PC5: Confused about usage of register: R7 in 'UnsetPending'
        ;
        (self.send_DormBindHero).houseId = houseId -- DECOMPILER ERROR at PC7: Confused about usage of register: R7 in 'UnsetPending'
        ;
        (self.send_DormBindHero).roomPos = roomPos -- DECOMPILER ERROR at PC9: Confused about usage of register: R7 in 'UnsetPending'
        ;
        (self.send_DormBindHero).elemIdx = elemIdx
        self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_DORM_BindUnbindHero,
                     proto_csmsg.CS_DORM_BindUnbindHero, self.send_DormBindHero)
        cs_WaitNetworkResponse:StartWait(
            proto_csmsg_MSG_ID.MSG_CS_DORM_BindUnbindHero, callBack,
            proto_csmsg_MSG_ID.MSG_SC_DORM_BindUnbindHero)
    end

DormNetworkCtrl.SC_DORM_BindUnbindHero =
    function(self, msg)
        -- function num : 0_13 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
        do
            if msg.ret ~= proto_csmsg_ErrorCode.None then
                local errorMsg =
                    "DormNetworkCtrl SC_DORM_BindUnbindHero erro:" ..
                        tostring(msg.ret)
                error(errorMsg)
                if isGameDev then
                    (cs_MessageCommon.ShowMessageTips)(errorMsg)
                end
                cs_WaitNetworkResponse:AddWaitData(
                    proto_csmsg_MSG_ID.MSG_CS_DORM_BindUnbindHero, false)
                cs_WaitNetworkResponse:WaitComplete(
                    proto_csmsg_MSG_ID.MSG_CS_DORM_BindUnbindHero)
            end
            cs_WaitNetworkResponse:AddWaitData(
                proto_csmsg_MSG_ID.MSG_CS_DORM_BindUnbindHero, true)
        end
    end

DormNetworkCtrl.Reset = function(self)
    -- function num : 0_14
end

return DormNetworkCtrl

