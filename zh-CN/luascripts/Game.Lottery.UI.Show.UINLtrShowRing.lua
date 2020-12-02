-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLtrShowRing = class("UINLtrShowRing", UIBaseNode)
local base = UIBaseNode
UINLtrShowRing.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINLtrShowRing.InitLtrShowRing = function(self, pos, color)
  -- function num : 0_1 , upvalues : _ENV
  self:__ClearFadeTween()
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).anchoredPosition = pos
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.transform).sizeDelta = Vector2.zero
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img).color = color
end

UINLtrShowRing.SetLtrShowRingSize = function(self, sizeDelta)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.transform).sizeDelta = sizeDelta
end

UINLtrShowRing.LtrShowRingFade = function(self)
  -- function num : 0_3
  if self.fadeTween ~= nil then
    return 
  end
  self.fadeTween = (((self.ui).img):DOFade(0, 1)):OnComplete(function()
    -- function num : 0_3_0 , upvalues : self
    self:__ClearFadeTween()
  end
)
end

UINLtrShowRing.__ClearFadeTween = function(self)
  -- function num : 0_4
  if self.fadeTween ~= nil then
    (self.fadeTween):Kill()
    self.fadeTween = nil
  end
end

UINLtrShowRing.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  self:__ClearFadeTween()
  ;
  (base.OnDelete)(self)
end

return UINLtrShowRing

