local UINLtrPoolBaseRule = class("UINLtrPoolBaseRule", UIBaseNode)
local base = UIBaseNode
UINLtrPoolBaseRule.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINLtrPoolBaseRule.InitLtrPoolBaseRule = function(self, poolCfg)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_Des1Title).text = (LanguageUtil.GetLocaleText)(poolCfg.title1)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Des1Rule).text = (LanguageUtil.GetLocaleText)(poolCfg.des1)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Des2Title).text = (LanguageUtil.GetLocaleText)(poolCfg.title2)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Des2Rule).text = (LanguageUtil.GetLocaleText)(poolCfg.des2)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Des3Title).text = (LanguageUtil.GetLocaleText)(poolCfg.title3)
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Des3Rule).text = (LanguageUtil.GetLocaleText)(poolCfg.des3)
  if #((self.ui).tex_Des1Title).text == 0 then
    (((self.ui).tex_Des1Title).gameObject):SetActive(false)
  end
  if #((self.ui).tex_Des2Title).text == 0 then
    (((self.ui).tex_Des2Title).gameObject):SetActive(false)
  end
  if #((self.ui).tex_Des3Title).text == 0 then
    (((self.ui).tex_Des3Title).gameObject):SetActive(false)
  end
  local itemId = (poolCfg.change_rule)[1]
  local num1 = (poolCfg.change_rule)[2]
  local num2 = (poolCfg.change_rule)[3]
  local num3 = (poolCfg.change_rule)[4]
  local itemCfg = (ConfigData.item)[itemId]
  -- DECOMPILER ERROR at PC97: Confused about usage of register: R7 in 'UnsetPending'

  if itemCfg ~= nil then
    ((self.ui).img_Item).sprite = CRH:GetSpriteByItemConfig(itemCfg)
  else
    ;
    (((self.ui).img_Item).gameObject):SetActive(false)
  end
  for i = 2, #poolCfg.change_rule do
    (((self.ui).item_nums)[i - 1]):SetIndex(0, tostring((poolCfg.change_rule)[i]))
  end
end

UINLtrPoolBaseRule.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINLtrPoolBaseRule

