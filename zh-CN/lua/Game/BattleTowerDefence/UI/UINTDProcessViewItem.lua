local UINTDProcessViewItem = class("UINTDProcessViewItem", UIBaseNode)
local base = UIBaseNode
local cs_EaseOutBack = (((CS.DG).Tweening).Ease).OutBack
UINTDProcessViewItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINTDProcessViewItem.InitTDProcessViewItem = function(self, completed)
  -- function num : 0_1 , upvalues : _ENV
  if not completed or not (self.ui).col_orange then
    local col = (self.ui).col_gray
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_cube).color = col
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).localScale = Vector3.one
  ;
  ((self.ui).fX_Glow):Stop()
end

UINTDProcessViewItem.PlayScaleTween = function(self)
  -- function num : 0_2 , upvalues : _ENV, cs_EaseOutBack
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  (self.transform).localScale = Vector3.zero
  ;
  ((((self.transform):DOScale((Vector3.New)(1.4, 1.4, 1), 0.35)):SetRecyclable(true)):SetLink(self.gameObject)):SetEase(cs_EaseOutBack)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_cube).color = (self.ui).col_orange
  ;
  ((self.ui).fX_Glow):Play()
end

UINTDProcessViewItem.DOTweenKill = function(self)
  -- function num : 0_3
  ((self.ui).fX_Glow):Stop()
  ;
  (self.transform):DOKill()
end

UINTDProcessViewItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINTDProcessViewItem

