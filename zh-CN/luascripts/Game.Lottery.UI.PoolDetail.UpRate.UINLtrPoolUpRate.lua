-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLtrPoolUpRate = class("UINLtrPoolUpRate", UIBaseNode)
local base = UIBaseNode
local UINLtrPoolUpRateGroup = require("Game.Lottery.UI.PoolDetail.UpRate.UINLtrPoolUpRateGroup")
UINLtrPoolUpRate.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINLtrPoolUpRateGroup
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  ((self.ui).upRateItem):SetActive(false)
  self.groupPool = (UIItemPool.New)(UINLtrPoolUpRateGroup, (self.ui).upRateItem)
end

UINLtrPoolUpRate.InitLtrPoolUpRate = function(self, heroRewardList, resLoader, poolCfg)
  -- function num : 0_1 , upvalues : _ENV
  local groupDataList = {}
  local starList = {}
  for k,rewardData in ipairs(heroRewardList) do
    local star = (rewardData.rankCfg).star
    if groupDataList[star] == nil then
      groupDataList[star] = {}
      ;
      (table.insert)(starList, star)
    end
    local groupList = groupDataList[star]
    ;
    (table.insert)(groupList, rewardData)
  end
  ;
  (table.sort)(starList, function(a, b)
    -- function num : 0_1_0
    do return b < a end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self.groupPool):HideAll()
  for k,star in ipairs(starList) do
    local rewardDataList = groupDataList[star]
    local ratio = 0
    if #poolCfg.prob_in < star then
      error("gashapon_para.prob_in error")
    else
      ratio = (poolCfg.prob_in)[star]
    end
    local groupItem = (self.groupPool):GetOne()
    groupItem:InitLtrPoolUpRateGroup(rewardDataList, star, ratio, resLoader)
  end
end

UINLtrPoolUpRate.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (self.groupPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINLtrPoolUpRate

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLtrPoolUpRate = class("UINLtrPoolUpRate", UIBaseNode)
local base = UIBaseNode
local UINLtrPoolUpRateGroup = require(
                                  "Game.Lottery.UI.PoolDetail.UpRate.UINLtrPoolUpRateGroup")
UINLtrPoolUpRate.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINLtrPoolUpRateGroup
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    ((self.ui).upRateItem):SetActive(false)
    self.groupPool = (UIItemPool.New)(UINLtrPoolUpRateGroup,
                                      (self.ui).upRateItem)
end

UINLtrPoolUpRate.InitLtrPoolUpRate = function(self, heroRewardList, resLoader,
                                              poolCfg)
    -- function num : 0_1 , upvalues : _ENV
    local groupDataList = {}
    local starList = {}
    for k, rewardData in ipairs(heroRewardList) do
        local star = (rewardData.rankCfg).star
        if groupDataList[star] == nil then
            groupDataList[star] = {};
            (table.insert)(starList, star)
        end
        local groupList = groupDataList[star];
        (table.insert)(groupList, rewardData)
    end
    (table.sort)(starList, function(a, b)
        -- function num : 0_1_0
        do return b < a end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end);
    (self.groupPool):HideAll()
    for k, star in ipairs(starList) do
        local rewardDataList = groupDataList[star]
        local ratio = 0
        if #poolCfg.prob_in < star then
            error("gashapon_para.prob_in error")
        else
            ratio = (poolCfg.prob_in)[star]
        end
        local groupItem = (self.groupPool):GetOne()
        groupItem:InitLtrPoolUpRateGroup(rewardDataList, star, ratio, resLoader)
    end
end

UINLtrPoolUpRate.OnDelete = function(self)
    -- function num : 0_2 , upvalues : base
    (self.groupPool):DeleteAll();
    (base.OnDelete)(self)
end

return UINLtrPoolUpRate

