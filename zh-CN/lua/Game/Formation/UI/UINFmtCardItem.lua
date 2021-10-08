local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
local UINFmtCardItemTag = require("Game.Formation.UI.UINFmtCardItemTag")
local UINFmtCardItem = class("UINFmtCardItem", UINHeroCardItem)
local base = UINHeroCardItem
UINFmtCardItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, base, UINFmtCardItemTag
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.LuaUIBindingTable)((self.ui).heroItem, self.ui)
  ;
  (base.OnInit)(self)
  self.tagPool = (UIItemPool.New)(UINFmtCardItemTag, (self.ui).syncItem)
  ;
  ((self.ui).syncItem):SetActive(false)
  self.color_ori_level = ((self.ui).tex_Level).color
  self.color_ori_rank = (((self.ui).img_star).image).color
end

UINFmtCardItem.InitHeroCardItem = function(self, heroData, resloader, clickedAction)
  -- function num : 0_1 , upvalues : base, _ENV
  self.heroData = heroData
  self.resloader = resloader
  self.onClickedAction = clickedAction
  ;
  (base.InitHeroCardItem)(self, heroData, resloader, clickedAction)
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
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).tex_Level).color = (self.ui).color_sync
    else
      -- DECOMPILER ERROR at PC54: Confused about usage of register: R5 in 'UnsetPending'

      ((self.ui).tex_Level).color = self.color_ori_level
    end
    if selfHeroData.rank ~= heroData.rank then
      local item = (self.tagPool):GetOne(true)
      item:InitTag(selfHeroData.rank, heroData.rank, 1)
      ;
      (item.transform):SetParent(((self.ui).obj_syncList).transform)
      for i,v in ipairs((self.ui).starArr) do
        -- DECOMPILER ERROR at PC82: Confused about usage of register: R11 in 'UnsetPending'

        (v.image).color = (self.ui).color_sync
      end
    else
      for i,v in ipairs((self.ui).starArr) do
        -- DECOMPILER ERROR at PC93: Confused about usage of register: R10 in 'UnsetPending'

        (v.image).color = self.color_ori_rank
      end
    end
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

UINFmtCardItem.UpdateSkin = function(self)
  -- function num : 0_2 , upvalues : _ENV, base
  local realHeroData = (PlayerDataCenter.heroDic)[(self.heroData).dataId]
  if realHeroData == nil then
    (base.UpdateSkin)(self)
    return 
  end
  ;
  (self.heroData):UpdateSkin(realHeroData.skinId)
  ;
  (base.UpdateSkin)(self)
end

UINFmtCardItem.SetSelectActive = function(self, active, isbench)
  -- function num : 0_3 , upvalues : base
  (base.SetSelectActive)(self, active, isbench)
  if ((self.ui).obj_syncList).activeInHierarchy == active then
    ((self.ui).obj_syncList):SetActive(not active)
  end
end

return UINFmtCardItem

