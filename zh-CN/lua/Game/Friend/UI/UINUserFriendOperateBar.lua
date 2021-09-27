local UINUserFriendOperateBar = class("UINUserFriendOperateBar", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local eFriendEnum = require("Game.Friend.eFriendEnum")
local eFriendUIState = eFriendEnum.eFriendUIState
UINUserFriendOperateBar.ctor = function(self, friendNetworkCtrl)
  -- function num : 0_0
  self.friendNetworkCtrl = friendNetworkCtrl
end

UINUserFriendOperateBar.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.friendDataCenter = PlayerDataCenter.friendDataCenter
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Require, self, self.OnClickAddFriend)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Delete, self, self.OnClickDeleteFriend)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Cancle, self, self.OnClickCanacle)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnClickConfirm)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Fight, self, self.OnClickFight)
end

UINUserFriendOperateBar.RefreshFriendBar = function(self, friendUIState, userInfoData)
  -- function num : 0_2 , upvalues : eFriendUIState, _ENV
  self.userInfoData = userInfoData
  ;
  ((self.ui).obj_Wait):SetActive(false)
  if friendUIState == eFriendUIState.friendList then
    (((self.ui).btn_Require).gameObject):SetActive(false)
    ;
    (((self.ui).btn_Delete).gameObject):SetActive(true)
    ;
    (((self.ui).btn_Cancle).gameObject):SetActive(false)
    ;
    (((self.ui).btn_Confirm).gameObject):SetActive(false)
    if isGameDev then
      (((self.ui).btn_Fight).gameObject):SetActive(true)
    else
      ;
      (((self.ui).btn_Fight).gameObject):SetActive(false)
    end
  else
    if friendUIState == eFriendUIState.friendApplication then
      (((self.ui).btn_Require).gameObject):SetActive(false)
      ;
      (((self.ui).btn_Delete).gameObject):SetActive(false)
      ;
      (((self.ui).btn_Cancle).gameObject):SetActive(true)
      ;
      (((self.ui).btn_Confirm).gameObject):SetActive(true)
      ;
      (((self.ui).btn_Fight).gameObject):SetActive(false)
    else
      if friendUIState == eFriendUIState.searchResult then
        (((self.ui).btn_Require).gameObject):SetActive(true)
        ;
        (((self.ui).btn_Delete).gameObject):SetActive(false)
        ;
        (((self.ui).btn_Cancle).gameObject):SetActive(false)
        ;
        (((self.ui).btn_Confirm).gameObject):SetActive(false)
        ;
        (((self.ui).btn_Fight).gameObject):SetActive(false)
      else
        if friendUIState == eFriendUIState.searchSelf then
          (((self.ui).btn_Require).gameObject):SetActive(false)
          ;
          (((self.ui).btn_Delete).gameObject):SetActive(false)
          ;
          (((self.ui).btn_Cancle).gameObject):SetActive(false)
          ;
          (((self.ui).btn_Confirm).gameObject):SetActive(false)
          ;
          (((self.ui).btn_Fight).gameObject):SetActive(false)
        end
      end
    end
  end
end

UINUserFriendOperateBar.OnClickDeleteFriend = function(self)
  -- function num : 0_3 , upvalues : cs_MessageCommon, _ENV
  (cs_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(TipContent.Friend_DeleteAlert), function()
    -- function num : 0_3_0 , upvalues : self
    if (self.friendDataCenter):TryGetFriendData((self.userInfoData):GetUserUID()) ~= nil then
      (self.friendNetworkCtrl):CS_FRIEND_DissolveFriend((self.userInfoData):GetUserUID())
    end
  end
, nil)
end

UINUserFriendOperateBar.OnClickConfirm = function(self)
  -- function num : 0_4 , upvalues : cs_MessageCommon, _ENV
  if self:__JudgeIsApplyOutOfData() then
    return 
  end
  if (self.friendDataCenter):GetIsFriendFull() then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Friend_AddFailure))
    self:OnClickCanacle()
    return 
  end
  ;
  (self.friendNetworkCtrl):CS_FRIEND_AgreeApply((self.userInfoData):GetUserUID(), function(args)
    -- function num : 0_4_0 , upvalues : self
    local isSuccess = nil
    if args ~= nil and args.Count > 0 then
      isSuccess = args[0]
    else
      return 
    end
    if isSuccess then
      (self.friendDataCenter):UpdateFriendApplyReddotNum()
    else
      ;
      (self.friendDataCenter):DeleteApplyNotice((self.userInfoData):GetUserUID())
    end
  end
)
end

UINUserFriendOperateBar.OnClickCanacle = function(self)
  -- function num : 0_5
  if self:__JudgeIsApplyOutOfData(true) then
    return 
  end
  local uid = (self.userInfoData):GetUserUID()
  ;
  (self.friendNetworkCtrl):CS_FRIEND_IgnoreApply(uid, function()
    -- function num : 0_5_0 , upvalues : self, uid
    (self.friendDataCenter):DeleteApplyNotice(uid)
  end
)
end

UINUserFriendOperateBar.OnClickAddFriend = function(self)
  -- function num : 0_6 , upvalues : cs_MessageCommon, _ENV
  if (self.friendDataCenter):GetIsFriendFull() then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Friend_FriendListIsFull))
    return 
  end
  ;
  (self.friendNetworkCtrl):CS_FRIEND_ApplyFriend((self.userInfoData):GetUserUID(), function()
    -- function num : 0_6_0 , upvalues : self
    ((self.ui).obj_Wait):SetActive(true)
    ;
    (((self.ui).btn_Require).gameObject):SetActive(false)
    ;
    (((self.ui).btn_Delete).gameObject):SetActive(false)
    ;
    (((self.ui).btn_Cancle).gameObject):SetActive(false)
    ;
    (((self.ui).btn_Confirm).gameObject):SetActive(false)
  end
)
end

UINUserFriendOperateBar.OnClickFight = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local myUserData = PlayerDataCenter.inforData
  local opUserData = (self.friendDataCenter):TryGetFriendData((self.userInfoData):GetUserUID())
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight, true)
  dormFightCtrl:EnterScene(myUserData, opUserData)
end

UINUserFriendOperateBar.__JudgeIsApplyOutOfData = function(self, notPopMsg)
  -- function num : 0_8 , upvalues : cs_MessageCommon, _ENV
  if (self.userInfoData):GetIsApplicationTimeOut() then
    if not notPopMsg then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Friend_AppExpire))
    end
    ;
    (self.friendDataCenter):DeleteApplyNotice((self.userInfoData):GetUserUID())
    return true
  end
end

UINUserFriendOperateBar.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnDelete)(self)
end

return UINUserFriendOperateBar

