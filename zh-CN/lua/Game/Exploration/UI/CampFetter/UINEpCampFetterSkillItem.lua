local UINEpCampFetterSkillItem = class("UINEpCampFetterSkillItem", UIBaseNode)
local base = UIBaseNode
UINEpCampFetterSkillItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINEpCampFetterSkillItem.InitEpCampFetterSkillItem = function(self, camp_ConnectCfg, isFirst, resLoader)
  -- function num : 0_1 , upvalues : _ENV
  ((self.ui).image_Deliver):SetActive(not isFirst)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).img_EffIcon).sprite = (AtlasUtil.GetSpriteFromAtlas)(UIAtlasConsts.Atlas_CampFetterIcon, camp_ConnectCfg.icon, resLoader)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

  if camp_ConnectCfg.is_show_active ~= 0 then
    ((self.ui).img_EffIcon).color = (self.ui).color_activeSkill
  else
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_EffIcon).color = Color.white
  end
end

UINEpCampFetterSkillItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINEpCampFetterSkillItem

