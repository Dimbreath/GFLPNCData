local UISideAddFriend = class("UISideAddFriend", UIBaseWindow)
local base = UIBaseWindow
local cs_MessageCommon = CS.MessageCommon
UISideAddFriend.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_Cancel, self, self.OnCLickCancle)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnClickAddFriend)
end

UISideAddFriend.InitAddHeroSide = function(self, userUID, resLoader)
  -- function num : 0_1 , upvalues : _ENV
  self.resLoader = resLoader
  ;
  (((self.ui).btn_Cancel).gameObject):SetActive(false)
  ;
  (((self.ui).btn_Confirm).gameObject):SetActive(false)
  PlayerDataCenter:GetUserInfoByUID(userUID, function(userData)
    -- function num : 0_1_0 , upvalues : self
    if userData == nil then
      return 
    end
    if userData:GetIsFriend() then
      return 
    end
    ;
    ((self.ui).inTween):DOPlay()
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).text = userData:GetUserName()
    self:RefreshUserHead(userData:GetAvatarId())
    self:RefreshUserHeadFrame(userData:GetAvatarFrameId())
    self.userData = userData
    ;
    (((self.ui).btn_Cancel).gameObject):SetActive(true)
    ;
    (((self.ui).btn_Confirm).gameObject):SetActive(true)
  end
)
end

UISideAddFriend.OnCLickCancle = function(self)
  -- function num : 0_2
  self:Delete()
end

UISideAddFriend.OnClickAddFriend = function(self)
  -- function num : 0_3 , upvalues : _ENV, cs_MessageCommon
  if (PlayerDataCenter.friendDataCenter):GetIsFriendFull() then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Friend_AddFailure))
    self:Delete()
    return 
  end
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Friend)):CS_FRIEND_ApplyFriend((self.userData):GetUserUID(), function()
    -- function num : 0_3_0 , upvalues : self
    self:Delete()
  end
)
end

UISideAddFriend.RefreshUserHead = function(self, avatarId)
  -- function num : 0_4 , upvalues : _ENV
  if avatarId == nil then
    return 
  end
  local cfg = (ConfigData.portrait)[avatarId]
  if cfg == nil then
    return 
  end
  local icon = cfg.icon
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

  if (string.IsNullOrEmpty)(icon) ~= nil then
    ((self.ui).img_UserHead).sprite = CRH:GetSprite(icon, CommonAtlasType.HeroHeadIcon)
  end
end

UISideAddFriend.RefreshUserHeadFrame = function(self, avatarFrameId)
  -- function num : 0_5 , upvalues : _ENV
  if avatarFrameId == nil then
    return 
  end
  local cfg = (ConfigData.portrait_frame)[avatarFrameId]
  if cfg == nil then
    return 
  end
  local icon = cfg.icon
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

  if (string.IsNullOrEmpty)(icon) ~= nil then
    ((self.ui).img_Frame).sprite = CRH:GetSprite(icon, CommonAtlasType.HeroHeadIcon)
  end
end

UISideAddFriend.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UISideAddFriend

