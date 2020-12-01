-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLtrPoolDetail = class("UINLtrPoolDetail", UIBaseNode)
local base = UIBaseNode
local UINLtrPoolBaseRule = require("Game.Lottery.UI.PoolDetail.BaseRule.UINLtrPoolBaseRule")
local UINLtrPoolDetailRate = require("Game.Lottery.UI.PoolDetail.DetailRate.UINLtrPoolDetailRate")
local UINLtrPoolUpRate = require("Game.Lottery.UI.PoolDetail.UpRate.UINLtrPoolUpRate")
local UINLtrPoolDetailTog = require("Game.Lottery.UI.PoolDetail.UINLtrPoolDetailTog")
local cs_ResLoader = CS.ResLoader
UINLtrPoolDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINLtrPoolBaseRule, UINLtrPoolDetailRate, UINLtrPoolUpRate, UINLtrPoolDetailTog, cs_ResLoader
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
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
  self.typeTogList = {}
  for k,tog in ipairs((self.ui).typeTogList) do
    (UIUtil.AddValueChangedListener)(tog, self, self._OnClickDetailType, k)
    local typeTog = (UINLtrPoolDetailTog.New)()
    typeTog:Init(tog.gameObject)
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.typeTogList)[k] = typeTog
  end
  self.resLoader = (cs_ResLoader.Create)()
end

UINLtrPoolDetail.InitLtrPoolDetail = function(self, poolCfg, exitAction)
  -- function num : 0_1 , upvalues : _ENV
  self.poolCfg = poolCfg
  ;
  (UIUtil.Push2BackStack)(function()
    -- function num : 0_1_0 , upvalues : self, exitAction
    self:Hide()
    if exitAction ~= nil then
      exitAction()
    end
  end
)
  self:Show()
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
    ((self.ui).togGroup):SetAllTogglesOff()
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R4 in 'UnsetPending'

    if allZero then
      (((self.ui).typeTogList)[2]).isOn = true
    else
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (((self.ui).typeTogList)[1]).isOn = true
    end
  end
end

UINLtrPoolDetail._GenPoolData = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.rewardHeroDic = {}
  self.rewardDataList = {}
  local gashaponCfg = (ConfigData.gashapon)[(self.poolCfg).gashapon_id]
  if gashaponCfg == nil then
    error("Cant get gashaponCfg, id = " .. (self.poolCfg).gashapon_id)
    return 
  end
  self._itemIsAdd = false
  for type,v in pairs(gashaponCfg) do
    local rewardTypeDic = ((ConfigData.gashapon_buildfree_pool).rewardTypeDic)[type]
    self:_AddRewardData(rewardTypeDic, ConfigData.gashapon_buildfree_pool)
    rewardTypeDic = ((ConfigData.gashapon_reward_pool).rewardTypeDic)[type]
    self:_AddRewardData(rewardTypeDic, ConfigData.gashapon_reward_pool)
  end
  ;
  (table.sort)(self.rewardDataList, function(a, b)
    -- function num : 0_2_0
    local isHeroA = a.heroCfg ~= nil
    local isHeroB = b.heroCfg ~= nil
    local starA = a.rankCfg ~= nil and (a.rankCfg).star or 0
    local starB = b.rankCfg ~= nil and (b.rankCfg).star or 0
    if isHeroA == isHeroB then
      if starA == starB then
        if (a.itemCfg).id >= (b.itemCfg).id then
          do return a.upHero ~= b.upHero end
          do return starB < starA end
          do return isHeroA end
          do return a.upHero end
          -- DECOMPILER ERROR: 12 unprocessed JMP targets
        end
      end
    end
  end
)
end

UINLtrPoolDetail._AddRewardData = function(self, rewardTypeDic, rewardPool)
  -- function num : 0_3 , upvalues : _ENV
  if rewardTypeDic == nil then
    return 
  end
  for k,id in pairs(rewardTypeDic) do
    local rewardCfg = rewardPool[id]
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
            -- DECOMPILER ERROR at PC62: Confused about usage of register: R16 in 'UnsetPending'

            ;
            (self.rewardHeroDic)[heroId] = rewardData
            if ((self.poolCfg).heroUpAllDic)[heroId] then
              rewardData.upHero = true
              if #(self.poolCfg).prob_up < rankCfg.star then
                error("gashapon_para.prob_up error, gashapon_id = " .. tostring((self.poolCfg).gashapon_id))
              else
                rate = ((self.poolCfg).prob_up)[rankCfg.star]
                if #(self.poolCfg).prob < rankCfg.star then
                  error("gashapon_para.prob error, gashapon_id = " .. tostring((self.poolCfg).gashapon_id))
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
                      -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out DO_STMT

                      -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                      -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_STMT

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

UINLtrPoolDetail._OnClickDetailType = function(self, index, isOn)
  -- function num : 0_4 , upvalues : _ENV
  local typeTog = (self.typeTogList)[index]
  typeTog:ChangeLtrPoolDetailTogState(isOn)
  if index == 1 then
    if isOn then
      (self.upRateNode):Show()
      local heroRewardList = {}
      for heroId,v in pairs((self.poolCfg).heroUpAllDic) do
        local rewardData = (self.rewardHeroDic)[heroId]
        if rewardData == nil then
          error((string.format)("rewardData is null, heroId:%s, gashapon_id:%s", heroId, (self.poolCfg).gashapon_id))
        else
          ;
          (table.insert)(heroRewardList, rewardData)
        end
      end
      ;
      (self.upRateNode):InitLtrPoolUpRate(heroRewardList, self.resLoader, self.poolCfg)
    else
      do
        ;
        (self.upRateNode):Hide()
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
          end
        end
      end
    end
  end
end

UINLtrPoolDetail.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (self.baseRuleNode):Delete()
  ;
  (self.upRateNode):Delete()
  ;
  (self.detailRateNode):Delete()
  ;
  (self.resLoader):Put2Pool()
  self.resLoader = nil
  ;
  (base.OnDelete)(self)
end

return UINLtrPoolDetail

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLtrPoolDetail = class("UINLtrPoolDetail", UIBaseNode)
local base = UIBaseNode
local UINLtrPoolBaseRule = require(
                               "Game.Lottery.UI.PoolDetail.BaseRule.UINLtrPoolBaseRule")
local UINLtrPoolDetailRate = require(
                                 "Game.Lottery.UI.PoolDetail.DetailRate.UINLtrPoolDetailRate")
local UINLtrPoolUpRate = require(
                             "Game.Lottery.UI.PoolDetail.UpRate.UINLtrPoolUpRate")
local UINLtrPoolDetailTog = require(
                                "Game.Lottery.UI.PoolDetail.UINLtrPoolDetailTog")
local cs_ResLoader = CS.ResLoader
UINLtrPoolDetail.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINLtrPoolBaseRule, UINLtrPoolDetailRate, UINLtrPoolUpRate, UINLtrPoolDetailTog, cs_ResLoader
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.baseRuleNode = (UINLtrPoolBaseRule.New)();
    (self.baseRuleNode):Init((self.ui).baseRulePanel);
    (self.baseRuleNode):Hide()
    self.detailRateNode = (UINLtrPoolDetailRate.New)();
    (self.detailRateNode):Init((self.ui).detailRatePanel);
    (self.detailRateNode):Hide()
    self.upRateNode = (UINLtrPoolUpRate.New)();
    (self.upRateNode):Init((self.ui).uPRatePanel);
    (self.upRateNode):Hide()
    self.typeTogList = {}
    for k, tog in ipairs((self.ui).typeTogList) do
        (UIUtil.AddValueChangedListener)(tog, self, self._OnClickDetailType, k)
        local typeTog = (UINLtrPoolDetailTog.New)()
        typeTog:Init(tog.gameObject) -- DECOMPILER ERROR at PC58: Confused about usage of register: R7 in 'UnsetPending'
        ;
        (self.typeTogList)[k] = typeTog
    end
    self.resLoader = (cs_ResLoader.Create)()
end

UINLtrPoolDetail.InitLtrPoolDetail = function(self, poolCfg, exitAction)
    -- function num : 0_1 , upvalues : _ENV
    self.poolCfg = poolCfg;
    (UIUtil.Push2BackStack)(function()
        -- function num : 0_1_0 , upvalues : self, exitAction
        self:Hide()
        if exitAction ~= nil then exitAction() end
    end)
    self:Show()
    self:_GenPoolData()
    local allZero = true
    for k, rate in ipairs(poolCfg.prob_in) do
        if rate ~= 0 then
            allZero = false
            break
        end
    end
    do

        ((((self.ui).typeTogList)[1]).gameObject):SetActive(not allZero);
        ((self.ui).togGroup):SetAllTogglesOff()
        -- DECOMPILER ERROR at PC36: Confused about usage of register: R4 in 'UnsetPending'

        if allZero then
            (((self.ui).typeTogList)[2]).isOn = true
        else
            -- DECOMPILER ERROR at PC41: Confused about usage of register: R4 in 'UnsetPending'


            (((self.ui).typeTogList)[1]).isOn = true
        end
    end
end

UINLtrPoolDetail._GenPoolData = function(self)
    -- function num : 0_2 , upvalues : _ENV
    self.rewardHeroDic = {}
    self.rewardDataList = {}
    local gashaponCfg = (ConfigData.gashapon)[(self.poolCfg).gashapon_id]
    if gashaponCfg == nil then
        error("Cant get gashaponCfg, id = " .. (self.poolCfg).gashapon_id)
        return
    end
    self._itemIsAdd = false
    for type, v in pairs(gashaponCfg) do
        local rewardTypeDic =
            ((ConfigData.gashapon_buildfree_pool).rewardTypeDic)[type]
        self:_AddRewardData(rewardTypeDic, ConfigData.gashapon_buildfree_pool)
        rewardTypeDic = ((ConfigData.gashapon_reward_pool).rewardTypeDic)[type]
        self:_AddRewardData(rewardTypeDic, ConfigData.gashapon_reward_pool)
    end
    (table.sort)(self.rewardDataList, function(a, b)
        -- function num : 0_2_0
        local isHeroA = a.heroCfg ~= nil
        local isHeroB = b.heroCfg ~= nil
        local starA = a.rankCfg ~= nil and (a.rankCfg).star or 0
        local starB = b.rankCfg ~= nil and (b.rankCfg).star or 0
        if isHeroA == isHeroB then
            if starA == starB then
                if (a.itemCfg).id >= (b.itemCfg).id then
                    do return a.upHero ~= b.upHero end
                    do return starB < starA end
                    do return isHeroA end
                    do return a.upHero end
                    -- DECOMPILER ERROR: 12 unprocessed JMP targets
                end
            end
        end
    end)
end

UINLtrPoolDetail._AddRewardData = function(self, rewardTypeDic, rewardPool)
    -- function num : 0_3 , upvalues : _ENV
    if rewardTypeDic == nil then return end
    for k, id in pairs(rewardTypeDic) do
        local rewardCfg = rewardPool[id]
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
                        error("Can\'t find rankCfg, id = " ..
                                  tostring(heroCfg.rank))
                    else
                        rewardData.rankCfg = rankCfg -- DECOMPILER ERROR at PC62: Confused about usage of register: R16 in 'UnsetPending'
                        ;
                        (self.rewardHeroDic)[heroId] = rewardData
                        if ((self.poolCfg).heroUpAllDic)[heroId] then
                            rewardData.upHero = true
                            if #(self.poolCfg).prob_up < rankCfg.star then
                                error(
                                    "gashapon_para.prob_up error, gashapon_id = " ..
                                        tostring((self.poolCfg).gashapon_id))
                            else
                                rate = ((self.poolCfg).prob_up)[rankCfg.star]
                                if #(self.poolCfg).prob < rankCfg.star then
                                    error(
                                        "gashapon_para.prob error, gashapon_id = " ..
                                            tostring((self.poolCfg).gashapon_id))
                                else
                                    do
                                        do
                                            rate =
                                                ((self.poolCfg).prob)[rankCfg.star]
                                            if not self._itemIsAdd then
                                                rewardData.isItem = true
                                                self._itemIsAdd = true
                                                rewardData.rate = rate;
                                                (table.insert)(
                                                    self.rewardDataList,
                                                    rewardData)
                                            end
                                            -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out DO_STMT

                                            -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                            -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_STMT

                                            -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                            -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_STMT

                                            -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                            -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_STMT

                                            -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                            -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_STMT

                                            -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                            -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_STMT

                                            -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                            -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_STMT

                                            -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                            -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out IF_STMT

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

UINLtrPoolDetail._OnClickDetailType = function(self, index, isOn)
    -- function num : 0_4 , upvalues : _ENV
    local typeTog = (self.typeTogList)[index]
    typeTog:ChangeLtrPoolDetailTogState(isOn)
    if index == 1 then
        if isOn then
            (self.upRateNode):Show()
            local heroRewardList = {}
            for heroId, v in pairs((self.poolCfg).heroUpAllDic) do
                local rewardData = (self.rewardHeroDic)[heroId]
                if rewardData == nil then
                    error((string.format)(
                              "rewardData is null, heroId:%s, gashapon_id:%s",
                              heroId, (self.poolCfg).gashapon_id))
                else

                    (table.insert)(heroRewardList, rewardData)
                end
            end
            (self.upRateNode):InitLtrPoolUpRate(heroRewardList, self.resLoader,
                                                self.poolCfg)
        else
            do

                (self.upRateNode):Hide()
                if index == 2 then
                    if isOn then
                        (self.detailRateNode):Show();
                        (self.detailRateNode):InitLtrPoolDetailRate(
                            self.rewardDataList)
                    else

                        (self.detailRateNode):Hide()
                    end
                else
                    if index == 3 then
                        if isOn then
                            (self.baseRuleNode):Show();
                            (self.baseRuleNode):InitLtrPoolBaseRule(self.poolCfg)
                        else

                            (self.baseRuleNode):Hide()
                        end
                    end
                end
            end
        end
    end
end

UINLtrPoolDetail.OnDelete = function(self)
    -- function num : 0_5 , upvalues : base
    (self.baseRuleNode):Delete();
    (self.upRateNode):Delete();
    (self.detailRateNode):Delete();
    (self.resLoader):Put2Pool()
    self.resLoader = nil;
    (base.OnDelete)(self)
end

return UINLtrPoolDetail

