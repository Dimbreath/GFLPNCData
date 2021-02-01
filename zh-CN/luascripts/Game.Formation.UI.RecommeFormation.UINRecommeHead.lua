-- params : ...
-- function num : 0 , upvalues : _ENV
local UINRecommeHead = class("UINRecommeHead", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
UINRecommeHead.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroHeadItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.heroItem = UINHeroHeadItem:New()
  ;
  (self.heroItem):Init((self.ui).heroHeadItem)
end

UINRecommeHead.InitHead = function(self, data, isHas, isMvp)
  -- function num : 0_1
  ((self.ui).obj_NotGet):SetActive(not isHas)
  ;
  ((self.ui).obj_MVP):SetActive(isMvp)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Level).text = "LV" .. data.level
  ;
  (self.heroItem):InitHeroHeadItem(data)
  local half = data.rank % 2
  local rankImgIndex = (data.rank - half) / 2 - 1
  if rankImgIndex >= 0 then
    (((self.ui).img_Star).gameObject):SetActive(true)
    ;
    ((self.ui).img_Star):SetIndex(rankImgIndex)
    local vec = ((((self.ui).img_Star).image).rectTransform).sizeDelta
    vec.x = (((((self.ui).img_Star).image).sprite).rect).width
    -- DECOMPILER ERROR at PC55: Confused about usage of register: R7 in 'UnsetPending'

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

return UINRecommeHead

