-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthItemBase = class("UIAthItemBase", UIBaseNode)
local base = UIBaseNode
UIAthItemBase.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIAthItemBase.InitAthItem = function(self, color, height, space, athData)
  -- function num : 0_1
  self.athData = athData
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_ATH).color = color
  local size = (((self.ui).img_ATH).transform).sizeDelta
  size.y = height
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (((self.ui).img_ATH).transform).sizeDelta = size
end

UIAthItemBase.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UIAthItemBase

