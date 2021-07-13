-- params : ...
-- function num : 0 , upvalues : _ENV
local UINWCRankPanelItem = class("UINWCRankPanelItem", UIBaseNode)
local base = UIBaseNode
local UINWCRankPanelItemHeroHead = require("Game.PeriodicChallenge.UI.WeeklyChallengeRank.UINWCRankPanelItemHeroHead")
UINWCRankPanelItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINWCRankPanelItemHeroHead
  self.waitingDataIndex = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.heroHeadPool = (UIItemPool.New)(UINWCRankPanelItemHeroHead, (self.ui).obj_HeroHead)
  ;
  ((self.ui).obj_HeroHead):SetActive(false)
end

UINWCRankPanelItem.RefreshWCRItemInfo = function(self, rankData)
  -- function num : 0_1 , upvalues : _ENV
  self.waitingDataIndex = nil
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_RankNumber).text = tostring(rankData.rank)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_PlayerName).text = tostring((rankData.entry).name)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Score).text = tostring((rankData.entry).score)
  local count = 0
  ;
  (self.heroHeadPool):HideAll()
  for key,heroData in ipairs((rankData.entry).heroes) do
    ((self.heroHeadPool):GetOne()):InitHead(heroData.id, heroData.level, heroData.star)
    count = count + 1
  end
  do
    if count < 5 then
    end
  end
end

UINWCRankPanelItem.SetWCRItemWait4Data = function(self, dataIndex)
  -- function num : 0_2 , upvalues : _ENV
  self.waitingDataIndex = dataIndex
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_RankNumber).text = tostring(dataIndex)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_PlayerName).text = "加载中"
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Score).text = "加载中"
  ;
  (self.heroHeadPool):HideAll()
end

UINWCRankPanelItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINWCRankPanelItem

