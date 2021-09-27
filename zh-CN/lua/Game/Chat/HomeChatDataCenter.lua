local HomeChatDataCenter = class("HomeChatDataCenter")
local HomeChatData = require("Game.Chat.HomeChatData")
HomeChatDataCenter.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.curChannel = nil
  self.homeChatDatalist = {}
  self.newChatDataNum = 0
  self.curCDLevel = 0
  self.sendCd = 0
  self.OnCdChangeCallbackDic = {}
  self.lastSendTimeStamp = nil
  self.lastSendN = nil
  self.lastSenderMsg = nil
  self.lastInputMsg = nil
  self.MAX_CHATDATA_NUM = (ConfigData.game_config).chatListMaxDataNum
  self.MAX_INPUT_LENGTH = (ConfigData.game_config).chatMessageLength
  self.MAX_SAME_MESSAGE = (ConfigData.game_config).chatMatchSameMessage
end

HomeChatDataCenter.AddNewChatData = function(self, chatData)
  -- function num : 0_1 , upvalues : _ENV
  local removeNum = 0
  if self.MAX_CHATDATA_NUM <= #self.homeChatDatalist then
    removeNum = 1
    ;
    (table.remove)(self.homeChatDatalist, 1)
  end
  self.newChatDataNum = self.newChatDataNum + 1
  ;
  (table.insert)(self.homeChatDatalist, chatData)
  MsgCenter:Broadcast(eMsgEventId.OnNewWordChatDataCome, removeNum)
end

HomeChatDataCenter.AddOnSendCdChangeCallback = function(self, callback)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.OnCdChangeCallbackDic)[callback] = true
end

HomeChatDataCenter.SetCurChannel = function(self, channel)
  -- function num : 0_3
  self.curChannel = channel
end

HomeChatDataCenter.SetLastInputMsg = function(self, string)
  -- function num : 0_4
  self.lastInputMsg = string
end

HomeChatDataCenter.GetChatDataAtIndex = function(self, index)
  -- function num : 0_5
  if index <= 0 or #self.homeChatDatalist < index then
    return nil
  end
  return (self.homeChatDatalist)[index]
end

HomeChatDataCenter.GetCurDataCount = function(self)
  -- function num : 0_6
  return #self.homeChatDatalist
end

HomeChatDataCenter.GetLatestChatData = function(self)
  -- function num : 0_7
  local index = self:GetCurDataCount()
  return self:GetChatDataAtIndex(index)
end

HomeChatDataCenter.GetNewChatNum = function(self)
  -- function num : 0_8
  return self.newChatDataNum
end

HomeChatDataCenter.GetSendCd = function(self)
  -- function num : 0_9 , upvalues : _ENV
  return (math.ceil)(self.sendCd or 0)
end

HomeChatDataCenter.GetLastInputMsg = function(self, string)
  -- function num : 0_10
  self.lastInputMsg = string
end

HomeChatDataCenter.RemoveOnSendCdChangeCallback = function(self, callback)
  -- function num : 0_11
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.OnCdChangeCallbackDic)[callback] = nil
end

HomeChatDataCenter.CleanNewChatNum = function(self)
  -- function num : 0_12
  self.newChatDataNum = 0
end

HomeChatDataCenter.CleanAllChatData = function(self)
  -- function num : 0_13
  self.homeChatDatalist = {}
  self.newChatDataNum = 0
end

HomeChatDataCenter.ValidInputChange = function(self, str)
  -- function num : 0_14 , upvalues : _ENV
  if self.MAX_INPUT_LENGTH < (string.len)(str) then
    return false, (string.sub)(str, 1, self.MAX_INPUT_LENGTH)
  end
  return true, str
end

HomeChatDataCenter.ValidSendChat = function(self, str)
  -- function num : 0_15 , upvalues : _ENV
  str = (string.trim)(str)
  if (string.len)(str) <= 0 then
    return false
  end
  return true
end

HomeChatDataCenter.ValidSendTime = function(self)
  -- function num : 0_16 , upvalues : _ENV
  if self.sendCd ~= nil and self.sendCd > 0 then
    return false
  end
  local now = PlayerDataCenter.timestamp
  local cdChatNum = 0
  local cdTimeSpace = 0
  for level,cfg in ipairs(ConfigData.chat_cd) do
    if self.curCDLevel < level or level == #ConfigData.chat_cd then
      cdChatNum = cfg.message
      cdTimeSpace = cfg.time
      break
    end
  end
  do
    self.lastSendN = (self.lastSendN or 0) + 1
    if self.lastSendN == 1 then
      self.lastSendTimeStamp = now
    end
    if cdChatNum <= self.lastSendN then
      if now - self.lastSendTimeStamp < cdTimeSpace then
        self.lastSendN = 0
        if self.curCDLevel + 1 < #ConfigData.chat_cd then
          self.curCDLevel = self.curCDLevel + 1
        end
        self.sendCd = (math.ceil)(cdTimeSpace - (now - self.lastSendTimeStamp))
        self.lastSendTimeStamp = now
        self:StartChatCDTimer()
      else
        self.curCDLevel = 0
        self.lastSendTimeStamp = now
        self.lastSendN = 0
      end
    end
    return true
  end
end

HomeChatDataCenter.StartChatCDTimer = function(self)
  -- function num : 0_17 , upvalues : _ENV
  TimerManager:StopTimer(self.timerId)
  self.timerId = TimerManager:StartTimer(1, function()
    -- function num : 0_17_0 , upvalues : _ENV, self
    for callback,_ in pairs(self.OnCdChangeCallbackDic) do
      self.sendCd = self.sendCd - 1
      callback(self.sendCd)
      if self.sendCd <= 0 then
        self.sendCd = nil
        TimerManager:StopTimer(self.timerId)
      end
    end
  end
, self, false, false, false)
end

HomeChatDataCenter.Delete = function(self)
  -- function num : 0_18 , upvalues : _ENV
  TimerManager:StopTimer(self.timerId)
end

return HomeChatDataCenter

