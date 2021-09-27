local HomeChatData = class("HomeChatData")
HomeChatData.ctor = function(self)
  -- function num : 0_0
  self.isSelf = false
  self.senderInfo = nil
  self.isSinglePicture = false
  self.content = nil
  self.singlePicResName = nil
  self.__uiLayoutHeight = 0
end

HomeChatData.CreateChatData = function(isSelf, isSinglePicture, content, singlePicResName)
  -- function num : 0_1 , upvalues : HomeChatData
  local data = (HomeChatData.New)()
  data.isSelf = isSelf
  data.isSinglePicture = isSinglePicture
  data.content = content
  data.singlePicResName = singlePicResName
  return data
end

HomeChatData.GetIsSinglePicture = function(self)
  -- function num : 0_2
  return self.isSinglePicture
end

HomeChatData.GetContent = function(self)
  -- function num : 0_3
  return self.content
end

HomeChatData.GetContent4Home = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self:GetIsSinglePicture() then
    return ConfigData:GetTipContent(TipContent.ChatemojiReplace)
  end
  return self.content
end

HomeChatData.GetSinglePicResName = function(self)
  -- function num : 0_5
  return self.singlePicResName
end

return HomeChatData

