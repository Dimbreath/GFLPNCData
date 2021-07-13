-- params : ...
-- function num : 0 , upvalues : _ENV
local MailData = class("MailData")
local MailEnum = require("Game.Mail.MailEnum")
local MailParamKey = {keyNone = 0, keyLotteryPoolName = 1, keyGiftGroupName = 2, keyPayProductId = 3, keyTimestamp1 = 4}
MailData.CreateMailData = function(mailDataMsg)
  -- function num : 0_0 , upvalues : MailData
  local mailData = (MailData.New)()
  mailData:InitMailData(mailDataMsg)
  return mailData
end

MailData.ctor = function(self)
  -- function num : 0_1
  self.uid = nil
  self.info = nil
  self.att = nil
  self.expiredTm = nil
  self.status = nil
  self.isSelected = false
  self.isDeleted = false
  self._couldShow = true
end

MailData.InitMailData = function(self, mailData)
  -- function num : 0_2
  self.uid = mailData.uid
  self.info = mailData.info
  self.att = mailData.att
  self.expiredTm = mailData.expiredTm
  self.status = mailData.status
  self:DealSpecailParam()
  self:UpdateCouldShow()
end

MailData.GetState = function(self)
  -- function num : 0_3
  return self.status
end

MailData.IsHaveAtt = function(self)
  -- function num : 0_4 , upvalues : _ENV, MailEnum
  if self.att ~= nil and (self.att).data ~= nil then
    if (table.count)((self.att).data) == 0 then
      return false
    end
    return true, (self.att).data, self:GetState() == (MailEnum.eMailDetailType).Received
  else
    return false
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

MailData.GetIsPicked = function(self)
  -- function num : 0_5 , upvalues : MailEnum
  do return self:GetState() == (MailEnum.eMailDetailType).Received end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

MailData.GetTitle = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.info ~= nil and (self.info).title ~= nil then
    return (self.info).title
  else
    error("Can\'t read mail title")
    return ""
  end
end

MailData.GetMailEntryCode = function(self)
  -- function num : 0_7
  return (self.info).code
end

MailData.GetSender = function(self)
  -- function num : 0_8 , upvalues : _ENV
  if self.info ~= nil and (self.info).senderName ~= nil then
    return (self.info).senderName
  else
    error("Can\'t read mail senderName")
    return ""
  end
end

MailData.GetContent = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self.info ~= nil and (self.info).content ~= nil then
    return (self.info).content
  else
    error("Can\'t read mail content")
    return ""
  end
end

MailData.GetTime = function(self, needRaw)
  -- function num : 0_10 , upvalues : _ENV
  if self.info ~= nil and (self.info).created ~= nil then
    if needRaw then
      return (self.info).created
    end
    if (self.info).YMD == nil or (self.info).HM == nil then
      local dataTable = TimestampToDate((self.info).created)
      local YMD = (string.format)("%d/%02d/%02d", dataTable.year, dataTable.month, dataTable.day)
      local HM = (string.format)("%02d:%02d", dataTable.hour, dataTable.min)
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self.info).YMD = YMD
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self.info).HM = HM
    end
    do
      do return (self.info).YMD, (self.info).HM end
      error("Can\'t read mail created tiemStamp")
      do return  end
    end
  end
end

MailData.GetTimeBeforeExpired = function(self)
  -- function num : 0_11 , upvalues : _ENV
  return (math.ceil)((math.max)(self.expiredTm - PlayerDataCenter.timestamp, 0))
end

MailData.IsSignInRewardMail = function(self)
  -- function num : 0_12 , upvalues : _ENV, MailEnum
  local mailCfg = (ConfigData.mail)[(self.info).code]
  if mailCfg == nil then
    return false
  end
  do return mailCfg.type == (MailEnum.eMailType).SigninReward end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

MailData.IsSignInMonthCardReward = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local mailCfg = (ConfigData.mail)[(self.info).code]
  if mailCfg == nil then
    return false
  end
  do return mailCfg.entry == 115 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

MailData.UpdateCouldShow = function(self)
  -- function num : 0_14
  if self:IsSignInRewardMail() then
    self._couldShow = false
  end
end

MailData.GetCouldShow = function(self)
  -- function num : 0_15
  return self._couldShow
end

MailData.Update = function(self, mailData)
  -- function num : 0_16
  self.uid = mailData.uid
  self.info = mailData.info
  self.att = mailData.att
  self.expiredTm = mailData.expiredTm
  self.status = mailData.status
  self:DealSpecailParam()
  self:UpdateCouldShow()
end

MailData.DealSpecailParam = function(self)
  -- function num : 0_17 , upvalues : _ENV
  do
    if (self.info).titleParams ~= nil and #(self.info).titleParams > 0 then
      local paramsList = self:__DealSpecailParam_Local((self.info).titleParams)
      -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self.info).title = (string.format)((self.info).title, (table.unpack)(paramsList))
    end
    if (self.info).contentParams ~= nil and #(self.info).contentParams > 0 then
      local paramsList = self:__DealSpecailParam_Local((self.info).contentParams)
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self.info).content = (string.format)((self.info).content, (table.unpack)(paramsList))
    end
  end
end

MailData.__DealSpecailParam_Local = function(self, params)
  -- function num : 0_18 , upvalues : MailParamKey, _ENV
  local list = {}
  for i = 1, #params do
    local temp = params[i]
    local value = nil
    if temp.cat == MailParamKey.keyLotteryPoolName then
      value = (LanguageUtil.GetLocaleText)(((ConfigData.lottery_para)[temp.value]).name)
    else
      if temp.cat == MailParamKey.keyGiftGroupName then
        value = (LanguageUtil.GetLocaleText)(((ConfigData.pay_gift_type)[temp.value]).name)
      else
        if temp.cat == MailParamKey.keyPayProductId then
          value = (LanguageUtil.GetLocaleText)(((ConfigData.pay_product)[temp.value]).name)
        else
          if temp.cat == MailParamKey.keyTimestamp1 then
            local dateData = TimestampToDate(temp.value)
            local originalStr = (LanguageUtil.GetLocaleText)(ConfigData:GetTipContent(TipContent.MailDataInfo))
            value = (string.gsub)(originalStr, "%$(%w+)", dateData)
          else
            do
              do
                value = tostring(temp.value)
                ;
                (table.insert)(list, value)
                -- DECOMPILER ERROR at PC81: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC81: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC81: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC81: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC81: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC81: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC81: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC81: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC81: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
    end
  end
  return list
end

MailData.GetExtraParams = function(self)
  -- function num : 0_19
  return (self.info).extraParams
end

MailData.Delete = function(self)
  -- function num : 0_20
  self.isDeleted = true
end

return MailData

