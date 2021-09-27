local UINChatElement = class("UINChatElement", UIBaseNode)
local base = UIBaseNode
local CS_LayoutRebuilder = ((CS.UnityEngine).UI).LayoutRebuilder
UINChatElement.OnInit = function(self)
  -- function num : 0_0
  self.chatItem = nil
  self.chatData = nil
  self.indexInList = nil
end

UINChatElement.InitChatElement = function(self, myPool, otherPool)
  -- function num : 0_1
  self.myPool = myPool
  self.otherPool = otherPool
end

UINChatElement.RefreshChatItem = function(self, chatData, index)
  -- function num : 0_2
  self:OnRecycle()
  self.chatData = chatData
  self.indexInList = index
  if chatData.isSelf then
    self.chatItem = (self.myPool):GetOne()
  else
    self.chatItem = (self.otherPool):GetOne()
  end
  ;
  ((self.chatItem).transform):SetParent(self.transform, false)
  ;
  (self.chatItem):SetChatData(chatData)
end

UINChatElement.OnRecycle = function(self)
  -- function num : 0_3
  if self.chatItem ~= nil then
    if (self.chatData).isSelf then
      (self.myPool):HideOne(self.chatItem)
    else
      ;
      (self.otherPool):HideOne(self.chatItem)
    end
    self.chatItem = nil
  end
end

UINChatElement.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINChatElement

