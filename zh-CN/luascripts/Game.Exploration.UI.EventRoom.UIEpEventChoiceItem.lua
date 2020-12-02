-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEpEventChoiceItem = class("UIEpEventChoiceItem", UIBaseNode)
local base = UIBaseNode
local UINChipItem = require("Game.CommonUI.Item.UINChipItem")
local ChipData = require("Game.PlayerData.Item.ChipData")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
UIEpEventChoiceItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINChipItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_choiceItem, self, self.OnChoiceItemClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_chipNode, self, self.OnChipItemClick)
  local chipItem = (UINChipItem.New)()
  chipItem:Init((self.ui).uINChipItem)
  self.chipItem = chipItem
end

UIEpEventChoiceItem.InitEventChoiceItem = function(self, choiceData, clickAction)
  -- function num : 0_1
  self.idx = choiceData.idx
  self.choiceId = choiceData.choiceId
  self.onClickAction = clickAction
  self.catId = choiceData.catId
  self:RefreshChoiceUI(choiceData)
end

UIEpEventChoiceItem.RefreshChoiceUI = function(self, choiceData)
  -- function num : 0_2 , upvalues : ExplorationEnum, _ENV
  if choiceData.catId == (ExplorationEnum.eEventRoomChoiceType).Normal then
    self.cfg = (ConfigData.event_choice)[choiceData.choiceId]
    if self.cfg == nil then
      error("Can`t find choiceCfg id:" .. tostring(choiceData.choiceId))
      return 
    end
  else
    if choiceData.catId == (ExplorationEnum.eEventRoomChoiceType).Upgrade then
      self.cfg = (ConfigData.event_upgrade)[choiceData.choiceId]
    else
      if choiceData.catId == (ExplorationEnum.eEventRoomChoiceType).Jump then
        self.cfg = (ConfigData.event_jump)[choiceData.choiceId]
      end
    end
  end
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Describe).text = (LanguageUtil.GetLocaleText)((self.cfg).describe)
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite((self.cfg).icon, CommonAtlasType.ExplorationIcon)
  -- DECOMPILER ERROR at PC73: Confused about usage of register: R2 in 'UnsetPending'

  if not (self.cfg).choice_color or not Color.white then
    ((self.ui).tex_Describe).color = Color.black
    -- DECOMPILER ERROR at PC96: Confused about usage of register: R2 in 'UnsetPending'

    if not (self.cfg).choice_color or not (Color.New)(1, 1, 1, 0.3) then
      ((self.ui).img_IconBg).color = (Color.New)(0, 0, 0, 0.7)
      ;
      ((self.ui).img_Buttom):SetIndex((self.cfg).choice_color and 1 or 0)
      self:__SetChipItem()
      if choiceData.isAble ~= nil then
        self:SetItemCanClick(choiceData.isAble)
      end
    end
  end
end

UIEpEventChoiceItem.SetItemCanClick = function(self, isAble)
  -- function num : 0_3 , upvalues : _ENV
  self.isAble = isAble
  if not isAble or not Color.white then
    local color = (self.ui).col_CantSelect
  end
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).img_Buttom).image).color = color
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).color = color
  ;
  ((self.ui).ani_Select):SetActive(isAble)
end

UIEpEventChoiceItem.OnChoiceItemClick = function(self)
  -- function num : 0_4
  if self.onClickAction ~= nil then
    (self.onClickAction)(self.cfg, self.idx, self.isAble, self.catId)
  end
end

UIEpEventChoiceItem.__SetChipItem = function(self)
  -- function num : 0_5 , upvalues : _ENV, ChipData
  local getItem = (self.cfg).choiceGetNew
  if ConfigData:GetItemType(getItem.dataID) ~= eItemType.GlobalChip then
    do
      local isChip = getItem == nil
      ;
      (((self.ui).btn_chipNode).gameObject):SetActive(isChip)
      if isChip == true then
        self.chipData = (ChipData.New)(getItem.dataID)
        ;
        (self.chipItem):InitChipItem(self.chipData, getItem.dataNum)
      end
      ;
      (((self.ui).btn_chipNode).gameObject):SetActive(false)
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
end

UIEpEventChoiceItem.OnChipItemClick = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.chipData == nil then
    return 
  end
  local win = UIManager:ShowWindow(UIWindowTypeID.DungeonInfoDetail)
  local chipDataList = {}
  ;
  (table.insert)(chipDataList, self.chipData)
  win:ShowChipDetail(chipDataList, 1, nil, nil)
  win:SetSwitchBtnActive(false)
end

UIEpEventChoiceItem.GetAutoTipsHolder = function(self)
  -- function num : 0_7
  return (self.ui).autoTipsHolder
end

return UIEpEventChoiceItem

