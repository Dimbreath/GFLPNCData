-- params : ...
-- function num : 0 , upvalues : _ENV
local ArithmeticNetwork = class("ArithmeticNetwork", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
ArithmeticNetwork.ctor = function(self)
  -- function num : 0_0
  self.__athDetailTab = {}
  self.__athInstallTab = {}
  self.__athUninstallTab = {}
  self.__athMoveTab = {}
  self.__slotUpdateTab = {}
  self.__athOptimizeTab = {}
  self.__athInheritTab = {}
  self.__athLockTab = {}
  self.__athDecoTab = {}
  self.__athAutoDecoTab = {}
  self.__oneKeyInstallTab = {}
  self.__onekeyUninstallTab = {}
end

ArithmeticNetwork.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_Detail, self, proto_csmsg.SC_ATH_Detail, self.SC_ATH_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_SyncUpdateDiff, self, proto_csmsg.SC_ATH_SyncUpdateDiff, self.SC_ATH_SyncUpdateDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_AthRefillOp, self, proto_csmsg.SC_ATH_AthRefillOp, self.SC_ATH_AthRefillOp)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_AthUninstall, self, proto_csmsg.SC_ATH_AthUninstall, self.SC_ATH_AthUninstall)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_Move, self, proto_csmsg.SC_ATH_Move, self.SC_ATH_Move)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_SlotUpgrade, self, proto_csmsg.SC_ATH_SlotUpgrade, self.SC_ATH_SlotUpgrade)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_AthOptimize, self, proto_csmsg.SC_ATH_AthOptimize, self.SC_ATH_AthOptimize)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_AthInherit, self, proto_csmsg.SC_ATH_AthInherit, self.SC_ATH_AthInherit)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_AthLock, self, proto_csmsg.SC_ATH_AthLock, self.SC_ATH_AthLock)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_OneKeyDeco, self, proto_csmsg.SC_ATH_OneKeyDeco, self.SC_ATH_OneKeyDeco)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Ath_AutoDecoSetting, self, proto_csmsg.SC_Ath_AutoDecoSetting, self.SC_Ath_AutoDecoSetting)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_OneKeyInstall, self, proto_csmsg.SC_ATH_OneKeyInstall, self.SC_ATH_OneKeyInstall)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ATH_OneKeyUninstall, self, proto_csmsg.SC_ATH_OneKeyUninstall, self.SC_ATH_OneKeyUninstall)
end

ArithmeticNetwork.CS_ATH_Detail = function(self)
  -- function num : 0_2 , upvalues : _ENV, cs_WaitNetworkResponse
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
  if not funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm) then
    return 
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_Detail, proto_csmsg.CS_ATH_Detail, self.__athDetailTab)
  cs_WaitNetworkResponse:StartOrAddWait(proto_csmsg_MSG_ID.MSG_CS_ATH_Detail, proto_csmsg_MSG_ID.MSG_SC_ATH_Detail)
end

ArithmeticNetwork.SC_ATH_Detail = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV
  (PlayerDataCenter.allAthData):InitAllAthData(msg)
end

ArithmeticNetwork.SC_ATH_SyncUpdateDiff = function(self, msg)
  -- function num : 0_4 , upvalues : _ENV
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
  if not funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm) then
    return 
  end
  ;
  (PlayerDataCenter.allAthData):SyncAthDiff(msg)
  MsgCenter:Broadcast(eMsgEventId.OnAthDataUpdate, msg.updateAth, msg.heroSlot)
end

ArithmeticNetwork.CS_ATH_AthRefillOp = function(self, heroId, slotIdx, uid, gridId, oldMove, op, callBack)
  -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R8 in 'UnsetPending'

  (self.__athInstallTab).heroId = heroId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self.__athInstallTab).slotIdx = slotIdx
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self.__athInstallTab).uid = uid
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self.__athInstallTab).gridId = gridId
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self.__athInstallTab).oldMove = oldMove
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self.__athInstallTab).op = op
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_AthRefillOp, proto_csmsg.CS_ATH_AthRefillOp, self.__athInstallTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthRefillOp, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_AthRefillOp, proto_csmsg_MSG_ID.MSG_SC_ATH_SyncUpdateDiff)
end

ArithmeticNetwork.SC_ATH_AthRefillOp = function(self, msg)
  -- function num : 0_6 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_AthRefillOp error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthRefillOp)
  end
end

ArithmeticNetwork.CS_ATH_AthUninstall = function(self, uid, callBack)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.__athUninstallTab).uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_AthUninstall, proto_csmsg.CS_ATH_AthUninstall, self.__athUninstallTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthUninstall, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_AthUninstall, proto_csmsg_MSG_ID.MSG_SC_ATH_SyncUpdateDiff)
end

ArithmeticNetwork.SC_ATH_AthUninstall = function(self, msg)
  -- function num : 0_8 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_AthUninstall error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthUninstall)
  end
end

ArithmeticNetwork.CS_ATH_Move = function(self, uid, gridId, callBack)
  -- function num : 0_9 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

  (self.__athMoveTab).uid = uid
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.__athMoveTab).gridId = gridId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_Move, proto_csmsg.CS_ATH_Move, self.__athMoveTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_Move, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_Move, proto_csmsg_MSG_ID.MSG_SC_ATH_SyncUpdateDiff)
end

ArithmeticNetwork.SC_ATH_Move = function(self, msg)
  -- function num : 0_10 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_Move error:" .. tostring(msg.ret)
    error(err)
    ;
    (cs_MessageCommon.ShowMessageTips)(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_Move)
  end
end

ArithmeticNetwork.CS_ATH_SlotUpgrade = function(self, heroId, itemDic, athDic, callBack)
  -- function num : 0_11 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R5 in 'UnsetPending'

  (self.__slotUpdateTab).heroId = heroId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.__slotUpdateTab).item = itemDic
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.__slotUpdateTab).ath = athDic
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_SlotUpgrade, proto_csmsg.CS_ATH_SlotUpgrade, self.__slotUpdateTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_SlotUpgrade, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_SlotUpgrade, proto_csmsg_MSG_ID.MSG_SC_ATH_SyncUpdateDiff)
end

ArithmeticNetwork.SC_ATH_SlotUpgrade = function(self, msg)
  -- function num : 0_12 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_SlotUpgrade error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_SC_ATH_SlotUpgrade)
  end
end

ArithmeticNetwork.CS_ATH_AthOptimize = function(self, uid, idx, sect, callBack)
  -- function num : 0_13 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R5 in 'UnsetPending'

  (self.__athOptimizeTab).uid = uid
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.__athOptimizeTab).idx = idx
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.__athOptimizeTab).sect = sect
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_AthOptimize, proto_csmsg.CS_ATH_AthOptimize, self.__athOptimizeTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthOptimize, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_AthOptimize, proto_csmsg_MSG_ID.MSG_SC_ATH_SyncUpdateDiff)
end

ArithmeticNetwork.SC_ATH_AthOptimize = function(self, msg)
  -- function num : 0_14 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "SC_ATH_AthOptimize error:" .. tostring(msg.ret)
      error(err)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthOptimize)
      return 
    end
    ;
    (PlayerDataCenter.allAthData):UpdateAthFalure(msg.failure)
    cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_ATH_AthOptimize, msg.result)
    if not msg.result then
      cs_WaitNetworkResponse:WaitComplete(proto_csmsg_MSG_ID.MSG_CS_ATH_AthOptimize)
    end
  end
end

ArithmeticNetwork.CS_ATH_AthInherit = function(self, uidFrom, uidTo, idxFrom, idxTo, callBack)
  -- function num : 0_15 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R6 in 'UnsetPending'

  (self.__athInheritTab).from = uidFrom
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.__athInheritTab).to = uidTo
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.__athInheritTab).fromIdx = idxFrom
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.__athInheritTab).toIdx = idxTo
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_AthInherit, proto_csmsg.CS_ATH_AthInherit, self.__athInheritTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthInherit, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_AthInherit, proto_csmsg_MSG_ID.MSG_SC_ATH_SyncUpdateDiff)
end

ArithmeticNetwork.SC_ATH_AthInherit = function(self, msg)
  -- function num : 0_16 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_AthInherit error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthInherit)
  end
end

ArithmeticNetwork.CS_ATH_AthLock = function(self, uid, callBack)
  -- function num : 0_17 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.__athLockTab).uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_AthLock, proto_csmsg.CS_ATH_AthLock, self.__athLockTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthLock, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_AthLock, proto_csmsg_MSG_ID.MSG_SC_ATH_SyncUpdateDiff)
end

ArithmeticNetwork.SC_ATH_AthLock = function(self, msg)
  -- function num : 0_18 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_AthLock error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_AthLock)
    return 
  end
end

ArithmeticNetwork.CS_ATH_OneKeyDeco = function(self, DecoList, callBack)
  -- function num : 0_19 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  (self.__athDecoTab).uids = {}
  for key,value in pairs(DecoList) do
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R8 in 'UnsetPending'

    ((self.__athDecoTab).uids)[value] = true
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_OneKeyDeco, proto_csmsg.CS_ATH_OneKeyDeco, self.__athDecoTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_OneKeyDeco, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_OneKeyDeco, proto_csmsg_MSG_ID.MSG_SC_ATH_SyncUpdateDiff)
end

ArithmeticNetwork.SC_ATH_OneKeyDeco = function(self, msg)
  -- function num : 0_20 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_OneKeyDeco error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_OneKeyDeco)
  end
end

ArithmeticNetwork.CS_Ath_AutoDecoSetting = function(self, autoDecoConfig, callBack)
  -- function num : 0_21 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.__athAutoDecoTab).setting = autoDecoConfig
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Ath_AutoDecoSetting, proto_csmsg.CS_Ath_AutoDecoSetting, self.__athAutoDecoTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Ath_AutoDecoSetting, callBack, proto_csmsg_MSG_ID.MSG_SC_Ath_AutoDecoSetting)
end

ArithmeticNetwork.SC_Ath_AutoDecoSetting = function(self, msg)
  -- function num : 0_22 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Ath_AutoDecoSetting error:" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Ath_AutoDecoSetting)
  end
end

ArithmeticNetwork.CS_ATH_OneKeyInstall = function(self, heroId, slotId, athGroupDic, callBack)
  -- function num : 0_23 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R5 in 'UnsetPending'

  (self.__oneKeyInstallTab).heroId = heroId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.__oneKeyInstallTab).slotId = slotId
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.__oneKeyInstallTab).athGroup = athGroupDic
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_OneKeyInstall, proto_csmsg.CS_ATH_OneKeyInstall, self.__oneKeyInstallTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_OneKeyInstall, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_OneKeyInstall, proto_csmsg_MSG_ID.MSG_SC_ATH_SyncUpdateDiff)
end

ArithmeticNetwork.SC_ATH_OneKeyInstall = function(self, msg)
  -- function num : 0_24 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_OneKeyInstall error:" .. tostring(msg.ret)
    error(err)
    ;
    (cs_MessageCommon.ShowMessageTips)(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_OneKeyInstall)
  end
end

ArithmeticNetwork.CS_ATH_OneKeyUninstall = function(self, heroId, slotId, callBack)
  -- function num : 0_25 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

  (self.__onekeyUninstallTab).heroId = heroId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.__onekeyUninstallTab).slotId = slotId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ATH_OneKeyUninstall, proto_csmsg.CS_ATH_OneKeyUninstall, self.__onekeyUninstallTab)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ATH_OneKeyUninstall, callBack, proto_csmsg_MSG_ID.MSG_SC_ATH_OneKeyUninstall, proto_csmsg_MSG_ID.MSG_SC_ATH_SyncUpdateDiff)
end

ArithmeticNetwork.SC_ATH_OneKeyUninstall = function(self, msg)
  -- function num : 0_26 , upvalues : _ENV, cs_MessageCommon, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_ATH_OneKeyUninstall error:" .. tostring(msg.ret)
    error(err)
    ;
    (cs_MessageCommon.ShowMessageTips)(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_ATH_OneKeyUninstall)
  end
end

ArithmeticNetwork.Reset = function(self)
  -- function num : 0_27
end

return ArithmeticNetwork

