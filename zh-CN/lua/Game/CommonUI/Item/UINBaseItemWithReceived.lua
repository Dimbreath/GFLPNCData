local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINBaseItemWithReceived = class("UINBaseItemWithReceived", UINBaseItemWithCount)
local base = UINBaseItemWithCount
UINBaseItemWithReceived.OnInit = function(self)
  -- function num : 0_0 , upvalues : base
  (base.OnInit)(self)
end

UINBaseItemWithReceived.InitItemWithCount = function(self, itemCfg, count, clickEvent, isPicked)
  -- function num : 0_1 , upvalues : base
  self:SetPickedUIActive(isPicked)
  ;
  (base.InitItemWithCount)(self, itemCfg, count, clickEvent)
  if isPicked then
    self:CloseGreatRewardLoopFx()
  end
end

UINBaseItemWithReceived.SetPickedUIActive = function(self, isPicked)
  -- function num : 0_2
  ((self.ui).obj_isPicked):SetActive(isPicked)
end

UINBaseItemWithReceived.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINBaseItemWithReceived

