local UINChipDetailSuitInfo = class("UINChipDetailSuitInfo", UIBaseNode)
local base = UIBaseNode
local UINEpChipSuitDescItem = require("Game.Exploration.UI.ChipSuit.UINEpChipSuitDescItem")
local UINChipItemPress = require("Game.CommonUI.Item.UINChipItemPress")
local ChipData = require("Game.PlayerData.Item.ChipData")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local cs_TweenLoopType = ((CS.DG).Tweening).LoopType
UINChipDetailSuitInfo.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINEpChipSuitDescItem, UINChipItemPress
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self._OnClickClose)
  ;
  ((self.ui).obj_Text):SetActive(false)
  self.suitDescPool = (UIItemPool.New)(UINEpChipSuitDescItem, (self.ui).obj_Text)
  ;
  ((self.ui).uINChipItem):SetActive(false)
  self.chipItemPool = (UIItemPool.New)(UINChipItemPress, (self.ui).uINChipItem)
  self.__ShowChipDesc = BindCallback(self, self._ShowChipDesc)
  self.__HideChipDesc = BindCallback(self, self._HideChipDesc)
end

UINChipDetailSuitInfo.InitChipDetailSuitInfo = function(self, chipTagId, curChipData, closeCallback)
  -- function num : 0_1
  self.chipTagId = chipTagId
  self.curChipData = curChipData
  self.closeCallback = closeCallback
  self:_RefreshSuitInfo(chipTagId, curChipData)
end

UINChipDetailSuitInfo._RefreshSuitInfo = function(self, chipTagId, curChipData)
  -- function num : 0_2 , upvalues : _ENV, ChipData
  local chipTagCfg = (ConfigData.chip_tag)[chipTagId]
  local dynPlayer = (BattleUtil.GetCurDynPlayer)(true)
  local normalChipDic = table.emptytable
  local tmpBuffChipDic = table.emptytable
  if dynPlayer ~= nil then
    normalChipDic = dynPlayer:GetNormalChipDic()
    tmpBuffChipDic = dynPlayer:GetTmpBuffChipDic()
  end
  local previewChipDataDic = ExplorationManager:GetChipDataPreviewDic(true)
  local chipDataList = {}
  local haveCount = 0
  local haveCurChip = false
  for _,chipId in ipairs(chipTagCfg.chip_list) do
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
    if chipData.dataId == curChipData.dataId then
      if have then
        haveCurChip = true
      end
      have = true
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
  ;
  (self.chipItemPool):HideAll()
  for index,chipData in pairs(chipDataList) do
    local chipItem = (self.chipItemPool):GetOne()
    chipItem:InitChipItemWithPress(chipData, false, self.__ShowChipDesc, self.__HideChipDesc)
    chipItem:UnlockChipItem(index <= haveCount)
    if chipData.dataId == curChipData.dataId then
      (((self.ui).img_CurChip).transform):SetParent(chipItem.transform)
      -- DECOMPILER ERROR at PC113: Confused about usage of register: R17 in 'UnsetPending'

      ;
      (((self.ui).img_CurChip).transform).localPosition = Vector3.zero
      self:TweenChipSelectAlpha()
    end
  end
  local isShowDetail = (CommonUtil.GetDetailDescribeSetting)(eGameSetDescType.chip)
  ;
  (self.suitDescPool):HideAll()
  local tagSuitCfg = ((ConfigData.chip_tag).tag_suits)[chipTagId]
  for _,tag_suit in pairs(tagSuitCfg) do
    local chipDescItem = (self.suitDescPool):GetOne()
    local active = false
    if tag_suit.number <= haveCount then
      active = true
    end
    chipDescItem:InitSuitDescItem(tag_suit.number, active, ConfigData:GetChipDescriptionById(tag_suit.chip_id, 1, isShowDetail))
    if active and not haveCurChip and haveCount - 1 < tag_suit.number then
      chipDescItem:TweenEpChipSuitDescItem()
    end
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UINChipDetailSuitInfo._ShowChipDesc = function(self, chipData, chipItem)
  -- function num : 0_3 , upvalues : _ENV, HAType, VAType
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext(chipData:GetName(), chipData:GetChipDescription())
  win:FloatTo(chipItem.transform, HAType.left, VAType.up)
end

UINChipDetailSuitInfo._HideChipDesc = function(self, chipData, chipItem)
  -- function num : 0_4 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

UINChipDetailSuitInfo.TweenChipSelectAlpha = function(self)
  -- function num : 0_5 , upvalues : _ENV, cs_TweenLoopType
  ((self.ui).img_CurChip):DOKill(true)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_CurChip).color = Color.white
  local t = Time.time % 1.4
  ;
  ((((((self.ui).img_CurChip):DOFade((Color.New)(1, 1, 1, 0.5), 0.7)):From()):SetLoops(-1, cs_TweenLoopType.Yoyo)):SetLink(self.gameObject)):Goto(t, true)
end

UINChipDetailSuitInfo._OnClickClose = function(self)
  -- function num : 0_6
  self:Hide()
  if self.closeCallback ~= nil then
    (self.closeCallback)({})
  end
end

UINChipDetailSuitInfo.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (self.suitDescPool):DeleteAll()
  ;
  (self.chipItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINChipDetailSuitInfo

