local UILotteryPoolDetail = class("UILotteryPoolDetail", UIBaseWindow)
local base = UIBaseWindow
local UINLtrPoolBaseRule = require("Game.Lottery.UI.PoolDetail.BaseRule.UINLtrPoolBaseRule")
local UINLtrPoolDetailRate = require("Game.Lottery.UI.PoolDetail.DetailRate.UINLtrPoolDetailRate")
local UINLtrPoolUpRate = require("Game.Lottery.UI.PoolDetail.UpRate.UINLtrPoolUpRate")
local UINLtrPoolRecord = require("Game.Lottery.UI.PoolDetail.Record.UINLtrPoolRecord")
local UINLtrPoolDetailTog = require("Game.Lottery.UI.PoolDetail.UINLtrPoolDetailTog")
local CheckerTypeId, CheckerGlobalConfig = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local cs_ResLoader = CS.ResLoader
UILotteryPoolDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : UINLtrPoolBaseRule, UINLtrPoolDetailRate, UINLtrPoolUpRate, UINLtrPoolRecord, _ENV, UINLtrPoolDetailTog, cs_ResLoader
  self.baseRuleNode = (UINLtrPoolBaseRule.New)()
  ;
  (self.baseRuleNode):Init((self.ui).baseRulePanel)
  ;
  (self.baseRuleNode):Hide()
  self.detailRateNode = (UINLtrPoolDetailRate.New)()
  ;
  (self.detailRateNode):Init((self.ui).detailRatePanel)
  ;
  (self.detailRateNode):Hide()
  self.upRateNode = (UINLtrPoolUpRate.New)()
  ;
  (self.upRateNode):Init((self.ui).uPRatePanel)
  ;
  (self.upRateNode):Hide()
  self.recordNode = (UINLtrPoolRecord.New)()
  ;
  (self.recordNode):Init((self.ui).recordPanel)
  ;
  (self.recordNode):Hide()
  self.typeTogList = {}
  for k,tog in ipairs((self.ui).typeTogList) do
    (UIUtil.AddValueChangedListener)(tog, self, self._OnClickDetailType, k)
    local typeTog = (UINLtrPoolDetailTog.New)()
    typeTog:Init(tog.gameObject)
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.typeTogList)[k] = typeTog
  end
  self.resLoader = (cs_ResLoader.Create)()
end

UILotteryPoolDetail.InitLtrPoolDetail = function(self, poolCfg, exitAction)
  -- function num : 0_1 , upvalues : _ENV
  self.poolCfg = poolCfg
  ;
  (UIUtil.Push2BackStack)(self, function()
    -- function num : 0_1_0 , upvalues : self, exitAction
    self:Delete()
    if exitAction ~= nil then
      exitAction()
    end
  end
)
  self:Show()
  AudioManager:PlayAudioById(1066)
  self:_GenPoolData()
  local allZero = true
  for k,rate in ipairs(poolCfg.prob_in) do
    if rate ~= 0 then
      allZero = false
      break
    end
  end
  do
    ;
    ((((self.ui).typeTogList)[1]).gameObject):SetActive(not allZero)
    ;
    ((((self.ui).typeTogList)[2]).gameObject):SetActive(poolCfg.pool_client_type == 1)
    ;
    ((((self.ui).typeTogList)[4]).gameObject):SetActive(poolCfg.pool_type == 1)
    for k,tog in ipairs((self.ui).typeTogList) do
      tog.isOn = false
      if (tog.gameObject).activeInHierarchy then
        tog.isOn = true
        break
      end
    end
    if (self.poolCfg).lottery_id == 5 then
      ((self.ui).tex_RateFrame):SetIndex(1)
      ;
      ((self.ui).tex_RateDetail):SetIndex(1)
    else
      ((self.ui).tex_RateFrame):SetIndex(0)
      ;
      ((self.ui).tex_RateDetail):SetIndex(0)
    end
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
end

__GetRewardBuildingLevel = function(rewardCfg)
  -- function num : 0_2 , upvalues : _ENV, CheckerTypeId
  local level = 0
  for k,v in ipairs(rewardCfg.pre_condition) do
    if v == CheckerTypeId.BuildingLevel then
      level = (rewardCfg.pre_para2)[k]
      break
    end
  end
  do
    return level
  end
end

UILotteryPoolDetail._GenPoolData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self.rewardHeroDic = {}
  self.rewardDataList = {}
  local lotteryCfg = (ConfigData.lottery)[(self.poolCfg).lottery_id]
  if lotteryCfg == nil then
    error("Cant get lotteryCfg, id = " .. (self.poolCfg).lottery_id)
    return 
  end
  self._itemIsAdd = false
  for type,v in pairs(lotteryCfg) do
    local rewardTypeDic = (ConfigData.lottery_reward_pool)[type]
    if rewardTypeDic == nil then
      error("Cant get lottery_reward_pool, type = " .. tostring(type))
    else
      self:_AddRewardData(rewardTypeDic)
    end
  end
  ;
  (table.sort)(self.rewardDataList, function(a, b)
    -- function num : 0_3_0 , upvalues : _ENV
    local isHeroA = a.heroCfg ~= nil
    local isHeroB = b.heroCfg ~= nil
    local starA = a.rankCfg ~= nil and (a.rankCfg).star or 0
    local starB = b.rankCfg ~= nil and (b.rankCfg).star or 0
    local buildingLvA = __GetRewardBuildingLevel(a.rewardCfg)
    local buildingLvB = __GetRewardBuildingLevel(b.rewardCfg)
    if a.upHero ~= b.upHero then
      return a.upHero
    end
    if isHeroA ~= isHeroB then
      return isHeroA
    end
    if starB >= starA then
      do return starA == starB end
      if buildingLvB >= buildingLvA then
        do return buildingLvA == buildingLvB end
        do return (a.itemCfg).id < (b.itemCfg).id end
        -- DECOMPILER ERROR: 13 unprocessed JMP targets
      end
    end
  end
)
end

UILotteryPoolDetail._AddRewardData = function(self, rewardTypeDic)
  -- function num : 0_4 , upvalues : _ENV
  for k,rewardCfg in pairs(rewardTypeDic) do
    local rewardData = {}
    rewardData.rewardCfg = rewardCfg
    local itemId = rewardCfg.item_reward
    local itemCfg = (ConfigData.item)[itemId]
    if itemCfg == nil then
      error("Cant get itemCfg, id = " .. itemId)
    else
      rewardData.itemCfg = itemCfg
      local rate = (self.poolCfg).prob_item
      if itemCfg.action_type == eItemActionType.HeroCard then
        local heroId = (itemCfg.arg)[1]
        local heroCfg = (ConfigData.hero_data)[heroId]
        if heroCfg == nil then
          error("hero cfg is null,id:" .. tostring(heroId))
        else
          rewardData.heroCfg = heroCfg
          local rankCfg = (ConfigData.hero_rank)[heroCfg.rank]
          if rankCfg == nil then
            error("Can\'t find rankCfg, id = " .. tostring(heroCfg.rank))
          else
            rewardData.rankCfg = rankCfg
            -- DECOMPILER ERROR at PC58: Confused about usage of register: R14 in 'UnsetPending'

            ;
            (self.rewardHeroDic)[heroId] = rewardData
            if ((self.poolCfg).heroUpAllDic)[heroId] then
              rewardData.upHero = true
              if #(self.poolCfg).prob_up < rankCfg.star then
                error("lottery_para.prob_up error, lottery_id = " .. tostring((self.poolCfg).lottery_id))
              else
                rate = ((self.poolCfg).prob_up)[rankCfg.star]
                if #(self.poolCfg).prob < rankCfg.star then
                  error("lottery_para.prob error, lottery_id = " .. tostring((self.poolCfg).lottery_id))
                else
                  do
                    do
                      rate = ((self.poolCfg).prob)[rankCfg.star]
                      if not self._itemIsAdd then
                        rewardData.isItem = true
                        self._itemIsAdd = true
                        rewardData.rate = rate
                        ;
                        (table.insert)(self.rewardDataList, rewardData)
                      end
                      -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_STMT

                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

UILotteryPoolDetail._OnClickDetailType = function(self, index, isOn)
  -- function num : 0_5
  local typeTog = (self.typeTogList)[index]
  typeTog:ChangeLtrPoolDetailTogState(isOn)
  if index == 1 then
    if isOn then
      (self.upRateNode):Show()
      ;
      (self.upRateNode):InitLtrPoolUpRate(self.rewardDataList, self.resLoader)
    else
      ;
      (self.upRateNode):Hide()
    end
  else
    if index == 2 then
      if isOn then
        (self.detailRateNode):Show()
        ;
        (self.detailRateNode):InitLtrPoolDetailRate(self.rewardDataList)
      else
        ;
        (self.detailRateNode):Hide()
      end
    else
      if index == 3 then
        if isOn then
          (self.baseRuleNode):Show()
          ;
          (self.baseRuleNode):InitLtrPoolBaseRule(self.poolCfg)
        else
          ;
          (self.baseRuleNode):Hide()
        end
      else
        if index == 4 then
          if isOn then
            (self.recordNode):Show()
            ;
            (self.recordNode):InitLtrPoolRecord(self.poolCfg)
          else
            ;
            (self.recordNode):Hide()
          end
        end
      end
    end
  end
end

UILotteryPoolDetail.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (self.baseRuleNode):Delete()
  ;
  (self.upRateNode):Delete()
  ;
  (self.detailRateNode):Delete()
  ;
  (self.recordNode):Delete()
  ;
  (self.resLoader):Put2Pool()
  self.resLoader = nil
  ;
  (base.OnDelete)(self)
end

return UILotteryPoolDetail

