-- params : ...
-- function num : 0 , upvalues : _ENV
local UINEpOverclockListPanel = class("UINEpOverclockListPanel", UIBaseNode)
local base = UIBaseNode
local UINEpOverclockListItem = require("Game.Exploration.UI.Overclock.UINEpOverclockListItem")
UINEpOverclockListPanel.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINEpOverclockListItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).overclockItem):SetActive(false)
  self.clockItemPool = (UIItemPool.New)(UINEpOverclockListItem, (self.ui).overclockItem)
end

UINEpOverclockListPanel.InitOverclockListUI = function(self, overclockCtrl, clockSelectAction)
  -- function num : 0_1 , upvalues : _ENV
  local clockOptionList = overclockCtrl:GetOverclockOptions()
  ;
  (self.clockItemPool):HideAll()
  for k,clockOptionData in pairs(clockOptionList) do
    local clockItem = (self.clockItemPool):GetOne()
    clockItem:InitOverclockListItem(clockOptionData, overclockCtrl, clockSelectAction)
  end
end

UINEpOverclockListPanel.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINEpOverclockListPanel

