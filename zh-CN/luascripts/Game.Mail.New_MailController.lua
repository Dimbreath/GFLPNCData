-- params : ...
-- function num : 0 , upvalues : _ENV
local New_MailController = class("New_MailController", ControllerBase)
local cs_MessageCommon = CS.MessageCommon
local MailData = require("Game.Mail.MailData")
local MailEnum = require("Game.Mail.MailEnum")
local HomeEnum = require("Game.Home.HomeEnum")
New_MailController.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.hasNotify = false
  self.haveNotGetRewardMail = false
  self.haveCouldDeleteMail = false
  self.isUIOpen = false
  self._m_InitDataCallback = BindCallback(self, self.m_InitDataCallback)
  self.network = NetworkManager:GetNetwork(NetworkTypeID.Mail)
  self.mailDataDic = {}
end

New_MailController.OnMailUIShow = function(self, callback)
  -- function num : 0_1 , upvalues : _ENV, HomeEnum
  if self.hasNotify then
    self:ReqMailFetch(true, function()
    -- function num : 0_1_0 , upvalues : self, callback
    self:DeletAllOutDataMail()
    self:StartAutoDeleteTimer()
    if callback ~= nil then
      callback()
    end
  end
)
  else
    self:DeletAllOutDataMail()
    self:StartAutoDeleteTimer()
    if callback ~= nil then
      callback()
    end
  end
  self.isUIOpen = true
  MsgCenter:Broadcast(eMsgEventId.CleanNotice, (HomeEnum.eNoticeType).Mail)
end

New_MailController.OnMailUIHide = function(self)
  -- function num : 0_2
  if self.m_outDataTimer ~= nil then
    (self.m_outDataTimer):Stop()
    self.m_outDataTimer = nil
  end
  self.isUIOpen = false
end

New_MailController.GetInitData = function(self)
  -- function num : 0_3
  (self.network):CS_MAIL_Detail(self._m_InitDataCallback)
end

New_MailController.m_InitDataCallback = function(self, args)
  -- function num : 0_4 , upvalues : _ENV
  if args ~= nil and args.Count > 0 then
    local mailDetails = args[0]
    self:InitOrUpdateData(mailDetails, true)
  else
    do
      error("InitData args error")
    end
  end
end

New_MailController.RecvUpdateDiff = function(self, data, delete)
  -- function num : 0_5 , upvalues : _ENV
  if delete ~= nil and (table.count)(delete) > 0 then
    self:DeleteData(delete)
  end
  if data ~= nil and (table.count)(data) > 0 then
    self:InitOrUpdateData(data)
  end
end

New_MailController.ReqMailRead = function(self, uid, callback)
  -- function num : 0_6 , upvalues : MailEnum
  local mailDetail = (self.mailDataDic)[uid]
  if mailDetail.status == (MailEnum.eMailDetailType).None then
    (self.network):CS_MAIL_Read(uid, callback)
  end
end

New_MailController.ReqReceiveAttachment = function(self, uid)
  -- function num : 0_7 , upvalues : _ENV
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  ;
  (self.network):CS_MAIL_ReceiveAttachment(uid, function()
    -- function num : 0_7_0 , upvalues : _ENV, self, uid
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      -- function num : 0_7_0_0 , upvalues : self, uid, _ENV
      local rewardIds = {}
      local rewardNums = {}
      local _, rewardDic, _ = ((self.mailDataDic)[uid]):IsHaveAtt()
      for id,num in pairs(rewardDic) do
        (table.insert)(rewardIds, id)
        ;
        (table.insert)(rewardNums, num)
      end
      if window == nil then
        return 
      end
      window:InitRewardsItem(rewardIds, rewardNums, self._heroIdSnapShoot)
    end
)
  end
)
end

New_MailController.ReqDeleteOneMail = function(self, uid)
  -- function num : 0_8
  if self.isDeleting then
    return 
  end
  self.isDeleting = true
  ;
  (self.network):CS_MAIL_Delete(uid, function()
    -- function num : 0_8_0 , upvalues : self
    self.isDeleting = false
  end
)
end

New_MailController.ReqOneClickPickUp = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self.haveNotGetRewardMail then
    self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    ;
    (self.network):CS_MAIL_OneClickPickUp(function(args)
    -- function num : 0_9_0 , upvalues : _ENV, self
    if args ~= nil and args.Count > 0 then
      local update = args[0]
      do
        if update == nil then
          return 
        end
        local rewardDic = {}
        for uid,data in pairs(update) do
          for key,value in pairs((data.att).data) do
            if rewardDic[key] == nil then
              rewardDic[key] = value
            else
              rewardDic[key] = value + rewardDic[key]
            end
          end
        end
        local rewardIds = {}
        local rewardNums = {}
        for id,num in pairs(rewardDic) do
          (table.insert)(rewardIds, id)
          ;
          (table.insert)(rewardNums, R12_PC46)
        end
        UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      -- function num : 0_9_0_0 , upvalues : rewardIds, rewardNums, self
      if window == nil then
        return 
      end
      window:InitRewardsItem(rewardIds, rewardNums, self._heroIdSnapShoot)
    end
)
      end
    else
      do
        ;
        ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(TipContent.ResourceOverflow))
      end
    end
  end
)
  end
end

New_MailController.ReqOneClickDelete = function(self)
  -- function num : 0_10
  if self.haveCouldDeleteMail then
    (self.network):CS_MAIL_OneKeyDelete()
  end
end

New_MailController.HasMailNotify = function(self)
  -- function num : 0_11 , upvalues : _ENV, HomeEnum, cs_MessageCommon
  self.hasNotify = true
  MsgCenter:Broadcast(eMsgEventId.NewNotice, (HomeEnum.eNoticeType).Mail, PlayerDataCenter.timestamp, nil)
  ;
  (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.mail_Notice))
  local mailNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Mail)
  mailNode:SetRedDotCount(1)
  local mailWin = UIManager:GetWindow(UIWindowTypeID.Mail)
  if mailWin ~= nil then
    self:ReqMailFetch(false)
  end
end

New_MailController.ReqMailFetch = function(self, waitRev, callback)
  -- function num : 0_12
  (self.network):CS_MAIL_Fetch(waitRev, callback)
end

New_MailController.RecvMailFetch = function(self)
  -- function num : 0_13
  self.hasNotify = false
  self:RefrshMailRedDot()
end

New_MailController.InitOrUpdateData = function(self, mailDetails, isInit)
  -- function num : 0_14 , upvalues : _ENV, MailData, MailEnum, HomeEnum
  local hasDiff = false
  local hasNew = false
  local diffDatas = {}
  for _,mailDetail in pairs(mailDetails) do
    if (self.mailDataDic)[mailDetail.uid] ~= nil then
      ((self.mailDataDic)[mailDetail.uid]):Update(mailDetail)
      hasDiff = true
      ;
      (table.insert)(diffDatas, (self.mailDataDic)[mailDetail.uid])
    else
      local mailData = (MailData.CreateMailData)(mailDetail)
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R12 in 'UnsetPending'

      ;
      (self.mailDataDic)[mailDetail.uid] = mailData
      hasNew = true
    end
  end
  self:m_RefreshDeleteAndNewState()
  if hasDiff or hasNew then
    MsgCenter:Broadcast(eMsgEventId.OnMailDiff, diffDatas, hasNew)
  end
  if self.isUIOpen then
    self:StartAutoDeleteTimer()
  end
  self:RefrshMailRedDot()
  if isInit then
    local latestTime = nil
    for _,mailData in pairs(self.mailDataDic) do
      if mailData:GetState() == (MailEnum.eMailDetailType).None then
        local time = mailData:GetTime(true)
        if latestTime == nil or latestTime < time then
          latestTime = time
        end
      end
    end
    if latestTime ~= nil then
      MsgCenter:Broadcast(eMsgEventId.NewNotice, (HomeEnum.eNoticeType).Mail, latestTime)
    end
  end
end

New_MailController.DeleteData = function(self, delete)
  -- function num : 0_15 , upvalues : _ENV
  for uid,_ in pairs(delete) do
    if (self.mailDataDic)[uid] ~= nil then
      ((self.mailDataDic)[uid]):Delete()
      -- DECOMPILER ERROR at PC13: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self.mailDataDic)[uid] = nil
    end
  end
  self:m_RefreshDeleteAndNewState()
  self:RefrshMailRedDot()
  MsgCenter:Broadcast(eMsgEventId.OnMailDelete, delete)
end

New_MailController.m_RefreshDeleteAndNewState = function(self)
  -- function num : 0_16 , upvalues : _ENV, MailEnum
  self.haveCouldDeleteMail = false
  self.haveNotGetRewardMail = false
  for _,mailData in pairs(self.mailDataDic) do
    local isHaveAtt, attDic, isPicked = mailData:IsHaveAtt()
    if isHaveAtt and not isPicked then
      self.haveNotGetRewardMail = true
    else
      if isHaveAtt and isPicked then
        self.haveCouldDeleteMail = true
      else
        if not isHaveAtt and mailData:GetState() ~= (MailEnum.eMailDetailType).None then
          self.haveCouldDeleteMail = true
        end
      end
    end
  end
  do
    if not self.haveCouldDeleteMail or not self.haveNotGetRewardMail then
    end
  end
end

New_MailController.GetMailDataList = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local list = {}
  for _,data in pairs(self.mailDataDic) do
    (table.insert)(list, data)
  end
  ;
  (table.sort)(list, function(a, b)
    -- function num : 0_17_0
    if a:GetTime(true) == b:GetTime(true) then
      if b.uid >= a.uid then
        do return a.status ~= b.status end
        do return b:GetTime(true) < a:GetTime(true) end
        do return a.status < b.status end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
)
  return list
end

New_MailController.StartAutoDeleteTimer = function(self)
  -- function num : 0_18 , upvalues : _ENV
  if self.m_outDataTimer ~= nil then
    (self.m_outDataTimer):Stop()
    self.m_outDataTimer = nil
  end
  if (table.count)(self.mailDataDic) > 0 then
    local time = self:GetLatestRefreshTm()
    self.m_outDataTimer = (TimerManager:GetTimer(time, (BindCallback(self, self.DeletAllOutDataMail, true)), nil, true, false, true)):Start()
  end
end

New_MailController.GetLatestRefreshTm = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local seconds = math.maxinteger
  for _,data in pairs(self.mailDataDic) do
    seconds = (math.min)(data:GetTimeBeforeExpired(), seconds)
  end
  return seconds
end

New_MailController.DeletAllOutDataMail = function(self, isFromTimer)
  -- function num : 0_20 , upvalues : _ENV
  if isFromTimer == true then
    self.m_outDataTimer = nil
  end
  local delete = {}
  for uid,data in pairs(self.mailDataDic) do
    if data:GetTimeBeforeExpired() <= 0 then
      ((self.mailDataDic)[uid]):Delete()
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self.mailDataDic)[uid] = nil
      delete[uid] = true
    end
  end
  if (table.count)(delete) > 0 then
    self:RefrshMailRedDot()
    MsgCenter:Broadcast(eMsgEventId.OnMailDelete, delete)
  end
end

New_MailController.RefrshMailRedDot = function(self)
  -- function num : 0_21 , upvalues : _ENV, MailEnum
  local mailNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Mail)
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Mail) then
    mailNode:SetRedDotCount(0)
    return 
  end
  for uid,mailData in pairs(self.mailDataDic) do
    if mailData:GetState() == (MailEnum.eMailDetailType).None then
      mailNode:SetRedDotCount(1)
      return 
    else
      if mailData:GetState() == (MailEnum.eMailDetailType).Read and mailData:IsHaveAtt() then
        mailNode:SetRedDotCount(1)
        return 
      end
    end
  end
  if self.hasNotify then
    mailNode:SetRedDotCount(1)
    return 
  end
  mailNode:SetRedDotCount(0)
end

New_MailController.OnDelete = function(self)
  -- function num : 0_22
end

return New_MailController

