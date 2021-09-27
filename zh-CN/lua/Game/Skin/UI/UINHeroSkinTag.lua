local UINHeroSkinTag = class("UINHeroSkinTag", UIBaseNode)
local base = UIBaseNode
UINHeroSkinTag.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINHeroSkinTag.InitTag = function(self, tagIndex)
  -- function num : 0_1
  self.tagIndex = tagIndex
  ;
  ((self.ui).tex_Tag):SetIndex(self.tagIndex)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_tag).color = ((self.ui).color_show_tags)[self.tagIndex + 1]
end

UINHeroSkinTag.SetSelectState = function(self, isSelect)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  if isSelect then
    ((self.ui).img_tag).color = ((self.ui).color_show_tags)[self.tagIndex + 1]
  else
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_tag).color = ((self.ui).color_hide_tags)[self.tagIndex + 1]
  end
end

return UINHeroSkinTag

