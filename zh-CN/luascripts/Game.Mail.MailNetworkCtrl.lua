-- params : ...
-- function num : 0 , upvalues : _ENV
local MailNetworkCtrl = class("MailNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = (CS.WaitNetworkResponse).Instance
MailNetworkCtrl.ctor = function(self)
  -- function num : 0_0
end

MailNetworkCtrl.InitNetwork = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MAIL_Notify, self, proto_csmsg.SC_MAIL_Notify, self.SC_MAIL_Notify)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MAIL_Fetch, self, proto_csmsg.SC_MAIL_Fetch, self.SC_MAIL_Fetch)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MAIL_Read, self, proto_csmsg.SC_MAIL_Read, self.SC_MAIL_Read)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MAIL_ReceiveAttachment, self, proto_csmsg.SC_MAIL_ReceiveAttachment, self.SC_MAIL_ReceiveAttachment)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MAIL_Delete, self, proto_csmsg.SC_MAIL_Delete, self.SC_MAIL_Delete)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MAIL_OneClickPickUp, self, proto_csmsg.SC_MAIL_OneClickPickUp, self.SC_MAIL_OneClickPickUp)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MAIL_SyncUpdateDiff, self, proto_csmsg.SC_MAIL_SyncUpdateDiff, self.MailCommonDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MAIL_Detail, self, proto_csmsg.SC_MAIL_Detail, self.SC_MAIL_Detail)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MAIL_OneKeyDelete, self, proto_csmsg.SC_MAIL_OneKeyDelete, self.SC_MAIL_OneKeyDelete)
end

MailNetworkCtrl.MailCommonDiff = function(self, diffMsg)
  -- function num : 0_2 , upvalues : _ENV
  (ControllerManager:GetController(ControllerTypeId.Mail, true)):RecvUpdateDiff(diffMsg.update, diffMsg.delete)
end

MailNetworkCtrl.SC_MAIL_Notify = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (ControllerManager:GetController(ControllerTypeId.Mail, true)):HasMailNotify()
end

local waitNtework = false
MailNetworkCtrl.CS_MAIL_Fetch = function(self, waitRev, callback)
  -- function num : 0_4 , upvalues : _ENV, waitNtework, cs_WaitNetworkResponse
  local msg = {}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MAIL_Fetch, proto_csmsg.CS_MAIL_Fetch, msg)
  if waitRev == nil or waitRev == true then
    waitNtework = true
    cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_Fetch, callback, proto_csmsg_MSG_ID.MSG_SC_MAIL_Fetch)
  end
end

MailNetworkCtrl.SC_MAIL_Fetch = function(self, msg)
  -- function num : 0_5 , upvalues : _ENV, waitNtework, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if waitNtework then
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_Fetch)
    end
    local err = "SC_MAIL_Fetch error,code:" .. tostring(msg.ret)
    if isGameDev then
      ((CS.MessageCommon).ShowMessageTips)(err)
    end
    error(err)
  else
    do
      ;
      (ControllerManager:GetController(ControllerTypeId.Mail, true)):RecvMailFetch()
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
    end
  end
end

MailNetworkCtrl.CS_MAIL_Read = function(self, uid, callback)
  -- function num : 0_6 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {}
  msg.uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MAIL_Read, proto_csmsg.CS_MAIL_Read, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_Read, callback, proto_csmsg_MSG_ID.MSG_SC_MAIL_Read)
end

MailNetworkCtrl.SC_MAIL_Read = function(self, msg)
  -- function num : 0_7 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_MAIL_Read error,code:" .. tostring(msg.ret)
    if isGameDev then
      ((CS.MessageCommon).ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_Read)
  else
    do
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
    end
  end
end

MailNetworkCtrl.CS_MAIL_ReceiveAttachment = function(self, uid, callback)
  -- function num : 0_8 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {}
  msg.uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MAIL_ReceiveAttachment, proto_csmsg.CS_MAIL_ReceiveAttachment, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_ReceiveAttachment, callback, proto_csmsg_MSG_ID.MSG_SC_MAIL_ReceiveAttachment)
end

MailNetworkCtrl.SC_MAIL_ReceiveAttachment = function(self, msg)
  -- function num : 0_9 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if msg.ret == proto_csmsg_ErrorCode.BACKPACK_ITEM_OVERFLOW then
      ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.ResourceOverflow))
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_ReceiveAttachment)
      return 
    end
    self.currUid = nil
    local err = "SC_MAIL_ReceiveAttachment error,code:" .. tostring(msg.ret)
    if isGameDev then
      ((CS.MessageCommon).ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_ReceiveAttachment)
  else
    do
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
    end
  end
end

MailNetworkCtrl.CS_MAIL_Delete = function(self, uid, callback)
  -- function num : 0_10 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {}
  msg.uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MAIL_Delete, proto_csmsg.CS_MAIL_Delete, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_Delete, callback, proto_csmsg_MSG_ID.MSG_SC_MAIL_Delete)
end

MailNetworkCtrl.SC_MAIL_Delete = function(self, msg)
  -- function num : 0_11 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    self.currUid = nil
    local err = "SC_MAIL_ReceiveAttachment error,code:" .. tostring(msg.ret)
    if isGameDev then
      ((CS.MessageCommon).ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_Delete)
  else
    do
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
    end
  end
end

MailNetworkCtrl.CS_MAIL_OneClickPickUp = function(self, callback)
  -- function num : 0_12 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MAIL_OneClickPickUp, proto_csmsg.CS_MAIL_OneClickPickUp, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_OneClickPickUp, callback, proto_csmsg_MSG_ID.MSG_SC_MAIL_OneClickPickUp)
end

MailNetworkCtrl.SC_MAIL_OneClickPickUp = function(self, msg)
  -- function num : 0_13 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_MAIL_OneClickPickUp error,code:" .. tostring(msg.ret)
    if isGameDev then
      ((CS.MessageCommon).ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_OneClickPickUp)
  else
    do
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
      local syncUpdateDiff = msg.syncUpdateDiff
      if syncUpdateDiff ~= nil and syncUpdateDiff.mail ~= nil and (syncUpdateDiff.mail).update ~= nil then
        cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_MAIL_OneClickPickUp, (syncUpdateDiff.mail).update)
      end
    end
  end
end

MailNetworkCtrl.CS_MAIL_OneKeyDelete = function(self, callback)
  -- function num : 0_14 , upvalues : _ENV, cs_WaitNetworkResponse
  local msg = {}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MAIL_OneKeyDelete, proto_csmsg.CS_MAIL_OneKeyDelete, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_OneKeyDelete, callback, proto_csmsg_MSG_ID.MSG_SC_MAIL_OneKeyDelete)
end

MailNetworkCtrl.SC_MAIL_OneKeyDelete = function(self, msg)
  -- function num : 0_15 , upvalues : _ENV, cs_WaitNetworkResponse
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_MAIL_OneKeyDelete error,code:" .. tostring(msg.ret)
    if isGameDev then
      ((CS.MessageCommon).ShowMessageTips)(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_OneKeyDelete)
  else
    do
      NetworkManager:HandleDiff(msg.syncUpdateDiff)
    end
  end
end

MailNetworkCtrl.CS_MAIL_Detail = function(self, callback)
  -- function num : 0_16 , upvalues : _ENV, cs_WaitNetworkResponse
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MAIL_Detail, proto_csmsg.CS_MAIL_Detail, table.emptytable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_Detail, callback, proto_csmsg_MSG_ID.MSG_SC_MAIL_Detail)
end

MailNetworkCtrl.SC_MAIL_Detail = function(self, msg)
  -- function num : 0_17 , upvalues : cs_WaitNetworkResponse, _ENV
  cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_MAIL_Detail, msg.data)
end

MailNetworkCtrl.Reset = function(self)
  -- function num : 0_18
  self.currUid = 0
end

return MailNetworkCtrl

