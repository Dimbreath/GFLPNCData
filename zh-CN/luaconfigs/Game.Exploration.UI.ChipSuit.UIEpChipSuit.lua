-- params : ...
-- function num : 0 , upvalues : _ENV
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
  ((self.ui).chipSuitItem):SetActive(false)
  ;
  ((self.ui).suitDescItem):SetActive(false)
  ;
  ((self.ui).chipItem):SetActive(false)
  self.chipSuitPool = (UIItemPool.New)(UINEpChipSuitItem, (self.ui).chipSuitItem)
  self.suitDescPool = (UIItemPool.New)(UINEpChipSuitDescItem, (self.ui).suitDescItem)
  self.chipItemPool = (UIItemPool.New)(UINChipItemPress, (self.ui).chipItem)
  self.__ShowChipDesc = BindCallback(self, self.ShowChipDesc)
  self.__HideChipDesc = BindCallback(self, self.HideChipDesc)
  self.__chipSuitClick = BindCallback(self, self.OnChipSuitItemClick)
  self.__onChipSuitUpdate = BindCallback(self, self.RefreshChipSuitList)
  MsgCenter:AddListener(eMsgEventId.OnEpChipSuitUpdate, self.__onChipSuitUpdate)
end

UIEpChipSuit.InitChipSuitUI = function(self, dynplayer, tagId, OnCloseCallback, verticalNormalizedPosition)
  -- function num : 0_1
  self.__dynplayer = dynplayer
  self:RefreshChipSuitList(tagId)
  self:_LocateScrollPos(verticalNormalizedPosition)
  self.OnCloseCallback = OnCloseCallback
end

UIEpChipSuit.RefreshChipSuitList = function(self, tagId)
  -- function num : 0_2 , upvalues : _ENV
  local dynplayer = self.__dynplayer
  local selectChipSuit = nil
  if self.__selectChipItem ~= nil then
    selectChipSuit = (self.__selectChipItem):GetDynChipSuit()
    self.__selectChipItem = nil
  end
  ;
  (self.chipSuitPool):HideAll()
  local chiplist = dynplayer:GetChipSuitSortList()
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

UIEpChipSuit._LocateScrollPos = function(self, verticalNormalizedPosition)
  -- function num : 0_3 , upvalues : _ENV
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
  -- function num : 0_4
  if self.__selectChipItem == chipSuitItem then
    return 
  end
  self.__selectChipItem = chipSuitItem
  self:__RefreshSelectChipSuit(chipSuitItem)
end

UIEpChipSuit.__RefreshSelectChipSuit = function(self, chipSuitItem)
  -- function num : 0_5 , upvalues : _ENV, ChipData
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
  local previewChipDataDic = ExplorationManager:GetChipDataPreviewDic()
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
  ;
  (self.suitDescPool):HideAll()
  local count = chipSuit:GetChipSuitCount()
  for _,tag_suit in pairs(chipSuit.tagSuitCfg) do
    local chipDescItem = (self.suitDescPool):GetOne()
    local active = false
    if tag_suit.number <= count then
      active = true
    end
    chipDescItem:InitSuitDescItem(tag_suit.number, active, (LanguageUtil.GetLocaleText)(tag_suit.suit_info))
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UIEpChipSuit.ShowChipDesc = function(self, chipData, chipItem)
  -- function num : 0_6 , upvalues : _ENV, HAType, VAType
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext(chipData:GetName(), chipData:GetChipDescription())
  win:FloatTo(chipItem.transform, HAType.left, VAType.up)
end

UIEpChipSuit.HideChipDesc = function(self, chipData, chipItem)
  -- function num : 0_7 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

UIEpChipSuit.OnBtnReturnClicked = function(self)
  -- function num : 0_8
  if self.OnCloseCallback ~= nil then
    (self.OnCloseCallback)()
  end
  self:Delete()
end

UIEpChipSuit.OnDelete = function(self)
  -- function num : 0_9 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnEpChipSuitUpdate, self.__onChipSuitUpdate)
  ;
  (base.OnDelete)(self)
end

return UIEpChipSuit

