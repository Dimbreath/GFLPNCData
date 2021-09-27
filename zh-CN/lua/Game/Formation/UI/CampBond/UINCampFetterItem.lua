local UINCampFetterItem = class("UINCampFetterItem", UIBaseNode)
local base = UIBaseNode
UINCampFetterItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.heroIconWidth = (((self.ui).img_NeedHeroCount).sizeDelta).x
end

UINCampFetterItem.InitCampFetterItem = function(self, campId, count, neededHeroCount, resloader)
  -- function num : 0_1 , upvalues : _ENV
  local cfg = ((ConfigData.camp_connection)[campId])[neededHeroCount]
  local isUnlock = cfg.fetters_num <= count
  local isActive = cfg.is_show_active ~= 0
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = (AtlasUtil.GetSpriteFromAtlas)(UIAtlasConsts.Atlas_CampFetterIcon, cfg.icon, resloader)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(cfg.name)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).tex_Detail).text = (LanguageUtil.GetLocaleText)(cfg.text)
  if isActive then
    ((self.ui).tex_Attri):SetIndex(1)
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.ui).img_attri).color = (self.ui).color_orange
  else
    ((self.ui).tex_Attri):SetIndex(0)
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.ui).img_attri).color = Color.black
  end
  self:__RefreshUnlock(isUnlock, neededHeroCount)
  self:__RefreshHeroIcon(neededHeroCount)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UINCampFetterItem.__RefreshUnlock = function(self, isUnlock, neededHeroCount)
  -- function num : 0_2 , upvalues : _ENV
  ((self.ui).obj_IsEffective):SetActive(isUnlock)
  ;
  ((self.ui).obj_tex_Tips):SetActive(not isUnlock)
  if isUnlock then
    ((self.ui).img_bondEffDetailItem):SetIndex(0)
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).canvasGroup).alpha = 1
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).color = Color.black
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Detail).color = Color.black
  else
    ;
    ((self.ui).img_bondEffDetailItem):SetIndex(1)
    ;
    ((self.ui).tex_Tips):SetIndex(0, tostring(neededHeroCount))
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).canvasGroup).alpha = 0.3
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).color = Color.white
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Detail).color = Color.white
  end
end

UINCampFetterItem.__RefreshHeroIcon = function(self, neededHeroCount)
  -- function num : 0_3 , upvalues : _ENV
  local width = self.heroIconWidth * neededHeroCount
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_NeedHeroCount).sizeDelta = (Vector3.New)(width, (((self.ui).img_NeedHeroCount).sizeDelta).y)
end

UINCampFetterItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINCampFetterItem

