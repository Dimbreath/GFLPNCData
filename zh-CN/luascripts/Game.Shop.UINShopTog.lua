-- params : ...
-- function num : 0 , upvalues : _ENV
local UINShopTog = class("UINShopTog", UIBaseNode)
local base = UIBaseNode
UINShopTog.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  local oringinalSize = (self.transform).sizeDelta
  local target = (Vector2.New)(1.0666666666667 * oringinalSize.x, oringinalSize.y)
  self.extendTween = (((self.transform):DOSizeDelta(target, 0.25)):SetAutoKill(false)):Pause()
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_taskPageTog, self, self.OnValueChage)
end

UINShopTog.InitShopTog = function(self, shopCfg, openPageCallback)
  -- function num : 0_1 , upvalues : _ENV
  self.shopId = shopCfg.id
  self.openPageCallback = openPageCallback
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_TypeName).text = (LanguageUtil.GetLocaleText)(shopCfg.name)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_TypeEN).text = (LanguageUtil.GetLocaleText)(shopCfg.name_en)
end

UINShopTog.OnValueChage = function(self, bool)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if bool then
    ((self.ui).tex_TypeName).color = (self.ui).color_black
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_TypeEN).color = (self.ui).color_black
    ;
    (self.extendTween):PlayForward()
    ;
    ((self.ui).img_Select):SetIndex(1)
    if self.openPageCallback ~= nil then
      (self.openPageCallback)(self.shopId)
    end
  else
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_TypeName).color = (self.ui).color_gray
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_TypeEN).color = (self.ui).color_gray
    ;
    (self.extendTween):PlayBackwards()
    ;
    ((self.ui).img_Select):SetIndex(0)
  end
end

UINShopTog.SetSelected = function(self, bool)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tog_taskPageTog).isOn = bool
end

UINShopTog.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINShopTog

