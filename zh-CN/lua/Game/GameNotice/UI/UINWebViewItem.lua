local UINWebViewItem = class("UINWebViewItem", UIBaseNode)
local base = UIBaseNode
UINWebViewItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINWebViewItem.LoadWebViewByUrl = function(self, url, hasFade)
  -- function num : 0_1
  self:Hide()
  if url == nil then
    return 
  end
  self:Show()
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).uniWebView).ReferenceRectTransform = self.transform
  ;
  ((self.ui).uniWebView):SetZoomEnabled(false)
  ;
  ((self.ui).uniWebView):SetBackButtonEnabled(false)
  ;
  ((self.ui).uniWebView):Load(url)
  ;
  ((self.ui).uniWebView):Show(hasFade)
end

UINWebViewItem.ClearCache = function(self)
  -- function num : 0_2
  ((self.ui).uniWebView):CleanCache()
end

UINWebViewItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINWebViewItem

