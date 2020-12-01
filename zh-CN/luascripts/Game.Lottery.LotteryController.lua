-- params : ...
-- function num : 0 , upvalues : _ENV
local LotteryController = class("LotteryController", ControllerBase)
local base = ControllerBase
local LotteryEnum = require("Game.Lottery.LotteryEnum")
local LotteryShowCtrl = require("Game.Lottery.Ctrl.LotteryShowCtrl")
local ShopEnum = require("Game.Shop.ShopEnum")
local cs_MessageCommon = CS.MessageCommon
local cs_camera = (CS.UnityEngine).Camera
LotteryController.ctor = function(self)
  -- function num : 0_0 , upvalues : LotteryShowCtrl, LotteryEnum
  self.ctrls = {}
  self.ltrShowCtrl = (LotteryShowCtrl.New)(self)
  self.__lotteryState = (LotteryEnum.eLotteryState).None
end

LotteryController.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, cs_camera
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Lottery)
  self.dailyLotteryLimtNum = (ConfigData.game_config).DailyLotteryLimtNum
  self.__mianCam = cs_camera.main
end

LotteryController.InitLottery = function(self, showWindowCallback)
  -- function num : 0_2 , upvalues : _ENV, LotteryEnum
  self:_InitLtrPoolData()
  self.poolIndex = 1
  UIManager:ShowWindowAsync(UIWindowTypeID.LotteryWindow, function(win)
    -- function num : 0_2_0 , upvalues : self, showWindowCallback, LotteryEnum
    if win ~= nil then
      win:InitUILottery(self, self.poolIdList, self.poolIndex)
      if showWindowCallback ~= nil then
        showWindowCallback()
      end
      self:ChangeLotteryState((LotteryEnum.eLotteryState).Normal)
    end
  end
)
end

LotteryController._InitLtrPoolData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self.poolIdList = {}
  for poolId,v in pairs(ConfigData.gashapon_para) do
    if (CheckCondition.CheckLua)(v.pre_condition, v.pre_para1, v.pre_para2) then
      (table.insert)(self.poolIdList, poolId)
    end
  end
  ;
  (table.sort)(self.poolIdList, function(a, b)
    -- function num : 0_3_0 , upvalues : _ENV
    do return ((ConfigData.gashapon_para)[a]).line < ((ConfigData.gashapon_para)[b]).line end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

LotteryController.ChangeLotteryState = function(self, state)
  -- function num : 0_4 , upvalues : LotteryEnum, _ENV
  self.__lotteryState = state
  if state == (LotteryEnum.eLotteryState).Normal then
    GuideManager:TryTriggerGuide(eGuideCondition.InLottery)
  end
end

LotteryController.IsLotteryNormalState = function(self)
  -- function num : 0_5 , upvalues : LotteryEnum
  do return self.__lotteryState == (LotteryEnum.eLotteryState).Normal end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

LotteryController.GetLtrPoolNum = function(poolId)
  -- function num : 0_6 , upvalues : _ENV
  local counterElem = (ControllerManager:GetController(ControllerTypeId.TimePass)):getCounterElemData(proto_object_CounterModule.CounterModuleLotteryNum, poolId)
  if counterElem ~= nil and PlayerDataCenter.timestamp <= counterElem.nextExpiredTm then
    return counterElem.times
  end
  return 0
end

LotteryController.LtrPoolIsFreeCdNow = function(poolId)
  -- function num : 0_7 , upvalues : _ENV
  local counterElem = (ControllerManager:GetController(ControllerTypeId.TimePass)):getCounterElemData(proto_object_CounterModule.CounterModuleLotteryFreeCd, poolId)
  local curLtrPoolCfg = (ConfigData.gashapon_para)[poolId]
  if curLtrPoolCfg.cd == 0 then
    return false
  end
  -- DECOMPILER ERROR at PC26: Unhandled construct in 'MakeBoolean' P1

  if counterElem ~= nil and counterElem.nextExpiredTm < PlayerDataCenter.timestamp then
    return true
  end
  do return true end
  return false
end

LotteryController.SelectLtrPool = function(self, poolId)
  -- function num : 0_8 , upvalues : _ENV
  self.curPoolId = poolId
  self.curLtrPoolCfg = (ConfigData.gashapon_para)[poolId]
  self.enableExcuteFree = (self.curLtrPoolCfg).cd ~= 0
  self.cost1Name = (LanguageUtil.GetLocaleText)(((ConfigData.item)[(self.curLtrPoolCfg).costId1]).name)
  self.cost2Name = (LanguageUtil.GetLocaleText)(((ConfigData.item)[(self.curLtrPoolCfg).costId2]).name)
  if self:CheckLtrPoolExpired() then
    return 
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

LotteryController.LtrDrawOne = function(self)
  -- function num : 0_9 , upvalues : cs_MessageCommon, _ENV, LotteryEnum
  if self:CheckLtrPoolExpired() then
    return 
  end
  local curNum = (self.GetLtrPoolNum)(self.curPoolId)
  if self.dailyLotteryLimtNum - curNum < 1 then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.lottery_DailyLimtFull))
    return 
  end
  local itemCount = PlayerDataCenter:GetItemCount((self.curLtrPoolCfg).costId1)
  if self.__onDrawOneComplete == nil then
    self.__onDrawOneComplete = BindCallback(self, self.OnLtrDrawOneComplete)
  end
  local executeOneFunc = function()
    -- function num : 0_9_0 , upvalues : self, LotteryEnum, _ENV
    self:ChangeLotteryState((LotteryEnum.eLotteryState).LotteryAnimation)
    self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    ;
    (self.networkCtrl):SendExecuteOnce(self.curPoolId, self.__onDrawOneComplete)
  end

  if (self.LtrPoolIsFreeCdNow)(self.curPoolId) then
    executeOneFunc()
  else
    if (self.curLtrPoolCfg).costNum1 <= itemCount then
      if (self.curLtrPoolCfg).pool_type == (LotteryEnum.eLotteryPoolType).Paid then
        local msg = (string.format)("是否使用<color=#FE8B15>%s%s</color>进行检索", tostring((self.curLtrPoolCfg).costNum1), self.cost1Name)
        do
          UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(window)
    -- function num : 0_9_1 , upvalues : msg, self, executeOneFunc
    if window == nil then
      return 
    end
    window:ShowItemCost(msg, (self.curLtrPoolCfg).costId1, (self.curLtrPoolCfg).costNum1, executeOneFunc)
  end
)
        end
      else
        do
          executeOneFunc()
          self:OnConsumptionNotEnough((self.curLtrPoolCfg).costId1, itemCount, (self.curLtrPoolCfg).costNum1, executeOneFunc)
        end
      end
    end
  end
end

LotteryController.OnLtrDrawOneComplete = function(self, objList)
  -- function num : 0_10 , upvalues : _ENV
  if objList.Count ~= 1 then
    error("objList.Count error:" .. tostring(objList.Count))
    return 
  end
  local elemList = objList[0]
  self:GenLtrResult(elemList)
end

LotteryController.LtrDrawTen = function(self)
  -- function num : 0_11 , upvalues : cs_MessageCommon, _ENV, LotteryEnum
  if self:CheckLtrPoolExpired() then
    return 
  end
  local curNum = (self.GetLtrPoolNum)(self.curPoolId)
  if self.dailyLotteryLimtNum - curNum < 10 then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.lottery_DailyLimtFull))
    return 
  end
  local itemCount = PlayerDataCenter:GetItemCount((self.curLtrPoolCfg).costId2)
  if self.__onDrawTenComplete == nil then
    self.__onDrawTenComplete = BindCallback(self, self.OnLtrDrawTenComplete)
  end
  local executeTenFunc = function()
    -- function num : 0_11_0 , upvalues : self, LotteryEnum, _ENV
    self:ChangeLotteryState((LotteryEnum.eLotteryState).LotteryAnimation)
    self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    ;
    (self.networkCtrl):SendExecuteTen(self.curPoolId, self.__onDrawTenComplete)
  end

  if (self.curLtrPoolCfg).costNum2 <= itemCount then
    if (self.curLtrPoolCfg).pool_type == (LotteryEnum.eLotteryPoolType).Paid then
      local msg = (string.format)(ConfigData:GetTipContent(303), tostring((self.curLtrPoolCfg).costNum2), self.cost2Name)
      do
        UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(window)
    -- function num : 0_11_1 , upvalues : msg, self, executeTenFunc
    if window == nil then
      return 
    end
    window:ShowItemCost(msg, (self.curLtrPoolCfg).costId2, (self.curLtrPoolCfg).costNum2, executeTenFunc)
  end
)
      end
    else
      do
        executeTenFunc()
        self:OnConsumptionNotEnough((self.curLtrPoolCfg).costId2, itemCount, (self.curLtrPoolCfg).costNum2, executeTenFunc)
      end
    end
  end
end

LotteryController.OnLtrDrawTenComplete = function(self, objList)
  -- function num : 0_12 , upvalues : _ENV
  if objList.Count ~= 1 then
    error("objList.Count error:" .. tostring(objList.Count))
    return 
  end
  local elemList = objList[0]
  self:GenLtrResult(elemList)
end

LotteryController.GenLtrResult = function(self, elemList)
  -- function num : 0_13 , upvalues : _ENV
  local newElemList = {}
  for k,v in ipairs(elemList) do
    if v.firstReward then
      (table.insert)(newElemList, v)
      ;
      (table.remove)(elemList, k)
      break
    end
  end
  do
    local count = #elemList
    for i = count, 1, -1 do
      local index = (math.random)(i)
      local elem = (table.remove)(elemList, index)
      ;
      (table.insert)(newElemList, elem)
    end
    local showRareList = {}
    local heroIdList = {}
    local newHeroIndexDic = {}
    local acquiredHeroIdDic = {}
    for k,elem in ipairs(newElemList) do
      local itemId = elem.item
      local itemCfg = (ConfigData.item)[itemId]
      if itemCfg == nil then
        error("Can\'t find item, id = " .. tostring(itemId))
      else
        elem.itemCfg = itemCfg
        local rare = eHeroCardRareType.R
        if itemCfg.action_type == eItemActionType.HeroCard then
          local heroId = (itemCfg.arg)[1]
          local heroData = (PlayerDataCenter.heroDic)[heroId]
          ;
          (table.insert)(heroIdList, heroId)
          local isNewHero = ((self._heroIdSnapShoot)[heroId] ~= true and not acquiredHeroIdDic[heroId])
          newHeroIndexDic[#heroIdList] = isNewHero
          elem.isNewHero = isNewHero
          local rankCfg = (ConfigData.hero_rank)[(heroData.heroCfg).rank]
          if rankCfg == nil then
            error("Can\'t find rankCfg, id = " .. tostring((heroData.heroCfg).rank))
          else
            rare = rankCfg.rare
          end
          elem.heroData = heroData
          acquiredHeroIdDic[heroId] = true
        end
        ;
        (table.insert)(showRareList, rare)
      end
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.LotteryShow, function(window)
    -- function num : 0_13_0 , upvalues : self, showRareList
    if window == nil then
      return 
    end
    window:InitLotteryShow(self.ltrShowCtrl)
    self:__SetMainCamActive(false)
    ;
    (self.ltrShowCtrl):LtrShowStart(showRareList, (self.curLtrPoolCfg).pool_type)
  end
)
    self.heroIdList = heroIdList
    self.newHeroIndexDic = newHeroIndexDic
    self.rewardElemList = newElemList
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
end

LotteryController.LtrShowEnd = function(self)
  -- function num : 0_14 , upvalues : _ENV
  UIManager:DeleteWindow(UIWindowTypeID.LotteryShow)
  if self.rewardElemList == nil then
    return 
  end
  if #self.rewardElemList == 1 then
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_14_0 , upvalues : self, _ENV
    if window == nil then
      return 
    end
    window:BindCommonRewardStart(function()
      -- function num : 0_14_0_0 , upvalues : self
      self:_HideLtrShow()
    end
)
    window:InitRewardsItem({((self.rewardElemList)[1]).item}, {((self.rewardElemList)[1]).num}, self._heroIdSnapShoot)
    window:BindCommonRewardExit(BindCallback(self, self.OnLotteryComplete, true))
  end
)
  else
    if #self.heroIdList == 0 then
      self:LtrHeroShowEnd(true)
    else
      UIManager:ShowWindowAsync(UIWindowTypeID.GetHero, function(window)
    -- function num : 0_14_1 , upvalues : self
    if window == nil then
      return 
    end
    window:InitGetHeroList(self.heroIdList, false, true, self.newHeroIndexDic, function()
      -- function num : 0_14_1_0 , upvalues : self
      self:LtrHeroShowEnd(false)
    end
)
    self:_HideLtrShow()
  end
)
    end
  end
end

LotteryController.LtrHeroShowEnd = function(self, withHideShow)
  -- function num : 0_15 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.LotteryResult, function(window)
    -- function num : 0_15_0 , upvalues : self, _ENV, withHideShow
    if window == nil then
      return 
    end
    window:InitLtrResult(self.rewardElemList)
    window:BindLotteryResultExit(BindCallback(self, self.OnLotteryComplete, false))
    if withHideShow then
      self:_HideLtrShow()
    else
      UIManager:DeleteWindow(UIWindowTypeID.GetHero)
    end
  end
)
end

LotteryController.OnLotteryComplete = function(self, isSingle)
  -- function num : 0_16 , upvalues : _ENV, LotteryEnum
  local lotteryWindow = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
  if lotteryWindow == nil then
    self:ChangeLotteryState((LotteryEnum.eLotteryState).None)
  else
    if (lotteryWindow.poolDetailNode).active then
      self:ChangeLotteryState((LotteryEnum.eLotteryState).PoolDetail)
    else
      self:ChangeLotteryState((LotteryEnum.eLotteryState).Normal)
    end
  end
end

LotteryController._HideLtrShow = function(self)
  -- function num : 0_17 , upvalues : _ENV
  UIManager:ShowWindow(UIWindowTypeID.LotteryWindow)
  ;
  (self.ltrShowCtrl):HideLtrShow()
end

LotteryController.CheckLtrPoolExpired = function(self)
  -- function num : 0_18 , upvalues : _ENV, cs_MessageCommon
  local cfg = self.curLtrPoolCfg
  if not (CheckCondition.CheckLua)(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2) then
    (cs_MessageCommon.ShowMessageBoxConfirm)(ConfigData:GetTipContent(TipContent.Ltr_PoolExpired), function()
    -- function num : 0_18_0 , upvalues : self, _ENV
    self:_InitLtrPoolData()
    if #self.poolIdList < self.poolIndex then
      self.poolIndex = 1
    end
    local window = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
    window:RefreshLtrPoolUI(self.poolIdList, self.poolIndex)
  end
)
    return true
  end
  return false
end

LotteryController.OnConsumptionNotEnough = function(self, itemId, containNum, costNum, executeFunc)
  -- function num : 0_19 , upvalues : LotteryEnum, _ENV, ShopEnum
  if (self.curLtrPoolCfg).pool_type == (LotteryEnum.eLotteryPoolType).NoPaid then
    local msg = self.cost2Name .. ConfigData:GetTipContent(TipContent.lottery_ItemInsufficient)
    do
      UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(window)
    -- function num : 0_19_0 , upvalues : msg, itemId, costNum
    if window == nil then
      return 
    end
    window:ShowItemCostConfirm(msg, itemId, costNum)
  end
)
    end
  else
    do
      if (self.curLtrPoolCfg).pool_type == (LotteryEnum.eLotteryPoolType).Paid then
        local needItemNum = costNum - containNum
        local quickBuyData = (ShopEnum.eQuickBuy).lottery
        local shopId = quickBuyData.shopId
        local goodData = nil
        local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
        do
          do
            if not ctrl.isUnlocked then
              local msg = self.cost1Name .. ConfigData:GetTipContent(TipContent.lottery_ItemInsufficient)
              UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(window)
    -- function num : 0_19_1 , upvalues : msg, itemId, costNum
    if window == nil then
      return 
    end
    window:ShowItemCostConfirm(msg, itemId, costNum)
  end
)
              return 
            end
            ctrl:GetShopData(shopId, function(shopData)
    -- function num : 0_19_2 , upvalues : goodData, itemId, _ENV, needItemNum, self, ctrl, executeFunc, costNum
    goodData = shopData:GetNormalShopGoodByItemId(itemId)
    if goodData == nil then
      error("Cant get goodData from normalShop, itemId = " .. itemId)
      return 
    end
    local needCurrencyNum = goodData.newCurrencyNum * needItemNum
    local containCurrencyNum = PlayerDataCenter:GetItemCount(goodData.currencyId)
    local currencyCfg = (ConfigData.item)[goodData.currencyId]
    if currencyCfg == nil then
      error("Item Cfg is null,ID:" .. tostring(goodData.currencyId))
      return 
    end
    local currencyName = (LanguageUtil.GetLocaleText)(currencyCfg.name)
    if needCurrencyNum <= containCurrencyNum then
      local msg = (string.format)(ConfigData:GetTipContent(302), tostring(needCurrencyNum), currencyName, tostring(needItemNum), self.cost1Name)
      do
        UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(window)
      -- function num : 0_19_2_0 , upvalues : msg, goodData, needCurrencyNum, itemId, needItemNum, ctrl, executeFunc
      if window == nil then
        return 
      end
      window:ShowItemConvert(msg, goodData.currencyId, needCurrencyNum, itemId, needItemNum, function()
        -- function num : 0_19_2_0_0 , upvalues : ctrl, goodData, needItemNum, executeFunc
        ctrl:ReqBuyGoods(goodData.shopId, goodData.shelfId, needItemNum, function()
          -- function num : 0_19_2_0_0_0 , upvalues : executeFunc
          executeFunc()
        end
)
      end
)
    end
)
      end
    else
      do
        local msg = (string.format)(ConfigData:GetTipContent(301), currencyName, self.cost1Name)
        UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(window)
      -- function num : 0_19_2_1 , upvalues : msg, goodData, needCurrencyNum, itemId, costNum
      if window == nil then
        return 
      end
      window:ShowItemCost2Confirm(msg, goodData.currencyId, needCurrencyNum, itemId, costNum)
    end
)
      end
    end
  end
)
          end
        end
      end
    end
  end
end

LotteryController.__SetMainCamActive = function(self, active)
  -- function num : 0_20 , upvalues : _ENV
  if not IsNull(self.__mianCam) then
    ((self.__mianCam).gameObject):SetActive(active)
  end
end

LotteryController.OnDelete = function(self)
  -- function num : 0_21 , upvalues : LotteryEnum, _ENV
  self:ChangeLotteryState((LotteryEnum.eLotteryState).None)
  UIManager:DeleteWindow(UIWindowTypeID.LotteryWindow)
  self:__SetMainCamActive(true)
  for k,v in pairs(self.ctrls) do
    v:OnDelete()
  end
end

return LotteryController

-- params : ...
-- function num : 0 , upvalues : _ENV
local LotteryController = class("LotteryController", ControllerBase)
local base = ControllerBase
local LotteryEnum = require("Game.Lottery.LotteryEnum")
local LotteryShowCtrl = require("Game.Lottery.Ctrl.LotteryShowCtrl")
local ShopEnum = require("Game.Shop.ShopEnum")
local cs_MessageCommon = CS.MessageCommon
local cs_camera = (CS.UnityEngine).Camera
LotteryController.ctor = function(self)
    -- function num : 0_0 , upvalues : LotteryShowCtrl, LotteryEnum
    self.ctrls = {}
    self.ltrShowCtrl = (LotteryShowCtrl.New)(self)
    self.__lotteryState = (LotteryEnum.eLotteryState).None
end

LotteryController.OnInit = function(self)
    -- function num : 0_1 , upvalues : _ENV, cs_camera
    self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Lottery)
    self.dailyLotteryLimtNum = (ConfigData.game_config).DailyLotteryLimtNum
    self.__mianCam = cs_camera.main
end

LotteryController.InitLottery = function(self, showWindowCallback)
    -- function num : 0_2 , upvalues : _ENV, LotteryEnum
    self:_InitLtrPoolData()
    self.poolIndex = 1
    UIManager:ShowWindowAsync(UIWindowTypeID.LotteryWindow, function(win)
        -- function num : 0_2_0 , upvalues : self, showWindowCallback, LotteryEnum
        if win ~= nil then
            win:InitUILottery(self, self.poolIdList, self.poolIndex)
            if showWindowCallback ~= nil then showWindowCallback() end
            self:ChangeLotteryState((LotteryEnum.eLotteryState).Normal)
        end
    end)
end

LotteryController._InitLtrPoolData = function(self)
    -- function num : 0_3 , upvalues : _ENV
    self.poolIdList = {}
    for poolId, v in pairs(ConfigData.gashapon_para) do
        if (CheckCondition.CheckLua)(v.pre_condition, v.pre_para1, v.pre_para2) then
            (table.insert)(self.poolIdList, poolId)
        end
    end
    (table.sort)(self.poolIdList, function(a, b)
        -- function num : 0_3_0 , upvalues : _ENV
        do
            return ((ConfigData.gashapon_para)[a]).line <
                       ((ConfigData.gashapon_para)[b]).line
        end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end)
end

LotteryController.ChangeLotteryState = function(self, state)
    -- function num : 0_4 , upvalues : LotteryEnum, _ENV
    self.__lotteryState = state
    if state == (LotteryEnum.eLotteryState).Normal then
        GuideManager:TryTriggerGuide(eGuideCondition.InLottery)
    end
end

LotteryController.IsLotteryNormalState =
    function(self)
        -- function num : 0_5 , upvalues : LotteryEnum
        do
            return self.__lotteryState == (LotteryEnum.eLotteryState).Normal
        end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end

LotteryController.GetLtrPoolNum = function(poolId)
    -- function num : 0_6 , upvalues : _ENV
    local counterElem = (ControllerManager:GetController(
                            ControllerTypeId.TimePass)):getCounterElemData(
                            proto_object_CounterModule.CounterModuleLotteryNum,
                            poolId)
    if counterElem ~= nil and PlayerDataCenter.timestamp <=
        counterElem.nextExpiredTm then return counterElem.times end
    return 0
end

LotteryController.LtrPoolIsFreeCdNow = function(poolId)
    -- function num : 0_7 , upvalues : _ENV
    local counterElem = (ControllerManager:GetController(
                            ControllerTypeId.TimePass)):getCounterElemData(
                            proto_object_CounterModule.CounterModuleLotteryFreeCd,
                            poolId)
    local curLtrPoolCfg = (ConfigData.gashapon_para)[poolId]
    if curLtrPoolCfg.cd == 0 then return false end
    -- DECOMPILER ERROR at PC26: Unhandled construct in 'MakeBoolean' P1

    if counterElem ~= nil and counterElem.nextExpiredTm <
        PlayerDataCenter.timestamp then return true end
    do return true end
    return false
end

LotteryController.SelectLtrPool = function(self, poolId)
    -- function num : 0_8 , upvalues : _ENV
    self.curPoolId = poolId
    self.curLtrPoolCfg = (ConfigData.gashapon_para)[poolId]
    self.enableExcuteFree = (self.curLtrPoolCfg).cd ~= 0
    self.cost1Name = (LanguageUtil.GetLocaleText)(
                         ((ConfigData.item)[(self.curLtrPoolCfg).costId1]).name)
    self.cost2Name = (LanguageUtil.GetLocaleText)(
                         ((ConfigData.item)[(self.curLtrPoolCfg).costId2]).name)
    if self:CheckLtrPoolExpired() then return end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

LotteryController.LtrDrawOne = function(self)
    -- function num : 0_9 , upvalues : cs_MessageCommon, _ENV, LotteryEnum
    if self:CheckLtrPoolExpired() then return end
    local curNum = (self.GetLtrPoolNum)(self.curPoolId)
    if self.dailyLotteryLimtNum - curNum < 1 then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.lottery_DailyLimtFull))
        return
    end
    local itemCount =
        PlayerDataCenter:GetItemCount((self.curLtrPoolCfg).costId1)
    if self.__onDrawOneComplete == nil then
        self.__onDrawOneComplete = BindCallback(self, self.OnLtrDrawOneComplete)
    end
    local executeOneFunc = function()
        -- function num : 0_9_0 , upvalues : self, LotteryEnum, _ENV
        self:ChangeLotteryState((LotteryEnum.eLotteryState).LotteryAnimation)
        self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot();
        (self.networkCtrl):SendExecuteOnce(self.curPoolId,
                                           self.__onDrawOneComplete)
    end

    if (self.LtrPoolIsFreeCdNow)(self.curPoolId) then
        executeOneFunc()
    else
        if (self.curLtrPoolCfg).costNum1 <= itemCount then
            if (self.curLtrPoolCfg).pool_type ==
                (LotteryEnum.eLotteryPoolType).Paid then
                local msg = (string.format)(
                                "是否使用<color=#FE8B15>%s%s</color>进行检索",
                                tostring((self.curLtrPoolCfg).costNum1),
                                self.cost1Name)
                do
                    UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon,
                                              function(window)
                        -- function num : 0_9_1 , upvalues : msg, self, executeOneFunc
                        if window == nil then return end
                        window:ShowItemCost(msg, (self.curLtrPoolCfg).costId1,
                                            (self.curLtrPoolCfg).costNum1,
                                            executeOneFunc)
                    end)
                end
            else
                do
                    executeOneFunc()
                    self:OnConsumptionNotEnough((self.curLtrPoolCfg).costId1,
                                                itemCount,
                                                (self.curLtrPoolCfg).costNum1,
                                                executeOneFunc)
                end
            end
        end
    end
end

LotteryController.OnLtrDrawOneComplete =
    function(self, objList)
        -- function num : 0_10 , upvalues : _ENV
        if objList.Count ~= 1 then
            error("objList.Count error:" .. tostring(objList.Count))
            return
        end
        local elemList = objList[0]
        self:GenLtrResult(elemList)
    end

LotteryController.LtrDrawTen = function(self)
    -- function num : 0_11 , upvalues : cs_MessageCommon, _ENV, LotteryEnum
    if self:CheckLtrPoolExpired() then return end
    local curNum = (self.GetLtrPoolNum)(self.curPoolId)
    if self.dailyLotteryLimtNum - curNum < 10 then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.lottery_DailyLimtFull))
        return
    end
    local itemCount =
        PlayerDataCenter:GetItemCount((self.curLtrPoolCfg).costId2)
    if self.__onDrawTenComplete == nil then
        self.__onDrawTenComplete = BindCallback(self, self.OnLtrDrawTenComplete)
    end
    local executeTenFunc = function()
        -- function num : 0_11_0 , upvalues : self, LotteryEnum, _ENV
        self:ChangeLotteryState((LotteryEnum.eLotteryState).LotteryAnimation)
        self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot();
        (self.networkCtrl):SendExecuteTen(self.curPoolId,
                                          self.__onDrawTenComplete)
    end

    if (self.curLtrPoolCfg).costNum2 <= itemCount then
        if (self.curLtrPoolCfg).pool_type == (LotteryEnum.eLotteryPoolType).Paid then
            local msg = (string.format)(ConfigData:GetTipContent(303),
                                        tostring((self.curLtrPoolCfg).costNum2),
                                        self.cost2Name)
            do
                UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon,
                                          function(window)
                    -- function num : 0_11_1 , upvalues : msg, self, executeTenFunc
                    if window == nil then return end
                    window:ShowItemCost(msg, (self.curLtrPoolCfg).costId2,
                                        (self.curLtrPoolCfg).costNum2,
                                        executeTenFunc)
                end)
            end
        else
            do
                executeTenFunc()
                self:OnConsumptionNotEnough((self.curLtrPoolCfg).costId2,
                                            itemCount,
                                            (self.curLtrPoolCfg).costNum2,
                                            executeTenFunc)
            end
        end
    end
end

LotteryController.OnLtrDrawTenComplete =
    function(self, objList)
        -- function num : 0_12 , upvalues : _ENV
        if objList.Count ~= 1 then
            error("objList.Count error:" .. tostring(objList.Count))
            return
        end
        local elemList = objList[0]
        self:GenLtrResult(elemList)
    end

LotteryController.GenLtrResult = function(self, elemList)
    -- function num : 0_13 , upvalues : _ENV
    local newElemList = {}
    for k, v in ipairs(elemList) do
        if v.firstReward then
            (table.insert)(newElemList, v);
            (table.remove)(elemList, k)
            break
        end
    end
    do
        local count = #elemList
        for i = count, 1, -1 do
            local index = (math.random)(i)
            local elem = (table.remove)(elemList, index);
            (table.insert)(newElemList, elem)
        end
        local showRareList = {}
        local heroIdList = {}
        local newHeroIndexDic = {}
        local acquiredHeroIdDic = {}
        for k, elem in ipairs(newElemList) do
            local itemId = elem.item
            local itemCfg = (ConfigData.item)[itemId]
            if itemCfg == nil then
                error("Can\'t find item, id = " .. tostring(itemId))
            else
                elem.itemCfg = itemCfg
                local rare = eHeroCardRareType.R
                if itemCfg.action_type == eItemActionType.HeroCard then
                    local heroId = (itemCfg.arg)[1]
                    local heroData = (PlayerDataCenter.heroDic)[heroId];
                    (table.insert)(heroIdList, heroId)
                    local isNewHero =
                        ((self._heroIdSnapShoot)[heroId] ~= true and
                            not acquiredHeroIdDic[heroId])
                    newHeroIndexDic[#heroIdList] = isNewHero
                    elem.isNewHero = isNewHero
                    local rankCfg =
                        (ConfigData.hero_rank)[(heroData.heroCfg).rank]
                    if rankCfg == nil then
                        error("Can\'t find rankCfg, id = " ..
                                  tostring((heroData.heroCfg).rank))
                    else
                        rare = rankCfg.rare
                    end
                    elem.heroData = heroData
                    acquiredHeroIdDic[heroId] = true
                end
                (table.insert)(showRareList, rare)
            end
        end
        UIManager:ShowWindowAsync(UIWindowTypeID.LotteryShow, function(window)
            -- function num : 0_13_0 , upvalues : self, showRareList
            if window == nil then return end
            window:InitLotteryShow(self.ltrShowCtrl)
            self:__SetMainCamActive(false);
            (self.ltrShowCtrl):LtrShowStart(showRareList,
                                            (self.curLtrPoolCfg).pool_type)
        end)
        self.heroIdList = heroIdList
        self.newHeroIndexDic = newHeroIndexDic
        self.rewardElemList = newElemList
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
    end
end

LotteryController.LtrShowEnd = function(self)
    -- function num : 0_14 , upvalues : _ENV
    UIManager:DeleteWindow(UIWindowTypeID.LotteryShow)
    if self.rewardElemList == nil then return end
    if #self.rewardElemList == 1 then
        UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
            -- function num : 0_14_0 , upvalues : self, _ENV
            if window == nil then return end
            window:BindCommonRewardStart(
                function()
                    -- function num : 0_14_0_0 , upvalues : self
                    self:_HideLtrShow()
                end)
            window:InitRewardsItem({((self.rewardElemList)[1]).item},
                                   {((self.rewardElemList)[1]).num},
                                   self._heroIdSnapShoot)
            window:BindCommonRewardExit(BindCallback(self,
                                                     self.OnLotteryComplete,
                                                     true))
        end)
    else
        if #self.heroIdList == 0 then
            self:LtrHeroShowEnd(true)
        else
            UIManager:ShowWindowAsync(UIWindowTypeID.GetHero, function(window)
                -- function num : 0_14_1 , upvalues : self
                if window == nil then return end
                window:InitGetHeroList(self.heroIdList, false, true,
                                       self.newHeroIndexDic, function()
                    -- function num : 0_14_1_0 , upvalues : self
                    self:LtrHeroShowEnd(false)
                end)
                self:_HideLtrShow()
            end)
        end
    end
end

LotteryController.LtrHeroShowEnd = function(self, withHideShow)
    -- function num : 0_15 , upvalues : _ENV
    UIManager:ShowWindowAsync(UIWindowTypeID.LotteryResult, function(window)
        -- function num : 0_15_0 , upvalues : self, _ENV, withHideShow
        if window == nil then return end
        window:InitLtrResult(self.rewardElemList)
        window:BindLotteryResultExit(BindCallback(self, self.OnLotteryComplete,
                                                  false))
        if withHideShow then
            self:_HideLtrShow()
        else
            UIManager:DeleteWindow(UIWindowTypeID.GetHero)
        end
    end)
end

LotteryController.OnLotteryComplete = function(self, isSingle)
    -- function num : 0_16 , upvalues : _ENV, LotteryEnum
    local lotteryWindow = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
    if lotteryWindow == nil then
        self:ChangeLotteryState((LotteryEnum.eLotteryState).None)
    else
        if (lotteryWindow.poolDetailNode).active then
            self:ChangeLotteryState((LotteryEnum.eLotteryState).PoolDetail)
        else
            self:ChangeLotteryState((LotteryEnum.eLotteryState).Normal)
        end
    end
end

LotteryController._HideLtrShow = function(self)
    -- function num : 0_17 , upvalues : _ENV
    UIManager:ShowWindow(UIWindowTypeID.LotteryWindow);
    (self.ltrShowCtrl):HideLtrShow()
end

LotteryController.CheckLtrPoolExpired = function(self)
    -- function num : 0_18 , upvalues : _ENV, cs_MessageCommon
    local cfg = self.curLtrPoolCfg
    if not (CheckCondition.CheckLua)(cfg.pre_condition, cfg.pre_para1,
                                     cfg.pre_para2) then
        (cs_MessageCommon.ShowMessageBoxConfirm)(
            ConfigData:GetTipContent(TipContent.Ltr_PoolExpired), function()
                -- function num : 0_18_0 , upvalues : self, _ENV
                self:_InitLtrPoolData()
                if #self.poolIdList < self.poolIndex then
                    self.poolIndex = 1
                end
                local window = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
                window:RefreshLtrPoolUI(self.poolIdList, self.poolIndex)
            end)
        return true
    end
    return false
end

LotteryController.OnConsumptionNotEnough =
    function(self, itemId, containNum, costNum, executeFunc)
        -- function num : 0_19 , upvalues : LotteryEnum, _ENV, ShopEnum
        if (self.curLtrPoolCfg).pool_type ==
            (LotteryEnum.eLotteryPoolType).NoPaid then
            local msg = self.cost2Name ..
                            ConfigData:GetTipContent(
                                TipContent.lottery_ItemInsufficient)
            do
                UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon,
                                          function(window)
                    -- function num : 0_19_0 , upvalues : msg, itemId, costNum
                    if window == nil then return end
                    window:ShowItemCostConfirm(msg, itemId, costNum)
                end)
            end
        else
            do
                if (self.curLtrPoolCfg).pool_type ==
                    (LotteryEnum.eLotteryPoolType).Paid then
                    local needItemNum = costNum - containNum
                    local quickBuyData = (ShopEnum.eQuickBuy).lottery
                    local shopId = quickBuyData.shopId
                    local goodData = nil
                    local ctrl = ControllerManager:GetController(
                                     ControllerTypeId.Shop, true)
                    do
                        do
                            if not ctrl.isUnlocked then
                                local msg =
                                    self.cost1Name ..
                                        ConfigData:GetTipContent(
                                            TipContent.lottery_ItemInsufficient)
                                UIManager:ShowWindowAsync(
                                    UIWindowTypeID.MessageCommon,
                                    function(window)
                                        -- function num : 0_19_1 , upvalues : msg, itemId, costNum
                                        if window == nil then
                                            return
                                        end
                                        window:ShowItemCostConfirm(msg, itemId,
                                                                   costNum)
                                    end)
                                return
                            end
                            ctrl:GetShopData(shopId, function(shopData)
                                -- function num : 0_19_2 , upvalues : goodData, itemId, _ENV, needItemNum, self, ctrl, executeFunc, costNum
                                goodData =
                                    shopData:GetNormalShopGoodByItemId(itemId)
                                if goodData == nil then
                                    error(
                                        "Cant get goodData from normalShop, itemId = " ..
                                            itemId)
                                    return
                                end
                                local needCurrencyNum =
                                    goodData.newCurrencyNum * needItemNum
                                local containCurrencyNum =
                                    PlayerDataCenter:GetItemCount(
                                        goodData.currencyId)
                                local currencyCfg =
                                    (ConfigData.item)[goodData.currencyId]
                                if currencyCfg == nil then
                                    error(
                                        "Item Cfg is null,ID:" ..
                                            tostring(goodData.currencyId))
                                    return
                                end
                                local currencyName =
                                    (LanguageUtil.GetLocaleText)(
                                        currencyCfg.name)
                                if needCurrencyNum <= containCurrencyNum then
                                    local msg =
                                        (string.format)(
                                            ConfigData:GetTipContent(302),
                                            tostring(needCurrencyNum),
                                            currencyName, tostring(needItemNum),
                                            self.cost1Name)
                                    do
                                        UIManager:ShowWindowAsync(
                                            UIWindowTypeID.MessageCommon,
                                            function(window)
                                                -- function num : 0_19_2_0 , upvalues : msg, goodData, needCurrencyNum, itemId, needItemNum, ctrl, executeFunc
                                                if window == nil then
                                                    return
                                                end
                                                window:ShowItemConvert(msg,
                                                                       goodData.currencyId,
                                                                       needCurrencyNum,
                                                                       itemId,
                                                                       needItemNum,
                                                                       function()
                                                    -- function num : 0_19_2_0_0 , upvalues : ctrl, goodData, needItemNum, executeFunc
                                                    ctrl:ReqBuyGoods(
                                                        goodData.shopId,
                                                        goodData.shelfId,
                                                        needItemNum, function()
                                                            -- function num : 0_19_2_0_0_0 , upvalues : executeFunc
                                                            executeFunc()
                                                        end)
                                                end)
                                            end)
                                    end
                                else
                                    do
                                        local msg =
                                            (string.format)(
                                                ConfigData:GetTipContent(301),
                                                currencyName, self.cost1Name)
                                        UIManager:ShowWindowAsync(
                                            UIWindowTypeID.MessageCommon,
                                            function(window)
                                                -- function num : 0_19_2_1 , upvalues : msg, goodData, needCurrencyNum, itemId, costNum
                                                if window == nil then
                                                    return
                                                end
                                                window:ShowItemCost2Confirm(msg,
                                                                            goodData.currencyId,
                                                                            needCurrencyNum,
                                                                            itemId,
                                                                            costNum)
                                            end)
                                    end
                                end
                            end)
                        end
                    end
                end
            end
        end
    end

LotteryController.__SetMainCamActive = function(self, active)
    -- function num : 0_20 , upvalues : _ENV
    if not IsNull(self.__mianCam) then
        ((self.__mianCam).gameObject):SetActive(active)
    end
end

LotteryController.OnDelete = function(self)
    -- function num : 0_21 , upvalues : LotteryEnum, _ENV
    self:ChangeLotteryState((LotteryEnum.eLotteryState).None)
    UIManager:DeleteWindow(UIWindowTypeID.LotteryWindow)
    self:__SetMainCamActive(true)
    for k, v in pairs(self.ctrls) do v:OnDelete() end
end

return LotteryController

