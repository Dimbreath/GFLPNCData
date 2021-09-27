local UINWCRankPanelItemHeroHead = class("UINWCRankPanelItemHeroHead", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
UINWCRankPanelItemHeroHead.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroHeadItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.heroItem = UINHeroHeadItem:New()
  ;
  (self.heroItem):Init((self.ui).heroHeadItem)
end

UINWCRankPanelItemHeroHead.InitHead = function(self, heroId, level, rank, clickCallback)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R5 in 'UnsetPending'

  ((self.ui).tex_Level).text = "LV" .. tostring(level)
  ;
  (self.heroItem):InitHeroHeadItemWithId(heroId, clickCallback)
  local half = rank % 2
  local rankImgIndex = (rank - half) / 2 - 1
  if rankImgIndex >= 0 then
    (((self.ui).img_Star).gameObject):SetActive(true)
    ;
    ((self.ui).img_Star):SetIndex(rankImgIndex)
    local vec = ((((self.ui).img_Star).image).rectTransform).sizeDelta
    vec.x = (((((self.ui).img_Star).image).sprite).rect).width
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R8 in 'UnsetPending'

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

return UINWCRankPanelItemHeroHead

