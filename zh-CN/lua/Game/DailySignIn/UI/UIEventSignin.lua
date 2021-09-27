local UIEventSignin = class("UIEventSignin", UIBaseWindow)
local base = UIBaseWindow
local UINEventSigninRewardItem = require("Game.DailySignIn.UI.UINEventSigninRewardItem")
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local JumpManager = require("Game.Jump.JumpManager")
local ShopEnum = require("Game.Shop.ShopEnum")
local cs_ResLoader = CS.ResLoader
UIEventSignin.OnInit = function(self)
  -- function num : 0_0 , upvalues : cs_ResLoader, _ENV, UINEventSigninRewardItem, UINBaseItemWithReceived, JumpManager
  self.selectedItemDateNum = nil
  self.__TimerId = nil
  self.lastPickedNum = 0
  self.resloader = (cs_ResLoader.Create)()
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_jump, self, self.OnClickBuyMonthCard)
  self.rewardItemPool = (UIItemPool.New)(UINEventSigninRewardItem, (self.ui).obj_dailyItem)
  ;
  ((self.ui).obj_dailyItem):SetActive(false)
  self.obj_noneBGList = {}
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.obj_noneBGList)[1] = (self.ui).obj_noneBG
  ;
  ((self.ui).obj_noneBG):SetActive(false)
  self.ItemWithCountList = {}
  local rewardItem = (UINBaseItemWithReceived.New)()
  rewardItem:Init((self.ui).obj_rewardItem)
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.ItemWithCountList)[1] = rewardItem
  ;
  ((self.ui).obj_rewardItem):SetActive(false)
  self.__SelectRewardItemCallback = BindCallback(self, self.__SelectRewardItem)
  self.__ShowMonthCardLeftNum = BindCallback(self, self.ShowMonthCardLeftNum)
  MsgCenter:AddListener(eMsgEventId.MonthCardRefresh, self.__ShowMonthCardLeftNum)
  self._lastCouldUseItemJump = JumpManager.couldUseItemJump
  JumpManager.couldUseItemJump = false
end

UIEventSignin.InitEventSignin = function(self, activityId, notPickedSinginMailUIDList)
  -- function num : 0_1 , upvalues : _ENV
  self.isOpenInActivity = activityId ~= nil
  if self.isOpenInActivity then
    (((self.ui).btn_close).gameObject):SetActive(false)
    ;
    (((self.ui).btn_backGround).gameObject):SetActive(false)
  else
    (UIUtil.AddButtonListener)((self.ui).btn_close, self, self.CloseEventSignin)
    ;
    (UIUtil.AddButtonListener)((self.ui).btn_backGround, self, self.CloseEventSignin)
  end
  local notPickedMailUIDsList = {}
  local allWait2PickDayDic = {}
  local allWait2PickUidDic = {}
  if notPickedSinginMailUIDList ~= nil then
    local mailController = ControllerManager:GetController(ControllerTypeId.Mail, false)
    for _,mailUid in pairs(notPickedSinginMailUIDList) do
      if mailController ~= nil and (mailController.mailDataDic)[mailUid] ~= nil then
        local mailData = (mailController.mailDataDic)[mailUid]
        local pickDay = (mailData:GetExtraParams())[1]
        if pickDay == nil then
          error("mail UID:" .. tostring(mailUid) .. " not have a pickDayInfo as sigin reward")
        elseif allWait2PickDayDic[pickDay] == nil then
          allWait2PickDayDic[pickDay] = 1
          allWait2PickUidDic[pickDay] = {}
          ;
          (table.insert)(allWait2PickUidDic[pickDay], mailUid)
        else
          allWait2PickDayDic[pickDay] = allWait2PickDayDic[pickDay] + 1
          ;
          (table.insert)(allWait2PickUidDic[pickDay], mailUid)
        end
      end
    end
  end
  for pickDay,list in pairs(allWait2PickUidDic) do
    list.pickDay = pickDay
    ;
    (table.insert)(notPickedMailUIDsList, list)
  end
  ;
  (table.sort)(notPickedMailUIDsList, function(a, b)
    -- function num : 0_1_0
    do return a.pickDay < b.pickDay end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for index,value in ipairs(notPickedMailUIDsList) do
    value.pickDay = nil
  end
  self:__InitRewardList(allWait2PickDayDic)
  self:__SetBeforeRefreshTime()
  self:ShowMonthCardLeftNum()
  self:SetSinginMailUIDList(notPickedMailUIDsList)
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

UIEventSignin.__InitRewardList = function(self, allWait2PickDayDic)
  -- function num : 0_2 , upvalues : _ENV
  local counterElem = (ControllerManager:GetController(ControllerTypeId.TimePass)):getCounterElemData(proto_object_CounterModule.CounterModuleDailyBouns, 0)
  if counterElem or not 5 then
    local dayPassTime = (TimestampToDate(counterElem.nextExpiredTm)).hour
  end
  local monthDayNum = nil
  local dataTable = TimestampToDate((math.floor)(PlayerDataCenter.timestamp))
  local logicDataTable = TimestampToDate((os.time)({year = dataTable.year, month = dataTable.month, day = dataTable.day, hour = dataTable.hour - dayPassTime}))
  monthDayNum = (os.date)("%d", (os.time)({year = logicDataTable.year, month = logicDataTable.month + 1, day = 0}))
  self.monthDayNum = tonumber(monthDayNum)
  if dataTable.month <= 9 then
    ((self.ui).tex_month):SetIndex(0, "0" .. tostring(logicDataTable.month))
  else
    ;
    ((self.ui).tex_month):SetIndex(0, tostring(logicDataTable.month))
  end
  -- DECOMPILER ERROR at PC88: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_year).text = tostring(logicDataTable.year)
  local pickedDayNum = (PlayerDataCenter.dailySignInData):SingInNum()
  self.lastPickedNum = pickedDayNum
  ;
  (self.rewardItemPool):HideAll()
  for i = 1, monthDayNum do
    local item = (self.rewardItemPool):GetOne()
    item:InitSigninRewardItem(R15_PC107, self.__SelectRewardItemCallback)
    if i > pickedDayNum then
      do
        item:SetIsReceived(R15_PC107)
        -- DECOMPILER ERROR at PC120: Overwrote pending register: R15 in 'AssignReg'

        -- DECOMPILER ERROR at PC123: Overwrote pending register: R15 in 'AssignReg'

        item:SetIsReceived(R15_PC107)
        if pickedDayNum == i then
          item:SetCurDayMArker()
          -- DECOMPILER ERROR at PC131: Overwrote pending register: R15 in 'AssignReg'

          self:__SelectRewardItem(R15_PC107)
        end
        -- DECOMPILER ERROR at PC133: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC133: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  for _,go in pairs(self.obj_noneBGList) do
    -- DECOMPILER ERROR at PC139: Overwrote pending register: R15 in 'AssignReg'

    go:SetActive(R15_PC107)
  end
  for i = monthDayNum + 1, 35 do
    local go = nil
    if (self.obj_noneBGList)[i - monthDayNum] ~= nil then
      go = (self.obj_noneBGList)[i - monthDayNum]
    else
      go = ((self.ui).obj_noneBG):Instantiate()
      -- DECOMPILER ERROR at PC164: Confused about usage of register: R13 in 'UnsetPending'

      ;
      (self.obj_noneBGList)[i - monthDayNum] = go
    end
    -- DECOMPILER ERROR at PC166: Overwrote pending register: R15 in 'AssignReg'

    go:SetActive(R15_PC107)
    ;
    (go.transform):SetAsLastSibling()
  end
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

UIEventSignin.__SelectRewardItem = function(self, SigninRewardItem)
  -- function num : 0_3 , upvalues : _ENV, UINBaseItemWithReceived
  self.selectedItemDateNum = SigninRewardItem.dateNum
  ;
  (((self.ui).obj_Select).transform):SetParent(SigninRewardItem.transform, false)
  ;
  ((self.ui).obj_Select):SetActive(true)
  ;
  ((self.ui).obj_sign):SetActive(SigninRewardItem.isPicked)
  local itemIds, itemNums = (PlayerDataCenter.dailySignInData):GetSingInRewardByDayNum(SigninRewardItem.dateNum)
  local MC_itemIds, MC_itemNums = (PlayerDataCenter.dailySignInData):GetMonthCardRewardBm()
  for _,item in pairs(self.ItemWithCountList) do
    (item.gameObject):SetActive(false)
  end
  local count = 0
  if itemIds ~= nil then
    for index,id in ipairs(itemIds) do
      if (self.ItemWithCountList)[index] == nil then
        local rewardItem = (UINBaseItemWithReceived.New)()
        local go = ((self.ui).obj_rewardItem):Instantiate()
        rewardItem:Init(go)
        -- DECOMPILER ERROR at PC59: Confused about usage of register: R14 in 'UnsetPending'

        ;
        (self.ItemWithCountList)[index] = rewardItem
      end
      do
        local itemCfg = (ConfigData.item)[id]
        do
          local num = itemNums[index]
          ;
          (((self.ItemWithCountList)[index]).transform):SetParent(((self.ui).obj_normalAwardGroup).transform, false)
          ;
          ((self.ItemWithCountList)[index]):InitItemWithCount(itemCfg, num)
          ;
          (((self.ItemWithCountList)[index]).gameObject):SetActive(true)
          -- DECOMPILER ERROR at PC85: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
    count = #itemIds
  end
  if MC_itemIds ~= nil then
    for index,id in ipairs(MC_itemIds) do
      if (self.ItemWithCountList)[index + count] == nil then
        local rewardItem = (UINBaseItemWithReceived.New)()
        local go = ((self.ui).obj_rewardItem):Instantiate()
        rewardItem:Init(go)
        -- DECOMPILER ERROR at PC110: Confused about usage of register: R14 in 'UnsetPending'

        ;
        (self.ItemWithCountList)[index + count] = rewardItem
      end
      do
        local itemCfg = (ConfigData.item)[id]
        do
          local num = MC_itemNums[index]
          ;
          (((self.ItemWithCountList)[index + count]).transform):SetParent(((self.ui).obj_monthAwardGroup).transform, false)
          ;
          ((self.ItemWithCountList)[index + count]):InitItemWithCount(itemCfg, num)
          ;
          (((self.ItemWithCountList)[index + count]).gameObject):SetActive(true)
          -- DECOMPILER ERROR at PC139: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
end

UIEventSignin.__SetBeforeRefreshTime = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local counterElem = (ControllerManager:GetController(ControllerTypeId.TimePass)):getCounterElemData(proto_object_CounterModule.CounterModuleGlobalDailyFlush, 0)
  if counterElem ~= nil then
    self.passTimeStamp = counterElem.nextExpiredTm
    self:__RefreshBeforeRefreshTime()
    TimerManager:StopTimer(self.__TimerId)
    self.__TimerId = TimerManager:StartTimer(1, self.__RefreshBeforeRefreshTime, self, false, false, true)
  end
end

UIEventSignin.__RefreshBeforeRefreshTime = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((self.ui).tex_time):SetIndex(0, TimestampToTime((math.max)(0, self.passTimeStamp - PlayerDataCenter.timestamp)))
end

UIEventSignin.SetSinginMailUIDList = function(self, notPickedMailUIDsList)
  -- function num : 0_6 , upvalues : _ENV
  if #notPickedMailUIDsList <= 0 then
    return 
  end
  local mailController = ControllerManager:GetController(ControllerTypeId.Mail, false)
  self:ShowCollectSignInReward(mailController, notPickedMailUIDsList, 1)
end

UIEventSignin.ShowCollectSignInReward = function(self, mailController, notPickedMailUIDsList, index)
  -- function num : 0_7 , upvalues : _ENV
  if mailController == nil then
    error("can\'t get mailController")
    return 
  end
  local mailUids = notPickedMailUIDsList[index]
  for _,mailUid in ipairs(mailUids) do
    if (mailController.mailDataDic)[mailUid] == nil then
      error("can\'t get mail data with UID:" .. tostring(mailUid))
      return 
    end
  end
  local dayNum = (((mailController.mailDataDic)[mailUids[1]]):GetExtraParams())[1]
  local thisRewardItem = ((self.rewardItemPool).listItem)[dayNum]
  if thisRewardItem == nil then
    self:_CollectSignInreward(mailUids, mailController, notPickedMailUIDsList, index)
  else
    self.waitingShowReward = true
    thisRewardItem:LoadAndPlayFx(self.resloader, nil, nil, function()
    -- function num : 0_7_0 , upvalues : self, mailUids, mailController, notPickedMailUIDsList, index, thisRewardItem
    self:_CollectSignInreward(mailUids, mailController, notPickedMailUIDsList, index)
    thisRewardItem:SetIsReceived(true)
    self.waitingShowReward = false
    ;
    ((self.ui).obj_sign):SetActive(true)
  end
)
  end
end

UIEventSignin._CollectSignInreward = function(self, mailUids, mailController, notPickedSinginMailUIDList, index)
  -- function num : 0_8 , upvalues : _ENV
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  self:__GetAllMailRewars(mailUids, 1, function()
    -- function num : 0_8_0 , upvalues : _ENV, index, notPickedSinginMailUIDList, self, mailController, mailUids
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      -- function num : 0_8_0_0 , upvalues : index, notPickedSinginMailUIDList, self, mailController, _ENV, mailUids
      local rewardIds = {}
      local rewardNums = {}
      local TryShowNext = function()
        -- function num : 0_8_0_0_0 , upvalues : index, notPickedSinginMailUIDList, self, mailController
        local index = index
        if index < #notPickedSinginMailUIDList then
          index = index + 1
          self:ShowCollectSignInReward(mailController, notPickedSinginMailUIDList, index)
        end
      end

      for _,mailUid in ipairs(mailUids) do
        local mailData = (mailController.mailDataDic)[mailUid]
        if mailData == nil then
          TryShowNext()
          return 
        end
        local _, rewardDic, _ = mailData:IsHaveAtt()
        for id,num in pairs(rewardDic) do
          (table.insert)(rewardIds, id)
          ;
          (table.insert)(rewardNums, num)
        end
      end
      if window == nil then
        return 
      end
      window:AddNext2ShowReward(rewardIds, rewardNums, self._heroIdSnapShoot, nil, "签到奖励", TryShowNext)
      for _,mailUid in ipairs(mailUids) do
        mailController:ReqDeleteOneMail(mailUid)
      end
    end
)
  end
)
end

UIEventSignin.__GetAllMailRewars = function(self, mailUids, index, callback)
  -- function num : 0_9 , upvalues : _ENV
  local mailUid = mailUids[index]
  index = index + 1
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Mail)):CS_MAIL_ReceiveAttachment(mailUid, function()
    -- function num : 0_9_0 , upvalues : mailUids, index, self, callback
    if index <= #mailUids then
      self:__GetAllMailRewars(mailUids, index, callback)
    else
      if callback ~= nil then
        callback()
      end
    end
  end
)
end

UIEventSignin.ShowMonthCardLeftNum = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local leftday = (PlayerDataCenter.dailySignInData):GetMonthCardLeftCount()
  if leftday > 0 then
    ((self.ui).tex_jump):SetIndex(1, tostring(leftday))
  else
    ;
    ((self.ui).tex_jump):SetIndex(0)
  end
end

UIEventSignin.OnClickBuyMonthCard = function(self)
  -- function num : 0_11 , upvalues : _ENV, ShopEnum, JumpManager
  local payGiftShopId = (ControllerManager:GetController(ControllerTypeId.PayGift, true)).shopId
  local monthPageId = nil
  for pageId,cfg in pairs(ConfigData.shop_page) do
    if cfg.mark == (ShopEnum.ePageMarkType).MonthCard then
      monthPageId = pageId
      break
    end
  end
  do
    JumpManager:Jump((JumpManager.eJumpTarget).DynShop, function(callback)
    -- function num : 0_11_0 , upvalues : self
    self:CloseEventSignin()
    if callback ~= nil then
      callback()
    end
  end
, nil, {payGiftShopId, 0, monthPageId})
  end
end

UIEventSignin.SetCloseCallback = function(self, callback)
  -- function num : 0_12
  self.closeCallback = callback
end

UIEventSignin.CloseEventSignin = function(self)
  -- function num : 0_13 , upvalues : JumpManager
  if self.waitingShowReward then
    return 
  end
  if self.closeCallback ~= nil then
    (self.closeCallback)()
  end
  JumpManager.couldUseItemJump = self._lastCouldUseItemJump
  self:Delete()
end

UIEventSignin.OnDelete = function(self)
  -- function num : 0_14 , upvalues : _ENV, base
  TimerManager:StopTimer(self.__TimerId)
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.MonthCardRefresh, self.__ShowMonthCardLeftNum)
  ;
  (base.OnDelete)(self)
end

return UIEventSignin

