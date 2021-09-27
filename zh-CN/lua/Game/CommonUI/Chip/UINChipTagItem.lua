local UINChipTagItem = class("UINChipTagItem", UIBaseNode)
UINChipTagItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINChipTagItem.InitChipTag = function(self, tagId)
  -- function num : 0_1 , upvalues : _ENV
  local chipTagCfg = (ConfigData.chip_tag)[tagId]
  if chipTagCfg == nil then
    error("chip tag cfg is null,id:" .. tostring(tagId))
  end
  local name = (LanguageUtil.GetLocaleText)(chipTagCfg.tag_name)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Tag).text = name
  ;
  ((self.ui).eff_Tag):SetActive(false)
end

UINChipTagItem.InitChipTagAndSuit = function(self, tagId, haveCount, maxCount, owner)
  -- function num : 0_2 , upvalues : _ENV
  local chipTagCfg = (ConfigData.chip_tag)[tagId]
  if chipTagCfg == nil then
    error("chip tag cfg is null,id:" .. tostring(tagId))
  end
  local name = (LanguageUtil.GetLocaleText)(chipTagCfg.tag_name)
  local countStr = (string.format)("(%d/%d)", haveCount, maxCount)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).tex_Tag).text = name .. countStr
  if not owner and haveCount > 0 then
    ((self.ui).eff_Tag):SetActive(true)
  else
    ;
    ((self.ui).eff_Tag):SetActive(false)
  end
end

UINChipTagItem.SetChipTagColor = function(self, color)
  -- function num : 0_3
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).img_Tag).color = color
end

return UINChipTagItem

