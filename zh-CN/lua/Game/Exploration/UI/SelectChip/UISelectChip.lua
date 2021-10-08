local UISelectChip = class("UISelectChip", UIBaseWindow)
local base = UIBaseWindow
local UISelectChipItem = require("Game.Exploration.UI.Base.UISelectChipItem")
local cs_GameObject = (CS.UnityEngine).GameObject
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local cs_MessageCommon = CS.MessageCommon
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local REFRESH_CHIP_UID = 4294967300
UISelectChip.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UISelectChipItem
  (UIUtil.AddButtonListener)((self.ui).btn_return, self, self.__OnClickSkipButton)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Refresh, self, self.__ClickRefresh)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CampBondSkill, self, self.__OnClickActiveCampFetter)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Skip, self, self.OnClickGiveup)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Map, self, self.OnClickMap)
  ;
  ((self.ui).propChipItem):SetActive(false)
  self.__ShowDungeonState = BindCallback(self, self.ShowDungeonState)
  MsgCenter:AddListener(eMsgEventId.OnSettleMentTimeLinePlayToEnd, self.__ShowDungeonState)
  self.selectChipItemPool = (UIItemPool.New)(UISelectChipItem, (self.ui).propChipItem)
  self.__onMoneyUpdate = BindCallback(self, self.__UpdateRefreshPriceInfo)
  MsgCenter:AddListener(eMsgEventId.EpMoneyChange, self.__onMoneyUpdate)
end

UISelectChip.OnUpdateRemainRefreshInfo = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if self._isGiveUp then
    return 
  end
  local roomData = ((ExplorationManager.epCtrl).playerCtrl):GetCurrentRoomData()
  if roomData == nil then
    return 0
  end
  self.refreshCount = roomData.refreshAlgCntAfterBattle
  local totalRefreshCount, refreshTimeCfg, refreshPriceCfg, currencyId = self:__GetCurRoomTotalRefreshCountAndPriceCfg()
  self.totalRefreshCount = totalRefreshCount
  self.currencyId = currencyId
  self.curRefreshPrice = ConfigData:CalculatePriceGeneralFunc(self.refreshCount, refreshTimeCfg, refreshPriceCfg)
  self.remainRefreshTime = self.totalRefreshCount
  if self.totalRefreshCount > 0 then
    self.remainRefreshTime = self.totalRefreshCount - self.refreshCount
  end
  local canRefresh = false
  local canShowRemainCount = false
  if self.remainRefreshTime == -1 or self.remainRefreshTime > 0 then
    canRefresh = true
  end
  if self.remainRefreshTime > 0 then
    canShowRemainCount = true
  end
  self:UpdateRefreshCount(canRefresh, self.remainRefreshTime, canShowRemainCount, self.curRefreshPrice)
end

UISelectChip.__UpdateRefreshPriceInfo = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local curMoney = ((ExplorationManager.epCtrl).dynPlayer):GetItemCount(self.currencyId)
  self.isLack = curMoney < self.curRefreshPrice
  ;
  ((self.ui).img_Lack):SetActive(self.isLack)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UISelectChip.__GetCurRoomTotalRefreshCountAndPriceCfg = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local epId = ((ExplorationManager.epCtrl).mapData).exploraionId
  local epMonsterRefreshId = ((ConfigData.exploration)[epId]).monster_room_refresh
  local epMonsterRoomCfg = (ConfigData.exploration_monster_room)[epMonsterRefreshId]
  if epMonsterRoomCfg == nil then
    error("找不到对应的怪物房配置,id= " .. epMonsterRefreshId)
    return 0
  end
  if epMonsterRoomCfg.refresh_times == nil then
    return 0
  end
  local maxTime = (epMonsterRoomCfg.refresh_times)[#epMonsterRoomCfg.refresh_times]
  return maxTime, epMonsterRoomCfg.refresh_times, epMonsterRoomCfg.prices, epMonsterRoomCfg.currency
end

UISelectChip.__GetCurRoomRefreshedRemainCount = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local roomData = ((ExplorationManager.epCtrl).playerCtrl):GetCurrentRoomData()
  if roomData == nil then
    return 0
  end
  return roomData.refreshAlgCntAfterBattle
end

UISelectChip.OnShow = function(self)
  -- function num : 0_5 , upvalues : base, _ENV
  (base.OnShow)(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, false)
end

UISelectChip.OnHide = function(self)
  -- function num : 0_6 , upvalues : base, _ENV
  (base.OnHide)(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, true)
end

UISelectChip.InitSelectChip = function(self, refreshable, chipDataList, dynPlayer, selectEvent, giveupEvent, toFakeCamera, refreshEvent)
  -- function num : 0_7 , upvalues : _ENV, ExplorationEnum
  (((self.ui).btn_Map).gameObject):SetActive(ExplorationManager:HasRoomSceneInEp())
  self:RefreshMapBtnState(true)
  ;
  (((self.ui).btn_Refresh).gameObject):SetActive(refreshable)
  if refreshable then
    self.__onlockClickAction = BindCallback(self, self.OnLockSelect)
    self:OnUpdateRemainRefreshInfo()
    self:SetClickRefreshCallback(BindCallback(self, self.OnRefreshChipAction))
  end
  self.toFakeCamera = toFakeCamera
  self.dynPlayer = dynPlayer
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
  end
  self.resloader = ((CS.ResLoader).Create)()
  self.selectEvent = selectEvent
  self.giveupEvent = giveupEvent
  self.refreshChipEvent = refreshEvent
  self.chipItemList = {}
  self.chipDataList = chipDataList
  self.__clickedPanelAction = BindCallback(self, self.OnChipPanelClicked)
  self:RefreshChipList(self.chipDataList, refreshable)
  if toFakeCamera then
    self:__ToFackCameraCanvas()
    ;
    (self.transform):SetLayer(LayerMask.UI3D)
  else
    ;
    (self.transform):SetLayer(LayerMask.UI)
    if not GuideManager:TryTriggerGuide(eGuideCondition.InSelectChip) or ExplorationManager:IsInExploration() then
      local curRoomData = (ExplorationManager.epCtrl):GetCurrentRoomData()
      local actionList = ExplorationManager:GetEpGuideActionList(curRoomData.x, (ExplorationEnum.epGuideMomentType).BattleSelectChip)
      if actionList ~= nil and #actionList > 0 then
        local EpGuideUtil = require("Game.Exploration.Util.EpGuideUtil")
        ;
        (EpGuideUtil.ExecuteEpGuideActions)(actionList)
      end
    end
  end
  do
    MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, false)
  end
end

UISelectChip.OnLockSelect = function(self, chipItem)
  -- function num : 0_8 , upvalues : _ENV, cs_MessageCommon
  if self.lockedChipItems == nil then
    self.lockedChipItems = {}
  end
  chipItem.lockState = not chipItem.lockState
  if chipItem.lockState then
    if #self.chipItemList - 1 <= (table.count)(self.lockedChipItems) then
      chipItem.lockState = not chipItem.lockState
      ;
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.exploration_Treasure_AlertNotSelectAllReward))
      return 
    end
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self.lockedChipItems)[chipItem.idx] = chipItem
  else
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self.lockedChipItems)[chipItem.idx] = nil
  end
  chipItem:ChangelockUi()
end

UISelectChip.RefreshChipList = function(self, chipDataList, refreshable)
  -- function num : 0_9 , upvalues : _ENV, ChipEnum
  local afterAnim = function()
    -- function num : 0_9_0 , upvalues : self, chipDataList, _ENV, refreshable, ChipEnum
    self.chipDataList = chipDataList
    if self.selectChipItemPool ~= nil then
      self.selectChip = nil
      self.chipItemList = {}
      ;
      (self.selectChipItemPool):HideAll()
      for k,chipData in ipairs(chipDataList) do
        local chipItem = (self.selectChipItemPool):GetOne()
        -- DECOMPILER ERROR at PC22: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (chipItem.gameObject).name = tostring(chipData.dataId)
        chipItem:Show()
        chipItem:InitSelectChipItem(k, chipData, self.dynPlayer, self.resloader, self.__clickedPanelAction, self.__onlockClickAction, refreshable, false)
        chipItem:SetTRModifier((self.ui).modifier)
        ;
        (chipItem.panel):ShowEpChipDetailEff(5)
        ;
        (chipItem.panel):InitDissolveTweenSetting()
        local isHadChip = ((self.dynPlayer).chipDic)[chipData.dataId] ~= nil
        if not isHadChip or not (ChipEnum.eChipShowState).UpState then
          local chipShowState = (ChipEnum.eChipShowState).NewState
        end
        chipItem:SetObjNewTagActive(true, chipShowState)
        ;
        (table.insert)(self.chipItemList, chipItem)
      end
    end
    self:RefreshGiveupState(chipDataList)
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end

  if #self.chipItemList > 0 then
    (UIUtil.AddOneCover)("UISelectChip")
    self:CleanSelect()
    local waitingAnimNum = 0
    do
      local isAddedCallback = false
      local palyOver = function()
    -- function num : 0_9_1 , upvalues : waitingAnimNum, afterAnim, _ENV
    waitingAnimNum = waitingAnimNum - 1
    if waitingAnimNum <= 0 then
      afterAnim()
      ;
      (UIUtil.CloseOneCover)("UISelectChip")
    end
  end

      for chipIndex,chipItem in ipairs(self.chipItemList) do
        if not chipItem.lockState then
          local chipPanel = chipItem:GetChipDetailPanel()
          waitingAnimNum = waitingAnimNum + 1
          chipPanel:OnDissolveTweenCompleteAction(palyOver)
          isAddedCallback = true
          chipPanel:PlayDissolveTween()
        end
      end
      AudioManager:PlayAudioById(1123)
      if not isAddedCallback then
        afterAnim()
      end
    end
  else
    do
      afterAnim()
    end
  end
end

UISelectChip.GetChipPanelByIndex = function(self, index)
  -- function num : 0_10
  local chipItem = (self.chipItemList)[index]
  if chipItem == nil then
    return nil
  end
  return chipItem:GetChipDetailPanel()
end

UISelectChip.RefreshGiveupState = function(self, chipDataList)
  -- function num : 0_11 , upvalues : _ENV
  if self.giveupEvent == nil then
    (((self.ui).btn_Skip).gameObject):SetActive(false)
    return 
  end
  ;
  (((self.ui).btn_Skip).gameObject):SetActive(true)
  local qualityChip = nil
  for k,v in pairs(chipDataList) do
    if qualityChip == nil or qualityChip:GetQuality() < v:GetQuality() then
      qualityChip = v
    end
  end
  if qualityChip == nil then
    (((self.ui).priceText).gameObject):SetActive(false)
    return 
  end
  ;
  (((self.ui).priceText).gameObject):SetActive(true)
  local epTypeCfg = ExplorationManager:GetEpTypeCfg()
  local chipPrice = qualityChip:GetChipBuyPrice(ExplorationManager:GetEpModuleTypeCfgId())
  local price = ConfigData:CalculateEpChipSalePrice(epTypeCfg.store_pool, qualityChip:GetCount(), chipPrice, self.dynPlayer)
  -- DECOMPILER ERROR at PC70: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).priceText).text = "+" .. tostring(price)
end

UISelectChip.OnChipPanelClicked = function(self, chipPanel)
  -- function num : 0_12 , upvalues : _ENV
  if chipPanel == nil or self._isGiveUp then
    return 
  end
  local stateInfoWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if stateInfoWindow == nil or not ((stateInfoWindow.chipList).gameObject).activeInHierarchy then
    return 
  end
  self:ComfirmSelectChip(chipPanel)
end

UISelectChip.CleanSelect = function(self)
  -- function num : 0_13 , upvalues : _ENV
  for _,v in pairs(self.chipItemList) do
    (v.panel):UnSelectAlpha(false)
    ;
    (v.panel):SetSelectAnima(false)
    ;
    (v.panel):OnSelectChipChanged(false)
  end
end

UISelectChip.ComfirmSelectChip = function(self, chipPanel)
  -- function num : 0_14 , upvalues : _ENV
  local index = chipPanel.index
  local chipData = chipPanel:GetChipDetailPanelData()
  local chipReturnMoney = (ExplorationManager:GetDynPlayer()):GetChipReturnMoney(chipData.dataId, chipData:GetCount())
  if self.selectEvent ~= nil then
    (self.selectEvent)(index, function()
    -- function num : 0_14_0 , upvalues : self, index, _ENV, chipReturnMoney
    local selectChipItem = (self.chipItemList)[index]
    if selectChipItem ~= nil then
      local chipPanel = selectChipItem:GetChipDetailPanel()
      local chipData = chipPanel:GetChipDetailPanelData()
      local chipIconTran = chipPanel:GetChipItemTransform()
      local dungeonStateWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
      do
        do
          if dungeonStateWindow ~= nil then
            local uiPos = nil
            if self.toFakeCamera then
              uiPos = UIManager:World2UIPosition(chipIconTran.position)
              uiPos = (Vector3.New)(uiPos.x, uiPos.y, 0)
            else
              uiPos = (self.transform):InverseTransformPoint(chipIconTran.position)
            end
            dungeonStateWindow:ShowGetChipAni(chipData, uiPos, chipIconTran.localScale, chipReturnMoney)
          end
          ;
          (ExplorationManager:GetEpDataCenter()):AddNewChip(chipData.dataId)
          self:Delete()
        end
      end
    end
  end
)
  end
end

UISelectChip.OnClickGiveup = function(self)
  -- function num : 0_15
  self:StartGiveUpLogic()
end

UISelectChip.StartGiveUpLogic = function(self)
  -- function num : 0_16 , upvalues : _ENV
  if self._isGiveUp then
    return 
  end
  self._isGiveUp = true
  if self.giveupEvent ~= nil then
    (UIUtil.AddOneCover)("UISelectChip")
    ;
    (self.giveupEvent)(function(afterAnimCallabck)
    -- function num : 0_16_0 , upvalues : self, _ENV
    self:CleanSelect()
    local afterAnim = function()
      -- function num : 0_16_0_0 , upvalues : self, _ENV, afterAnimCallabck
      self:Delete()
      ;
      (UIUtil.CloseOneCover)("UISelectChip")
      if afterAnimCallabck ~= nil then
        afterAnimCallabck()
      end
    end

    local waitingAnimNum = 0
    local isAddedCallback = false
    local palyOver = function()
      -- function num : 0_16_0_1 , upvalues : waitingAnimNum, afterAnim
      waitingAnimNum = waitingAnimNum - 1
      if waitingAnimNum <= 0 then
        afterAnim()
      end
    end

    for chipIndex,chipItem in ipairs(self.chipItemList) do
      local chipPanel = chipItem:GetChipDetailPanel()
      waitingAnimNum = waitingAnimNum + 1
      chipPanel:OnDissolveTweenCompleteAction(palyOver)
      isAddedCallback = true
      chipPanel:PlayDissolveTween()
    end
    AudioManager:PlayAudioById(1123)
    if not isAddedCallback then
      afterAnim()
    end
  end
)
  end
end

UISelectChip.OnRefreshChipAction = function(self)
  -- function num : 0_17 , upvalues : _ENV
  if self.refreshChipEvent ~= nil then
    local idxs = nil
    if self.lockedChipItems ~= nil and (table.count)(self.lockedChipItems) > 0 then
      idxs = {}
      for k,v in pairs(self.lockedChipItems) do
        (table.insert)(idxs, k)
      end
    end
    do
      ;
      (self.refreshChipEvent)(self.currencyId, self.remainRefreshTime, self.curRefreshPrice, idxs)
    end
  end
end

UISelectChip.UpdateRefreshCount = function(self, isCouldRefresh, remaindTime, showRemainText, price)
  -- function num : 0_18 , upvalues : _ENV
  (((self.ui).btn_Refresh).gameObject):SetActive(isCouldRefresh)
  ;
  (((self.ui).tex_RefreshCount).gameObject):SetActive(showRemainText)
  if showRemainText then
    ((self.ui).tex_RefreshCount):SetIndex(0, tostring(remaindTime))
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Pay).text = "-" .. tostring(price)
  self:__UpdateRefreshPriceInfo()
end

UISelectChip.SetClickRefreshCallback = function(self, clickRefreshCallback)
  -- function num : 0_19
  self.clickRefreshCallback = clickRefreshCallback
end

UISelectChip.__ClickRefresh = function(self)
  -- function num : 0_20
  if self._isGiveUp then
    return 
  end
  if self.clickRefreshCallback ~= nil and not self.isLack then
    (self.clickRefreshCallback)()
  end
end

UISelectChip.SetHasEpActiveCampFetter = function(self, hasEpActive)
  -- function num : 0_21
  ((self.ui).obj_btn_CampBondSkill):SetActive(hasEpActive)
end

UISelectChip.SetActiveCampFetter = function(self, campId, heroNum, couldUse, cdStr)
  -- function num : 0_22 , upvalues : _ENV
  if couldUse then
    ((self.ui).img_btn_CampBondSkill):SetIndex(0)
    local campFetterCfg = ((ConfigData.camp_connection)[campId])[heroNum]
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).img_CampFetterIcon).sprite = (AtlasUtil.GetSpriteFromAtlas)(UIAtlasConsts.Atlas_CampFetterIcon, campFetterCfg.icon, self.resloader)
    ;
    ((self.ui).tex_campFetterName):SetIndex(0, (LanguageUtil.GetLocaleText)(campFetterCfg.name))
    ;
    ((self.ui).tex_subText):SetIndex(0, (LanguageUtil.GetLocaleText)(((ConfigData.camp)[campId]).name))
  else
    do
      ;
      ((self.ui).img_btn_CampBondSkill):SetIndex(1)
      local campFetterCfg = ((ConfigData.camp_connection)[campId])[heroNum]
      -- DECOMPILER ERROR at PC61: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).img_CampFetterIcon).sprite = (AtlasUtil.GetSpriteFromAtlas)(UIAtlasConsts.Atlas_CampFetterIcon, campFetterCfg.icon, self.resloader)
      ;
      ((self.ui).tex_campFetterName):SetIndex(1)
      ;
      ((self.ui).tex_subText):SetIndex(1, cdStr)
    end
  end
end

UISelectChip.SetClickActiveCampFetter = function(self, useCampFetterCallback)
  -- function num : 0_23
  self.useCampFetterCallback = useCampFetterCallback
end

UISelectChip.__OnClickActiveCampFetter = function(self)
  -- function num : 0_24
  if self.useCampFetterCallback ~= nil then
    (self.useCampFetterCallback)()
  end
end

UISelectChip.__OnClickSkipButton = function(self)
  -- function num : 0_25 , upvalues : _ENV
  ((CS.MessageCommon).ShowMessageBox)(ConfigData:GetTipContent(1011), function()
    -- function num : 0_25_0 , upvalues : self
    do
      if self.selectEvent ~= nil then
        local index = #self.chipDataList + 1
        ;
        (self.selectEvent)(index)
      end
      self:Delete()
    end
  end
, nil)
end

UISelectChip.__ToFackCameraCanvas = function(self)
  -- function num : 0_26 , upvalues : cs_GameObject, _ENV
  local fakeCameraBattle = ((cs_GameObject.Find)("FakeCameraBattleChip")):FindComponent(eUnityComponentID.Camera)
  self:AlignToFakeCamera(fakeCameraBattle)
end

UISelectChip.ShowDungeonState = function(self)
  -- function num : 0_27 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  win:Show()
  win:OnlyShowChipList(false, false)
  win:ChipListWeakenTween(false)
end

UISelectChip.OnClickMap = function(self)
  -- function num : 0_28
  self:RefreshMapBtnState(not self.mapBtnStateFlag)
end

UISelectChip.RefreshMapBtnState = function(self, flag)
  -- function num : 0_29
  self.mapBtnStateFlag = flag
  ;
  (((self.ui).modifier).gameObject):SetActive(flag)
  ;
  ((self.ui).img_btnBg):SetIndex(flag and 0 or 1)
  ;
  ((self.ui).tex_btnName):SetIndex(flag and 0 or 1)
  ;
  ((self.ui).obj_background):SetActive(flag)
  ;
  ((self.ui).obj_textContinue):SetActive(flag)
end

UISelectChip.OnDelete = function(self)
  -- function num : 0_30 , upvalues : _ENV, base
  if not self.toFakeCamera then
    MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
  end
  MsgCenter:RemoveListener(eMsgEventId.OnSettleMentTimeLinePlayToEnd, self.__ShowDungeonState)
  MsgCenter:RemoveListener(eMsgEventId.EpMoneyChange, self.__onMoneyUpdate)
  local window = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if window ~= nil then
    (window.chipList):CancelHighlightChipItem()
  end
  ;
  (self.selectChipItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
end

return UISelectChip

