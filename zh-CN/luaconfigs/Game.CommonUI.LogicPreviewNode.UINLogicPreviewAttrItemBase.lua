-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLogicPreviewAttrItemBase = class("UINLogicPreviewAttrItemBase", UIBaseNode)
local base = UIBaseNode
UINLogicPreviewAttrItemBase.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINLogicPreviewAttrItemBase.InitAttrItem = function(self, str, white, customColor)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R4 in 'UnsetPending'

  ((self.ui).tex_Attri).text = str
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  if customColor == nil then
    if not white or not Color.white then
      ((self.ui).tex_Attri).color = (self.ui).normalColor
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tex_Attri).color = customColor
    end
  end
end

UINLogicPreviewAttrItemBase.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINLogicPreviewAttrItemBase

