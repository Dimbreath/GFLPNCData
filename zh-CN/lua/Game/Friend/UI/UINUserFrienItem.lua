local UINUserFrienItem = class("UINUserFrienItem", UIBaseNode)
local base = UIBaseNode
UINUserFrienItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).friendItem, self, self.OnCliclFriendItem)
end

UINUserFrienItem.InitWithFriendData = function(self, friendData, clickCallback, resLoader)
  -- function num : 0_1
  self.friendData = friendData
  self.clickCallback = clickCallback
  self.resLoader = resLoader
  self:FrienItemRefreshUI()
end

UINUserFrienItem.FrienItemRefreshUI = function(self)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tex_Name).text = (self.friendData):GetUserName()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Level).text = (self.friendData):GetUserLevel()
  self:RefreshUserHead((self.friendData):GetAvatarId())
  self:RefreshUserHeadFrame((self.friendData):GetAvatarFrameId())
  self:RefreshFrienOnlineState()
end

UINUserFrienItem.RefreshUserHead = function(self, avatarId)
  -- function num : 0_3 , upvalues : _ENV
  if avatarId == nil or avatarId == 0 then
    return 
  end
  local cfg = (ConfigData.portrait)[avatarId]
  if cfg == nil or cfg.icon == nil then
    error("can\'t read portraitCfg with id:" .. tostring(avatarId))
    return 
  end
  local icon = cfg.icon
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R4 in 'UnsetPending'

  if (string.IsNullOrEmpty)(icon) ~= nil then
    ((self.ui).img_UserHead).sprite = CRH:GetSprite(icon, CommonAtlasType.HeroHeadIcon)
  end
end

UINUserFrienItem.RefreshUserHeadFrame = function(self, avatarFrameId)
  -- function num : 0_4 , upvalues : _ENV
  if avatarFrameId == nil or avatarFrameId == 0 then
    return 
  end
  local cfg = (ConfigData.portrait_frame)[avatarFrameId]
  if cfg == nil or cfg.icon == nil then
    error("can\'t read portrait_frameCfg with id:" .. tostring(avatarFrameId))
    return 
  end
  local icon = cfg.icon
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R4 in 'UnsetPending'

  if (string.IsNullOrEmpty)(icon) ~= nil then
    ((self.ui).img_Frame).sprite = CRH:GetSprite(icon, CommonAtlasType.HeroHeadIcon)
  end
end

local ONE_DAY_TIME = 86400
UINUserFrienItem.RefreshFrienOnlineState = function(self)
  -- function num : 0_5 , upvalues : _ENV, ONE_DAY_TIME
  local lastOfflineTs = (self.friendData):GetOnlineState()
  if lastOfflineTs == nil then
    ((self.ui).onLine):SetActive(false)
    ;
    ((self.ui).offLine):SetActive(false)
    return 
  else
    if lastOfflineTs == 0 then
      ((self.ui).onLine):SetActive(true)
      ;
      ((self.ui).offLine):SetActive(false)
      return 
    end
  end
  local timeSpan = PlayerDataCenter.timestamp - lastOfflineTs
  local isBeyoundOneDay = ONE_DAY_TIME < timeSpan
  ;
  ((self.ui).onLine):SetActive(not isBeyoundOneDay)
  ;
  ((self.ui).offLine):SetActive(isBeyoundOneDay)
  do
    if isBeyoundOneDay then
      local day = (math.ceil)(timeSpan / ONE_DAY_TIME)
      ;
      ((self.ui).tex_OffLineTime):SetIndex(0, tostring(day))
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

UINUserFrienItem.OnCliclFriendItem = function(self)
  -- function num : 0_6
  if self.clickCallback ~= nil then
    (self.clickCallback)(self)
  end
end

UINUserFrienItem.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UINUserFrienItem

