-- params : ...
-- function num : 0 , upvalues : _ENV
local ResetRoomNetworkCtrl = class("ResetRoomNetworkCtrl", NetworkCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
ResetRoomNetworkCtrl.ctor = function(self)
  -- function num : 0_0
  self.__sendPosition = {}
  self.__sendReproduction = {}
  self.__sendFusion = {}
  self.__sendReconstitution = {}
end

ResetRoomNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RECONSTITUTION_Reproduction, self, proto_csmsg.SC_EXPLORATION_RECONSTITUTION_Reproduction, self.SC_EXPLORATION_RECONSTITUTION_Reproduction)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RECONSTITUTION_Fusion, self, proto_csmsg.SC_EXPLORATION_RECONSTITUTION_Fusion, self.SC_EXPLORATION_RECONSTITUTION_Fusion)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RECONSTITUTION_Reconstitution, self, proto_csmsg.SC_EXPLORATION_RECONSTITUTION_Reconstitution, self.SC_EXPLORATION_RECONSTITUTION_Reconstitution)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RECONSTITUTION_Quit, self, proto_csmsg.SC_EXPLORATION_RECONSTITUTION_Quit, self.SC_EXPLORATION_RECONSTITUTION_Quit)
end

ResetRoomNetworkCtrl.CS_EXPLORATION_RECONSTITUTION_Reproduction = function(self, position, algData, heroId)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

  (self.__sendReproduction).position = position
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.__sendReproduction).alg = {}
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.__sendReproduction).alg).algId = algData.dataId
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.__sendReproduction).alg).ch = algData:GetHeroID() or 0
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.__sendReproduction).heroId = heroId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RECONSTITUTION_Reproduction, proto_csmsg.CS_EXPLORATION_RECONSTITUTION_Reproduction, self.__sendReproduction)
end

ResetRoomNetworkCtrl.SC_EXPLORATION_RECONSTITUTION_Reproduction = function(self, msg)
  -- function num : 0_3 , upvalues : _ENV, cs_MessageCommon
  do
    if msg.ret ~= proto_csmsg_ErrorCode.None then
      local err = "ResetRoomNetworkCtrl:SC_EXPLORATION_RECONSTITUTION_Reproduction error" .. tostring(msg.ret)
      error(err)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
      return 
    end
    if ExplorationManager.epCtrl == nil then
      return 
    end
    ;
    ((ExplorationManager.epCtrl).resetRoomCtrl):OnSendMsgSuccess()
  end
end

ResetRoomNetworkCtrl.CS_EXPLORATION_RECONSTITUTION_Fusion = function(self, position, algItemList)
  -- function num : 0_4 , upvalues : _ENV, cs_WaitNetworkResponse
  if #algItemList < 0 then
    return 
  end
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.__sendFusion).position = position
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.__sendFusion).alg = {}
  for _,v in ipairs(algItemList) do
    local tab = {}
    tab.algId = v.dataId
    tab.ch = (v.chipData):GetHeroID() or 0
    ;
    (table.insert)((self.__sendFusion).alg, tab)
  end
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RECONSTITUTION_Fusion, proto_csmsg.CS_EXPLORATION_RECONSTITUTION_Fusion, self.__sendFusion)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RECONSTITUTION_Fusion, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RECONSTITUTION_Fusion)
end

ResetRoomNetworkCtrl.SC_EXPLORATION_RECONSTITUTION_Fusion = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RECONSTITUTION_Fusion)
    local err = "ResetRoomNetworkCtrl:SC_EXPLORATION_RECONSTITUTION_Fusion error" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    return 
  end
  do
    if ExplorationManager.epCtrl == nil then
      return 
    end
    ;
    ((ExplorationManager.epCtrl).resetRoomCtrl):OnSendMsgSuccess(msg.alg)
  end
end

ResetRoomNetworkCtrl.CS_EXPLORATION_RECONSTITUTION_Reconstitution = function(self, position, algData)
  -- function num : 0_6 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.__sendReconstitution).position = position
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.__sendReconstitution).alg = {}
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.__sendReconstitution).alg).algId = algData.dataId
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.__sendReconstitution).alg).ch = algData:GetHeroID() or 0
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RECONSTITUTION_Reconstitution, proto_csmsg.CS_EXPLORATION_RECONSTITUTION_Reconstitution, self.__sendReconstitution)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RECONSTITUTION_Reconstitution, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RECONSTITUTION_Reconstitution)
end

ResetRoomNetworkCtrl.SC_EXPLORATION_RECONSTITUTION_Reconstitution = function(self, msg)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RECONSTITUTION_Reconstitution)
    local err = "ResetRoomNetworkCtrl:SC_EXPLORATION_RECONSTITUTION_Reconstitution error" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    return 
  end
  do
    if ExplorationManager.epCtrl == nil then
      return 
    end
    ;
    ((ExplorationManager.epCtrl).resetRoomCtrl):OnSendMsgSuccess(msg.alg)
  end
end

ResetRoomNetworkCtrl.CS_EXPLORATION_RECONSTITUTION_Quit = function(self, position)
  -- function num : 0_8 , upvalues : _ENV, cs_WaitNetworkResponse
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.__sendPosition).position = position
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RECONSTITUTION_Quit, proto_csmsg.CS_EXPLORATION_RECONSTITUTION_Quit, self.__sendPosition)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RECONSTITUTION_Quit, proto_csmsg_MSG_ID.MSG_SC_EXPLORATION_RECONSTITUTION_Quit)
end

ResetRoomNetworkCtrl.SC_EXPLORATION_RECONSTITUTION_Quit = function(self, msg)
  -- function num : 0_9 , upvalues : _ENV, cs_WaitNetworkResponse, cs_MessageCommon
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_EXPLORATION_RECONSTITUTION_Quit)
    local err = "ResetRoomNetworkCtrl:SC_EXPLORATION_RECONSTITUTION_Quit error" .. tostring(msg.ret)
    error(err)
    if isGameDev then
      (cs_MessageCommon.ShowMessageTips)(err)
    end
    return 
  end
  do
    if ExplorationManager.epCtrl == nil then
      return 
    end
    ;
    ((ExplorationManager.epCtrl).resetRoomCtrl):CloseResetRoom()
  end
end

ResetRoomNetworkCtrl.Reset = function(self)
  -- function num : 0_10
end

return ResetRoomNetworkCtrl

