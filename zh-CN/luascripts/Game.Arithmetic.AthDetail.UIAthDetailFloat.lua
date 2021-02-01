-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthDetailFloat = class("UIAthDetailFloat", UIBaseNode)
local base = UIBaseNode
local UINAthDetailItem = require("Game.Arithmetic.AthDetail.UINAthDetailItem")
local cs_LeanTouch = ((CS.Lean).Touch).LeanTouch
local cs_InputUtility = CS.InputUtility
UIAthDetailFloat.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINAthDetailItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.detailItem = (UINAthDetailItem.New)()
  ;
  (self.detailItem):Init((self.ui).aTHDetailItem)
end

UIAthDetailFloat.InitAthDetailFloat = function(self, athData)
  -- function num : 0_1 , upvalues : _ENV, cs_LeanTouch
  (self.detailItem):InitAthDetailItem(nil, athData, nil, false, false, true)
  self.__onFingerDown = BindCallback(self, self.OnFingerDown)
  ;
  (cs_LeanTouch.OnFingerDown)("+", self.__onFingerDown)
end

UIAthDetailFloat.OnFingerDown = function(self, leanFinger)
  -- function num : 0_2 , upvalues : cs_InputUtility, _ENV
  if not (cs_InputUtility.OverUIValidTag)(TagConsts.ValidTarget) then
    self:Hide()
  end
end

UIAthDetailFloat.OnHide = function(self)
  -- function num : 0_3 , upvalues : cs_LeanTouch, base
  (cs_LeanTouch.OnFingerDown)("-", self.__onFingerDown)
  ;
  (base.OnHide)(self)
end

UIAthDetailFloat.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (self.detailItem):Delete()
  ;
  (base.OnDelete)(self)
end

return UIAthDetailFloat

