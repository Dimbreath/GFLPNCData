local UINWCRankRewardPanelItem = class("UINWCRankRewardPanelItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
UINWCRankRewardPanelItem.eType = {actuallyRank = 1, percentRank = 2}
UINWCRankRewardPanelItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithCount
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.itemPool = (UIItemPool.New)(UINBaseItemWithCount, (self.ui).uINBaseItemWithCount)
  ;
  ((self.ui).uINBaseItemWithCount):SetActive(false)
end

UINWCRankRewardPanelItem.InitRankRewardPanelItem = function(self, rankRewardCfg, lastScore, isLastRegion)
  -- function num : 0_1 , upvalues : UINWCRankRewardPanelItem, _ENV
  if (UINWCRankRewardPanelItem.eType).actuallyRank == rankRewardCfg.type then
    if lastScore == nil or lastScore == 0 then
      if rankRewardCfg.score == 1 then
        ((self.ui).tex_AwardNumber):SetIndex(0, tostring(rankRewardCfg.score))
      else
        ;
        ((self.ui).tex_AwardNumber):SetIndex(1, "1", tostring(rankRewardCfg.score))
      end
    else
      ;
      ((self.ui).tex_AwardNumber):SetIndex(1, tostring(lastScore + 1), tostring(rankRewardCfg.score))
    end
  else
    if (UINWCRankRewardPanelItem.eType).percentRank == rankRewardCfg.type then
      if isLastRegion then
        ((self.ui).tex_AwardNumber):SetIndex(3)
      else
        ;
        ((self.ui).tex_AwardNumber):SetIndex(2, tostring(FormatNum(rankRewardCfg.score / 10)))
      end
    end
  end
  ;
  (self.itemPool):HideAll()
  for index,itemId in ipairs(rankRewardCfg.rewardIds) do
    local itemCfg = (ConfigData.item)[itemId]
    if itemCfg == nil then
      error("can\'t read itemCfg with id " .. tostring(R13_PC83))
    else
      local item = (self.itemPool):GetOne()
      item:InitItemWithCount(R13_PC83, (rankRewardCfg.rewardNums)[index])
    end
  end
end

UINWCRankRewardPanelItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINWCRankRewardPanelItem

