-- params : ...
-- function num : 0 , upvalues : _ENV
local UINMonthCard = class("UINMonthCard", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
UINMonthCard.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithReceived
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Buy, self, self.OnClickBuy)
  self.rewardPool = (UIItemPool.New)(UINBaseItemWithReceived, (self.ui).rewardItem)
  ;
  ((self.ui).rewardItem):SetActive(false)
  self.extrRewardList = {}
  self.__Refresh = BindCallback(self, self.Refresh)
  MsgCenter:AddListener(eMsgEventId.MonthCardRefresh, self.__Refresh)
end

UINMonthCard.InitMonthCard = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (self.rewardPool):HideAll()
  self.monthCardCfg = (ConfigData.month_card)[1]
  for i = 1, #(self.monthCardCfg).first_award_ids do
    local itemCfg = (ConfigData.item)[((self.monthCardCfg).first_award_ids)[i]]
    local count = ((self.monthCardCfg).first_award_nums)[i]
    local item = (self.rewardPool):GetOne(true)
    ;
    (item.gameObject):SetActive(true)
    ;
    (item.transform):SetParent(((self.ui).obj_CurrentItemList).transform)
    item:InitItemWithCount(itemCfg, count, nil, false)
  end
  for i = 1, #(self.monthCardCfg).daily_award_ids do
    local itemCfg = (ConfigData.item)[((self.monthCardCfg).daily_award_ids)[i]]
    local count = ((self.monthCardCfg).daily_award_nums)[i]
    local item = (self.rewardPool):GetOne(true)
    ;
    (item.gameObject):SetActive(true)
    ;
    (item.transform):SetParent(((self.ui).obj_DailyItemList).transform)
    item:InitItemWithCount(itemCfg, count, nil, false)
    ;
    (table.insert)(self.extrRewardList, item)
  end
  local payCtr = ControllerManager:GetController(ControllerTypeId.Pay, true)
  local priceStr, price, unit = payCtr:GetPayPriceShow((self.monthCardCfg).price)
  -- DECOMPILER ERROR at PC96: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_Price).text = priceStr
  self:Refresh()
end

UINMonthCard.RefreshSpecailReddot = function(self, shopId, pageId)
  -- function num : 0_2 , upvalues : _ENV
  local saveUserData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
  local isBoughtMonthCardRDClosed = saveUserData:SetSReddotClose(RedDotStaticTypeId.Main .. "." .. RedDotStaticTypeId.ShopWindow .. "." .. tostring(shopId) .. "." .. tostring(pageId), true)
  if not isBoughtMonthCardRDClosed then
    local ok, shopNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ShopWindow, shopId, pageId)
    if ok then
      shopNode:SetRedDotCount(0)
    end
  end
end

UINMonthCard.Refresh = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local dailySignInData = PlayerDataCenter.dailySignInData
  local dayCount = dailySignInData:GetMonthCardLeftCount()
  local isCanBuy = not dailySignInData:IsLimitMonthCardBuy()
  ;
  (((self.ui).btn_Buy).gameObject):SetActive(isCanBuy)
  ;
  ((self.ui).obj_GetLimited):SetActive(not isCanBuy)
  if dailySignInData:IsHaveCard() then
    ((self.ui).tex_Time):SetIndex(0, tostring(dayCount))
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (((self.ui).tex_Time).text).color = (self.ui).color_hasCardText
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_Time).color = (self.ui).color_hasCardBg
  else
    ;
    ((self.ui).tex_Time):SetIndex(1)
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (((self.ui).tex_Time).text).color = (self.ui).color_noHaveCardText
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_Time).color = (self.ui).color_noHaveCardBg
  end
  for i,v in ipairs(self.extrRewardList) do
    v:SetPickedUIActive(dailySignInData:IsHaveCard())
  end
  if self.waitingMonthCardreward then
    local mailController = ControllerManager:GetController(ControllerTypeId.Mail, false)
    local notPickedSinginMailUIDList = mailController:GetSignInRewardMailUIDs(true, true, true)
    if #notPickedSinginMailUIDList > 0 then
      self:ShowCollectSignInReward(mailController, notPickedSinginMailUIDList, 1)
    end
    self.waitingMonthCardreward = nil
  end
  do
    if PlayerDataCenter.timestamp <= (PlayerDataCenter.dailySignInData).expireAt then
      if self.timer == nil then
        self.timer = TimerManager:GetTimer(1, self.CountDownExpire, self, false, false, false)
        ;
        (self.timer):Start()
      else
        ;
        (self.timer):Stop()
        ;
        (self.timer):Init(1, self.CountDownExpire, self, false, false, false)
        ;
        (self.timer):Start()
      end
    end
  end
end

UINMonthCard.CountDownExpire = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (PlayerDataCenter.dailySignInData).expireAt < PlayerDataCenter.timestamp then
    if self.timer ~= nil then
      (self.timer):Stop()
      self.timer = nil
    end
    self:Refresh()
  end
end

UINMonthCard.ShowCollectSignInReward = function(self, mailController, notPickedSinginMailUIDList, index)
  -- function num : 0_5 , upvalues : _ENV
  local mailUid = notPickedSinginMailUIDList[index]
  if mailController == nil or (mailController.mailDataDic)[mailUid] == nil then
    error("can\'t get mail data with UID:" .. tostring(mailUid))
    return 
  end
  local win = UIManager:GetWindow(UIWindowTypeID.CommonReward)
  if win ~= nil and win.active then
    win:BindCommonRewardExit(function()
    -- function num : 0_5_0 , upvalues : self, mailController, notPickedSinginMailUIDList, index
    self:ShowCollectSignInReward(mailController, notPickedSinginMailUIDList, index)
  end
)
    return 
  end
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Mail)):CS_MAIL_ReceiveAttachment(mailUid, function()
    -- function num : 0_5_1 , upvalues : _ENV, mailController, mailUid, self, index, notPickedSinginMailUIDList
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      -- function num : 0_5_1_0 , upvalues : mailController, mailUid, _ENV, self, index, notPickedSinginMailUIDList
      local rewardIds = {}
      local rewardNums = {}
      local _, rewardDic, _ = ((mailController.mailDataDic)[mailUid]):IsHaveAtt()
      for id,num in pairs(rewardDic) do
        (table.insert)(rewardIds, id)
        ;
        (table.insert)(rewardNums, num)
      end
      if window == nil then
        return 
      end
      window:AddNext2ShowReward(rewardIds, rewardNums, self._heroIdSnapShoot, nil, "签到奖励", function()
        -- function num : 0_5_1_0_0 , upvalues : index, notPickedSinginMailUIDList, self, mailController
        local index = index
        if index < #notPickedSinginMailUIDList then
          index = index + 1
          self:ShowCollectSignInReward(mailController, notPickedSinginMailUIDList, index)
        end
      end
, nil)
      mailController:ReqDeleteOneMail(mailUid)
    end
)
  end
)
end

UINMonthCard.OnClickBuy = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if (PlayerDataCenter.dailySignInData):IsLimitMonthCardBuy() then
    return 
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.DailySignIn)
  network:CS_MONTH_CARD_BUY((self.monthCardCfg).price)
  self.waitingMonthCardreward = true
end

UINMonthCard.OnDelete = function(self)
  -- function num : 0_7 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.MonthCardRefresh, self.__Refresh)
  if self.timer ~= nil then
    (self.timer):Stop()
    self.timer = nil
  end
  ;
  (base.OnDelete)(self)
end

return UINMonthCard

