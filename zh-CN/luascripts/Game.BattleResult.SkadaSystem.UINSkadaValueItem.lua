-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSkadaValueItem = class("UINSkadaValueItem", UIBaseNode)
local base = UIBaseNode
UINSkadaValueItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINSkadaValueItem.InitSkadaValueItem = function(self, color)
  -- function num : 0_1
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).img_Color).color = color
end

UINSkadaValueItem.SetSkadaValue = function(self, progress, value, alpha)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R4 in 'UnsetPending'

  ((self.ui).slider).value = progress
  ;
  ((self.ui).tex_Value):SetIndex(0, tostring(value), (string.format)("%.f", progress * 100))
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).canvasGroup).alpha = alpha
end

UINSkadaValueItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINSkadaValueItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSkadaValueItem = class("UINSkadaValueItem", UIBaseNode)
local base = UIBaseNode
UINSkadaValueItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINSkadaValueItem.InitSkadaValueItem = function(self, color)
    -- function num : 0_1
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).img_Color).color = color
end

UINSkadaValueItem.SetSkadaValue = function(self, progress, value, alpha)
    -- function num : 0_2 , upvalues : _ENV
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R4 in 'UnsetPending'

    ((self.ui).slider).value = progress;
    ((self.ui).tex_Value):SetIndex(0, tostring(value),
                                   (string.format)("%.f", progress * 100)) -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).canvasGroup).alpha = alpha
end

UINSkadaValueItem.OnDelete = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnDelete)(self)
end

return UINSkadaValueItem

