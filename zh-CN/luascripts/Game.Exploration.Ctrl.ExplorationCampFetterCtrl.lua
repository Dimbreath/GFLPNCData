-- params : ...
-- function num : 0 , upvalues : _ENV
local ExplorationCampFetterCtrl = class("ExplorationCampFetterCtrl", ExplorationCtrlBase)
local cs_MessageCommon = CS.MessageCommon
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local REFRESH_CHIP_UID = 4294967300
local CDType2TipDic = {[(ExplorationEnum.eCampFetterCDType).totalEp] = function()
  -- function num : 0_0 , upvalues : _ENV
  return ConfigData:GetTipContent(TipContent.CampFetter_ActiveCD1)
end
, [(ExplorationEnum.eCampFetterCDType).nextFoor] = function(dynCampFetter)
  -- function num : 0_1 , upvalues : _ENV
  local _, CD = dynCampFetter:GetActiveFetterSkillCD()
  return (string.format)(ConfigData:GetTipContent(TipContent.CampFetter_ActiveCD2), tostring(CD))
end
, [(ExplorationEnum.eCampFetterCDType).afterBattle] = function(dynCampFetter)
  -- function num : 0_2 , upvalues : _ENV
  local _, CD = dynCampFetter:GetActiveFetterSkillCD()
  return (string.format)(ConfigData:GetTipContent(TipContent.CampFetter_ActiveCD3), tostring(CD))
end
, [(ExplorationEnum.eCampFetterCDType).afterMoveRoom] = function(dynCampFetter)
  -- function num : 0_3 , upvalues : _ENV
  local _, CD = dynCampFetter:GetActiveFetterSkillCD()
  return (string.format)(ConfigData:GetTipContent(TipContent.CampFetter_ActiveCD4), tostring(CD))
end
}
ExplorationCampFetterCtrl.ctor = function(self, epCtrl)
  -- function num : 0_4 , upvalues : ExplorationEnum, _ENV
  local eCampFetterActiveSkillType = ExplorationEnum.eCampFetterActiveSkillType
  self.explorationNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self.epCtrl = epCtrl
  self.dynPlayer = (self.epCtrl).dynPlayer
  self.__buffIds = nil
  self.isHaveActive = nil
  self.activeDynCampFetter = nil
  self.activeShowConditionList = nil
  self.usingCampFetterList = nil
  self.couldUpdateDic = {}
  self.couldShowAciveFetter = true
  self:InItCampFetterCtrlData()
  self.__onEpOpStateChanged = BindCallback(self, self.__OnEpOpStateChanged)
  MsgCenter:AddListener(eMsgEventId.OnEpOpStateChanged, self.__onEpOpStateChanged)
  self.__onBuffChange = BindCallback(self, self.OnBuffChange)
  MsgCenter:AddListener(eMsgEventId.OnEpBuffListChange, self.__onBuffChange)
end

ExplorationCampFetterCtrl.IsHaveCampFetter = function(self)
  -- function num : 0_5
  local usingCampFetterList, totalUsingNum = self:GetUsingCampFetterList()
  do return totalUsingNum > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ExplorationCampFetterCtrl.IsHaveActiveCampFetter = function(self)
  -- function num : 0_6
  return self.isHaveActive
end

ExplorationCampFetterCtrl.InItCampFetterCtrlData = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local isCampFetterUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_CampConnection)
  if not isCampFetterUnlock then
    return 
  end
  self.activeDynCampFetter = self:GetActiveDynCampFetter()
  self.isHaveActive = self.activeDynCampFetter ~= nil
  self:ConfigIsNeedUpdate()
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ExplorationCampFetterCtrl.ConfigIsNeedUpdate = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local couldGen = self:__GenActiveShowConditionList()
  if not couldGen then
    return 
  end
  for _,condition in pairs(self.activeShowConditionList) do
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R7 in 'UnsetPending'

    (self.couldUpdateDic)[condition] = true
  end
end

ExplorationCampFetterCtrl.GetUsingCampFetterList = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self.usingCampFetterList ~= nil then
    return self.usingCampFetterList, self.totalUsingNum
  end
  local totalUsingNum = 0
  local usingCampFetterList = {}
  for campId,dynCampFetter in pairs((self.dynPlayer).campFetterDic) do
    local campFetterList, usingNum = dynCampFetter:GetAllCampFetter()
    local campHeroCount = dynCampFetter:GetCampHeroNum()
    ;
    (table.insert)(usingCampFetterList, {campFetterList = campFetterList, campId = campId, campHeroCount = campHeroCount})
    totalUsingNum = totalUsingNum + usingNum
  end
  ;
  (table.sort)(usingCampFetterList, function(a, b)
    -- function num : 0_9_0
    do return a.campId < b.campId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  self.usingCampFetterList = usingCampFetterList
  self.totalUsingNum = totalUsingNum
  return usingCampFetterList, totalUsingNum
end

ExplorationCampFetterCtrl.GetActiveDynCampFetter = function(self)
  -- function num : 0_10
  if (self.dynPlayer).activeCampFetterId ~= nil then
    return ((self.dynPlayer).campFetterDic)[(self.dynPlayer).activeCampFetterId]
  end
end

ExplorationCampFetterCtrl.UseActiveFetterSkill = function(self, uid, callback)
  -- function num : 0_11
  if self.activeDynCampFetter == nil then
    return false
  end
  if (self.activeDynCampFetter):GetCouldeUseActiveFetterSkill() then
    (self.explorationNetworkCtrl):CS_EXPLORATION_CAMP_FETTER_USE(uid, callback)
    return true
  else
    return false
  end
end

ExplorationCampFetterCtrl.__GenActiveShowConditionList = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if self.activeShowConditionList == nil then
    if self.activeDynCampFetter == nil then
      return false
    end
    local camp_active_skillId = (self.activeDynCampFetter):GetActiveFetterSkillID()
    if camp_active_skillId == nil then
      return false
    end
    local camp_active_skillCfg = (ConfigData.camp_active_skill)[camp_active_skillId]
    if camp_active_skillCfg ~= nil then
      self.activeShowConditionList = camp_active_skillCfg.use_limit
    else
      return false
    end
  end
  do
    return true
  end
end

ExplorationCampFetterCtrl.CouldShowActiveFetterSkill = function(self, eCampFetterUsableConditon)
  -- function num : 0_13 , upvalues : _ENV, ExplorationEnum
  if not self.couldShowAciveFetter then
    return false
  end
  local couldGen = self:__GenActiveShowConditionList()
  if not couldGen then
    return false
  end
  for _,condition in ipairs(self.activeShowConditionList) do
    if condition == eCampFetterUsableConditon then
      return true
    else
      if condition == (ExplorationEnum.eCampFetterUsableConditon).epCouldSelectNextRoom and eCampFetterUsableConditon == (ExplorationEnum.eCampFetterUsableConditon).ep then
        return nil
      end
    end
  end
  return false
end

ExplorationCampFetterCtrl.__OnEpOpStateChanged = function(self, opDetail, state)
  -- function num : 0_14 , upvalues : _ENV
  if opDetail ~= nil then
    state = opDetail.state
  end
  if state == proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
    self:OnEpCouldeSelectNextRoom()
  else
    self:OnEpCouldeSelectNextRoom(true)
  end
end

ExplorationCampFetterCtrl.OnEpBack2Ep = function(self)
  -- function num : 0_15 , upvalues : ExplorationEnum, _ENV, CDType2TipDic
  self:__TryForceSetAllRoomCouldSelect()
  if not (self.couldUpdateDic)[(ExplorationEnum.eCampFetterUsableConditon).ep] then
    return 
  end
  local stateInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if stateInfoWin == nil then
    return 
  end
  local epCampFetterNode = stateInfoWin:GetEpCampFetterNode()
  local couldShow = self:CouldShowActiveFetterSkill((ExplorationEnum.eCampFetterUsableConditon).ep)
  if couldShow == nil then
    return 
  end
  epCampFetterNode:SetHasEpActiveCampFetter(couldShow)
  if not couldShow then
    return 
  end
  local uid, campId, heroNum = (self.activeDynCampFetter):GetActiveFetterUID()
  local RefreshCouldUse = function()
    -- function num : 0_15_0 , upvalues : self, CDType2TipDic, epCampFetterNode, campId, heroNum
    local CDType = (self.activeDynCampFetter):GetActiceFetterCDType()
    local cdStr = (CDType2TipDic[CDType])(self.activeDynCampFetter)
    local couldUse = (self.activeDynCampFetter):GetCouldeUseActiveFetterSkill()
    epCampFetterNode:SetActiveCampFetter(campId, heroNum, couldUse, cdStr)
  end

  RefreshCouldUse()
  epCampFetterNode:SetClickActiveCampFetter(function()
    -- function num : 0_15_1 , upvalues : self, uid, RefreshCouldUse
    if (self.activeDynCampFetter):GetCouldeUseActiveFetterSkill() then
      self:ConfirmBeforeUseActive((self.activeDynCampFetter):GetActiveFetterDes(), function()
      -- function num : 0_15_1_0 , upvalues : self, uid, RefreshCouldUse
      self:UseActiveFetterSkill(uid, function()
        -- function num : 0_15_1_0_0 , upvalues : self, RefreshCouldUse
        self:__TryForceSetAllRoomCouldSelect()
        RefreshCouldUse()
      end
)
    end
)
    else
      RefreshCouldUse()
    end
  end
)
end

ExplorationCampFetterCtrl.OnEpSelectChip = function(self)
  -- function num : 0_16 , upvalues : _ENV, REFRESH_CHIP_UID, ExplorationEnum, CDType2TipDic
  local selectChipWindow = UIManager:GetWindow(UIWindowTypeID.SelectChip)
  if selectChipWindow == nil then
    return 
  end
  local campFetter = ((self.dynPlayer).campFetterDic)[REFRESH_CHIP_UID >> 32]
  if campFetter ~= nil then
    local RefreshChipRefresh = function()
    -- function num : 0_16_0 , upvalues : campFetter, REFRESH_CHIP_UID, selectChipWindow
    local couldShowRefreshChip = campFetter:GetCouldeUseActiveFetterSkill(REFRESH_CHIP_UID)
    local cdValue = campFetter:GetActiveFetterSkillCD(REFRESH_CHIP_UID)
    if not cdValue then
      selectChipWindow:UpdateRefreshCount(false, 0)
    else
      local remaindRefreshValue = 1 - cdValue
      selectChipWindow:UpdateRefreshCount(couldShowRefreshChip, remaindRefreshValue)
    end
  end

    do
      RefreshChipRefresh()
      selectChipWindow:SetClickRefreshCallback(function()
    -- function num : 0_16_1 , upvalues : self, REFRESH_CHIP_UID, selectChipWindow, RefreshChipRefresh
    (self.explorationNetworkCtrl):CS_EXPLORATION_CAMP_FETTER_USE(REFRESH_CHIP_UID, function()
      -- function num : 0_16_1_0 , upvalues : selectChipWindow, self, RefreshChipRefresh
      selectChipWindow:RefreshChipList(((self.epCtrl):GetCurrentRoomData()):GetRewardChipList())
      RefreshChipRefresh()
    end
)
  end
)
    end
  else
    do
      selectChipWindow:UpdateRefreshCount(false, 0)
      if not (self.couldUpdateDic)[(ExplorationEnum.eCampFetterUsableConditon).epChipSelect] then
        return 
      end
      local couldShow = self:CouldShowActiveFetterSkill((ExplorationEnum.eCampFetterUsableConditon).epChipSelect)
      selectChipWindow:SetHasEpActiveCampFetter(couldShow)
      if not couldShow then
        return 
      end
      local uid, campId, heroNum = (self.activeDynCampFetter):GetActiveFetterUID()
      local RefreshCouldUse = function()
    -- function num : 0_16_2 , upvalues : self, CDType2TipDic, selectChipWindow, campId, heroNum
    local CDType = (self.activeDynCampFetter):GetActiceFetterCDType()
    local cdStr = (CDType2TipDic[CDType])(self.activeDynCampFetter)
    local couldUse = (self.activeDynCampFetter):GetCouldeUseActiveFetterSkill()
    selectChipWindow:SetActiveCampFetter(campId, heroNum, couldUse, cdStr)
  end

      RefreshCouldUse()
      selectChipWindow:SetClickActiveCampFetter(function()
    -- function num : 0_16_3 , upvalues : self, uid, selectChipWindow, RefreshCouldUse
    if (self.activeDynCampFetter):GetCouldeUseActiveFetterSkill() then
      self:ConfirmBeforeUseActive((self.activeDynCampFetter):GetActiveFetterDes(), function()
      -- function num : 0_16_3_0 , upvalues : self, uid, selectChipWindow, RefreshCouldUse
      self:UseActiveFetterSkill(uid, function()
        -- function num : 0_16_3_0_0 , upvalues : selectChipWindow, self, RefreshCouldUse
        selectChipWindow:RefreshChipList(((self.epCtrl):GetCurrentRoomData()):GetRewardChipList())
        RefreshCouldUse()
      end
)
    end
)
    else
      RefreshCouldUse()
    end
  end
)
    end
  end
end

ExplorationCampFetterCtrl.OnEpBattleDeploy = function(self)
  -- function num : 0_17 , upvalues : ExplorationEnum, _ENV, CDType2TipDic
  if not (self.couldUpdateDic)[(ExplorationEnum.eCampFetterUsableConditon).epBattleDeploy] then
    return 
  end
  local battleWin = UIManager:GetWindow(UIWindowTypeID.Battle)
  if battleWin == nil then
    return 
  end
  local couldShow = self:CouldShowActiveFetterSkill((ExplorationEnum.eCampFetterUsableConditon).epBattleDeploy)
  battleWin:SetHasBattleActiveCampFetter(couldShow)
  if not couldShow then
    return 
  end
  local uid, campId, heroNum = (self.activeDynCampFetter):GetActiveFetterUID()
  local RefreshCouldUse = function()
    -- function num : 0_17_0 , upvalues : self, CDType2TipDic, battleWin, campId, heroNum
    local CDType = (self.activeDynCampFetter):GetActiceFetterCDType()
    local cdStr = (CDType2TipDic[CDType])(self.activeDynCampFetter)
    local couldUse = (self.activeDynCampFetter):GetCouldeUseActiveFetterSkill()
    battleWin:SetCampFetter(campId, heroNum, couldUse, cdStr)
  end

  RefreshCouldUse()
  battleWin:SetClickCampFetter(function()
    -- function num : 0_17_1 , upvalues : self, uid, RefreshCouldUse
    if (self.activeDynCampFetter):GetCouldeUseActiveFetterSkill() then
      self:ConfirmBeforeUseActive((self.activeDynCampFetter):GetActiveFetterDes(), function()
      -- function num : 0_17_1_0 , upvalues : self, uid, RefreshCouldUse
      self:UseActiveFetterSkill(uid, function()
        -- function num : 0_17_1_0_0 , upvalues : RefreshCouldUse
        RefreshCouldUse()
      end
)
    end
)
    else
      RefreshCouldUse()
    end
  end
)
end

ExplorationCampFetterCtrl.OnEpCouldeSelectNextRoom = function(self, isExitThisConditon)
  -- function num : 0_18 , upvalues : ExplorationEnum, _ENV, CDType2TipDic
  if not (self.couldUpdateDic)[(ExplorationEnum.eCampFetterUsableConditon).epCouldSelectNextRoom] then
    return 
  end
  local stateInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if stateInfoWin == nil then
    return 
  end
  local epCampFetterNode = stateInfoWin:GetEpCampFetterNode()
  if self:CouldShowActiveFetterSkill((ExplorationEnum.eCampFetterUsableConditon).epCouldSelectNextRoom) then
    local couldShow = not isExitThisConditon
  end
  epCampFetterNode:SetHasEpActiveCampFetter(couldShow)
  if not couldShow then
    return 
  end
  local uid, campId, heroNum = (self.activeDynCampFetter):GetActiveFetterUID()
  local Refresh = function(cdStr)
    -- function num : 0_18_0 , upvalues : self, CDType2TipDic, epCampFetterNode, campId, heroNum
    local CDType = (self.activeDynCampFetter):GetActiceFetterCDType()
    local cdStr = (CDType2TipDic[CDType])(self.activeDynCampFetter)
    local couldUse = (self.activeDynCampFetter):GetCouldeUseActiveFetterSkill()
    epCampFetterNode:SetActiveCampFetter(campId, heroNum, couldUse, cdStr)
  end

  Refresh()
  epCampFetterNode:SetClickActiveCampFetter(function()
    -- function num : 0_18_1 , upvalues : self, uid, Refresh
    if (self.activeDynCampFetter):GetCouldeUseActiveFetterSkill() then
      self:ConfirmBeforeUseActive((self.activeDynCampFetter):GetActiveFetterDes(), function()
      -- function num : 0_18_1_0 , upvalues : self, uid, Refresh
      self:UseActiveFetterSkill(uid, function()
        -- function num : 0_18_1_0_0 , upvalues : self, Refresh
        self:__TryForceSetAllRoomCouldSelect()
        Refresh()
      end
)
    end
)
    else
      Refresh()
    end
  end
)
end

ExplorationCampFetterCtrl.__TryForceSetAllRoomCouldSelect = function(self)
  -- function num : 0_19 , upvalues : ExplorationEnum, _ENV
  if (self.dynPlayer):IsHaveSpecificTypeBuff((ExplorationEnum.eBuffLogicId).freeSelectRoom) then
    local currentRoom = (self.epCtrl):GetCurrentRoomData()
    local allNetRoomDataList = currentRoom:GetNextAllRoom()
    for _,dynEpRoomData in pairs(allNetRoomDataList) do
      local roomPos = dynEpRoomData:GetRoomPosition()
      local roomUI = (self.epCtrl):GetRoomUI(roomPos)
      roomUI:SetIsFreeSelect(true)
      roomUI:ForceChangeRoomState2AbleChoose()
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R10 in 'UnsetPending'

      ;
      (((self.epCtrl).mapCtrl).roomStateDic)[roomPos] = (ExplorationEnum.eRoomTypeState).AbleChoose
    end
  end
end

ExplorationCampFetterCtrl.OnBuffChange = function(self, buffList)
  -- function num : 0_20
  self:OnOpenStore()
end

ExplorationCampFetterCtrl.OnOpenStore = function(self)
  -- function num : 0_21
  self:__ChangeStoreLeonMoneyState()
end

ExplorationCampFetterCtrl.__ChangeStoreLeonMoneyState = function(self)
  -- function num : 0_22 , upvalues : _ENV, ExplorationEnum
  local stateInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if stateInfoWin == nil then
    return 
  end
  local bool, logic_num, logic_per = (self.dynPlayer):IsHaveSpecificTypeBuff((ExplorationEnum.eBuffLogicId).couldLeonMoney)
  local storeWin = UIManager:GetWindow(UIWindowTypeID.EpStoreRoom)
  bool = not bool or storeWin ~= nil
  do
    -- DECOMPILER ERROR at PC29: Unhandled construct in 'MakeBoolean' P1

    if bool and logic_num ~= nil then
      local couldLeonMoney = logic_num[1]
      self:SetCouldLeonMoney(couldLeonMoney)
      stateInfoWin:SetLoanMoneyActive(bool, couldLeonMoney)
      storeWin:RefreshSelectItemDetail()
    end
    self:SetCouldLeonMoney(0)
    stateInfoWin:SetLoanMoneyActive(false)
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

ExplorationCampFetterCtrl.SetCouldLeonMoney = function(self, value)
  -- function num : 0_23
  self.couldLeonMoney = value or 0
end

ExplorationCampFetterCtrl.GetCouldLeonMoney = function(self)
  -- function num : 0_24
  return self.couldLeonMoney or 0
end

ExplorationCampFetterCtrl.ConfirmBeforeUseActive = function(self, msg, yesFunc, noFunc)
  -- function num : 0_25 , upvalues : _ENV
  local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
  window:ShowTextBoxWithYesAndNo(msg, yesFunc, noFunc)
end

ExplorationCampFetterCtrl.SetAllActiveFetterVisible = function(self, bool)
  -- function num : 0_26
  self.couldShowAciveFetter = bool
  self:OnEpBack2Ep()
  self:OnEpSelectChip()
  self:OnEpBattleDeploy()
  self:OnEpCouldeSelectNextRoom()
  self:OnOpenStore()
end

ExplorationCampFetterCtrl.OnDelete = function(self)
  -- function num : 0_27 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.OnEpOpStateChanged, self.__onEpOpStateChanged)
  MsgCenter:RemoveListener(eMsgEventId.OnEpBuffListChange, self.__onBuffChange)
end

return ExplorationCampFetterCtrl

