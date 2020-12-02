-- params : ...
-- function num : 0 , upvalues : _ENV
local UISelectChip = class("UISelectChip", UIBaseWindow)
local base = UIBaseWindow
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINChipDetailPanel")
local cs_GameObject = (CS.UnityEngine).GameObject
UISelectChip.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_skip, self, self.__OnClickSkipButton)
  ;
  ((self.ui).propChipItem):SetActive(false)
  self.__ShowDungeonState = BindCallback(self, self.ShowDungeonState)
  MsgCenter:AddListener(eMsgEventId.OnSettleMentTimeLinePlayToEnd, self.__ShowDungeonState)
end

UISelectChip.InitSelectChip = function(self, chipDataList, dynPlayer, selectEvent, toFakeCamera)
  -- function num : 0_1 , upvalues : _ENV, UINChipDetailPanel
  self.toFakeCamera = toFakeCamera
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
  end
  self.resloader = ((CS.ResLoader).Create)()
  self.selectEvent = selectEvent
  self.chipPanelList = {}
  self.chipDataList = chipDataList
  local clickedPanelAction = BindCallback(self, self.OnChipPanelClicked)
  local epChipIdDica = (ExplorationManager:GetEpDataCenter()):GetEpChipIdDic()
  for k,chipData in ipairs(chipDataList) do
    local go = ((self.ui).propChipItem):Instantiate()
    local panel = (UINChipDetailPanel.New)()
    panel:Init(go)
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R14 in 'UnsetPending'

    ;
    (panel.gameObject).name = tostring(k)
    panel:Show()
    panel:InitChipDetailPanel(k, chipData, dynPlayer, self.resloader, clickedPanelAction)
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
        -- DECOMPILER ERROR at PC99: Confused about usage of register: R13 in 'UnsetPending'

        ;
        (panelItem.gameObject).name = tostring(chipData.dataId)
      end
    end
  end
  do
    MsgCenter:Broadcast(eMsgEventId.DungeonHeroListActiveSet, false)
  end
end

UISelectChip.GetMaxPowerChipPanel = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local fightPower = -1
  local quality = -1
  local powerChipPanel = nil
  for k,chipPanel in pairs(self.chipPanelList) do
    if fightPower < chipPanel.fightPower or chipPanel.fightPower == fightPower and quality < chipPanel:GetChipQuality() then
      fightPower = chipPanel.fightPower
      quality = chipPanel:GetChipQuality()
      powerChipPanel = chipPanel
    end
  end
  return powerChipPanel
end

UISelectChip.OnChipPanelClicked = function(self, chipPanel)
  -- function num : 0_3 , upvalues : _ENV
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
  -- function num : 0_4 , upvalues : _ENV
  local index = chipPanel.index
  if self.selectEvent ~= nil then
    (self.selectEvent)(index, function()
    -- function num : 0_4_0 , upvalues : self, index, _ENV
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

UISelectChip.__OnClickSkipButton = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((CS.MessageCommon).ShowMessageBox)(ConfigData:GetTipContent(1011), function()
    -- function num : 0_5_0 , upvalues : self
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
  -- function num : 0_6 , upvalues : cs_GameObject, _ENV
  local fakeCameraBattle = ((cs_GameObject.Find)("FakeCameraBattleChip")):FindComponent(eUnityComponentID.Camera)
  self:AlignToFakeCamera(fakeCameraBattle)
end

UISelectChip.ShowDungeonState = function(self)
  -- function num : 0_7 , upvalues : _ENV
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
  -- function num : 0_8 , upvalues : _ENV, base
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

