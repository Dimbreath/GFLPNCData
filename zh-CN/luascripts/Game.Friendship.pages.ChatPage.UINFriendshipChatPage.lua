-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFriendshipChatPage = class("UINFriendshipChatPage", UIBaseNode)
local base = UIBaseNode
local UINFriendshipChatPageFriendList = require("Game.Friendship.pages.ChatPage.UINFriendshipChatPageFriendList")
local UINFriendshipChatPageChatDetail = require("Game.Friendship.pages.ChatPage.UINFriendshipChatPageChatDetail")
UINFriendshipChatPage.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.resloader = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINFriendshipChatPage.LaterInit = function(self, resloader)
  -- function num : 0_1 , upvalues : UINFriendshipChatPageChatDetail, UINFriendshipChatPageFriendList
  self.resloader = resloader
  self.chatDetail = (UINFriendshipChatPageChatDetail.New)()
  ;
  (self.chatDetail):Init((self.ui).obj_message)
  ;
  (self.chatDetail):InitChatDetail(self.resloader)
  self.friendList = (UINFriendshipChatPageFriendList.New)()
  ;
  (self.friendList):Init((self.ui).obj_iMChatList)
  ;
  (self.friendList):InitFriendList(self.resloader, (self.chatDetail).GetHeroData)
end

UINFriendshipChatPage.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (self.chatDetail):Delete()
  ;
  (self.friendList):Delete()
  ;
  (base.OnDelete)(self)
end

return UINFriendshipChatPage

