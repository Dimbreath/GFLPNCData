-- params : ...
-- function num : 0 , upvalues : _ENV
local UIGlobalChipDetail = class("UIGlobalPropItemDetail", UIBaseWindow)
local base = UIBaseWindow
local UINChipItemDetail = require("Game.CommonUI.Item.UINChipItemDetail")
UIGlobalChipDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : UINChipItemDetail, _ENV
  self.PropItemDetail = (UINChipItemDetail.New)()
  ;
  (self.PropItemDetail):Init((self.ui).PropItem)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CloseBg, self, self.OnCloseButtonClick)
end

UIGlobalChipDetail.InitChipItemDetail = function(self, ChipData, heroList, contain)
  -- function num : 0_1
  (self.PropItemDetail):InitChipDetail(ChipData)
  ;
  (self.PropItemDetail):UpdateAdaptHero(heroList, contain)
end

UIGlobalChipDetail.OnCloseButtonClick = function(self)
  -- function num : 0_2
  self:Hide()
end

return UIGlobalChipDetail

