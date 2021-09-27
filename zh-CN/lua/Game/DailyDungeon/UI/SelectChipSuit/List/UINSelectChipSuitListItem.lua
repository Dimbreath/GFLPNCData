local UINSelectChipSuitListItem = class("UINSelectChipSuitListItem", UIBaseNode)
local base = UIBaseNode
local ChipData = require("Game.PlayerData.Item.ChipData")
local UINChipItemPress = require("Game.CommonUI.Item.UINChipItemPress")
local UINSltChipSuitItemIntro = require("Game.DailyDungeon.UI.SelectChipSuit.List.UINSltChipSuitItemIntro")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
UINSelectChipSuitListItem.ctor = function(self, seChipSuitList)
  -- function num : 0_0
  self.seChipSuitList = seChipSuitList
end

UINSelectChipSuitListItem.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINChipItemPress
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_RichIntro, self, self._OnClickShowIntro)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_root, self, self._OnClickRoot)
  ;
  (((self.ui).uINChipItem).gameObject):SetActive(false)
  self.chipItemPool = (UIItemPool.New)(UINChipItemPress, (self.ui).uINChipItem)
  self.__ShowChipDesc = BindCallback(self, self._ShowChipDesc)
  self.__HideChipDesc = BindCallback(self, self._HideChipDesc)
end

UINSelectChipSuitListItem.InitSelectChipSuitListItem = function(self, seChipSuitData, showIntro, selected)
  -- function num : 0_2 , upvalues : _ENV, ChipData
  self.seChipSuitData = seChipSuitData
  local dynChipSuitData = seChipSuitData.dynChipSuitData
  self.chipTagId = dynChipSuitData.tagId
  self._selected = selected
  self._showIntro = showIntro
  self:_ShowIntroNode(showIntro)
  self:_ShowSelect(selected)
  local influenceId = dynChipSuitData:GetSuitChipInfluence()
  local career = (ConfigData.career)[influenceId]
  if career == nil then
    ((self.ui).tex_Apply):SetIndex(1)
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).img_Career).enabled = false
  else
    ;
    ((self.ui).tex_Apply):SetIndex(0, (LanguageUtil.GetLocaleText)(career.name))
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).img_Career).sprite = CRH:GetSprite(career.icon, CommonAtlasType.CareerCamp)
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).img_Career).enabled = true
  end
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R7 in 'UnsetPending'

  if not ((self.ui).highlightColors)[influenceId] then
    ((self.ui).img_Light).color = Color.white
    -- DECOMPILER ERROR at PC63: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = dynChipSuitData:GetChipSuitIconSprite()
    -- DECOMPILER ERROR at PC68: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).text = dynChipSuitData:GetChipSuitName()
    local canUseNum = (math.max)(seChipSuitData.selectNumMax - seChipSuitData.selectNumCur, 0)
    ;
    ((self.ui).tex_Count):SetIndex(0, tostring(canUseNum), tostring(seChipSuitData.selectNumMax))
    local useUp = seChipSuitData.selectNumMax <= seChipSuitData.selectNumCur
    ;
    ((self.ui).obj_NoCount):SetActive(useUp)
    -- DECOMPILER ERROR at PC101: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((self.ui).btn_root).interactable = not useUp
    ;
    (self.chipItemPool):HideAll()
    local chipIdList = dynChipSuitData:GetSuitChipList()
    for k,chipId in ipairs(chipIdList) do
      local chipData = (ChipData.NewChipForLocal)(chipId, seChipSuitData.chipQuality)
      local chipItem = (self.chipItemPool):GetOne()
      chipItem:InitChipItemWithPress(chipData, false, self.__ShowChipDesc, self.__HideChipDesc)
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

UINSelectChipSuitListItem._ShowChipDesc = function(self, chipData, chipItem)
  -- function num : 0_3 , upvalues : _ENV, HAType, VAType
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  local showDesc = (CommonUtil.GetDetailDescribeSetting)(eGameSetDescType.chip)
  win:SetTitleAndContext(chipData:GetName(), chipData:GetChipDescription(showDesc))
  win:FloatTo(chipItem.transform, HAType.left, VAType.up)
end

UINSelectChipSuitListItem._HideChipDesc = function(self, chipData, chipItem)
  -- function num : 0_4 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

UINSelectChipSuitListItem._OnClickRoot = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local selected = not self._selected
  if not (self.seChipSuitList):TrySelectChipSuitItem(self.chipTagId, selected) then
    return 
  end
  self._selected = selected
  self:_ShowSelect(self._selected)
  if self._selected then
    AudioManager:PlayAudioById(1058)
  end
end

UINSelectChipSuitListItem._ShowSelect = function(self, show)
  -- function num : 0_6 , upvalues : _ENV
  if show then
    if IsNull(self.selectObj) then
      self.selectObj = ((self.ui).obj_IsSelect):Instantiate(self.transform)
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.selectObj).transform).anchoredPosition = Vector2.zero
    end
    ;
    (self.selectObj):SetActive(true)
  else
    if not IsNull(self.selectObj) then
      (self.selectObj):SetActive(false)
    end
  end
  ;
  ((self.ui).img_IsSel):SetIndex(show and 1 or 0)
end

UINSelectChipSuitListItem._OnClickShowIntro = function(self)
  -- function num : 0_7 , upvalues : _ENV
  self._showIntro = not self._showIntro
  self:_ShowIntroNode(self._showIntro)
  ;
  (self.seChipSuitList):RecordSeChipSuitListItemIntroState(self.chipTagId, self._showIntro)
  if self._showIntro then
    AudioManager:PlayAudioById(1072)
  end
end

UINSelectChipSuitListItem._ShowIntroNode = function(self, show)
  -- function num : 0_8 , upvalues : UINSltChipSuitItemIntro
  local index = show and 1 or 0
  ;
  ((self.ui).img_RichIntro):SetIndex(index)
  if show then
    do
      if self.introNode == nil then
        local go = ((self.ui).introItem):Instantiate((self.ui).richIntroHolder)
        self.introNode = (UINSltChipSuitItemIntro.New)()
        ;
        (self.introNode):Init(go)
      end
      ;
      (self.introNode):Show()
      ;
      (self.introNode):InitSltChipSuitItemIntro(self.chipTagId)
      ;
      ((self.ui).obj_normal):SetActive(false)
      if self.introNode ~= nil then
        (self.introNode):Hide()
        ;
        ((self.ui).obj_normal):SetActive(true)
      end
    end
  end
end

UINSelectChipSuitListItem.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  (self.chipItemPool):DeleteAll()
  if self.introNode ~= nil then
    (self.introNode):Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UINSelectChipSuitListItem

