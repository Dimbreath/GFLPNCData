local UINSupportHeroItem = class("UINSupportHeroItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
UINSupportHeroItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINHeroCardItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SelDetail, self, self.OnClickSupportorInfo)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Use, self, self.OnClickUse)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_FriendInfo, self, self.OnClickFriendInfo)
  self.heroCard = (UINHeroCardItem.New)()
  ;
  (self.heroCard):Init((self.ui).uINHeroItem)
  self.expiredData = nil
end

UINSupportHeroItem.InitSupportHeroCard = function(self, friednSupportHeroData, useCardCallback, resloader, normalHeroDic)
  -- function num : 0_1 , upvalues : _ENV
  self.friednSupportHeroData = friednSupportHeroData
  self.useCardCallback = useCardCallback
  self.expiredData = friednSupportHeroData.expiredSupport
  ;
  (self.heroCard):InitHeroCardItem(friednSupportHeroData, resloader, nil, nil)
  ;
  (self.heroCard):SetEfficiencyActive(true)
  self:RefreshUserInfo(resloader)
  if self.expiredData ~= nil then
    ((self.ui).obj_img_SameHero):SetActive(true)
    ;
    ((self.ui).tex_Tip):SetIndex(1, tostring((self.expiredData).nextUseTurn))
  else
    ;
    ((self.ui).obj_img_SameHero):SetActive(false)
  end
end

UINSupportHeroItem.RefreshUserInfo = function(self, resloader)
  -- function num : 0_2 , upvalues : _ENV
  local userInfoData = (self.friednSupportHeroData):GetUserInfo()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_UserName).text = userInfoData:GetUserName()
  ;
  ((self.ui).tex_UserLv):SetIndex(0, tostring(userInfoData:GetUserLevel()))
  ;
  ((self.ui).img_Recommend):SetActive(not userInfoData:GetIsFriend())
  local avatarId = userInfoData:GetAvatarId()
  if avatarId == nil then
    return 
  end
  local cfg = (ConfigData.portrait)[avatarId]
  if cfg == nil then
    return 
  end
  local icon = cfg.icon
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R6 in 'UnsetPending'

  if (string.IsNullOrEmpty)(icon) ~= nil then
    ((self.ui).img_UserHead).sprite = CRH:GetSprite(icon, CommonAtlasType.HeroHeadIcon)
  end
  local avatarFrameId = userInfoData:GetAvatarFrameId()
  if avatarFrameId == nil then
    return 
  end
  local cfg = (ConfigData.portrait_frame)[avatarFrameId]
  if cfg == nil then
    return 
  end
  local icon = cfg.icon
  -- DECOMPILER ERROR at PC83: Confused about usage of register: R9 in 'UnsetPending'

  if (string.IsNullOrEmpty)(icon) ~= nil and CRH:GetSprite(icon) ~= nil then
    ((self.ui).img_Frame).sprite = CRH:GetSprite(icon, CommonAtlasType.HeroHeadIcon)
  end
end

UINSupportHeroItem.OnClickSupportorInfo = function(self)
  -- function num : 0_3 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.SupportHeroState, function(win)
    -- function num : 0_3_0 , upvalues : self
    if win == nil then
      return 
    end
    win:InitSupportHeroState(self.friednSupportHeroData)
  end
)
end

UINSupportHeroItem.OnClickUse = function(self)
  -- function num : 0_4 , upvalues : cs_MessageCommon, _ENV
  if self.expiredData ~= nil then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Support_CanNotUseSameSupport))
    return 
  end
  if self.useCardCallback ~= nil then
    (self.useCardCallback)(self)
  end
end

UINSupportHeroItem.OnClickFriendInfo = function(self)
  -- function num : 0_5 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonUserInfo, function(win)
    -- function num : 0_5_0 , upvalues : self
    if win == nil then
      return 
    end
    win:InitUserInfoView((self.friednSupportHeroData):GetUserInfo())
  end
)
end

UINSupportHeroItem.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (base.OnDelete)(self)
end

return UINSupportHeroItem

