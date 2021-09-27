local LotteryController = class("LotteryController", ControllerBase)
local base = ControllerBase
local LotteryEnum = require("Game.Lottery.LotteryEnum")
local LotteryShowCtrl = require("Game.Lottery.Ctrl.LotteryShowCtrl")
local ShopEnum = require("Game.Shop.ShopEnum")
local cs_MessageCommon = CS.MessageCommon
local cs_camera = (CS.UnityEngine).Camera
local RequestPreview = require("Game.RequestPreview.RequestPreview")
LotteryController.ctor = function(self)
  -- function num : 0_0 , upvalues : LotteryShowCtrl, LotteryEnum, _ENV
  self.ctrls = {}
  self.ltrShowCtrl = (LotteryShowCtrl.New)(self)
  self.__lotteryState = (LotteryEnum.eLotteryState).None
  self._ResetAllPoolFunc = BindCallback(self, self._ResetAllPool)
  self._ResetLtrStateFunc = BindCallback(self, self._ResetLtrState)
end

LotteryController.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, cs_camera
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Lottery)
  self.dailyLotteryLimtNum = (ConfigData.game_config).DailyLotteryLimtNum
  self.__mianCam = cs_camera.main
end

LotteryController.InitLottery = function(self, showWindowCallback, defaultSelectPoolId)
  -- function num : 0_2 , upvalues : _ENV, LotteryEnum
  self:_InitLtrPoolData()
  self.poolIndex = 1
  for index,poolData in ipairs(self.poolDataList) do
    if poolData.poolId == defaultSelectPoolId then
      self.poolIndex = index
    end
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.LotteryWindow, function(win)
    -- function num : 0_2_0 , upvalues : self, LotteryEnum, showWindowCallback
    if win ~= nil then
      win:InitUILottery(self, self.poolDataList, self.poolIndex)
      self:ChangeLotteryState((LotteryEnum.eLotteryState).Normal)
      if showWindowCallback ~= nil then
        showWindowCallback(win)
      end
    end
  end
)
end

LotteryController._InitLtrPoolData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self.poolDataList = (PlayerDataCenter.allLtrData):GetOpeningLtrPoolDataList()
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

LotteryController.SelectLtrPool = function(self, poolId)
  -- function num : 0_6 , upvalues : _ENV
  self.curPoolId = poolId
  self.curLtrPoolCfg = (ConfigData.lottery_para)[poolId]
  self.curLtrPoolData = ((PlayerDataCenter.allLtrData).ltrDataDic)[poolId]
  self.enableExcuteFree = (self.curLtrPoolCfg).cd ~= 0
  if self:CheckLtrPoolExpired() then
    return 
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

LotteryController.LtrDrawOne = function(self)
  -- function num : 0_7 , upvalues : cs_MessageCommon, _ENV, LotteryEnum
  if self:CheckLtrPoolExpired() then
    return 
  end
  local curNum = (self.curLtrPoolData):GetLtrPoolTotalNum()
  if self.dailyLotteryLimtNum - curNum < 1 then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.lottery_DailyLimtFull))
    return 
  end
  local itemCount = PlayerDataCenter:GetItemCount((self.curLtrPoolCfg).costId1)
  if self.__onDrawOneComplete == nil then
    self.__onDrawOneComplete = BindCallback(self, self.OnLtrDrawOneComplete)
  end
  local executeOneFunc = function()
    -- function num : 0_7_0 , upvalues : self, LotteryEnum, _ENV
    if self:CheckLtrPoolExpired() then
      return 
    end
    self:ChangeLotteryState((LotteryEnum.eLotteryState).LotteryAnimation)
    self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    self:__BeforeDrawFunc()
    ;
    (self.networkCtrl):SendExecuteOnce(self.curPoolId, self.__onDrawOneComplete)
  end

  if (self.curLtrPoolData):IsLtrExecOneceFree() then
    executeOneFunc()
  else
    if (self.curLtrPoolCfg).costNum1 <= itemCount then
      self:OnConsumptionEnough((self.curLtrPoolCfg).costId1, (self.curLtrPoolCfg).costNum1, executeOneFunc)
    else
      self:OnConsumptionNotEnough((self.curLtrPoolCfg).costId1, itemCount, (self.curLtrPoolCfg).costNum1, executeOneFunc)
    end
  end
end

LotteryController.OnLtrDrawOneComplete = function(self, objList, notNeedPopPreview)
  -- function num : 0_8 , upvalues : _ENV
  if objList.Count ~= 1 then
    error("objList.Count error:" .. tostring(objList.Count))
    return 
  end
  local elemList = objList[0]
  self:GenLtrResult(elemList, notNeedPopPreview)
  local ltrWin = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
  if ltrWin ~= nil then
    ltrWin:RefreshCurLtrChangedUI()
  end
end

LotteryController.LtrDrawTen = function(self)
  -- function num : 0_9 , upvalues : cs_MessageCommon, _ENV, LotteryEnum
  if self:CheckLtrPoolExpired() then
    return 
  end
  local curNum = (self.curLtrPoolData):GetLtrPoolTotalNum()
  if self.dailyLotteryLimtNum - curNum < 10 then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.lottery_DailyLimtFull))
    return 
  end
  local itemCount = PlayerDataCenter:GetItemCount((self.curLtrPoolCfg).costId2)
  if self.__onDrawTenComplete == nil then
    self.__onDrawTenComplete = BindCallback(self, self.OnLtrDrawTenComplete)
  end
  local executeTenFunc = function()
    -- function num : 0_9_0 , upvalues : self, LotteryEnum, _ENV
    if self:CheckLtrPoolExpired() then
      return 
    end
    self:ChangeLotteryState((LotteryEnum.eLotteryState).LotteryAnimation)
    self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    self:__BeforeDrawFunc()
    ;
    (self.networkCtrl):SendExecuteTen(self.curPoolId, self.__onDrawTenComplete)
  end

  if (self.curLtrPoolCfg).costNum2 <= itemCount then
    self:OnConsumptionEnough((self.curLtrPoolCfg).costId2, (self.curLtrPoolCfg).costNum2, executeTenFunc)
  else
    self:OnConsumptionNotEnough((self.curLtrPoolCfg).costId2, itemCount, (self.curLtrPoolCfg).costNum2, executeTenFunc)
  end
end

LotteryController.OnLtrDrawTenComplete = function(self, objList, notNeedPopPreview)
  -- function num : 0_10 , upvalues : _ENV
  if objList.Count ~= 1 then
    error("objList.Count error:" .. tostring(objList.Count))
    return 
  end
  local elemList = objList[0]
  self:GenLtrResult(elemList, notNeedPopPreview)
  local ltrWin = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
  if ltrWin ~= nil then
    ltrWin:RefreshCurLtrChangedUI()
  end
end

LotteryController.LtrDrawSpecialOne = function(self)
  -- function num : 0_11 , upvalues : cs_MessageCommon, _ENV, LotteryEnum
  if self:CheckLtrPoolExpired() then
    return 
  end
  local curNum = (self.curLtrPoolData):GetLtrPoolTotalNum()
  if self.dailyLotteryLimtNum - curNum < 1 then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.lottery_DailyLimtFull))
    return 
  end
  local itemCount = PlayerDataCenter:GetItemCount((self.curLtrPoolCfg).costId3)
  if not self.__onDrawSpecialOneComplete then
    self.__onDrawSpecialOneComplete = BindCallback(self, self.OnLtrDrawSpecialOneComplete)
    local executeFunc = function()
    -- function num : 0_11_0 , upvalues : self, LotteryEnum, _ENV
    if self:CheckLtrPoolExpired() then
      return 
    end
    self:ChangeLotteryState((LotteryEnum.eLotteryState).LotteryAnimation)
    self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    self:__BeforeDrawFunc()
    ;
    (self.networkCtrl):CS_LOTTERY_ExecOnceSpecial(self.curPoolId, self.__onDrawSpecialOneComplete)
  end

    if (self.curLtrPoolCfg).costNum3 <= itemCount then
      self:OnConsumptionEnough((self.curLtrPoolCfg).costId3, (self.curLtrPoolCfg).costNum3, executeFunc)
    else
      self:OnConsumptionNotEnough((self.curLtrPoolCfg).costId3, itemCount, (self.curLtrPoolCfg).costNum3, executeFunc)
    end
  end
end

LotteryController.OnLtrDrawSpecialOneComplete = function(self, objList)
  -- function num : 0_12 , upvalues : _ENV
  if objList.Count ~= 1 then
    error("objList.Count error:" .. tostring(objList.Count))
    return 
  end
  local elemList = objList[0]
  self:GenLtrResult(elemList)
  local ltrWin = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
  if ltrWin ~= nil then
    ltrWin:RefreshCurLtrChangedUI()
  end
end

LotteryController.LtrFreeSelect = function(self, itemId)
  -- function num : 0_13 , upvalues : _ENV, LotteryEnum
  if self:CheckLtrPoolExpired() then
    return 
  end
  if not self.__OnLtrFreeSelectComplete then
    self.__OnLtrFreeSelectComplete = BindCallback(self, self.OnLtrFreeSelectComplete)
    self:ChangeLotteryState((LotteryEnum.eLotteryState).LotteryAnimation)
    self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    self._freeChoiceItemId = itemId
    ;
    (self.networkCtrl):CS_LOTTERY_IndepChoice(self.curPoolId, itemId, self.__OnLtrFreeSelectComplete)
  end
end

LotteryController.LtrFreeSelectJudge = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if self:CheckLtrPoolExpired() then
    return 
  end
  local itemCount = (self.curLtrPoolCfg).costNum4
  local PaidItemNum = PlayerDataCenter:GetItemCount(ConstGlobalItem.PaidItem)
  local FreeItemNum = PlayerDataCenter:GetItemCount(ConstGlobalItem.PaidSubItem)
  local executeFunc = function()
    -- function num : 0_14_0 , upvalues : _ENV, self
    local win = UIManager:GetWindow(UIWindowTypeID.LotterySelectHero)
    if win ~= nil then
      win:ConfimFreeSelectHero(self)
    end
  end

  if FreeItemNum < itemCount then
    local needItemNum = itemCount - FreeItemNum
    do
      local assignMsg = (string.format)(ConfigData:GetTipContent(10008), needItemNum, needItemNum)
      local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
      local executeBuyBeforeFunc = function()
    -- function num : 0_14_1 , upvalues : shopCtrl, _ENV, needItemNum, executeFunc
    shopCtrl:ReqExchangeGoods(ConstGlobalItem.PaidSubItem, needItemNum, executeFunc)
  end

      self:OnConsumptionNotEnough(ConstGlobalItem.PaidSubItem, FreeItemNum, itemCount, executeBuyBeforeFunc, assignMsg)
    end
  else
    do
      executeFunc()
    end
  end
end

LotteryController.OnLtrFreeSelectComplete = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local objList = {}
  objList.Count = 1
  objList[0] = {}
  local owned = (PlayerDataCenter.heroDic)[self._freeChoiceItemId] ~= nil
  local temp = {}
  temp.firstReward = owned
  temp.item = self._freeChoiceItemId
  temp.num = 1
  ;
  (table.insert)(objList[0], temp)
  self:OnLtrDrawOneComplete(objList, true)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

LotteryController.ReqExchangeLtrPtReward = function(self, itemId, extraAward)
  -- function num : 0_16 , upvalues : _ENV
  if self:CheckLtrPoolExpired() then
    return 
  end
  self._ptExchangeItemId = itemId
  self._extraAward = extraAward
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  if not self._OnExchangeLtrPtRewardFunc then
    self._OnExchangeLtrPtRewardFunc = BindCallback(self, self._OnExchangeLtrPtReward)
    ;
    (self.networkCtrl):CS_LOTTERY_PickPt(self.curPoolId, itemId, self._OnExchangeLtrPtRewardFunc)
  end
end

LotteryController._OnExchangeLtrPtReward = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local ltrWin = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
  if ltrWin ~= nil then
    ltrWin:RefreshCurLtrChangedUI()
  end
  local ltrExWin = UIManager:GetWindow(UIWindowTypeID.LotteryExchange)
  if ltrExWin ~= nil then
    (ltrExWin.ltrPtNode):ReFreshLtrPtUI()
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    -- function num : 0_17_0 , upvalues : _ENV, self
    if window == nil then
      return 
    end
    local rewardIds = {}
    local rewardNums = {}
    ;
    (table.insert)(rewardIds, self._ptExchangeItemId)
    ;
    (table.insert)(rewardNums, 1)
    if self._extraAward ~= nil then
      for id,num in pairs(self._extraAward) do
        (table.insert)(rewardIds, id)
        ;
        (table.insert)(rewardNums, num)
      end
    end
    do
      window:InitRewardsItem(rewardIds, rewardNums, self._heroIdSnapShoot)
    end
  end
)
end

LotteryController.__BeforeDrawFunc = function(self)
  -- function num : 0_18 , upvalues : _ENV
  NoticeManager:PuaseShowNotice("lottery")
end

LotteryController.GenLtrResult = function(self, elemList, notNeedPopPreview)
  -- function num : 0_19 , upvalues : _ENV
  local newElemList = elemList
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
    -- function num : 0_19_0 , upvalues : self, showRareList, notNeedPopPreview
    if window == nil then
      return 
    end
    window:InitLotteryShow(self.ltrShowCtrl)
    self:__SetMainCamActive(false)
    ;
    (self.ltrShowCtrl):LtrShowStart(showRareList, (self.curLtrPoolCfg).pool_client_type, notNeedPopPreview)
  end
)
  local backFun = function()
    -- function num : 0_19_1 , upvalues : _ENV
    local UILottery = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
    if UILottery ~= nil then
      UILottery:__RefreshGuaranteeState()
    end
  end

  TimerManager:StartTimer(0.1, backFun, self, true, false, false)
  self.heroIdList = heroIdList
  self.newHeroIndexDic = newHeroIndexDic
  self.rewardElemList = newElemList
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

LotteryController.LtrShowEnd = function(self, isSkip, notNeedPopPreview)
  -- function num : 0_20 , upvalues : _ENV
  UIManager:DeleteWindow(UIWindowTypeID.LotteryShow)
  if self.rewardElemList == nil then
    return 
  end
  if #self.heroIdList == 0 then
    self:LtrHeroShowEnd(true, notNeedPopPreview)
    return 
  end
  local newHeroCount = 0
  for heroid,hasNew in pairs(self.newHeroIndexDic) do
    if hasNew then
      newHeroCount = newHeroCount + 1
    end
  end
  if isSkip and newHeroCount == 0 then
    self:LtrHeroShowEnd(true, notNeedPopPreview)
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.GetHero, function(window)
    -- function num : 0_20_0 , upvalues : self, notNeedPopPreview, isSkip
    if window == nil then
      return 
    end
    window:InitGetHeroList(self.heroIdList, false, true, self.newHeroIndexDic, function()
      -- function num : 0_20_0_0 , upvalues : self, notNeedPopPreview
      self:LtrHeroShowEnd(false, notNeedPopPreview)
    end
, isSkip)
    self:_HideLtrShow()
  end
)
  end
end

LotteryController.LtrHeroShowEnd = function(self, withHideShow, notNeedPopPreview)
  -- function num : 0_21 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.LotteryResult, function(window)
    -- function num : 0_21_0 , upvalues : _ENV, self, notNeedPopPreview, withHideShow
    NoticeManager:ContinueShowNotice("lottery")
    if window == nil then
      return 
    end
    window:InitLtrResult(self.rewardElemList)
    window:BindLotteryResultExit(function()
      -- function num : 0_21_0_0 , upvalues : self, notNeedPopPreview
      self:OnLotteryComplete(notNeedPopPreview)
    end
)
    if #self.rewardElemList == 1 then
      AudioManager:PlayAudioById(1115)
    else
      AudioManager:PlayAudioById(1114)
    end
    if withHideShow then
      self:_HideLtrShow()
    else
      UIManager:DeleteWindow(UIWindowTypeID.GetHero)
    end
  end
)
end

LotteryController._ResetLtrState = function(self)
  -- function num : 0_22 , upvalues : _ENV, LotteryEnum
  local lotteryWindow = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
  if lotteryWindow == nil then
    self:ChangeLotteryState((LotteryEnum.eLotteryState).None)
  else
    self:ChangeLotteryState((LotteryEnum.eLotteryState).Normal)
  end
end

LotteryController.OnLotteryComplete = function(self, notNeedPopPreview)
  -- function num : 0_23 , upvalues : _ENV, RequestPreview
  self:_ResetLtrState()
  UIManager:ShowWindowOnly(UIWindowTypeID.TopStatus)
  self:CheckLtrPoolExpired(true)
  if not notNeedPopPreview then
    RequestPreview:TryRequestReview(self.rewardElemList)
  end
end

LotteryController._HideLtrShow = function(self)
  -- function num : 0_24 , upvalues : _ENV
  UIManager:ShowWindow(UIWindowTypeID.LotteryWindow)
  ;
  (self.ltrShowCtrl):HideLtrShow()
  self:__SetMainCamActive(true)
end

LotteryController.CheckLtrPoolExpired = function(self, immediateRefresh)
  -- function num : 0_25 , upvalues : cs_MessageCommon, _ENV
  local cfg = self.curLtrPoolCfg
  if not (self.curLtrPoolData):IsLtrPoolOpen() then
    if immediateRefresh then
      (self._ResetAllPoolFunc)()
    else
      ;
      (cs_MessageCommon.ShowMessageBoxConfirm)(ConfigData:GetTipContent(TipContent.Ltr_PoolExpired), self._ResetAllPoolFunc)
    end
    return true
  end
  return false
end

LotteryController._ResetAllPool = function(self)
  -- function num : 0_26 , upvalues : _ENV
  self:_InitLtrPoolData()
  if #self.poolDataList < self.poolIndex then
    self.poolIndex = 1
  end
  local window = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
  window:RefreshLtrPoolUI(self.poolDataList, self.poolIndex)
end

LotteryController.OnConsumptionEnough = function(self, costId, costNum, executeFunc)
  -- function num : 0_27 , upvalues : LotteryEnum, _ENV
  if (self.curLtrPoolCfg).pool_client_type == (LotteryEnum.eLotteryPoolType).Paid then
    local costName = (LanguageUtil.GetLocaleText)(((ConfigData.item)[costId]).name)
    local msg = (string.format)(ConfigData:GetTipContent(303), tostring(costNum), costName)
    if ((ConfigData.game_config).ltrShowDontHintCurrencyDic)[costId] and (PlayerDataCenter.cacheSaveData):GetEnableLotteryPaidExecuteConfirm() then
      local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
      window:ShowItemCost(msg, costId, costNum, executeFunc, nil, true)
      window:ShowDontRemindTog(function(isOn)
    -- function num : 0_27_0 , upvalues : _ENV
    (PlayerDataCenter.cacheSaveData):SetEnableLotteryPaidExecuteConfirm(not isOn)
  end
)
      return 
    end
  end
  do
    do
      local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
      window:ShowItemCost(msg, costId, costNum, executeFunc, nil, true)
      do return  end
      executeFunc()
    end
  end
end

LotteryController.OnConsumptionNotEnough = function(self, itemId, containNum, costNum, executeFunc, assignMsg)
  -- function num : 0_28 , upvalues : _ENV, LotteryEnum, ShopEnum
  local costItemName = (LanguageUtil.GetLocaleText)(((ConfigData.item)[itemId]).name)
  if (self.curLtrPoolCfg).pool_client_type == (LotteryEnum.eLotteryPoolType).NoPaid then
    local msg = costItemName .. ConfigData:GetTipContent(TipContent.lottery_ItemInsufficient)
    do
      local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
      window:ShowItemCostConfirm(msg, itemId, costNum, nil, true)
    end
  else
    do
      if (self.curLtrPoolCfg).pool_client_type == (LotteryEnum.eLotteryPoolType).Paid then
        local quickBuyData = (ShopEnum.eQuickBuy).lottery
        local shopId = quickBuyData.shopId
        local needItemNum = costNum - containNum
        local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
        local checkShopOpenFunc = function()
    -- function num : 0_28_0 , upvalues : shopCtrl, shopId, costItemName, _ENV, itemId, costNum
    if not shopCtrl:ShopIsUnlock(shopId) then
      local msg = costItemName .. ConfigData:GetTipContent(TipContent.lottery_ItemInsufficient)
      local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
      window:ShowItemCostConfirm(msg, itemId, costNum, nil, true)
      return false
    end
    do
      return true
    end
  end

        local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
        if itemId == ConstGlobalItem.PaidSubItem then
          self:__PaidCurrencyExecute(ConstGlobalItem.PaidSubItem, costNum, itemId, needItemNum, executeFunc, assignMsg)
          return 
        else
          if itemId == ConstGlobalItem.PaidItem then
            if checkShopOpenFunc() then
              payCtrl:Jump2BuyQuartz(nil, nil, true)
            end
            return 
          end
        end
        if not checkShopOpenFunc() then
          return 
        end
        shopCtrl:GetShopData(shopId, function(shopData)
    -- function num : 0_28_1 , upvalues : itemId, _ENV, needItemNum, self, shopCtrl, executeFunc
    local goodData = shopData:GetNormalShopGoodByItemId(itemId)
    if goodData == nil then
      error("Cant get goodData from normalShop, itemId = " .. itemId)
      return 
    end
    local needCurrencyNum = goodData.newCurrencyNum * needItemNum
    self:__PaidCurrencyExecute(goodData.currencyId, needCurrencyNum, itemId, needItemNum, function()
      -- function num : 0_28_1_0 , upvalues : shopCtrl, goodData, needItemNum, executeFunc
      shopCtrl:ReqBuyGoods(goodData.shopId, goodData.shelfId, needItemNum, function()
        -- function num : 0_28_1_0_0 , upvalues : executeFunc
        executeFunc()
      end
)
    end
)
  end
)
      end
    end
  end
end

LotteryController.__PaidCurrencyExecute = function(self, currencyId, needCurrencyNum, needItemId, needItemNum, executeFunc, assignMsg)
  -- function num : 0_29 , upvalues : _ENV
  local payCtrl = ControllerManager:GetController(ControllerTypeId.Pay, true)
  local containCurrencyNum = PlayerDataCenter:GetItemCount(currencyId)
  local currencyCfg = (ConfigData.item)[currencyId]
  if currencyCfg == nil then
    error("Item Cfg is null,ID:" .. tostring(currencyId))
    return 
  end
  local currencyName = (LanguageUtil.GetLocaleText)(currencyCfg.name)
  local srcIdList = {}
  local srcNumList = {}
  local needPaidItemNum = 0
  if currencyId == ConstGlobalItem.PaidSubItem then
    needPaidItemNum = needCurrencyNum - containCurrencyNum
    if needPaidItemNum > 0 and (containCurrencyNum == 0 or currencyId == needItemId) then
      (table.insert)(srcIdList, ConstGlobalItem.PaidItem)
      ;
      (table.insert)(srcNumList, needPaidItemNum)
      local itemCfg = (ConfigData.item)[ConstGlobalItem.PaidItem]
      currencyName = tostring(needPaidItemNum) .. (LanguageUtil.GetLocaleText)(itemCfg.name)
    else
      do
        if needPaidItemNum > 0 and containCurrencyNum > 0 then
          (table.insert)(srcIdList, ConstGlobalItem.PaidItem)
          ;
          (table.insert)(srcNumList, needPaidItemNum)
          ;
          (table.insert)(srcIdList, ConstGlobalItem.PaidSubItem)
          ;
          (table.insert)(srcNumList, containCurrencyNum)
          local itemCfg = (ConfigData.item)[ConstGlobalItem.PaidItem]
          currencyName = tostring(needPaidItemNum) .. (LanguageUtil.GetLocaleText)(itemCfg.name) .. "+" .. tostring(containCurrencyNum) .. currencyName
        else
          do
            ;
            (table.insert)(srcIdList, ConstGlobalItem.PaidSubItem)
            ;
            (table.insert)(srcNumList, needCurrencyNum)
            currencyName = tostring(needCurrencyNum) .. currencyName
            ;
            (table.insert)(srcIdList, currencyId)
            ;
            (table.insert)(srcNumList, needCurrencyNum)
            currencyName = tostring(needCurrencyNum) .. currencyName
            local needItemName = (LanguageUtil.GetLocaleText)(((ConfigData.item)[needItemId]).name)
            local msg = assignMsg
            if msg == nil then
              msg = (string.format)(ConfigData:GetTipContent(302), currencyName, tostring(needItemNum), needItemName)
            end
            local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
            window:ShowItemConvert(msg, srcIdList, srcNumList, {needItemId}, {needItemNum}, function()
    -- function num : 0_29_0 , upvalues : needPaidItemNum, _ENV, payCtrl, executeFunc
    if PlayerDataCenter:GetItemCount(ConstGlobalItem.PaidItem) < needPaidItemNum then
      payCtrl:Jump2BuyQuartz(nil, nil, true)
    else
      executeFunc()
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
  -- function num : 0_30 , upvalues : _ENV
  if not IsNull(self.__mianCam) then
    ((self.__mianCam).gameObject):SetActive(active)
  end
end

LotteryController.IsInLotteryShow = function(self)
  -- function num : 0_31 , upvalues : LotteryEnum
  do return self.__lotteryState == (LotteryEnum.eLotteryState).LotteryAnimation end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

LotteryController.OnDelete = function(self)
  -- function num : 0_32 , upvalues : LotteryEnum, _ENV
  self:ChangeLotteryState((LotteryEnum.eLotteryState).None)
  self:__SetMainCamActive(true)
  for k,v in pairs(self.ctrls) do
    v:OnDelete()
  end
end

return LotteryController

