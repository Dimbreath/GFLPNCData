local UINSltChipSuitItemIntro = class("UINSltChipSuitItemIntro", UIBaseNode)
local base = UIBaseNode
local UINEpChipSuitDescItem = require("Game.Exploration.UI.ChipSuit.UINEpChipSuitDescItem")
UINSltChipSuitItemIntro.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINEpChipSuitDescItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.transform).anchoredPosition = Vector2.zero
  ;
  ((self.ui).suitDescItem):SetActive(false)
  self.suitDescPool = (UIItemPool.New)(UINEpChipSuitDescItem, (self.ui).suitDescItem)
end

UINSltChipSuitItemIntro.InitSltChipSuitItemIntro = function(self, chipTagId)
  -- function num : 0_1 , upvalues : _ENV
  local isShowDetail = (CommonUtil.GetDetailDescribeSetting)(eGameSetDescType.chip)
  ;
  (self.suitDescPool):HideAll()
  local tagSuitCfg = ((ConfigData.chip_tag).tag_suits)[chipTagId]
  for _,tag_suit in pairs(tagSuitCfg) do
    local chipDescItem = (self.suitDescPool):GetOne()
    chipDescItem:InitSuitDescItem(tag_suit.number, true, ConfigData:GetChipDescriptionById(tag_suit.chip_id, 1, isShowDetail))
  end
end

UINSltChipSuitItemIntro.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (self.suitDescPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINSltChipSuitItemIntro

