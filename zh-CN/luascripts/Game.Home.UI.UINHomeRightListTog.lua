-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHomeRightListTog = class("UINHomeRightListTog", UIBaseNode)
local base = UIBaseNode
UINHomeRightListTog.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_FuncPageItem, self, self.OnClick)
end

UINHomeRightListTog.InitTog = function(self, typeIndex, callback)
  -- function num : 0_1
  self.typeIndex = typeIndex
  self.callback = callback
  ;
  ((self.ui).img_Icon):SetIndex(typeIndex)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.ui).col_Icon = (((self.ui).img_Icon).image).color
end

UINHomeRightListTog.OnClick = function(self, bool)
  -- function num : 0_2
  ((self.ui).img_OnSelect):SetActive(bool)
  self:ChangeColorOnClick(bool)
  if bool and self.callback ~= nil then
    (self.callback)(self.typeIndex)
  end
end

UINHomeRightListTog.ChangeColorOnClick = function(self, bool)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).col_Icon).a = bool and 1 or 0.3
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).img_Icon).image).color = (self.ui).col_Icon
end

UINHomeRightListTog.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINHomeRightListTog

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHomeRightListTog = class("UINHomeRightListTog", UIBaseNode)
local base = UIBaseNode
UINHomeRightListTog.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddValueChangedListener)((self.ui).tog_FuncPageItem, self,
                                     self.OnClick)
end

UINHomeRightListTog.InitTog = function(self, typeIndex, callback)
    -- function num : 0_1
    self.typeIndex = typeIndex
    self.callback = callback;
    ((self.ui).img_Icon):SetIndex(typeIndex) -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.ui).col_Icon = (((self.ui).img_Icon).image).color
end

UINHomeRightListTog.OnClick = function(self, bool)
    -- function num : 0_2
    ((self.ui).img_OnSelect):SetActive(bool)
    self:ChangeColorOnClick(bool)
    if bool and self.callback ~= nil then (self.callback)(self.typeIndex) end
end

UINHomeRightListTog.ChangeColorOnClick =
    function(self, bool)
        -- function num : 0_3
        -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'


        ((self.ui).col_Icon).a = bool and 1 or 0.3 -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'
        ;
        (((self.ui).img_Icon).image).color = (self.ui).col_Icon
    end

UINHomeRightListTog.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnDelete)(self)
end

return UINHomeRightListTog

