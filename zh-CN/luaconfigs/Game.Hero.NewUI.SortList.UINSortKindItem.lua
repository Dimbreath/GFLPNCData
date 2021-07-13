-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSortKindItem = class("UINSortKindItem", UIBaseNode)
local base = UIBaseNode
local HeroFilterEnum = require("Game.Hero.NewUI.HeroFilterEnum")
UINSortKindItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_kindItem, self, self.__OnKindItemClick)
  self.select = false
  self:SetSelectUIActive()
end

UINSortKindItem.InitSortKindItem = function(self, kindType, index, onSelectFunc)
  -- function num : 0_1 , upvalues : HeroFilterEnum, _ENV
  self.kindType = kindType
  self.index = index
  self.onSelectFunc = onSelectFunc
  self.isStarType = false
  if self.kindType == (HeroFilterEnum.eKindType).Rank then
    self.isStarType = true
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_KindName).text = tostring(index)
  else
    if self.kindType == (HeroFilterEnum.eKindType).Camp then
      local campCfg = (ConfigData.camp)[index]
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self.ui).tex_KindName).text = (LanguageUtil.GetLocaleText)(campCfg.name)
    else
      do
        do
          local carrerCfg = (ConfigData.career)[index]
          -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'

          ;
          ((self.ui).tex_KindName).text = (LanguageUtil.GetLocaleText)(carrerCfg.name)
          ;
          (((self.ui).img_Star).gameObject):SetActive(self.isStarType)
        end
      end
    end
  end
end

UINSortKindItem.__OnKindItemClick = function(self)
  -- function num : 0_2
  self.select = not self.select
  self:SetSelectUIActive()
  if self.onSelectFunc ~= nil then
    (self.onSelectFunc)(self.kindType, self.index, self.select)
  end
end

UINSortKindItem.SetSelectUIActive = function(self)
  -- function num : 0_3 , upvalues : _ENV
  ((self.ui).obj_OnSelect):SetActive(self.select)
  ;
  (((self.ui).img_Star).gameObject):SetActive(self.isStarType)
  if not self.select or not Color.black then
    local selColor = Color.white
  end
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_KindName).color = selColor
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_Star).color = selColor
end

UINSortKindItem.SetSelectState = function(self, flag)
  -- function num : 0_4
  self.select = flag
  self:SetSelectUIActive()
end

UINSortKindItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UINSortKindItem

