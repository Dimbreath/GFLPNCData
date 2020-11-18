-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpChipDiscard = class("UIEpChipDiscard", UIBaseWindow)
local base = UIBaseWindow
local UINEpChipDiscardItem = require("Game.Exploration.UI.ChipDiscard.UINEpChipDiscardItem")
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINChipDetailPanel")
UIEpChipDiscard.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipDetailPanel
  self.explorationNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self.chipItemDic = {}
  self.chipDataList = {}
  self.isOverLimit = true
  self.costItemNum = 0
  self.costItemId = 1
  self.resloader = ((CS.ResLoader).Create)()
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Map, self, self.OnStoreMapClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Discard, self, self.DiscardChip)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_AddTotalCount, self, self.AddLimit)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Skip, self, self.Close)
  self.__FromMapBackToUI = BindCallback(self, self.FromMapBackToUI)
  MsgCenter:AddListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
  self.__onChipListChange = BindCallback(self, self.OnChipListChange)
  MsgCenter:AddListener(eMsgEventId.OnEpChipListChange, self.__onChipListChange)
  self.__OnChipLimitChange = BindCallback(self, self.OnChipLimitChange)
  MsgCenter:AddListener(eMsgEventId.OnChipLimitChange, self.__OnChipLimitChange)
  self._OnClick = BindCallback(self, self.OnClick)
  -- DECOMPILER ERROR at PC90: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).chipLoopList).onInstantiateItem = BindCallback(self, self.m_OnNewItem)
  -- DECOMPILER ERROR at PC97: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).chipLoopList).onChangeItem = BindCallback(self, self.m_OnChangeItem)
  self.chipDetailPanel = (UINChipDetailPanel.New)()
  ;
  (self.chipDetailPanel):Init((self.ui).uINChipItemDetail)
  ;
  (self.chipDetailPanel):SetChipEffectHeroNodeActive(true)
end

UIEpChipDiscard.InitEpChipDiscard = function(self, dynPlayer, closeCallback)
  -- function num : 0_1
  self.dynPlayer = dynPlayer
  self.closeCallback = closeCallback
  self.discardId = (self.dynPlayer):GetChipDiscardId()
  local opDetail = (self.dynPlayer):GetOperatorDetail()
  self.position = opDetail.curPostion
  self:OnChipListChange()
  self.__mapActiveState = false
  self:m_SwitchMapBtnState(self.__mapActiveState)
end

UIEpChipDiscard.OnChipListChange = function(self)
  -- function num : 0_2
  self:RefreshExitSituation()
  self:RefreshLoopList()
  self:RefreshAddLimit()
end

UIEpChipDiscard.OnChipLimitChange = function(self)
  -- function num : 0_3
  self:RefreshExitSituation()
  self:RefreshAddLimit()
end

UIEpChipDiscard.RefreshExitSituation = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local nowCount, nowLimit = nil, nil
  self.isOverLimit = (self.dynPlayer):IsChipOverLimitNum()
  ;
  ((self.ui).needDiscard):SetActive(self.isOverLimit)
  do
    if self.isOverLimit then
      local needDrop = nowCount - nowLimit
      ;
      ((self.ui).tex_NeedDiscard):SetIndex(0, tostring(needDrop))
    end
    ;
    (((self.ui).btn_Discard).gameObject):SetActive(self.isOverLimit)
  end
end

UIEpChipDiscard.RefreshLoopList = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self.chipDataList = {}
  for chipId,chipData in pairs((self.dynPlayer).chipDic) do
    (table.insert)(self.chipDataList, chipData)
  end
  local num = #self.chipDataList
  if num > 0 then
    (self.chipDetailPanel):Show()
    if self.isOverLimit then
      (((self.ui).btn_Discard).gameObject):SetActive(true)
    end
  else
    ;
    (self.chipDetailPanel):Hide()
    ;
    (((self.ui).btn_Discard).gameObject):SetActive(false)
  end
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).chipLoopList).totalCount = num
  ;
  ((self.ui).chipLoopList):RefillCells()
end

UIEpChipDiscard.RefreshAddLimit = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local discardCfg = (ConfigData.exploration_discard)[self.discardId]
  if discardCfg == nil then
    error("can\'t read discardCfg with discardId=" .. tostring(self.discardId))
    return 
  end
  self.costItemId = discardCfg.upgrade_scaleId or 1
  self.costItemNum = 0
  local levelCfg = discardCfg.upgrade_level
  local scaleValuesCfg = discardCfg.upgrade_scaleValues
  local levelCount = #levelCfg
  local chipDiscardLimit = (self.dynPlayer):GetChipDiscardLimit()
  for i = 1, levelCount do
    -- DECOMPILER ERROR at PC36: Unhandled construct in 'MakeBoolean' P1

    if i <= 1 and chipDiscardLimit <= levelCfg[1] then
      self.costItemNum = scaleValuesCfg[1]
    end
    -- DECOMPILER ERROR at PC45: Unhandled construct in 'MakeBoolean' P1

    if levelCount <= i and levelCfg[i - 1] < chipDiscardLimit then
      self.costItemNum = scaleValuesCfg[i]
    end
    if levelCfg[i - 1] < chipDiscardLimit and chipDiscardLimit <= levelCfg[i] then
      self.costItemNum = scaleValuesCfg[i]
    end
  end
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Money).text = tostring(self.costItemNum)
  -- DECOMPILER ERROR at PC73: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_Money).sprite = CRH:GetSprite(((ConfigData.item)[self.costItemId]).icon)
end

UIEpChipDiscard.m_OnNewItem = function(self, go)
  -- function num : 0_7 , upvalues : UINEpChipDiscardItem
  local ChipDiscardItem = (UINEpChipDiscardItem.New)()
  ChipDiscardItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.chipItemDic)[go] = ChipDiscardItem
end

UIEpChipDiscard.m_OnChangeItem = function(self, go, index)
  -- function num : 0_8 , upvalues : _ENV
  local ChipDiscardItem = (self.chipItemDic)[go]
  if ChipDiscardItem == nil then
    error("Can\'t find levelItem by gameObject")
    return 
  end
  local chipData = (self.chipDataList)[index + 1]
  if chipData == nil then
    error("Can\'t find levelData by index, index = " .. tonumber(index))
  end
  ChipDiscardItem:InitDiscardChipItem(self.discardId, chipData, self._OnClick)
  ChipDiscardItem:SetItemSelect(self.selectedData == chipData)
  if self.selectedData == nil and index == 0 then
    self:OnClick(ChipDiscardItem)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UIEpChipDiscard.m_GetItemByData = function(self, chipData)
  -- function num : 0_9 , upvalues : _ENV
  for k,v in ipairs(self.chipDataList) do
    if v == chipData then
      local index = k - 1
      return self:m_GetItemGoByIndex(index)
    end
  end
end

UIEpChipDiscard.m_GetItemGoByIndex = function(self, index)
  -- function num : 0_10
  if (((self.ui).chipLoopList).content).childCount <= index then
    return nil
  end
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
  -- function num : 0_11
  if self.selectedData ~= nil and self.selectedData ~= ChipDiscardItem.chipData then
    local lastItem = self:m_GetItemByData(self.selectedData)
    if lastItem ~= nil then
      lastItem:SetItemSelect(false)
    end
    self.selectedData = ChipDiscardItem.chipData
    ChipDiscardItem:SetItemSelect(true)
  else
    do
      if self.selectedData == nil then
        self.selectedData = ChipDiscardItem.chipData
        ChipDiscardItem:SetItemSelect(true)
      end
      ;
      (self.chipDetailPanel):Show()
      ;
      (self.chipDetailPanel):InitChipDetailPanel(nil, ChipDiscardItem.chipData, self.dynPlayer, self.resloader, nil, true, true, true)
    end
  end
end

UIEpChipDiscard.DiscardChip = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if not self.isOverLimit then
    ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(260))
    return 
  end
  ;
  (self.explorationNetworkCtrl):CS_EXPLORATION_AlgUpperLimit_Sold(self.position, (self.selectedData).dataId)
  self.selectedData = nil
end

UIEpChipDiscard.AddLimit = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local currentItemNum = (self.dynPlayer):GetItemCount(self.costItemId)
  if self.costItemNum <= currentItemNum then
    (self.explorationNetworkCtrl):CS_EXPLORATION_AlgUpperLimit_PurchaseLimit(self.position)
  else
    ;
    ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(275))
    return 
  end
end

UIEpChipDiscard.OnStoreMapClicked = function(self)
  -- function num : 0_14
  self.__mapActiveState = not self.__mapActiveState
  self:m_SwitchMapBtnState(self.__mapActiveState)
end

UIEpChipDiscard.FromMapBackToUI = function(self)
  -- function num : 0_15
  self.__mapActiveState = false
  self:m_SwitchMapBtnState(self.__mapActiveState)
end

UIEpChipDiscard.m_SwitchMapBtnState = function(self, openMap)
  -- function num : 0_16 , upvalues : _ENV
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

UIEpChipDiscard.Close = function(self)
  -- function num : 0_17 , upvalues : _ENV
  if self.isOverLimit then
    return 
  end
  ;
  (self.explorationNetworkCtrl):CS_EXPLORATION_AlgUpperLimit_Exit(self.position)
  MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete)
  if self.closeCallback ~= nil then
    (self.closeCallback)()
  end
  self:Delete()
end

UIEpChipDiscard.OnDelete = function(self)
  -- function num : 0_18 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
  MsgCenter:RemoveListener(eMsgEventId.OnEpChipListChange, self.__onChipListChange)
  MsgCenter:RemoveListener(eMsgEventId.OnChipLimitChange, self.__OnChipLimitChange)
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
    self.resLoader = nil
  end
  ;
  (base.OnDelete)(self)
  MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
end

return UIEpChipDiscard

