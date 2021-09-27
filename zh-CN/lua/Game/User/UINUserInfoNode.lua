local UINUserInfoNode = class("UINUserInfoNode", UIBaseNode)
local base = UIBaseNode
local UINUserInfoBottomItem = require("Game.User.UINUserInfoBottomItem")
local UINUserInfoSupportHeroNode = require("Game.User.UINUserInfoSupportHeroNode")
local newBottomItemTab = {
[1] = {func = function(userInfoData)
  -- function num : 0_0 , upvalues : _ENV
  local totalCount = (ConfigData.hero_data).totalHeroCount
  return tostring(userInfoData:GetHasHeroNum()) .. "<color=#777777><size=36>/" .. tostring(totalCount) .. "</size></color>"
end
}
, 
[2] = {func = function(userInfoData)
  -- function num : 0_1 , upvalues : _ENV
  local epProgress = userInfoData:GetEpProgress()
  if epProgress.sectorId == nil or epProgress.stageIndex == nil then
    return "NO PASS"
  end
  return "STAGE " .. tostring(epProgress.sectorId) .. "-" .. tostring(epProgress.stageIndex)
end
}
, 
[3] = {func = function(userInfoData)
  -- function num : 0_2 , upvalues : _ENV
  return tostring(userInfoData:GetInfinityLevelSum()) .. "m"
end
}
, 
[4] = {func = function(userInfoData)
  -- function num : 0_3 , upvalues : _ENV
  local totalLevel = userInfoData:GetBuildingTotalLevel()
  return "Lv." .. tostring(totalLevel)
end
}
}
UINUserInfoNode.OnInit = function(self)
  -- function num : 0_4 , upvalues : _ENV, UINUserInfoSupportHeroNode
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CopyUID, self, self._OnCopyUIDClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ChangeName, self, self._OnChangeNameClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_UINUserHead, self, self._OpenChangeUserHead)
  ;
  ((self.ui).obj_bottomInfoListItem):SetActive(false)
  ;
  ((self.ui).obj_supportHeroItem):SetActive(false)
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_PlacerHolder).text = ConfigData:GetTipContent((ConfigData.game_config).playerDefaultSignatureId)
  self.supportPool = (UIItemPool.New)(UINUserInfoSupportHeroNode, (self.ui).obj_supportHeroItem)
  self:_InitGameVersion()
  self.__OnHeroUpdate = BindCallback(self, self._OnHeroUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__OnHeroUpdate)
end

UINUserInfoNode._InitGameVersion = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local hasHotUpdateVer = (CS.ClientConsts).GameVersionStr
  ;
  ((self.ui).tex_Version):SetIndex(0, hasHotUpdateVer)
end

UINUserInfoNode.RefershInfoNode = function(self, userInfoData, changeNameAction, resLoader, couldEditSelf)
  -- function num : 0_6
  self.userInfoData = userInfoData
  self.resLoader = resLoader
  self.couldEditSelf = couldEditSelf
  self:_RefreshDiffWithOtherUser()
  self:SetChangeNameBtnActive(changeNameAction)
  self:_RefreshUserInfo()
  self:_RefreshExperience()
  self:RefreshSupport()
end

UINUserInfoNode.UpdateInfoNode = function(self)
  -- function num : 0_7
  if self.userInfoData == nil then
    return 
  end
  self:_RefreshUserInfo()
  self:_RefreshExperience()
  self:RefreshSupport()
end

UINUserInfoNode._RefreshDiffWithOtherUser = function(self)
  -- function num : 0_8
  local isSelf = (self.userInfoData):GetIsSelfUserInfo()
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  if isSelf then
    ((self.ui).input_Signature).interactable = self.couldEditSelf
  end
end

UINUserInfoNode._RefreshUserInfo = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local userInfoData = self.userInfoData
  self:RefreshUserName(userInfoData:GetUserName())
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_UID).text = "UID:" .. userInfoData:GetUserUID()
  self:RefreshUserHead(userInfoData:GetAvatarId())
  self:RefreshUserHeadFrame(userInfoData:GetAvatarFrameId())
  self:RefreshUserSignature(userInfoData:GetAvatarSignature())
  self:RefreshDressUp(userInfoData:GetBackgroudPlateId())
  self:RefreshUserLevel(userInfoData:GetUserLevel())
  local timeDate = TimestampToDate(userInfoData:GetCreateTime())
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_CreateTime).text = timeDate.year .. "-" .. timeDate.month .. "-" .. timeDate.day
end

UINUserInfoNode.RefreshUserLevel = function(self, tempLv)
  -- function num : 0_10 , upvalues : _ENV
  if tempLv >= 10 or not "LV.0" .. tostring(tempLv) then
    local strLv = "LV." .. tostring(tempLv)
  end
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Level).text = strLv
end

UINUserInfoNode.SaveUserSignature = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if (self.userInfoData):GetAvatarSignature() ~= ((self.ui).input_Signature).text then
    local text = ((self.ui).input_Signature).text
    ;
    (NetworkManager:GetNetwork(NetworkTypeID.Object)):CS_User_SignatureMod(text)
  end
end

UINUserInfoNode._RefreshExperience = function(self)
  -- function num : 0_12 , upvalues : _ENV, UINUserInfoBottomItem, newBottomItemTab
  if self.bottomInfoPool == nil then
    self.bottomInfoPool = (UIItemPool.New)(UINUserInfoBottomItem, (self.ui).obj_bottomInfoListItem)
  else
    ;
    (self.bottomInfoPool):HideAll()
  end
  for index,tab in ipairs(newBottomItemTab) do
    local item = (self.bottomInfoPool):GetOne()
    item:InitUserInfoBottomItem(index, tab.func, nil, self.userInfoData)
  end
end

UINUserInfoNode.RefreshDressUp = function(self, backgroudPlateId)
  -- function num : 0_13 , upvalues : _ENV
  local resCfg = (ConfigData.portrait_card)[backgroudPlateId]
  ;
  (((self.ui).img_DressUp).gameObject):SetActive(false)
  if resCfg == nil then
    return 
  end
  local resName = resCfg.icon
  if self.softMaskMat == nil then
    self.softMaskMat = (((CS.UnityEngine).Object).Instantiate)((self.ui).mat_softMask)
    ;
    (self.softMaskMat):SetFloat("_clipSoftX", 400)
    ;
    (self.softMaskMat):SetFloat("_clipSoftY", 1)
  end
  if self.dressUpResloader ~= nil then
    (self.dressUpResloader):Put2Pool()
    self.dressUpResloader = nil
  end
  self.dressUpResloader = ((CS.ResLoader).Create)()
  local path = PathConsts:GetUserDressUpPath(resName)
  ;
  (self.dressUpResloader):LoadABAssetAsync(path, function(texture)
    -- function num : 0_13_0 , upvalues : _ENV, self
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    if not IsNull(texture) then
      ((self.ui).img_DressUp).texture = texture
      ;
      (((self.ui).img_DressUp).gameObject):SetActive(true)
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((self.ui).img_DressUp).material = self.softMaskMat
    end
  end
)
end

UINUserInfoNode.RefreshUserName = function(self, strUserName)
  -- function num : 0_14 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_Name).text = tostring(strUserName)
end

UINUserInfoNode.RefreshUserHead = function(self, avatarId)
  -- function num : 0_15 , upvalues : _ENV
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

UINUserInfoNode.RefreshUserHeadFrame = function(self, avatarFrameId)
  -- function num : 0_16 , upvalues : _ENV
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

UINUserInfoNode.RefreshUserSignature = function(self, strSignature)
  -- function num : 0_17 , upvalues : _ENV
  if strSignature == nil then
    return 
  end
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).input_Signature).text = tostring(strSignature)
end

UINUserInfoNode.RefreshSupport = function(self)
  -- function num : 0_18 , upvalues : _ENV
  (self.supportPool):HideAll()
  for index,supportHeroInfo in ipairs((self.userInfoData):GetSupportHoreInfoList()) do
    local item = (self.supportPool):GetOne()
    item:InitSupportHero(index, self.userInfoData, self.resLoader, self.couldEditSelf)
  end
end

UINUserInfoNode._OnCopyUIDClick = function(self)
  -- function num : 0_19 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ((CS.UnityEngine).GUIUtility).systemCopyBuffer = (self.userInfoData):GetUserUID()
  ;
  ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(TipContent.UserInfo_CopyUIDDone))
  AudioManager:PlayAudioById(1124)
end

UINUserInfoNode._OnChangeNameClick = function(self)
  -- function num : 0_20
  if not (self.userInfoData):GetIsSelfUserInfo() or not self.couldEditSelf then
    return 
  end
  if self._changeNameAction ~= nil then
    (self._changeNameAction)()
  end
end

UINUserInfoNode.SetChangeNameBtnActive = function(self, changeNameAction)
  -- function num : 0_21
  if changeNameAction == nil then
    (((self.ui).btn_ChangeName).gameObject):SetActive(false)
    return 
  end
  ;
  (((self.ui).btn_ChangeName).gameObject):SetActive(true)
  self._changeNameAction = changeNameAction
end

UINUserInfoNode._OpenChangeUserHead = function(self)
  -- function num : 0_22 , upvalues : _ENV
  if not (self.userInfoData):GetIsSelfUserInfo() or not self.couldEditSelf then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.UserInfoDialog, function(window)
    -- function num : 0_22_0
    if window ~= nil then
      window:OpenChangeUserHeadDialog()
    end
  end
)
end

UINUserInfoNode._OnHeroUpdate = function(self)
  -- function num : 0_23 , upvalues : _ENV
  for _,nodeItem in pairs((self.supportPool).listItem) do
    nodeItem:RefreshSupportHero()
  end
end

UINUserInfoNode.OnDelete = function(self)
  -- function num : 0_24 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__OnHeroUpdate)
  if self.softMaskMat ~= nil then
    DestroyUnityObject(self.softMaskMat)
    self.softMaskMat = nil
  end
  if self.dressUpResloader ~= nil then
    (self.dressUpResloader):Put2Pool()
    self.dressUpResloader = nil
  end
  if self.bottomInfoPool ~= nil then
    (self.bottomInfoPool):DeleteAll()
  end
  if self.supportPool ~= nil then
    (self.supportPool):DeleteAll()
  end
  ;
  (base.OnDelete)(self)
end

return UINUserInfoNode

