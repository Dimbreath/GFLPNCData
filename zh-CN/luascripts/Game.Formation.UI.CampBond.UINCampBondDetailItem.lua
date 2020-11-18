-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCampBondDetailItem = class("UINCampBondDetailItem", UIBaseNode)
local base = UIBaseNode
UINCampBondDetailItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.countImgWidth = ((((self.ui).heroCount_Bg).transform).sizeDelta).x
end

UINCampBondDetailItem.InitCampBondDetailItem = function(self, isValid, count, maxCount, description)
  -- function num : 0_1 , upvalues : _ENV
  if not isValid or not (self.ui).color_valid then
    local color = (self.ui).color_normal
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).img_HeroCount).color = color
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Content).color = color
  ;
  ((self.ui).tex_isVaild):SetIndex(isValid and 1 or 0)
  local size = (((self.ui).heroCount_Bg).transform).sizeDelta
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (((self.ui).heroCount_Bg).transform).sizeDelta = (Vector2.New)(self.countImgWidth * maxCount, size.y)
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (((self.ui).img_HeroCount).transform).sizeDelta = (Vector2.New)(self.countImgWidth * count, size.y)
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Content).text = description
end

UINCampBondDetailItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINCampBondDetailItem

