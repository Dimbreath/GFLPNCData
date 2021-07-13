-- params : ...
-- function num : 0 , upvalues : _ENV
local UITreasureRoom = class("UITreasureRoom", UIBaseWindow)
local base = UIBaseWindow
local UITreasureRoomChipItem = require("Game.Exploration.UI.Base.UISelectChipItem")
local CS_ResLoader = CS.ResLoader
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
UITreasureRoom.OnInit = function(self)
  -- function num : 0_0 , upvalues : CS_ResLoader, _ENV, UITreasureRoomChipItem
  self.resloader = (CS_ResLoader.Create)()
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Refresh, self, self.OnRefreshClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Skip, self, self.OnSkipClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Map, self, self.OnClickShowMap)
  self.itemPool = (UIItemPool.New)(UITreasureRoomChipItem, (self.ui).obj_treasureItem)
  ;
  ((self.ui).obj_treasureItem):SetActive(false)
  self.chipItemArr = {}
  self.selectChipItem = nil
  self.GlobalChipData = nil
  self.__mapActiveState = false
  self.__onToggleChipItemClick = BindCallback(self, self.OnChipPanelClicked)
  self.__onlockClickAction = BindCallback(self, self.OnlockClick)
  self.__OnChipDetailActiveChange = BindCallback(self, self.OnChipDetailActiveChange)
  MsgCenter:AddListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  self.__FromMapBackToUI = BindCallback(self, self.FromMapBackToUI)
  MsgCenter:AddListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
end

UITreasureRoom.OnShow = function(self)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.OnShow)(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, false)
end

UITreasureRoom.OnHide = function(self)
  -- function num : 0_2 , upvalues : base, _ENV
  (base.OnHide)(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, true)
end

UITreasureRoom.InitTreasureRoom = function(self, ctrl, roomData, isFirstOpen)
  -- function num : 0_3 , upvalues : _ENV
  do
    if roomData == nil then
      local err = "UITreasureRoom:InitTreasureRoom error:cfgData is nil "
      error(err)
      return 
    end
    self.ctrl = ctrl
    self.roomData = roomData
    self.treasureData = roomData.treasureData
    self.cfg = roomData.cfg
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_Pay).text = "-" .. tostring(roomData.refreshCostNum)
    self:UpdateCouldRefreshRoom()
    self:__ShowChipDetail((roomData.treasureData).chipDatas, isFirstOpen)
    self:__ShowGiveUpPrice((roomData.treasureData).chipDatas)
    self.__mapActiveState = false
    self:SwitchRoomMapBtnState(self.__mapActiveState)
    if GuideManager:TryTriggerGuide(eGuideCondition.InEpTreasureRoom) then
    end
  end
end

UITreasureRoom.UpdateCouldRefreshRoom = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local totalRefreshTime = 0
  if (self.cfg).times ~= nil then
    totalRefreshTime = (self.cfg).maxRefreshTime
  end
  if totalRefreshTime == 0 then
    (((self.ui).btn_Refresh).gameObject):SetActive(false)
  else
    local remainRefreshTime = 0
    if totalRefreshTime > 0 then
      remainRefreshTime = totalRefreshTime - (self.treasureData).freshCnt
    end
    if totalRefreshTime == -1 or remainRefreshTime <= 0 then
      (((self.ui).tex_RefreshCount).gameObject):SetActive(false)
    else
      ;
      ((self.ui).tex_RefreshCount):SetIndex(0, tostring(remainRefreshTime))
    end
    if totalRefreshTime >= 0 and remainRefreshTime <= 0 then
      (((self.ui).btn_Refresh).gameObject):SetActive(false)
    end
    self.currMoney = ((self.ctrl).dynPlayer):GetMoneyCount()
    self.isLack = self.currMoney < (self.roomData).refreshCostNum
    ;
    ((self.ui).obj_Lack):SetActive(self.isLack)
    ;
    ((self.ui).tex_Refresh):SetIndex(self.isLack and 1 or 0)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UITreasureRoom.__ShowChipDetail = function(self, chipDatas, isFirstOpen)
  -- function num : 0_5 , upvalues : _ENV, ChipEnum
  (UIUtil.AddOneCover)("UITreasureRoom")
  local afterAnim = function()
    -- function num : 0_5_0 , upvalues : self, _ENV, chipDatas, ChipEnum
    (self.itemPool):HideAll()
    self.chipItemArr = {}
    for index,chipData in pairs(chipDatas) do
      local item = (self.itemPool):GetOne(true)
      -- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (item.gameObject).name = tostring((chipData.data).dataId)
      item:InitSelectChipItem(chipData.idx, chipData.data, (self.ctrl).dynPlayer, self.resloader, self.__onToggleChipItemClick, self.__onlockClickAction, true)
      item:SetTRModifier((self.ui).modifier)
      ;
      (item.panel):ShowEpChipDetailEff(5)
      ;
      (item.panel):InitDissolveTweenSetting()
      local isHadChip = (((self.ctrl).dynPlayer).chipDic)[(chipData.data).dataId] ~= nil
      if not isHadChip or not (ChipEnum.eChipShowState).UpState then
        local chipShowState = (ChipEnum.eChipShowState).NewState
      end
      item:SetObjNewTagActive(true, chipShowState)
      ;
      (table.insert)(self.chipItemArr, item)
    end
    ;
    (UIUtil.CloseOneCover)("UITreasureRoom")
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end

  local waitingAnimNum = 0
  local isAddedCallback = false
  local palyOver = function()
    -- function num : 0_5_1 , upvalues : waitingAnimNum, afterAnim
    waitingAnimNum = waitingAnimNum - 1
    if waitingAnimNum <= 0 then
      afterAnim()
    end
  end

  if not isFirstOpen then
    self:CleanSelect()
    for chipIndex,chipItem in ipairs(self.chipItemArr) do
      if not chipItem.lockState then
        local chipPanel = chipItem:GetChipDetailPanel()
        waitingAnimNum = waitingAnimNum + 1
        chipPanel:OnDissolveTweenCompleteAction(palyOver)
        isAddedCallback = true
        chipPanel:PlayDissolveTween()
      end
    end
  end
  do
    if not isAddedCallback then
      afterAnim()
    end
  end
end

UITreasureRoom.__ShowGiveUpPrice = function(self, chipDatas)
  -- function num : 0_6 , upvalues : _ENV, ExplorationEnum
  local qualityChip = nil
  for k,v in pairs(chipDatas) do
    if qualityChip == nil or qualityChip:GetQuality() < (v.data):GetQuality() then
      qualityChip = v.data
    end
  end
  if qualityChip == nil then
    (((self.ui).priceText).gameObject):SetActive(false)
    return 
  end
  ;
  (((self.ui).priceText).gameObject):SetActive(true)
  local epTypeCfg = ExplorationManager:GetEpTypeCfg()
  local epShop = (ConfigData.exploration_shop)[epTypeCfg.store_pool]
  local index = 0
  for i = 1, #epShop.discount_level do
    if (epShop.discount_level)[i] <= qualityChip:GetCount() then
      index = i
      break
    end
  end
  do
    if index == 0 then
      index = #epShop.discount_level
    end
    local discount_scale = ((self.ctrl).dynPlayer):GetSpecificBuffLogicPerPara((ExplorationEnum.eBuffLogicId).sealChipScale)
    if discount_scale == nil or discount_scale == 0 then
      discount_scale = (epShop.discount_scale)[index] / 1000
    else
      discount_scale = discount_scale / 100
    end
    local price = (math.floor)(qualityChip:GetChipBuyPrice(ExplorationManager:GetEpModuleId()) * (discount_scale))
    -- DECOMPILER ERROR at PC89: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.ui).priceText).text = "+" .. tostring(price)
  end
end

UITreasureRoom.GetMaxInPlayPowerChip = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local fightPower = -1
  local quality = -1
  local powerChipPanel = nil
  for k,item in pairs(self.chipItemArr) do
    local chipPanel = item:GetChipDetailPanel()
    local curFightPower = chipPanel:GetInPlayFightPower((self.ctrl).dynPlayer)
    if fightPower < curFightPower or curFightPower == fightPower and quality < chipPanel:GetChipQuality() then
      fightPower = curFightPower
      quality = chipPanel:GetChipQuality()
      powerChipPanel = chipPanel
    end
  end
  return powerChipPanel
end

UITreasureRoom.OnChipPanelClicked = function(self, chipPanel)
  -- function num : 0_8 , upvalues : _ENV
  if chipPanel == nil or self._isGiveUp then
    return 
  end
  if self.selectChipItem == chipPanel then
    self:OnComfirmClick(chipPanel)
  end
  if self.selectChipItem ~= nil then
    (self.selectChipItem):OnSelectChipChanged(false)
  end
  chipPanel:OnSelectChipChanged(true)
  self.selectChipItem = chipPanel
  for _,v in pairs((self.itemPool).listItem) do
    if v.panel ~= self.selectChipItem then
      (v.panel):SetUnSelectAlpha()
    end
  end
end

UITreasureRoom.CleanSelect = function(self)
  -- function num : 0_9 , upvalues : _ENV
  self.selectChipItem = nil
  for _,v in pairs((self.itemPool).listItem) do
    (v.panel):UnSelectAlpha(false)
    ;
    (v.panel):SetSelectAnima(false)
    ;
    (v.panel):OnSelectChipChanged(false)
  end
end

UITreasureRoom.OnlockClick = function(self, chipItem)
  -- function num : 0_10
  if chipItem ~= nil then
    (self.ctrl):SendItemLockOrUnlock(chipItem)
  end
end

UITreasureRoom.OnComfirmClick = function(self, chipPanel)
  -- function num : 0_11 , upvalues : _ENV
  local chipItemTran = chipPanel:GetChipItemTransform()
  local chipData = chipPanel:GetChipDetailPanelData()
  local dynPlayer = ExplorationManager:GetDynPlayer()
  local chipReturnMoney = dynPlayer:GetChipReturnMoney(chipData.dataId, chipData:GetCount())
  local waitChip = not dynPlayer:IsNormalChipFullLevel(chipData.dataId)
  ;
  (self.ctrl):SendItemSelect(chipPanel.index, waitChip, function()
    -- function num : 0_11_0 , upvalues : self, chipItemTran, _ENV, chipData, chipReturnMoney, chipPanel
    local uiPos = (self.transform):InverseTransformPoint(chipItemTran.position)
    local localScale = chipItemTran.localScale
    local dungeonStateWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
    if dungeonStateWindow ~= nil then
      dungeonStateWindow:ShowGetChipAni(chipData, uiPos, localScale, chipReturnMoney)
    end
    local chipData = chipPanel:GetChipDetailPanelData()
    ;
    (ExplorationManager:GetEpDataCenter()):AddNewChip(chipData.dataId)
  end
)
end

UITreasureRoom.OnRefreshClick = function(self)
  -- function num : 0_12
  (self.ctrl):SendRefreshTreasureRoom((self.treasureData).boxId)
end

UITreasureRoom.OnSkipClick = function(self)
  -- function num : 0_13 , upvalues : _ENV
  if self._isGiveUp then
    return 
  end
  self._isGiveUp = true
  ;
  (UIUtil.AddOneCover)("UITreasureRoom")
  self:CleanSelect()
  local waitingAnimNum = 0
  local isAddedCallback = false
  local palyOver = function()
    -- function num : 0_13_0 , upvalues : waitingAnimNum, self, _ENV
    waitingAnimNum = waitingAnimNum - 1
    if waitingAnimNum <= 0 then
      (self.ctrl):SendTreasureRoomQuit()
      ;
      (UIUtil.CloseOneCover)("UITreasureRoom")
    end
  end

  for chipIndex,chipItem in ipairs(self.chipItemArr) do
    local chipPanel = chipItem:GetChipDetailPanel()
    waitingAnimNum = waitingAnimNum + 1
    chipPanel:OnDissolveTweenCompleteAction(palyOver)
    isAddedCallback = true
    chipPanel:PlayDissolveTween()
  end
  if not isAddedCallback then
    (self.ctrl):SendTreasureRoomQuit()
  end
end

UITreasureRoom.OnClickShowMap = function(self)
  -- function num : 0_14
  self.__mapActiveState = not self.__mapActiveState
  self:SwitchRoomMapBtnState(self.__mapActiveState)
end

UITreasureRoom.FromMapBackToUI = function(self)
  -- function num : 0_15
  self.__mapActiveState = false
  self:SwitchRoomMapBtnState(self.__mapActiveState)
end

UITreasureRoom.OnChipDetailActiveChange = function(self, bool)
  -- function num : 0_16
  if bool then
    self:Hide()
  else
    self:Show()
  end
end

UITreasureRoom.SwitchRoomMapBtnState = function(self, openMap)
  -- function num : 0_17 , upvalues : _ENV
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

UITreasureRoom.OnDelete = function(self)
  -- function num : 0_18 , upvalues : _ENV, base
  (self.resloader):Put2Pool()
  self.resloader = nil
  if self.chipItemArr ~= nil then
    for _,v in pairs(self.chipItemArr) do
      v:OnDelete()
    end
  end
  do
    self.selectChipItem = nil
    self.GlobalChipData = nil
    MsgCenter:RemoveListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
    MsgCenter:RemoveListener(eMsgEventId.OnShowingMapRoomClick, self.__FromMapBackToUI)
    MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
    ;
    (base.OnDelete)(self)
  end
end

return UITreasureRoom

