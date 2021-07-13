-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFmtCampFetterSkillItem = class("UINFmtCampFetterSkillItem", UIBaseNode)
local base = UIBaseNode
UINFmtCampFetterSkillItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINFmtCampFetterSkillItem.InitFetterSkillItem = function(self, campFetterCfg, isfirst, resloader)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'

  ((self.ui).img_Icon).sprite = (AtlasUtil.GetSpriteFromAtlas)(UIAtlasConsts.Atlas_CampFetterIcon, campFetterCfg.icon, resloader)
  ;
  ((self.ui).img_Line):SetActive(not isfirst)
end

UINFmtCampFetterSkillItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINFmtCampFetterSkillItem

