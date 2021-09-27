local UINStOTechItemBaseEdge = require("Game.StrategyOverview.UI.StOItemEdge.UINStOTechItemBaseEdge")
local UINStOTechItemRewardEdge = class("UINStOTechItemRewardEdge", UINStOTechItemBaseEdge)
local base = UINStOTechItemBaseEdge
UINStOTechItemRewardEdge.InitEdge = function(self, techItem)
  -- function num : 0_0 , upvalues : base
  (((techItem.ui).norGroup).gameObject):SetActive(false)
  ;
  (base.InitEdge)(self, techItem)
end

UINStOTechItemRewardEdge.SetState = function(self, level, isUnLock)
  -- function num : 0_1
  if level > 0 then
    ((self.ui).rewardItem):SetIndex(0)
    ;
    ((self.ui).tex_Got):SetIndex(2)
  else
    if isUnLock then
      ((self.ui).rewardItem):SetIndex(1)
      ;
      ((self.ui).tex_Got):SetIndex(1)
    else
      ;
      ((self.ui).rewardItem):SetIndex(1)
      ;
      ((self.ui).tex_Got):SetIndex(0)
    end
  end
end

return UINStOTechItemRewardEdge

