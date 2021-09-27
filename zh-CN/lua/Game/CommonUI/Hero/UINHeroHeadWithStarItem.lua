local UINHeroHeadWithStarItem = class("UINHeroHeadWithStarItem", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
UINHeroHeadWithStarItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroHeadItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.heroData = nil
  self.heroItem = UINHeroHeadItem:New()
  ;
  (self.heroItem):Init((self.ui).heroHeadItem)
end

UINHeroHeadWithStarItem.InitHead = function(self, heroData, isHas, isMvp, clickCallback)
  -- function num : 0_1
  self.heroData = heroData
  if (self.ui).obj_NotGet ~= nil then
    ((self.ui).obj_NotGet):SetActive(not isHas)
  end
  if (self.ui).obj_MVP ~= nil then
    ((self.ui).obj_MVP):SetActive(isMvp)
  end
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Level).text = "LV" .. heroData.level
  ;
  (self.heroItem):InitHeroHeadItem(heroData, nil, clickCallback)
  local half = heroData.rank % 2
  local rankImgIndex = (heroData.rank - half) / 2 - 1
  if rankImgIndex >= 0 then
    (((self.ui).img_Star).gameObject):SetActive(true)
    ;
    ((self.ui).img_Star):SetIndex(rankImgIndex)
    local vec = ((((self.ui).img_Star).image).rectTransform).sizeDelta
    vec.x = (((((self.ui).img_Star).image).sprite).rect).width
    -- DECOMPILER ERROR at PC66: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((((self.ui).img_Star).image).rectTransform).sizeDelta = vec
  else
    do
      ;
      (((self.ui).img_Star).gameObject):SetActive(false)
      ;
      (((self.ui).img_Half).gameObject):SetActive(half == 1)
      -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end
  end
end

return UINHeroHeadWithStarItem

