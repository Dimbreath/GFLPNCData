local UINLtrPoolUpRate = class("UINLtrPoolUpRate", UIBaseNode)
local base = UIBaseNode
local UINLtrPoolUpHero = require("Game.Lottery.UI.PoolDetail.UpRate.UINLtrPoolUpHero")
UINLtrPoolUpRate.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINLtrPoolUpHero
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).obj_rateHeroItem):SetActive(false)
  self.heroItemPool = (UIItemPool.New)(UINLtrPoolUpHero, (self.ui).obj_rateHeroItem)
end

UINLtrPoolUpRate.InitLtrPoolUpRate = function(self, heroRewardList, resLoader)
  -- function num : 0_1 , upvalues : _ENV
  local rewardDataList = {}
  for k,rewardData in ipairs(heroRewardList) do
    local star = (rewardData.rankCfg).star
    local count = (math.ceil)(star / 2)
    if count >= 3 then
      (table.insert)(rewardDataList, rewardData)
    end
  end
  ;
  (table.sort)(rewardDataList, function(a, b)
    -- function num : 0_1_0
    if a.upHero ~= b.upHero then
      return false
    end
    do return (a.heroCfg).id < (b.heroCfg).id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self.heroItemPool):HideAll()
  for k,v in ipairs(rewardDataList) do
    local heroItem = (self.heroItemPool):GetOne()
    heroItem:InitLtrPoolUpHero(v, resLoader)
  end
end

UINLtrPoolUpRate.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (self.heroItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINLtrPoolUpRate

