-- params : ...
-- function num : 0 , upvalues : _ENV
local UINEpChipSuitDescItem = class("UINEpChipSuitDescItem", UIBaseNode)
UINEpChipSuitDescItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINEpChipSuitDescItem.InitSuitDescItem = function(self, number, active, info, activeColor, lockColor)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

  ((self.ui).tex_Count).text = tostring(number)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Desc).text = tostring(info)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

  if active then
    if activeColor ~= nil then
      ((self.ui).img_Count).color = activeColor
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).tex_Desc).color = activeColor
    else
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).img_Count).color = (self.ui).color_active
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).tex_Desc).color = Color.white
    end
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_Count).color = Color.white
  else
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R6 in 'UnsetPending'

    if lockColor ~= nil then
      ((self.ui).img_Count).color = lockColor
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).tex_Desc).color = lockColor
    else
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).img_Count).color = (self.ui).color_deactive
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).tex_Desc).color = (self.ui).color_deactive
    end
    -- DECOMPILER ERROR at PC62: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_Count).color = (self.ui).color_fontdeactive
  end
end

return UINEpChipSuitDescItem

