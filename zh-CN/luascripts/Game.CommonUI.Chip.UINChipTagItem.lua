-- params : ...
-- function num : 0 , upvalues : _ENV
local UINChipTagItem = class("UINChipTagItem", UIBaseNode)
UINChipTagItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  (self.ui).tex_Tag = (self.transform):FindComponent("Tex_Tag", eUnityComponentID.ExText)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).img_Tag = (self.gameObject):GetComponent(typeof(((CS.UnityEngine).UI).Image))
end

UINChipTagItem.InitChipTag = function(self, tagId)
  -- function num : 0_1 , upvalues : _ENV
  local chipTagCfg = (ConfigData.chip_tag)[tagId]
  if chipTagCfg == nil then
    error("chip tag cfg is null,id:" .. tostring(tagId))
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Tag).text = (LanguageUtil.GetLocaleText)(chipTagCfg.tag)
end

UINChipTagItem.SetChipTagColor = function(self, color)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).img_Tag).color = color
end

return UINChipTagItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINChipTagItem = class("UINChipTagItem", UIBaseNode)
UINChipTagItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    (self.ui).tex_Tag = (self.transform):FindComponent("Tex_Tag",
                                                       eUnityComponentID.ExText) -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'
    ;
    (self.ui).img_Tag = (self.gameObject):GetComponent(
                            typeof(((CS.UnityEngine).UI).Image))
end

UINChipTagItem.InitChipTag = function(self, tagId)
    -- function num : 0_1 , upvalues : _ENV
    local chipTagCfg = (ConfigData.chip_tag)[tagId]
    if chipTagCfg == nil then
        error("chip tag cfg is null,id:" .. tostring(tagId))
    end -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'
    
    ((self.ui).tex_Tag).text = (LanguageUtil.GetLocaleText)(chipTagCfg.tag)
end

UINChipTagItem.SetChipTagColor = function(self, color)
    -- function num : 0_2
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).img_Tag).color = color
end

return UINChipTagItem

