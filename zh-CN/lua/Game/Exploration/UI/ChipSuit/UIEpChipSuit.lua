local UIEpChipSuit = class("UIEpChipSuit", UIBaseWindow)
local base = UIBaseWindow
local UINEpChipSuitItem = require("Game.Exploration.UI.ChipSuit.UINEpChipSuitItem")
local UINEpChipSuitDescItem = require("Game.Exploration.UI.ChipSuit.UINEpChipSuitDescItem")
local UINChipItemPress = require("Game.CommonUI.Item.UINChipItemPress")
local ChipData = require("Game.PlayerData.Item.ChipData")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
UIEpChipSuit.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINEpChipSuitItem, UINEpChipSuitDescItem, UINChipItemPress
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.OnBtnReturnClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_background, self, self.OnBtnReturnClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SuitDetail, self, self.OnBtnChipSuitDetail)
  ;
  ((self.ui).chipSuitItem):SetActive(false)
  ;
  ((self.ui).suitDescItem):SetActive(false)
  ;
  ((self.ui).chipItem):SetActive(false)
  ;
  ((self.ui).simpleSuitItem):SetActive(false)
  ;
  (((self.ui).btn_SuitDetail).gameObject):SetActive(false)
  self.chipSuitPool = (UIItemPool.New)(UINEpChipSuitItem, (self.ui).chipSuitItem)
  self.simpleChipSuitPool = (UIItemPool.New)(UINEpChipSuitItem, (self.ui).simpleSuitItem)
  self.suitDescPool = (UIItemPool.New)(UINEpChipSuitDescItem, (self.ui).suitDescItem)
  self.chipItemPool = (UIItemPool.New)(UINChipItemPress, (self.ui).chipItem)
  self.__ShowChipDesc = BindCallback(self, self.ShowChipDesc)
  self.__HideChipDesc = BindCallback(self, self.HideChipDesc)
  self.__chipSuitClick = BindCallback(self, self.OnChipSuitItemClick)
  self.__OnEpChipSuitItemClicked = BindCallback(self, self.OnEpChipSuitItemClicked)
  self.__onChipSuitUpdate = BindCallback(self, self.RefreshChipSuitList)
  MsgCenter:AddListener(eMsgEventId.OnEpChipSuitUpdate, self.__onChipSuitUpdate)
end

UIEpChipSuit.InitEpChipSuit = function(self, dynplayer, OnCloseCallback)
  -- function num : 0_1 , upvalues : _ENV
  if not dynplayer then
    self.__dynplayer = (BattleUtil.GetCurDynPlayer)()
    self.OnCloseCallback = OnCloseCallback
  end
end

UIEpChipSuit.RefreshChipSuitSimpleUI = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self.simpleChipSuitPool):HideAll()
  local suitList = (self.__dynplayer):GetChipSuitSortList()
  ;
  (((self.ui).btn_SuitDetail).gameObject):SetActive(#suitList > 0)
  for i = 1, #suitList do
    local chipSuit = suitList[i]
    local chipSuitItem = (self.simpleChipSuitPool):GetOne()
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (chipSuitItem.gameObject).name = tostring(chipSuit.tagId)
    chipSuitItem:InitEpChipSuitItem(chipSuit, self.__OnEpChipSuitItemClicked)
  end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIEpChipSuit.RefreshChipSuitDetailUI = function(self, tagId)
  -- function num : 0_3
  self.__selectChipItem = nil
  self:RefreshChipSuitList(tagId)
  self:_LocateScrollPos(((self.ui).scroll_chipSuit).verticalNormalizedPosition)
end

UIEpChipSuit.RefreshChipSuitList = function(self, tagId)
  -- function num : 0_4 , upvalues : _ENV
  local dynplayer = self.__dynplayer
  local selectChipSuit = nil
  if self.__selectChipItem ~= nil then
    selectChipSuit = (self.__selectChipItem):GetDynChipSuit()
    self.__selectChipItem = nil
  end
  ;
  (self.chipSuitPool):HideAll()
  local chiplist = dynplayer:GetChipSuitSortList()
  if (BattleUtil.IsInDailyDungeon)() then
    local dungeonDyncElem = (PlayerDataCenter.dungeonDyncData):GetDailyDungeonDyncData()
    if dungeonDyncElem ~= nil then
      local lastChipGroup = dungeonDyncElem.lastChipGroup
      do
        if lastChipGroup ~= nil then
          (table.sort)(chiplist, function(a, b)
    -- function num : 0_4_0 , upvalues : lastChipGroup
    local v1 = lastChipGroup[a.tagId]
    local v2 = lastChipGroup[b.tagId]
    if v1 >= v2 then
      do return v1 == nil or v2 == nil or v1 == v2 end
      do return a.tagId < b.tagId end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
)
        end
      end
    end
  end
  do
    if #chiplist <= 0 then
      (self.suitDescPool):HideAll()
      ;
      (self.chipItemPool):HideAll()
      ;
      ((self.ui).suitTitleNode):SetActive(false)
      ;
      ((self.ui).suitSelectNode):SetActive(false)
      return 
    else
      ;
      ((self.ui).suitTitleNode):SetActive(true)
      ;
      ((self.ui).suitSelectNode):SetActive(true)
    end
    for _,chipSuit in pairs(chiplist) do
      local chipSuitItem = (self.chipSuitPool):GetOne()
      chipSuitItem:InitEpChipSuitItem(chipSuit, self.__chipSuitClick)
      if chipSuit == selectChipSuit then
        self.__selectChipItem = chipSuitItem
      else
        if self.__selectChipItem == nil and chipSuit.tagId == tagId then
          self.__selectChipItem = chipSuitItem
        end
      end
    end
    if self.__selectChipItem == nil then
      self.__selectChipItem = ((self.chipSuitPool).listItem)[1]
    end
    self:HideChipDesc()
    self:__RefreshSelectChipSuit(self.__selectChipItem)
  end
end

UIEpChipSuit._LocateScrollPos = function(self, verticalNormalizedPosition)
  -- function num : 0_5 , upvalues : _ENV
  if verticalNormalizedPosition ~= nil then
    (((CS.UnityEngine).Canvas).ForceUpdateCanvases)()
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).scroll).verticalNormalizedPosition = verticalNormalizedPosition
    return 
  end
  if self.__selectChipItem == nil then
    return 
  end
  for i,v in ipairs((self.chipSuitPool).listItem) do
    if v == self.__selectChipItem then
      (((CS.UnityEngine).Canvas).ForceUpdateCanvases)()
      local scrollHeight = ((((self.ui).scroll).transform).rect).height
      local rectHeight = ((((self.ui).scroll).content).rect).height
      local overRectIndex = (math.floor)(scrollHeight / (rectHeight / #(self.chipSuitPool).listItem))
      if overRectIndex < i then
        local allOverCount = #(self.chipSuitPool).listItem - overRectIndex
        do
          do
            local overCount = i - overRectIndex
            -- DECOMPILER ERROR at PC57: Confused about usage of register: R12 in 'UnsetPending'

            ;
            ((self.ui).scroll).verticalNormalizedPosition = 1 - overCount / allOverCount
            do break end
            -- DECOMPILER ERROR at PC61: Confused about usage of register: R10 in 'UnsetPending'

            ;
            ((self.ui).scroll).verticalNormalizedPosition = 1
            do break end
            -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

UIEpChipSuit.OnChipSuitItemClick = function(self, chipSuitItem)
  -- function num : 0_6
  if self.__selectChipItem == chipSuitItem then
    return 
  end
  self.__selectChipItem = chipSuitItem
  self:__RefreshSelectChipSuit(chipSuitItem)
end

UIEpChipSuit.__RefreshSelectChipSuit = function(self, chipSuitItem)
  -- function num : 0_7 , upvalues : _ENV, ChipData
  (((self.ui).suitSelectNode).transform):SetParent(chipSuitItem.transform)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).suitSelectNode).transform).localPosition = Vector3.zero
  local chipSuit = chipSuitItem:GetDynChipSuit()
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_TagName).text = chipSuit:GetChipSuitName()
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_TagIcon).sprite = chipSuit:GetChipSuitIconSprite()
  ;
  (self.chipItemPool):HideAll()
  local normalChipDic = (self.__dynplayer):GetNormalChipDic()
  local tmpBuffChipDic = (self.__dynplayer):GetTmpBuffChipDic()
  local chipDataList = {}
  local haveCount = 0
  local previewChipDataDic = ExplorationManager:GetChipDataPreviewDic(true)
  for _,chipId in pairs(chipSuit:GetSuitChipList()) do
    local chipData = nil
    local have = false
    if normalChipDic[chipId] ~= nil then
      chipData = normalChipDic[chipId]
      have = true
    else
      if tmpBuffChipDic[chipId] ~= nil then
        chipData = tmpBuffChipDic[chipId]
        have = true
      else
        chipData = previewChipDataDic[chipId]
        if chipData == nil then
          chipData = (ChipData.NewChipForLocal)(chipId)
        end
      end
    end
    if have then
      haveCount = haveCount + 1
      ;
      (table.insert)(chipDataList, haveCount, chipData)
    else
      ;
      (table.insert)(chipDataList, chipData)
    end
  end
  for index,chipData in pairs(chipDataList) do
    local chipItem = (self.chipItemPool):GetOne()
    chipItem:InitChipItemWithPress(chipData, false, self.__ShowChipDesc, self.__HideChipDesc)
    chipItem:UnlockChipItem(index <= haveCount)
  end
  local isShowDetail = (CommonUtil.GetDetailDescribeSetting)(eGameSetDescType.chip)
  ;
  (self.suitDescPool):HideAll()
  local count = chipSuit:GetChipSuitCount()
  for _,tag_suit in pairs(chipSuit.tagSuitCfg) do
    local chipDescItem = (self.suitDescPool):GetOne()
    local active = false
    if tag_suit.number <= count then
      active = true
    end
    chipDescItem:InitSuitDescItem(tag_suit.number, active, ConfigData:GetChipDescriptionById(tag_suit.chip_id, 1, isShowDetail))
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UIEpChipSuit.ShowChipDesc = function(self, chipData, chipItem)
  -- function num : 0_8 , upvalues : _ENV, HAType, VAType
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  local showDetail = (CommonUtil.GetDetailDescribeSetting)(eGameSetDescType.chip)
  win:SetTitleAndContext(chipData:GetName(), chipData:GetChipDescription(showDetail))
  win:FloatTo(chipItem.transform, HAType.left, VAType.up)
end

UIEpChipSuit.HideChipDesc = function(self, chipData, chipItem)
  -- function num : 0_9 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

UIEpChipSuit.OnBtnReturnClicked = function(self)
  -- function num : 0_10
  self:_SetDetailUIActive(false)
end

UIEpChipSuit.OnBtnChipSuitDetail = function(self)
  -- function num : 0_11
  self:_SetDetailUIActive(true)
  self:RefreshChipSuitDetailUI(nil)
end

UIEpChipSuit.OnEpChipSuitItemClicked = function(self, chipSuitItem)
  -- function num : 0_12
  self:_SetDetailUIActive(true)
  local chipSuit = chipSuitItem:GetDynChipSuit()
  self:RefreshChipSuitDetailUI(chipSuit.tagId)
end

UIEpChipSuit._SetDetailUIActive = function(self, active)
  -- function num : 0_13 , upvalues : _ENV
  if active then
    AudioManager:PlayAudioById(1070)
  else
    AudioManager:PlayAudioById(1071)
  end
  ;
  ((self.ui).obj_chipSuitNode):SetActive(not active)
  ;
  ((self.ui).obj_chipSuitDetail):SetActive(active)
  ;
  (((self.ui).btn_background).gameObject):SetActive(active)
end

UIEpChipSuit.OnDelete = function(self)
  -- function num : 0_14 , upvalues : _ENV, base
  if self.OnCloseCallback ~= nil then
    (self.OnCloseCallback)()
  end
  MsgCenter:RemoveListener(eMsgEventId.OnEpChipSuitUpdate, self.__onChipSuitUpdate)
  ;
  (base.OnDelete)(self)
end

return UIEpChipSuit

