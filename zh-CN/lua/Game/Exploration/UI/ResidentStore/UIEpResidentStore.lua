local UIEpResidentStore = class("UIEpResidentStore", UIBaseWindow)
local base = UIBaseWindow
local UISelectChipItem = require("Game.Exploration.UI.Base.UISelectChipItem")
local UINEpRSLevelPreview = require("Game.Exploration.UI.ResidentStore.StoreLevelPreview.UINEpRSLevelPreview")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local CS_ResLoader = CS.ResLoader
UIEpResidentStore.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, CS_ResLoader, UISelectChipItem
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self._OnClickReturn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Bg, self, self._OnClickReturn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ChipRefresh, self, self._OnClickRefresh)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_LevelUp, self, self._OnClickLevelUp)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Preview, self, self._OnClickPreviewLevel)
  self.resLoader = (CS_ResLoader.Create)()
  ;
  ((self.ui).selectChipItem):SetActive(false)
  self.chipItemPool = (UIItemPool.New)(UISelectChipItem, (self.ui).selectChipItem)
  self._OnClickChipItemFunc = BindCallback(self, self._OnClickChipItem)
  self._OnClickLockItemFunc = BindCallback(self, self._OnClickLockItem)
  ;
  ((self.ui).obj_Purchased):SetActive(false)
  -- DECOMPILER ERROR at PC72: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_RefreshPay).text = tostring((ConfigData.game_config).epResidentStoreRefreshCost)
  self.__OnChipDetailActiveChange = BindCallback(self, self.OnChipDetailActiveChange)
  MsgCenter:AddListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
end

UIEpResidentStore.OnShow = function(self)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.OnShow)(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, false)
  if not ExplorationManager:IsInExplorationTD() then
    MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, false)
  end
  local stateInfoWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if stateInfoWindow ~= nil then
    (stateInfoWindow.chipList):ShowDungeonChipListSellTween(true)
  end
end

UIEpResidentStore.OnHide = function(self)
  -- function num : 0_2 , upvalues : base, _ENV
  (base.OnHide)(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, true)
  if not ExplorationManager:IsInExplorationTD() then
    MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
  end
  local stateInfoWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if stateInfoWindow ~= nil then
    (stateInfoWindow.chipList):ShowDungeonChipListSellTween(false)
  end
end

UIEpResidentStore.InitEpResidentStore = function(self, residentStoreCtrl)
  -- function num : 0_3
  self.residentStoreCtrl = residentStoreCtrl
end

UIEpResidentStore.SetEpResidentStoreCloseFunc = function(self, closeCallback)
  -- function num : 0_4
  self.closeCallback = closeCallback
end

UIEpResidentStore.UpdEpResidentStore = function(self, storeDataList, level, exp, showRefreshTween, isOpen)
  -- function num : 0_5 , upvalues : _ENV, ChipEnum
  self.storeDataList = storeDataList
  self.level = level
  local dynPlayer = ExplorationManager:GetDynPlayer()
  local tweenIndex = 0
  for k,storeData in ipairs(storeDataList) do
    do
      local chipItem = ((self.chipItemPool).listItem)[k]
      if chipItem == nil then
        chipItem = (self.chipItemPool):GetOne()
      end
      local lockd = storeData.locked
      local updItemFunc = function()
    -- function num : 0_5_0 , upvalues : chipItem, k, storeData, dynPlayer, self, ChipEnum
    chipItem:InitSelectChipItem(k, storeData.chipData, dynPlayer, self.resLoader, self._OnClickChipItemFunc, self._OnClickLockItemFunc, not storeData.sold, true)
    chipItem:SetSelectChipItemSold(storeData.sold, (self.ui).obj_Purchased)
    chipItem:SetSelectChipItemLock(storeData.locked)
    ;
    (chipItem.panel):ShowEpChipDetailEff(5)
    local isHadChip = (dynPlayer.chipDic)[(storeData.chipData).dataId] ~= nil
    if not isHadChip or not (ChipEnum.eChipShowState).UpState then
      local chipShowState = (ChipEnum.eChipShowState).NewState
    end
    chipItem:SetObjNewTagActive(not storeData.sold, chipShowState)
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end

      if showRefreshTween and not lockd then
        (chipItem.panel):ShowChipPanelRefreshTween(updItemFunc, tweenIndex, isOpen)
        tweenIndex = tweenIndex + 1
      else
        updItemFunc()
      end
    end
  end
  local shopCfg = nil
  if (ConfigData.weekly_challenge_shop)[level] == nil then
    error("Cant get weekly_challenge_shop, level = " .. shopCfg)
    return 
  end
  for k,textInfo in ipairs((self.ui).chipRateTextList) do
    local l_0_5_19, k, textInfo = nil
    l_0_5_19, k = l_0_5_18:SetIndex, l_0_5_18
    textInfo = 0
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R8 in 'UnsetPending'

    l_0_5_19(k, textInfo, tostring(FormatNum((((ConfigData.weekly_challenge_shop)[level]).function_drop_ratio)[l_0_5_17] / 10)))
  end
  -- DECOMPILER ERROR at PC77: Overwrote pending register: R11 in 'AssignReg'

  if (ConfigData.weekly_challenge_shop).maxLevel <= level then
    ((self.ui).tex_Level):SetIndex(shopCfg)
    -- DECOMPILER ERROR at PC81: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((self.ui).img_ExpBar).fillAmount = 1
    ;
    ((self.ui).pay):SetActive(false)
    -- DECOMPILER ERROR at PC90: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (((self.ui).tex_EXP).text).text = ""
  else
    ;
    ((self.ui).tex_Level):SetIndex(0, tostring(level))
    local nextLvCfg = nil
    if (ConfigData.weekly_challenge_shop)[level + 1] == nil then
      error("Cant get weekly_challenge_shop, level = " .. nextLvCfg)
      return 
    end
    -- DECOMPILER ERROR at PC114: Confused about usage of register: R9 in 'UnsetPending'

    local needExp = nil
    -- DECOMPILER ERROR at PC118: Overwrote pending register: R12 in 'AssignReg'

    ;
    ((self.ui).pay):SetActive(needExp)
    -- DECOMPILER ERROR at PC123: Overwrote pending register: R12 in 'AssignReg'

    -- DECOMPILER ERROR at PC124: Overwrote pending register: R13 in 'AssignReg'

    -- DECOMPILER ERROR at PC125: Overwrote pending register: R13 in 'AssignReg'

    -- DECOMPILER ERROR at PC132: Confused about usage of register: R11 in 'UnsetPending'

    ;
    ((self.ui).tex_LvUpPay).text = nextLvCfg
    -- DECOMPILER ERROR at PC133: Confused about usage of register: R8 in 'UnsetPending'

    local curLvExp = nil
    -- DECOMPILER ERROR at PC135: Confused about usage of register: R9 in 'UnsetPending'

    -- DECOMPILER ERROR at PC135: Overwrote pending register: R12 in 'AssignReg'

    -- DECOMPILER ERROR at PC136: Confused about usage of register: R8 in 'UnsetPending'

    -- DECOMPILER ERROR at PC137: Overwrote pending register: R12 in 'AssignReg'

    do
      local curLvExpTotal = nil
      -- DECOMPILER ERROR at PC141: Confused about usage of register: R13 in 'UnsetPending'

      ;
      ((self.ui).img_ExpBar).fillAmount = curLvExp
      -- DECOMPILER ERROR at PC144: Overwrote pending register: R14 in 'AssignReg'

      -- DECOMPILER ERROR at PC147: Confused about usage of register: R11 in 'UnsetPending'

      ;
      ((self.ui).tex_EXP):SetIndex(curLvExpTotal, tostring(exp - ((ConfigData.weekly_challenge_shop)[level]).exp), tostring(nextLvCfg))
      -- DECOMPILER ERROR at PC153: Confused about usage of register R13 for local variables in 'ReleaseLocals'

      self:UpdEpRTRefreshBtnState()
    end
  end
end

UIEpResidentStore.UpdEpRTRefreshBtnState = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local curMoney = (ExplorationManager:GetDynPlayer()):GetMoneyCount()
  local canRefresh = (ConfigData.game_config).epResidentStoreRefreshCost <= curMoney
  ;
  ((self.ui).img_Lack):SetActive(not canRefresh)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).btn_ChipRefresh).enabled = canRefresh
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIEpResidentStore._OnClickChipItem = function(self, chipPanel)
  -- function num : 0_7
  if chipPanel == nil then
    return 
  end
  self:_OnComfirmClick(chipPanel)
end

UIEpResidentStore._OnComfirmClick = function(self, chipPanel)
  -- function num : 0_8 , upvalues : _ENV
  local chipItemTran = chipPanel:GetChipItemTransform()
  local chipData = chipPanel:GetChipDetailPanelData()
  ;
  (self.residentStoreCtrl):ReqResidentStorePurchase(chipPanel.index, function()
    -- function num : 0_8_0 , upvalues : _ENV, chipItemTran, chipData, self, chipPanel
    local dungeonStateWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
    if dungeonStateWindow ~= nil then
      local uiPos = (dungeonStateWindow.transform):InverseTransformPoint(chipItemTran.position)
      local localScale = chipItemTran.localScale
      dungeonStateWindow:ShowGetChipAni(chipData, uiPos, localScale)
    end
    do
      local selectChipItem = ((self.chipItemPool).listItem)[chipPanel.index]
      selectChipItem:SetSelectChipItemSold(true, (self.ui).obj_Purchased)
      selectChipItem:ShowSelectChipItemLockBtn(false)
      for _,v in pairs((self.chipItemPool).listItem) do
        (v.panel):OnSelectChipChanged(false)
        ;
        (v.panel):UnSelectAlpha(false)
      end
    end
  end
)
end

UIEpResidentStore._OnClickLockItem = function(self, chipItem)
  -- function num : 0_9
  (self.residentStoreCtrl):ReqEpResidentStoreLock(chipItem.idx, function(locked)
    -- function num : 0_9_0 , upvalues : chipItem
    chipItem:SetSelectChipItemLock(locked)
  end
)
end

UIEpResidentStore._OnClickLevelUp = function(self)
  -- function num : 0_10
  (self.residentStoreCtrl):ReqEpResidentStoreLvUp()
end

UIEpResidentStore._OnClickPreviewLevel = function(self)
  -- function num : 0_11 , upvalues : UINEpRSLevelPreview
  do
    if self.levelPreviewNode == nil then
      local levelPreviewNode = (UINEpRSLevelPreview.New)()
      levelPreviewNode:Init((self.ui).logicPreviewNode)
      self.levelPreviewNode = levelPreviewNode
    end
    ;
    (self.levelPreviewNode):InitEpRSLevelPreview(self.level)
    ;
    (self.levelPreviewNode):Show()
  end
end

UIEpResidentStore._OnClickRefresh = function(self)
  -- function num : 0_12
  (self.residentStoreCtrl):ReqEpResidentStoreRefresh()
end

UIEpResidentStore.OnChipDetailActiveChange = function(self, bool)
  -- function num : 0_13
  if bool then
    self:Hide()
  else
    self:Show()
  end
end

UIEpResidentStore._OnClickReturn = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if self.closeCallback ~= nil then
    (self.closeCallback)()
  end
  local stateInfoWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if stateInfoWindow ~= nil then
    (stateInfoWindow.chipList):TryPlayDungeonChipListSellCloseTween()
  end
  self:Delete()
end

UIEpResidentStore.OnDelete = function(self)
  -- function num : 0_15 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnDungeonDetailWinChange, self.__OnChipDetailActiveChange)
  ;
  (self.chipItemPool):DeleteAll()
  ;
  (self.resLoader):Put2Pool()
  self.resLoader = nil
  if self.levelPreviewNode ~= nil then
    (self.levelPreviewNode):Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UIEpResidentStore

