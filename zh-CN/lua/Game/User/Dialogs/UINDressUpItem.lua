local UINDressUpItem = class("UINDressUpItem", UIBaseNode)
local base = UIBaseNode
UINDressUpItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_dressUpItem, self, self.OnDressUpItemClick)
end

UINDressUpItem.InitDressUpItem = function(self, cfg, clickCallback, sprite, cfgId)
  -- function num : 0_1 , upvalues : _ENV
  self._cfg = cfg
  self._clickCallback = clickCallback
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_DressName).text = (LanguageUtil.GetLocaleText)(cfg.name)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Pic).sprite = sprite
  if cfgId == (PlayerDataCenter.inforData).backgroudPlateId then
    ((self.ui).img_Select):SetActive(true)
  else
    ;
    ((self.ui).img_Select):SetActive(false)
  end
end

UINDressUpItem.OnDressUpItemClick = function(self)
  -- function num : 0_2
  if self._clickCallback ~= nil then
    (self._clickCallback)(self._cfg)
  end
end

UINDressUpItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINDressUpItem

