local UIRichIntroItem = class("UIRichIntroItem", UIBaseNode)
local base = UIBaseNode
UIRichIntroItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UIRichIntroItem.InitRichIntroItem = function(self, richIntroCfg)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  if richIntroCfg.icon ~= nil and not (string.IsNullOrEmpty)(richIntroCfg.icon) then
    ((self.ui).img_icon).sprite = CRH:GetSprite(richIntroCfg.icon, CommonAtlasType.ExplorationIcon)
    ;
    (((self.ui).img_icon).gameObject):SetActive(true)
  else
    ;
    (((self.ui).img_icon).gameObject):SetActive(false)
  end
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_name).text = (LanguageUtil.GetLocaleText)(richIntroCfg.name)
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_describe).text = (LanguageUtil.GetLocaleText)(richIntroCfg.describe)
  local setColor = ((self.ui).colorList)[richIntroCfg.icon_color]
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R3 in 'UnsetPending'

  if setColor ~= nil then
    ((self.ui).col_title).color = setColor
  end
end

UIRichIntroItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UIRichIntroItem

