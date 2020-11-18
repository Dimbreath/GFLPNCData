-- params : ...
-- function num : 0 , upvalues : _ENV
local MailData = class("MailData")
local MailEnum = require("Game.Mail.MailEnum")
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
end

MailData.InitMailData = function(self, mailData)
  -- function num : 0_2
  self.uid = mailData.uid
  self.info = mailData.info
  self.att = mailData.att
  self.expiredTm = mailData.expiredTm
  self.status = mailData.status
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

MailData.GetTitle = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.info ~= nil and (self.info).title ~= nil then
    return (self.info).title
  else
    error("Can\'t read mail title")
    return ""
  end
end

MailData.GetSender = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.info ~= nil and (self.info).senderName ~= nil then
    return (self.info).senderName
  else
    error("Can\'t read mail senderName")
    return ""
  end
end

MailData.GetContent = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if self.info ~= nil and (self.info).content ~= nil then
    return (self.info).content
  else
    error("Can\'t read mail content")
    return ""
  end
end

MailData.GetTime = function(self, needRaw)
  -- function num : 0_8 , upvalues : _ENV
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
  -- function num : 0_9 , upvalues : _ENV
  return (math.ceil)((math.max)(self.expiredTm - PlayerDataCenter.timestamp, 0))
end

MailData.Update = function(self, mailData)
  -- function num : 0_10
  self.expiredTm = mailData.expiredTm
  self.status = mailData.status
end

MailData.Delete = function(self)
  -- function num : 0_11
  self.isDeleted = true
end

return MailData

