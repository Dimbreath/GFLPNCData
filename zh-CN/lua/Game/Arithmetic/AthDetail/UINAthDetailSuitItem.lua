local UINAthDetailSuitItem = class("UINAthDetailSuitItem", UIBaseNode)
local base = UIBaseNode
UINAthDetailSuitItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINAthDetailSuitItem.InitAthDetailSuitItem = function(self, curNum, suitNum, intro)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).tex_Collect):SetIndex(0, tostring(suitNum))
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Intro).text = intro
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

  if suitNum <= curNum then
    ((self.ui).img_Collect).color = (self.ui).color_ValidBg
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (((self.ui).tex_Collect).text).color = Color.white
  else
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_Collect).color = (self.ui).color_InvalidBg
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (((self.ui).tex_Collect).text).color = Color.black
  end
end

UINAthDetailSuitItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthDetailSuitItem

