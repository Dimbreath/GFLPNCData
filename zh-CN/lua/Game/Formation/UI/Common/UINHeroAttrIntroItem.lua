local UINHeroAttrIntroItem = class("UINHeroAttrItem", UIBaseNode)
local base = UIBaseNode
UINHeroAttrIntroItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.gameObject, self.ui)
end

UINHeroAttrIntroItem.ShowAttrPopIntro = function(self, attrId, iconSprite)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  if iconSprite ~= nil then
    ((self.ui).img_icon).sprite = iconSprite
  end
  local cfg = (ConfigData.attribute)[attrId]
  if cfg == nil then
    error("Can\'t find attribute, id = " .. tostring(attrId))
    return 
  end
  do
    if cfg.name ~= nil then
      local name = (LanguageUtil.GetLocaleText)(cfg.name)
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).text_title).text = name
    end
    if cfg.attribute_detail ~= nil then
      local introStr = (LanguageUtil.GetLocaleText)(cfg.attribute_detail)
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).text_detail).text = introStr
    end
  end
end

UINHeroAttrIntroItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINHeroAttrIntroItem

