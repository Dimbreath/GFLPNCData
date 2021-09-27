local UINWCRankRewardPanel = class("UINWCRankRewardPanel", UIBaseNode)
local base = UIBaseNode
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local UINWCRankRewardPanelItem = require("Game.PeriodicChallenge.UI.WeeklyChallengeRank.UINWCRankRewardPanelItem")
UINWCRankRewardPanel.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINWCRankRewardPanelItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.rewardItemPool = (UIItemPool.New)(UINWCRankRewardPanelItem, (self.ui).obj_rank)
  ;
  ((self.ui).obj_rank):SetActive(false)
  self.curRankItem = nil
end

UINWCRankRewardPanel.InitRankRewardPanel = function(self, selfRangeData)
  -- function num : 0_1 , upvalues : _ENV, UINWCRankRewardPanelItem
  local rank, rate = nil, nil
  if selfRangeData.score ~= 0 and selfRangeData.curRank ~= 0 then
    rank = selfRangeData.curRank
    rate = selfRangeData.curRank / selfRangeData.total
  end
  ;
  (self.rewardItemPool):HideAll()
  local lastScore = 0
  local maxIndex = #ConfigData.weekly_challenge_rank_reward
  for index,rankRewardCfg in ipairs(ConfigData.weekly_challenge_rank_reward) do
    local item = (self.rewardItemPool):GetOne()
    item:InitRankRewardPanelItem(rankRewardCfg, lastScore, maxIndex == index)
    lastScore = rankRewardCfg.score
    if rank ~= nil and self.curRankItem == nil then
      if rankRewardCfg.type == (UINWCRankRewardPanelItem.eType).actuallyRank and rank <= rankRewardCfg.score then
        self.curRankItem = item
      elseif rankRewardCfg.type == (UINWCRankRewardPanelItem.eType).percentRank and rate * 1000 <= rankRewardCfg.score then
        self.curRankItem = item
      end
    end
    ;
    ((item.ui).img_CurrentRank):SetActive(false)
  end
  if self.curRankItem ~= nil then
    (((self.curRankItem).ui).img_CurrentRank):SetActive(true)
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UINWCRankRewardPanel.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINWCRankRewardPanel

