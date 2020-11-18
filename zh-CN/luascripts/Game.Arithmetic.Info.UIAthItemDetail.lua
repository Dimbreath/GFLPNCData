-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.Arithmetic.Common.UIAthItemBase")
local UIAthItemDetail = class("UIAthItemDetail", base)
UIAthItemDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : base, _ENV
  (base.OnInit)(self)
  ;
  (UIUtil.AddButtonListener)((self.ui).rootBtn, self, self.OnClickAth)
end

UIAthItemDetail.InitAthItem = function(self, color, height, space, athData, isEmptyArea)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitAthItem)(self, color, height, space, athData)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_ATHSpace).text = tostring(space)
  self.isEmptyArea = isEmptyArea
  self:SelectAth(false)
end

UIAthItemDetail.SelectAth = function(self, select)
  -- function num : 0_2
  ((self.ui).img_OnSelect):SetActive(select)
end

UIAthItemDetail.SetClickAthEvent = function(self, clickEvent)
  -- function num : 0_3
  self.clickEvent = clickEvent
end

UIAthItemDetail.OnClickAth = function(self)
  -- function num : 0_4
  if self.clickEvent ~= nil then
    (self.clickEvent)(self)
  end
end

UIAthItemDetail.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UIAthItemDetail

