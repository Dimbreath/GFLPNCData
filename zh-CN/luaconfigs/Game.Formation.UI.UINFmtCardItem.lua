-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
local UINFmtCardItemTag = require("Game.Formation.UI.UINFmtCardItemTag")
local UINFmtCardItem = class("UINFmtCardItem", UINHeroCardItem)
local base = UINHeroCardItem
UINFmtCardItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroCardItem, UINFmtCardItemTag
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.cardItem = (UINHeroCardItem.New)()
  ;
  (self.cardItem):Init((self.ui).heroItem)
  self.tagPool = (UIItemPool.New)(UINFmtCardItemTag, (self.ui).syncItem)
  ;
  ((self.ui).syncItem):SetActive(false)
  self.color_ori_level = (((self.cardItem).ui).tex_Level).color
  self.color_ori_rank = ((((self.cardItem).ui).img_star).image).color
  for k,v in pairs((self.cardItem).ui) do
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R6 in 'UnsetPending'

    (self.ui)[k] = v
  end
end

UINFmtCardItem.InitHeroCardItem = function(self, heroData, resloader, clickedAction)
  -- function num : 0_1 , upvalues : _ENV
  self.heroData = heroData
  self.resloader = resloader
  self.onClickedAction = clickedAction
  ;
  (self.cardItem):InitHeroCardItem(heroData, resloader, clickedAction)
  local selfHeroData = (PlayerDataCenter.heroDic)[heroData.dataId]
  ;
  ((self.ui).obj_isSupport):SetActive(selfHeroData == nil)
  ;
  (self.tagPool):HideAll()
  if selfHeroData ~= nil then
    if selfHeroData.level ~= heroData.level then
      local item = (self.tagPool):GetOne(true)
      item:InitTag(selfHeroData.level, heroData.level, 0)
      ;
      (item.transform):SetParent(((self.ui).obj_syncList).transform)
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (((self.cardItem).ui).tex_Level).color = (self.ui).color_sync
    else
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R5 in 'UnsetPending'

      (((self.cardItem).ui).tex_Level).color = self.color_ori_level
    end
    if selfHeroData.rank ~= heroData.rank then
      local item = (self.tagPool):GetOne(true)
      item:InitTag(selfHeroData.rank, heroData.rank, 1)
      ;
      (item.transform):SetParent(((self.ui).obj_syncList).transform)
      for i,v in ipairs(((self.cardItem).ui).starArr) do
        -- DECOMPILER ERROR at PC85: Confused about usage of register: R11 in 'UnsetPending'

        (v.image).color = (self.ui).color_sync
      end
    else
      for i,v in ipairs(((self.cardItem).ui).starArr) do
        -- DECOMPILER ERROR at PC97: Confused about usage of register: R10 in 'UnsetPending'

        (v.image).color = self.color_ori_rank
      end
    end
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

UINFmtCardItem.SetSelectActive = function(self, active, isbench)
  -- function num : 0_2 , upvalues : base
  (base.SetSelectActive)(self, active, isbench)
  if ((self.ui).obj_syncList).activeInHierarchy == active then
    ((self.ui).obj_syncList):SetActive(not active)
  end
end

return UINFmtCardItem

