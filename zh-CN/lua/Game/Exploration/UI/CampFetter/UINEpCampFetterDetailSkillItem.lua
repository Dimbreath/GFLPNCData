local UINEpCampFetterDetailSkillItem = class("UINEpCampFetterDetailSkillItem", UIBaseNode)
local base = UIBaseNode
UINEpCampFetterDetailSkillItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINEpCampFetterDetailSkillItem.InitDetailSkillItem = function(self, cfg, resloader)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).img_Icon).sprite = (AtlasUtil.GetSpriteFromAtlas)(UIAtlasConsts.Atlas_CampFetterIcon, cfg.icon, resloader)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(cfg.name)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Detail).text = (LanguageUtil.GetLocaleText)(cfg.text)
  if cfg.is_show_active ~= 0 then
    ((self.ui).tex_Attri):SetIndex(1)
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_attri).color = (self.ui).color_orange
  else
    ;
    ((self.ui).tex_Attri):SetIndex(0)
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_attri).color = Color.black
  end
end

UINEpCampFetterDetailSkillItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINEpCampFetterDetailSkillItem

