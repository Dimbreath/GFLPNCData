-- params : ...
-- function num : 0 , upvalues : _ENV
local UISelectChip = class("UISelectChip", UIBaseWindow)
local base = UIBaseWindow
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINChipDetailPanel")
local cs_GameObject = (CS.UnityEngine).GameObject
local REFRESH_CHIP_UID = 4294967300
UISelectChip.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_return, self, self.__OnClickSkipButton)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Refresh, self, self.__ClickRefresh)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CampBondSkill, self, self.__OnClickActiveCampFetter)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Skip, self, self.OnClickGiveup)
  ;
  ((self.ui).propChipItem):SetActive(false)
  self.__ShowDungeonState = BindCallback(self, self.ShowDungeonState)
  MsgCenter:AddListener(eMsgEventId.OnSettleMentTimeLinePlayToEnd, self.__ShowDungeonState)
end

UISelectChip.OnShow = function(self)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.OnShow)(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, false)
end

UISelectChip.OnHide = function(self)
  -- function num : 0_2 , upvalues : base, _ENV
  (base.OnHide)(self)
  MsgCenter:Broadcast(eMsgEventId.OnEpBuffListDisplay, true)
end

UISelectChip.InitSelectChip = function(self, chipDataList, dynPlayer, selectEvent, giveupEvent, toFakeCamera)
  -- function num : 0_3 , upvalues : _ENV, UINChipDetailPanel
  self.toFakeCamera = toFakeCamera
  self.dynPlayer = dynPlayer
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
  end
  self.resloader = ((CS.ResLoader).Create)()
  self.selectEvent = selectEvent
  self.giveupEvent = giveupEvent
  self.chipPanelList = {}
  self.chipDataList = chipDataList
  local clickedPanelAction = BindCallback(self, self.OnChipPanelClicked)
  local epChipIdDica = (ExplorationManager:GetEpDataCenter()):GetEpChipIdDic()
  for k,chipData in ipairs(chipDataList) do
    local go = ((self.ui).propChipItem):Instantiate()
    local panel = (UINChipDetailPanel.New)()
    panel:Init(go)
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (panel.gameObject).name = tostring(k)
    panel:Show()
    panel:InitChipDetailPanel(k, chipData, dynPlayer, self.resloader, clickedPanelAction)
    panel:SetUIModifier((self.ui).modifier)
    local isNew = epChipIdDica[chipData.dataId] or false
    panel:SetObjNewTagActive(isNew)
    ;
    (table.insert)(self.chipPanelList, panel)
  end
  if toFakeCamera then
    self:__ToFackCameraCanvas()
    ;
    (self.transform):SetLayer(LayerMask.UI3D)
  else
    ;
    (self.transform):SetLayer(LayerMask.UI)
    if GuideManager:TryTriggerGuide(eGuideCondition.InSelectChip) then
      for k,panelItem in pairs(self.chipPanelList) do
        local chipData = panelItem:GetChipDetailPanelData()
        -- DECOMPILER ERROR at PC105: Confused about usage of register: R14 in 'UnsetPending'

        ;
        (panelItem.gameObject).name = tostring(chipData.dataId)
      end
    end
  end
  do
    self:RefreshGiveupState(chipDataList)
    MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, false)
  end
end

UISelectChip.RefreshChipList = function(self, chipDataList)
  -- function num : 0_4 , upvalues : _ENV, UINChipDetailPanel
  for index,panel in ipairs(self.chipPanelList) do
    panel:Delete()
  end
  self.selectChip = nil
  self.chipPanelList = {}
  self.chipDataList = chipDataList
  local clickedPanelAction = BindCallback(self, self.OnChipPanelClicked)
  local epChipIdDica = (ExplorationManager:GetEpDataCenter()):GetEpChipIdDic()
  for k,chipData in ipairs(chipDataList) do
    local go = ((self.ui).propChipItem):Instantiate()
    local panel = (UINChipDetailPanel.New)()
    panel:Init(go)
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (panel.gameObject).name = tostring(k)
    panel:Show()
    panel:InitChipDetailPanel(k, chipData, dynPlayer, self.resloader, clickedPanelAction)
    local isNew = epChipIdDica[chipData.dataId] or false
    panel:SetObjNewTagActive(isNew)
    ;
    (table.insert)(self.chipPanelList, panel)
  end
  self:RefreshGiveupState(chipDataList)
end

UISelectChip.GetMaxInPlayPowerChip = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local fightPower = -1
  local quality = -1
  local powerChipPanel = nil
  for k,chipPanel in pairs(self.chipPanelList) do
    local curFightPower = chipPanel:GetInPlayFightPower(self.dynPlayer)
    if fightPower < curFightPower or curFightPower == fightPower and quality < chipPanel:GetChipQuality() then
      fightPower = curFightPower
      quality = chipPanel:GetChipQuality()
      powerChipPanel = chipPanel
    end
  end
  return powerChipPanel
end

UISelectChip.RefreshGiveupState = function(self, chipDataList)
  -- function num : 0_6 , upvalues : _ENV
  if self.giveupEvent == nil then
    (((self.ui).btn_Skip).gameObject):SetActive(false)
    return 
  end
  ;
  (((self.ui).btn_Skip).gameObject):SetActive(true)
  local qualityChip = nil
  for k,v in pairs(chipDataList) do
    if qualityChip == nil or qualityChip.quality < v.quality then
      qualityChip = v
    end
  end
  if qualityChip == nil then
    (((self.ui).priceText).gameObject):SetActive(false)
    return 
  end
  ;
  (((self.ui).priceText).gameObject):SetActive(true)
  local epId = ((ExplorationManager.epCtrl).mapData).exploraionId
  local epShopId = (((ConfigData.exploration)[epId]).store_pool)[1]
  local epShop = (ConfigData.exploration_shop)[epShopId]
  local index = 0
  for i = 1, #epShop.discount_level do
    if (epShop.discount_level)[i] <= (qualityChip.chipBattleData).level then
      index = i
      break
    end
  end
  do
    if index == 0 then
      index = #epShop.discount_level
    end
    local price = (qualityChip.itemCfg).price * (epShop.discount_scale)[index] / 1000
    price = (math.floor)(price)
    -- DECOMPILER ERROR at PC92: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.ui).priceText).text = tostring(price)
  end
end

UISelectChip.OnChipPanelClicked = function(self, chipPanel)
  -- function num : 0_7 , upvalues : _ENV
  if chipPanel == nil then
    return 
  end
  local stateInfoWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if stateInfoWindow == nil or not ((stateInfoWindow.chipList).gameObject).activeInHierarchy then
    return 
  end
  if self.selectChip == chipPanel then
    self:ComfirmSelectChip(chipPanel)
  else
    ;
    (stateInfoWindow.chipList):HighlightChipItem(chipPanel:GetChipDetailPanelData())
  end
  if self.selectChip ~= nil then
    (self.selectChip):OnSelectChipChanged(false)
  end
  chipPanel:OnSelectChipChanged(true)
  self.selectChip = chipPanel
  for _,v in pairs(self.chipPanelList) do
    if v ~= self.selectChip then
      v:SetUnSelectAlpha()
    end
  end
  if self.ui ~= nil and ((self.ui).obj_TitleName).activeSelf and self.selectChip ~= nil then
    ((self.ui).obj_TitleName):SetActive(false)
  end
end

UISelectChip.ComfirmSelectChip = function(self, chipPanel)
  -- function num : 0_8 , upvalues : _ENV
  local index = chipPanel.index
  if self.selectEvent ~= nil then
    (self.selectEvent)(index, function()
    -- function num : 0_8_0 , upvalues : self, index, _ENV
    local chipPanelItem = (self.chipPanelList)[index]
    if chipPanelItem ~= nil then
      local chipData = chipPanelItem:GetChipDetailPanelData()
      local chipItem = chipPanelItem:GetChipItem()
      local dungeonStateWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
      do
        do
          if dungeonStateWindow ~= nil then
            local uiPos = nil
            if self.toFakeCamera then
              uiPos = UIManager:World2UIPosition((chipItem.transform).position)
              uiPos = (Vector3.New)(uiPos.x, uiPos.y, 0)
            else
              uiPos = (self.transform):InverseTransformPoint((chipItem.transform).position)
            end
            dungeonStateWindow:ShowGetChipAni(chipData, uiPos, (chipItem.transform).localScale)
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
  -- function num : 0_9
  if self.giveupEvent ~= nil then
    (self.giveupEvent)(function()
    -- function num : 0_9_0 , upvalues : self
    self:Delete()
  end
)
  end
end

UISelectChip.UpdateRefreshCount = function(self, isCouldRefresh, remaindTime)
  -- function num : 0_10 , upvalues : _ENV
  (((self.ui).btn_Refresh).gameObject):SetActive(isCouldRefresh)
  if isCouldRefresh then
    ((self.ui).tex_RefreshCount):SetIndex(0, tostring(remaindTime))
  end
end

UISelectChip.SetClickRefreshCallback = function(self, clickRefreshCallback)
  -- function num : 0_11
  self.clickRefreshCallback = clickRefreshCallback
end

UISelectChip.__ClickRefresh = function(self)
  -- function num : 0_12
  if self.clickRefreshCallback ~= nil then
    (self.clickRefreshCallback)()
  end
end

UISelectChip.SetHasEpActiveCampFetter = function(self, hasEpActive)
  -- function num : 0_13
  ((self.ui).obj_btn_CampBondSkill):SetActive(hasEpActive)
end

UISelectChip.SetActiveCampFetter = function(self, campId, heroNum, couldUse, cdStr)
  -- function num : 0_14 , upvalues : _ENV
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
  -- function num : 0_15
  self.useCampFetterCallback = useCampFetterCallback
end

UISelectChip.__OnClickActiveCampFetter = function(self)
  -- function num : 0_16
  if self.useCampFetterCallback ~= nil then
    (self.useCampFetterCallback)()
  end
end

UISelectChip.__OnClickSkipButton = function(self)
  -- function num : 0_17 , upvalues : _ENV
  ((CS.MessageCommon).ShowMessageBox)(ConfigData:GetTipContent(1011), function()
    -- function num : 0_17_0 , upvalues : self
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
  -- function num : 0_18 , upvalues : cs_GameObject, _ENV
  local fakeCameraBattle = ((cs_GameObject.Find)("FakeCameraBattleChip")):FindComponent(eUnityComponentID.Camera)
  self:AlignToFakeCamera(fakeCameraBattle)
end

UISelectChip.ShowDungeonState = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  win:Show()
  win:RefreshHeroListHp()
  win:OnlyShowChipList(true)
  win:ChipListWeakenTween(false)
  if GuideManager:TryTriggerGuide(eGuideCondition.InSelectChip) then
    for k,panelItem in pairs(self.chipPanelList) do
      local chipData = panelItem:GetChipDetailPanelData()
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (panelItem.gameObject).name = tostring(chipData.dataId)
    end
  end
end

UISelectChip.OnDelete = function(self)
  -- function num : 0_20 , upvalues : _ENV, base
  if not self.toFakeCamera then
    MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, true)
  end
  MsgCenter:RemoveListener(eMsgEventId.OnSettleMentTimeLinePlayToEnd, self.__ShowDungeonState)
  local window = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if window ~= nil then
    (window.chipList):CancelHighlightChipItem()
  end
  ;
  (base.OnDelete)(self)
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
end

return UISelectChip

