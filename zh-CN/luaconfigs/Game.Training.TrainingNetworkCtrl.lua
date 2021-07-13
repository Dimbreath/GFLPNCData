-- params : ...
-- function num : 0 , upvalues : _ENV
local TrainingNetworkCtrl = class("TrainingNetworkCtrl", NetworkCtrlBase)
local SlotData = require("Game.Training.Data.TrainingSlotData")
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
TrainingNetworkCtrl.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.redDotTrainingGlobalExpRatio = (ConfigData.game_config).redDotTrainingGlobalExpRatio
end

TrainingNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_TRAINING_Detail, self, proto_csmsg.SC_TRAINING_Detail, self.__OnRecvTrainingDetail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_TRAINING_SlotHero, self, proto_csmsg.SC_TRAINING_SlotHero, self.__OnRecvSlotHero)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_TRAINING_Settle, self, proto_csmsg.SC_TRAINING_Settle, self.__OnRecvTrainingSettle)
end

TrainingNetworkCtrl.__UpdateSlotData = function(self, data)
  -- function num : 0_2 , upvalues : _ENV
  local index = data.idx
  local slotData = (PlayerDataCenter.trainingSlotDatas)[index]
  if slotData ~= nil then
    slotData:UpdateTrainingData(data)
  else
    error("Training slot index is null, index = " .. tostring(index))
  end
end

TrainingNetworkCtrl.SendTrainingDetail = function(self)
  -- function num : 0_3 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_TRAINING_Detail, proto_csmsg.CS_TRAINING_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartOrAddWait(proto_csmsg_MSG_ID.MSG_CS_TRAINING_Detail, proto_csmsg_MSG_ID.MSG_SC_TRAINING_Detail)
end

TrainingNetworkCtrl.__OnRecvTrainingDetail = function(self, msg)
  -- function num : 0_4 , upvalues : _ENV
  for k,v in pairs((msg.detail).data) do
    self:__UpdateSlotData(v)
  end
  self:InitRedDotTraining()
end

TrainingNetworkCtrl.SendSlotHero = function(self, heroId, slotIndex, effectType)
  -- function num : 0_5 , upvalues : _ENV
  local tabMsg = {heroId = heroId, slotIdx = slotIndex, effType = effectType}
  self.__slotIndex = slotIndex
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_TRAINING_SlotHero, proto_csmsg.CS_TRAINING_SlotHero, tabMsg)
end

TrainingNetworkCtrl.__OnRecvSlotHero = function(self, msg)
  -- function num : 0_6 , upvalues : _ENV, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    for k,v in pairs((msg.detail).data) do
      self:__UpdateSlotData(v)
    end
    local window = UIManager:GetWindow(UIWindowTypeID.Training)
    if window ~= nil then
      window:UpdateTrainingUI()
      window:OnSlotHeroComplete(self.__slotIndex)
    end
    self.__slotIndex = nil
    self:UpdateRedDotEmptySlot()
  else
    do
      local err = "TrainingNetworkCtrl:__OnRecvSlotHero error:" .. tostring(msg.ret)
      error(err)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
    end
  end
end

TrainingNetworkCtrl.SendTrainingSettle = function(self, slotIndex)
  -- function num : 0_7 , upvalues : _ENV
  local tabMsg = {slotIdx = slotIndex}
  self.__slotIndex = slotIndex
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_TRAINING_Settle, proto_csmsg.CS_TRAINING_Settle, tabMsg)
end

TrainingNetworkCtrl.__OnRecvTrainingSettle = function(self, msg)
  -- function num : 0_8 , upvalues : _ENV, cs_MessageCommon
  if msg.ret == proto_csmsg_ErrorCode.None then
    for k,v in pairs((msg.detail).data) do
      self:__UpdateSlotData(v)
    end
    ;
    ((PlayerDataCenter.trainingSlotDatas)[self.__slotIndex]):Empty()
    local window = UIManager:GetWindow(UIWindowTypeID.Training)
    if window ~= nil then
      window:UpdateTrainingUI()
      window:OnSlotSettleComplete(self.__slotIndex)
    end
    self.__slotIndex = nil
    self:UpdateRedDotEmptySlot()
    self:UpdateRedDotCompleteSlot()
  else
    do
      local err = "TrainingNetworkCtrl:__OnRecvTrainingSettle error:" .. tostring(msg.ret)
      error(err)
      if isGameDev then
        (cs_MessageCommon.ShowMessageTips)(err)
      end
    end
  end
end

TrainingNetworkCtrl.InitRedDotTraining = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local globalExp = PlayerDataCenter:GetItemCount((ConfigData.game_config).globalExpItemId)
  local globalExpCeiling = (PlayerDataCenter.playerBonus):GetGlobalExpCeiling()
  local globalExpOk = self.redDotTrainingGlobalExpRatio < globalExp / globalExpCeiling
  local emptySlotCount = 0
  local trainingCompleteCount = 0
  for k,v in ipairs(PlayerDataCenter.trainingSlotDatas) do
    local unlock = v:CheckUnlock()
    if unlock and v.heroId == nil and globalExpOk then
      emptySlotCount = emptySlotCount + 1
    elseif unlock and v.heroId ~= nil then
      local duration, remainSecond, progress = v:UpdateProgress(PlayerDataCenter.timestamp)
      if progress >= 1 then
        trainingCompleteCount = trainingCompleteCount + 1
      end
    end
  end
  local emptySlotNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.EmptyTrainingSlotPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Training, RedDotStaticTypeId.EmptyTrainingSlot)
  emptySlotNode:SetRedDotCount(emptySlotCount)
  local completeNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.TrainingCompletePath, RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Training, RedDotStaticTypeId.TrainingComplete)
  completeNode:SetRedDotCount(trainingCompleteCount)
  self:StartTrainingRedDotTimer()
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

TrainingNetworkCtrl.UpdateRedDotEmptySlot = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Training, RedDotStaticTypeId.EmptyTrainingSlot)
  if not ok then
    return 
  end
  local globalExp = PlayerDataCenter:GetItemCount((ConfigData.game_config).globalExpItemId)
  local globalExpCeiling = (PlayerDataCenter.playerBonus):GetGlobalExpCeiling()
  local globalExpOk = self.redDotTrainingGlobalExpRatio < globalExp / globalExpCeiling
  local emptySlotCount = 0
  for k,v in ipairs(PlayerDataCenter.trainingSlotDatas) do
    local unlock = v:CheckUnlock()
    if unlock and v.heroId == nil and globalExpOk then
      emptySlotCount = emptySlotCount + 1
    end
  end
  node:SetRedDotCount(emptySlotCount)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

TrainingNetworkCtrl.UpdateRedDotCompleteSlot = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Training, RedDotStaticTypeId.TrainingComplete)
  if not ok then
    return 
  end
  local trainingCompleteCount = 0
  for k,v in ipairs(PlayerDataCenter.trainingSlotDatas) do
    local unlock = v:CheckUnlock()
    if unlock and v.heroId ~= nil then
      local duration, remainSecond, progress = v:UpdateProgress(PlayerDataCenter.timestamp)
      if progress >= 1 then
        trainingCompleteCount = trainingCompleteCount + 1
      end
    end
  end
  node:SetRedDotCount(trainingCompleteCount)
end

TrainingNetworkCtrl.StartTrainingRedDotTimer = function(self)
  -- function num : 0_12 , upvalues : _ENV
  self.redDotTimer = (TimerManager:GetTimer(60, (BindCallback(self, self.UpdateRedDotCompleteSlot)), nil, false, false, true)):Start()
end

TrainingNetworkCtrl.StopTrainingRedDotTimer = function(self)
  -- function num : 0_13
  if self.redDotTimer ~= nil then
    (self.redDotTimer):Stop()
    self.redDotTimer = nil
  end
end

TrainingNetworkCtrl.Reset = function(self)
  -- function num : 0_14 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  PlayerDataCenter.trainingSlotDatas = {}
  self:StopTrainingRedDotTimer()
end

return TrainingNetworkCtrl

