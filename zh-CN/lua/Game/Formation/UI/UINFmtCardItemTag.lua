local UINFmtCardItemTag = class("UINFmtCardItemTag", UIBaseNode)
local base = UIBaseNode
UINFmtCardItemTag.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINFmtCardItemTag.InitTag = function(self, oriVal, nowVal, textIndex)
  -- function num : 0_1
  local scale = ((self.ui).img_arrow).localScale
  scale.y = nowVal < oriVal and 1 or -1
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_arrow).localScale = scale
  ;
  ((self.ui).tex_Sync):SetIndex(textIndex)
end

return UINFmtCardItemTag

