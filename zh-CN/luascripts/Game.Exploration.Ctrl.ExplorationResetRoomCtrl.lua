-- params : ...
-- function num : 0 , upvalues : _ENV
local ExplorationResetRoomCtrl = class("ExplorationResetRoomCtrl", ExplorationCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
ExplorationResetRoomCtrl.ctor = function(self, epCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.netWork = NetworkManager:GetNetwork(NetworkTypeID.ResetRoom)
  self.epCtrl = epCtrl
  self.playerChipDatas = nil
  self.waitRefersh = false
  self.__onResetRoomUpdate = BindCallback(self, self.__OnResetRoomUpdate)
  MsgCenter:AddListener(eMsgEventId.OnResetRoomUpdate, self.__onResetRoomUpdate)
  self.__onChipListUpdate = BindCallback(self, self.__OnChipListUpdate)
  MsgCenter:AddListener(eMsgEventId.OnEpChipListChange, self.__onChipListUpdate)
  self.__onChipToHeroQuict = BindCallback(self, self.AddChipToHeroClose)
  self.__onChipToHeroConfirm = BindCallback(self, self.ChipToHeroConfirm)
end

ExplorationResetRoomCtrl.OnResetRoomOpen = function(self, roomData)
  -- function num : 0_1 , upvalues : _ENV
  if roomData.roomRecordList == nil then
    return 
  end
  self.currPosition = roomData.position
  self.dynPlayer = ExplorationManager:GetDynPlayer()
  if self.playerChipDatas == nil then
    self.playerChipDatas = (self.dynPlayer):GetChipList()
  end
  self.resetRoomDataList = {}
  for id,cfg in ipairs(ConfigData.exploration_reconsitution) do
    local resetRoomData = {}
    for i,time in ipairs(cfg.times) do
      local record = (roomData.roomRecordList)[id]
      if record == nil then
        record = 0
      end
      if record < time or time == -1 then
        resetRoomData.costId = cfg.costId
        resetRoomData.costNum = (cfg.costNums)[i]
        break
      end
    end
    do
      do
        ;
        (table.insert)(self.resetRoomDataList, resetRoomData)
        -- DECOMPILER ERROR at PC51: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  self.uiWindow = UIManager:ShowWindow(UIWindowTypeID.ResetRoom)
  if self.uiWindow ~= nil then
    (self.uiWindow):InitResetRoom(self, self.resetRoomDataList)
    ;
    (self.uiWindow):UpdateMoney((self.dynPlayer):GetMoneyCount())
  end
end

ExplorationResetRoomCtrl.SendInfomationOperation = function(self, btnInfo, selectChipItemList)
  -- function num : 0_2 , upvalues : ExplorationEnum, _ENV
  if btnInfo.currBtnId == (ExplorationEnum.eResetRoomType).Duplicate then
    self.uiHeroWindow = UIManager:ShowWindow(UIWindowTypeID.AddChipToHero)
    if self.uiHeroWindow ~= nil then
      (self.uiHeroWindow):InitAddChipToHero(self, (self.dynPlayer).heroList, (selectChipItemList[1]).chipData, self.__onChipToHeroQuict, self.__onChipToHeroConfirm)
    end
  else
    if btnInfo.currBtnId == (ExplorationEnum.eResetRoomType).Mix then
      (self.netWork):CS_EXPLORATION_RECONSTITUTION_Fusion(self.currPosition, selectChipItemList)
    else
      ;
      (self.netWork):CS_EXPLORATION_RECONSTITUTION_Reconstitution(self.currPosition, (selectChipItemList[1]).chipData)
    end
  end
  self.waitRefersh = true
end

ExplorationResetRoomCtrl.SendDuplicateOperation = function(self, chipData, heroId)
  -- function num : 0_3
  (self.netWork):CS_EXPLORATION_RECONSTITUTION_Reproduction(self.currPosition, chipData, heroId)
end

ExplorationResetRoomCtrl.SendResetRoomQuit = function(self)
  -- function num : 0_4
  (self.netWork):CS_EXPLORATION_RECONSTITUTION_Quit(self.currPosition)
end

ExplorationResetRoomCtrl.OnSendMsgSuccess = function(self, algId)
  -- function num : 0_5 , upvalues : cs_MessageCommon, _ENV
  if algId ~= nil then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.exploration_Reconstitution_AchieveChip) .. (LanguageUtil.GetLocaleText)(((ConfigData.item)[algId]).name))
  else
    ;
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.exploration_Reconstitution_ChipOperateSuccess))
  end
  if self.uiHeroWindow ~= nil then
    (self.uiHeroWindow):CloseAddChipToHero()
  end
end

ExplorationResetRoomCtrl.CloseResetRoom = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.uiWindow ~= nil then
    (self.uiWindow):CloseResetRoom(self, self.resetRoomDataList)
  end
  self.uiWindow = nil
  MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete)
end

ExplorationResetRoomCtrl.AddChipToHeroClose = function(self, uiWindow)
  -- function num : 0_7
  self.uiHeroWindow = uiWindow
  ;
  (self.uiHeroWindow):CloseAddChipToHero()
  self.uiHeroWindow = nil
  if self.uiWindow ~= nil then
    (self.uiWindow):InitResetRoom(self, self.resetRoomDataList)
  end
end

ExplorationResetRoomCtrl.ChipToHeroConfirm = function(self, uiWindow)
  -- function num : 0_8 , upvalues : cs_MessageCommon, _ENV
  self.uiHeroWindow = uiWindow
  if uiWindow.currHeroItem ~= nil then
    self:SendDuplicateOperation(uiWindow.currChipData, (uiWindow.currHeroItem).heroId)
  else
    ;
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.exploration_Reconstitution_SelectOneHero))
  end
end

ExplorationResetRoomCtrl.__OnResetRoomUpdate = function(self, roomData)
  -- function num : 0_9
  if self.waitRefersh and self.currPosition == roomData.position then
    self:OnResetRoomOpen(roomData)
    self.waitRefersh = false
  end
end

ExplorationResetRoomCtrl.__OnChipListUpdate = function(self, chipList)
  -- function num : 0_10
  self.playerChipDatas = chipList
end

ExplorationResetRoomCtrl.OnDelete = function(self)
  -- function num : 0_11 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.OnResetRoomUpdate, self.__onResetRoomUpdate)
  MsgCenter:RemoveListener(eMsgEventId.OnEpChipListChange, self.__onChipListUpdate)
  self.uiWindow = nil
  self.uiHeroWindow = nil
end

return ExplorationResetRoomCtrl

