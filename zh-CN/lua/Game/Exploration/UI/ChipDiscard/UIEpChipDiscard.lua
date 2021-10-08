local UIEpChipDiscard = class("UIEpChipDiscard", UIBaseWindow)
local base = UIBaseWindow
local UINEpChipDiscardItem = require("Game.Exploration.UI.ChipDiscard.UINEpChipDiscardItem")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINEpChipDetail")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
UIEpChipDiscard.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipDetailPanel
  self.explorationNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self.chipItemDic = {}
  self.chipDataList = {}
  self.isOverLimit = true
  self.costItemNum = 0
  self.costItemId = ConstGlobalItem.EpMoney
  self.resloader = ((CS.ResLoader).Create)()
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Map, self, self.OnStoreMapClicked)
  self._onDiscardChip = BindCallback(self, self.DiscardChip)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_AddTotalCount, self, self.AddChipLimit)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Skip, self, self.CloseEpDiscard)
  self.__FromMapBackToUI = BindCallback(self, self.FromMapBackToUI)
  MsgCenter:AddListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
  self.__onChipListChange = BindCallback(self, self.OnChipListChange, false)
  MsgCenter:AddListener(eMsgEventId.OnEpChipListChange, self.__onChipListChange)
  self.__OnChipLimitChange = BindCallback(self, self.OnChipLimitChange)
  MsgCenter:AddListener(eMsgEventId.OnChipLimitChange, self.__OnChipLimitChange)
  self._OnClick = BindCallback(self, self.OnClick)
  -- DECOMPILER ERROR at PC91: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).chipLoopList).onInstantiateItem = BindCallback(self, self.m_OnNewItem)
  -- DECOMPILER ERROR at PC98: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).chipLoopList).onChangeItem = BindCallback(self, self.m_OnChangeItem)
  self.chipDetailPanel = (UINChipDetailPanel.New)()
  ;
  (self.chipDetailPanel):Init((self.ui).uINChipItemDetail)
  self.__OnChipDetailActiveChange = BindCallback(self, self.OnChipDetailActiveChange)
  MsgCenter:AddListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
end

UIEpChipDiscard.OnShow = function(self)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.OnShow)(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, false)
  ;
  (self.transform):SetAsFirstSibling()
end

UIEpChipDiscard.OnHide = function(self)
  -- function num : 0_2 , upvalues : base, _ENV
  (base.OnHide)(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, true)
end

UIEpChipDiscard.InitEpChipDiscard = function(self, dynPlayer, closeCallback)
  -- function num : 0_3 , upvalues : _ENV
  (((self.ui).btn_Map).gameObject):SetActive(ExplorationManager:HasRoomSceneInEp())
  self.dynPlayer = dynPlayer
  self.closeCallback = closeCallback
  self.discardId = (self.dynPlayer):GetChipDiscardId()
  local opDetail = (self.dynPlayer):GetOperatorDetail()
  self.position = opDetail.curPostion
  self:OnChipListChange(true)
  self.__mapActiveState = false
  self:m_SwitchMapBtnState(self.__mapActiveState)
end

UIEpChipDiscard.OnChipListChange = function(self, isFirstOpen)
  -- function num : 0_4 , upvalues : _ENV
  self:RefreshExitSituation()
  self:RefreshLoopList()
  self:RefreshAddLimit()
  MsgCenter:Broadcast(eMsgEventId.OnChipDiscardChanged, isFirstOpen)
end

UIEpChipDiscard.OnChipLimitChange = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self:RefreshExitSituation()
  self:RefreshAddLimit()
  MsgCenter:Broadcast(eMsgEventId.OnChipDiscardChanged, false)
end

UIEpChipDiscard.RefreshExitSituation = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local nowCount, nowLimit = nil, nil
  self.isOverLimit = (self.dynPlayer):IsChipOverLimitNum()
  ;
  ((self.ui).needDiscard):SetActive(self.isOverLimit)
  if self.isOverLimit then
    local needDrop = nowCount - nowLimit
    ;
    ((self.ui).tex_NeedDiscard):SetIndex(0, tostring(needDrop))
  end
end

UIEpChipDiscard.RefreshLoopList = function(self)
  -- function num : 0_7 , upvalues : _ENV
  self.chipDataList = {}
  for chipId,chipData in pairs((self.dynPlayer):GetNormalChipDic()) do
    if not chipData:IsConsumeSkillChip() then
      (table.insert)(self.chipDataList, chipData)
    end
  end
  local num = #self.chipDataList
  if num > 0 then
    (self.chipDetailPanel):Show()
  else
    if self.isOverLimit then
      (self.chipDetailPanel):Hide()
    end
  end
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).chipLoopList).totalCount = num
  ;
  ((self.ui).chipLoopList):RefillCells()
end

UIEpChipDiscard.RefreshAddLimit = function(self)
  -- function num : 0_8 , upvalues : _ENV
  self.costItemId = (self.dynPlayer):GetChipUpgradeLimitPrice()
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Money).text = tostring(self.costItemNum)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_Money).sprite = CRH:GetSpriteByItemId(self.costItemId)
end

UIEpChipDiscard.m_OnNewItem = function(self, go)
  -- function num : 0_9 , upvalues : UINEpChipDiscardItem
  local ChipDiscardItem = (UINEpChipDiscardItem.New)()
  ChipDiscardItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.chipItemDic)[go] = ChipDiscardItem
end

UIEpChipDiscard.m_OnChangeItem = function(self, go, index)
  -- function num : 0_10 , upvalues : _ENV
  local ChipDiscardItem = (self.chipItemDic)[go]
  if ChipDiscardItem == nil then
    error("Can\'t find levelItem by gameObject")
    return 
  end
  local chipData = (self.chipDataList)[index + 1]
  if chipData == nil then
    error("Can\'t find levelData by index, index = " .. tonumber(index))
  end
  ChipDiscardItem:InitDiscardChipItem(self.discardId, chipData, self._OnClick, self.dynPlayer)
  ChipDiscardItem:SetItemSelect(self.selectedData == chipData)
  if self.selectedData == nil and index == 0 then
    self:OnClick(ChipDiscardItem)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIEpChipDiscard.m_GetItemByData = function(self, chipData)
  -- function num : 0_11 , upvalues : _ENV
  for k,v in ipairs(self.chipDataList) do
    if v == chipData then
      local index = k - 1
      return self:m_GetItemGoByIndex(index)
    end
  end
end

UIEpChipDiscard.m_GetItemGoByIndex = function(self, index)
  -- function num : 0_12
  local go = ((self.ui).chipLoopList):GetCellByIndex(index)
  do
    if go ~= nil then
      local ChipDiscardItem = (self.chipItemDic)[go]
      return ChipDiscardItem
    end
    return nil
  end
end

UIEpChipDiscard.OnClick = function(self, ChipDiscardItem)
  -- function num : 0_13 , upvalues : _ENV
  if ChipDiscardItem == nil then
    return 
  end
  do
    if self.selectedData ~= nil and self.selectedData ~= ChipDiscardItem.chipData then
      local lastItem = self:m_GetItemByData(self.selectedData)
      if lastItem ~= nil then
        lastItem:SetItemSelect(false)
      end
    end
    self.selectedData = ChipDiscardItem.chipData
    self.selectChipPrice = ChipDiscardItem.price
    ChipDiscardItem:SetItemSelect(true)
    ;
    (self.chipDetailPanel):Show()
    ;
    (self.chipDetailPanel):InitEpChipDetail(nil, ChipDiscardItem.chipData, self.dynPlayer, self.resloader, true, eChipDetailPowerType.Subtract, true)
    ;
    (self.chipDetailPanel):ShowHeroHeadOrTacticActive(true)
    local sprite, numStr = ChipDiscardItem:GetEpChipDiscardItemMoneyIconSpriteNum()
    ;
    ((self.chipDetailPanel):GetDetailButtonGroup()):InitBtnSelByCost(false, numStr, self._onDiscardChip, sprite)
  end
end

UIEpChipDiscard.DiscardChip = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if self.selectedData == nil then
    return 
  end
  if not self.isOverLimit then
    ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(260))
    return 
  end
  ;
  ((CS.MessageCommon).ShowMessageBox)((string.format)(ConfigData:GetTipContent(287), (self.selectedData):GetName(), tostring(self.selectChipPrice)), function()
    -- function num : 0_14_0 , upvalues : self
    self:StartDiscardChip(self.selectedData)
  end
, nil)
end

UIEpChipDiscard.StartDiscardChip = function(self, chipData)
  -- function num : 0_15 , upvalues : _ENV
  (self.explorationNetworkCtrl):CS_EXPLORATION_AlgUpperLimit_Sold(self.position, chipData.dataId, function()
    -- function num : 0_15_0 , upvalues : _ENV
    AudioManager:PlayAudioById(1040)
  end
)
  self.selectedData = nil
end

UIEpChipDiscard.AddChipLimit = function(self)
  -- function num : 0_16 , upvalues : _ENV
  local currentItemNum = (self.dynPlayer):GetItemCount(self.costItemId)
  if self.costItemNum <= currentItemNum then
    (self.explorationNetworkCtrl):CS_EXPLORATION_AlgUpperLimit_PurchaseLimit(self.position)
  else
    ;
    ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(275))
    return 
  end
end

UIEpChipDiscard.OnStoreMapClicked = function(self)
  -- function num : 0_17
  self.__mapActiveState = not self.__mapActiveState
  self:m_SwitchMapBtnState(self.__mapActiveState)
end

UIEpChipDiscard.FromMapBackToUI = function(self)
  -- function num : 0_18
  self.__mapActiveState = false
  self:m_SwitchMapBtnState(self.__mapActiveState)
end

UIEpChipDiscard.m_SwitchMapBtnState = function(self, openMap)
  -- function num : 0_19 , upvalues : _ENV
  if openMap then
    ((self.ui).tex_MapBtnName):SetIndex(1)
  else
    ;
    ((self.ui).tex_MapBtnName):SetIndex(0)
  end
  ;
  ((self.ui).frameNode):SetActive(not openMap)
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, openMap)
end

UIEpChipDiscard.CloseEpDiscard = function(self)
  -- function num : 0_20 , upvalues : _ENV, ExplorationEnum
  if self.isOverLimit then
    return 
  end
  ;
  (self.explorationNetworkCtrl):CS_EXPLORATION_AlgUpperLimit_Exit(self.position, function()
    -- function num : 0_20_0 , upvalues : _ENV, ExplorationEnum, self
    MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, (ExplorationEnum.eExitRoomCompleteType).DiscardChip)
    if self.closeCallback ~= nil then
      (self.closeCallback)()
    end
    self:Delete()
  end
)
end

UIEpChipDiscard.OnChipDetailActiveChange = function(self, active)
  -- function num : 0_21
  if active then
    self:Hide()
  else
    self:Show()
  end
end

UIEpChipDiscard.OnDelete = function(self)
  -- function num : 0_22 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
  MsgCenter:RemoveListener(eMsgEventId.OnEpChipListChange, self.__onChipListChange)
  MsgCenter:RemoveListener(eMsgEventId.OnChipLimitChange, self.__OnChipLimitChange)
  MsgCenter:RemoveListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  ;
  (((self.ui).chipLoopList).gameObject):SetActive(false)
  for k,v in pairs(self.chipItemDic) do
    v:OnDelete()
  end
  ;
  (base.OnDelete)(self)
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
end

UIEpChipDiscard.OnDeleteEntity = function(self)
  -- function num : 0_23 , upvalues : base
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
    self.resLoader = nil
  end
  self.chipItemDic = nil
  ;
  (self.chipDetailPanel):Delete()
  ;
  (base.OnDeleteEntity)(self)
end

return UIEpChipDiscard

