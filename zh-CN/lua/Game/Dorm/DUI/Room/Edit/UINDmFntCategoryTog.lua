local UINDmFntCategoryTog = class("UINDmFntCategoryTog", UIBaseNode)
local base = UIBaseNode
UINDmFntCategoryTog.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).rootTog, self, self._OnClickTogRoot)
end

UINDmFntCategoryTog.InitDmFntCategoryTog = function(self, fntCatgCfg, sprite, selectFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.fntCatgCfg = fntCatgCfg
  self.selectFunc = selectFunc
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = sprite
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_typeName).text = (LanguageUtil.GetLocaleText)(fntCatgCfg.name)
end

UINDmFntCategoryTog.SetDmFntCategoryTogOn = function(self)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).rootTog).isOn = true
end

UINDmFntCategoryTog._OnClickTogRoot = function(self, isOn)
  -- function num : 0_3 , upvalues : _ENV
  if not isOn or not Color.black then
    local col = Color.gray
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_typeName).color = col
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).color = col
  if isOn then
    ((self.ui).img_SelFurnType):SetParent(self.transform)
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_SelFurnType).anchoredPosition = Vector2.zero
    ;
    ((self.ui).img_SelFurnType):SetAsFirstSibling()
  end
  if self.selectFunc ~= nil then
    (self.selectFunc)((self.fntCatgCfg).id)
  end
end

UINDmFntCategoryTog.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINDmFntCategoryTog

