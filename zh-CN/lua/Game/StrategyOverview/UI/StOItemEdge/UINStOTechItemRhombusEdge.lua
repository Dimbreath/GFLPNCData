local UINStOTechItemBaseEdge = require("Game.StrategyOverview.UI.StOItemEdge.UINStOTechItemBaseEdge")
local UINStOTechItemRhombusEdge = class("UINStOTechItemRhombusEdge", UINStOTechItemBaseEdge)
local base = UINStOTechItemBaseEdge
UINStOTechItemRhombusEdge.InitEdge = function(self, techItem)
  -- function num : 0_0 , upvalues : base
  (base.InitEdge)(self, techItem)
  ;
  (((techItem.ui).img_Icon).transform):SetParent(((self.ui).img_RewardNodePlus).transform)
end

return UINStOTechItemRhombusEdge

