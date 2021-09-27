local UIUserInfoView = class("UIUserInfoView", UIBaseWindow)
local base = UIBaseWindow
local UINUserInfoNode = require("Game.User.UINUserInfoNode")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
UIUserInfoView.OnInit = function(self)
  -- function num : 0_0 , upvalues : cs_ResLoader, _ENV, UINUserInfoNode
  self.resLoader = (cs_ResLoader.Create)()
  ;
  (UIUtil.SetTopStatus)(self, self.Delete)
  ;
  (UIUtil.AddButtonListener)((self.ui).background, self, UIUtil.OnClickBack)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Require, self, self.AddStrangerAsFriend)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Delete, self, self.OnClickDeleteFriend)
  self.friendDataCenter = PlayerDataCenter.friendDataCenter
  self.friendNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
  self.userInfoNode = (UINUserInfoNode.New)()
  ;
  (self.userInfoNode):Init((self.ui).obj_uINUserInfoNode)
  ;
  (((self.ui).btn_Require).gameObject):SetActive(false)
  ;
  (((self.ui).btn_Delete).gameObject):SetActive(false)
  ;
  ((self.ui).obj_Wait):SetActive(false)
  self._OnFriendListChange = BindCallback(self, self.RefreshUserInfo)
  MsgCenter:AddListener(eMsgEventId.OnUserFriendListChange, self._OnFriendListChange)
end

UIUserInfoView.InitUserInfoView = function(self, userInfoData)
  -- function num : 0_1
  self.userInfoData = userInfoData
  ;
  (self.userInfoNode):RefershInfoNode(userInfoData, nil, self.resLoader, false)
  local isFriend = userInfoData:GetIsFriend()
  local isSelf = userInfoData:GetIsSelfUserInfo()
  if not isFriend and not isSelf then
    (((self.ui).btn_Require).gameObject):SetActive(true)
  else
    ;
    (((self.ui).btn_Require).gameObject):SetActive(false)
  end
  if isFriend and not isSelf then
    (((self.ui).btn_Delete).gameObject):SetActive(true)
  else
    ;
    (((self.ui).btn_Delete).gameObject):SetActive(false)
  end
end

UIUserInfoView.RefreshUserInfo = function(self)
  -- function num : 0_2 , upvalues : _ENV
  PlayerDataCenter:GetUserInfoByUID((self.userInfoData):GetUserUID(), function(userInfoData)
    -- function num : 0_2_0 , upvalues : self
    self:InitUserInfoView(userInfoData)
  end
)
end

UIUserInfoView.AddStrangerAsFriend = function(self)
  -- function num : 0_3 , upvalues : cs_MessageCommon, _ENV
  if (self.friendDataCenter):GetIsFriendFull() then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Friend_AddFailure))
    return 
  end
  ;
  (self.friendNetworkCtrl):CS_FRIEND_ApplyFriend((self.userInfoData):GetUserUID(), function()
    -- function num : 0_3_0 , upvalues : self
    ((self.ui).obj_Wait):SetActive(true)
    ;
    (((self.ui).btn_Require).gameObject):SetActive(false)
  end
)
end

UIUserInfoView.OnClickDeleteFriend = function(self)
  -- function num : 0_4 , upvalues : cs_MessageCommon, _ENV
  (cs_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(TipContent.Friend_DeleteAlert), function()
    -- function num : 0_4_0 , upvalues : self
    if (self.friendDataCenter):TryGetFriendData((self.userInfoData):GetUserUID()) ~= nil then
      (self.friendNetworkCtrl):CS_FRIEND_DissolveFriend((self.userInfoData):GetUserUID(), function()
      -- function num : 0_4_0_0 , upvalues : self
      self:RefreshUserInfo()
    end
)
    end
  end
, nil)
end

UIUserInfoView.OnDelete = function(self)
  -- function num : 0_5 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnUserFriendListChange, self._OnFriendListChange)
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
    self.resLoader = nil
  end
  ;
  (self.userInfoNode):Delete()
  ;
  (base.OnDelete)(self)
end

return UIUserInfoView

