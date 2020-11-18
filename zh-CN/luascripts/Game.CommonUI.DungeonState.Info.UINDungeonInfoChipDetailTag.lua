-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDungeonInfoChipDetailTag = class("UINDungeonInfoChipDetailTag", UIBaseNode)
local base = UIBaseNode
UINDungeonInfoChipDetailTag.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINDungeonInfoChipDetailTag.InitTagItem = function(self, tagConfig, color)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).tex_Tag).text = (LanguageUtil.GetLocaleText)(tagConfig.tag)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_tagItem).color = color
end

UINDungeonInfoChipDetailTag.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINDungeonInfoChipDetailTag

