-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFactoryEnterHeroItem = class("UINFactoryEnterHeroItem", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
UINFactoryEnterHeroItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.heroHeadItem = nil
  self.clickCallback = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_enterItem, self, self.OnClickItem)
end

UINFactoryEnterHeroItem.InitHeroItem = function(self, heroId, resloader, clickCallback)
  -- function num : 0_1 , upvalues : UINHeroHeadItem, _ENV
  self.clickCallback = clickCallback
  if heroId == nil then
    ((self.ui).obj_img_Add):SetActive(true)
    ;
    ((self.ui).obj_heroHeadItem):SetActive(false)
    return 
  else
    ;
    ((self.ui).obj_img_Add):SetActive(false)
    ;
    ((self.ui).obj_heroHeadItem):SetActive(true)
  end
  if self.heroHeadItem == nil then
    self.heroHeadItem = (UINHeroHeadItem.New)()
    ;
    (self.heroHeadItem):Init((self.ui).obj_heroHeadItem)
  end
  local heroData = (PlayerDataCenter.heroDic)[heroId]
  ;
  (self.heroHeadItem):InitHeroHeadItem(heroData, resloader)
end

UINFactoryEnterHeroItem.OnClickItem = function(self)
  -- function num : 0_2
  if self.clickCallback ~= nil then
    (self.clickCallback)()
  end
end

UINFactoryEnterHeroItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINFactoryEnterHeroItem

