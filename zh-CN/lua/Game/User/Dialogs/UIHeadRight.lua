local UIHeadRight = class("UIHeadRight", UIBaseNode)
local base = UIBaseNode
UIHeadRight.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnChangeConfirm)
  self.isHead = true
  self.infoUI = UIManager:GetWindow(UIWindowTypeID.UserInfo)
  self.savedHeadItem = nil
  self.savedHeadFrameItem = nil
end

UIHeadRight.BindCloseFun = function(self, onCloseCallback)
  -- function num : 0_1
  self._onCloseCallback = onCloseCallback
end

UIHeadRight.OnChangeConfirm = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.infoUI == nil then
    self.infoUI = UIManager:GetWindow(UIWindowTypeID.UserInfo)
  end
  if self.savedHeadItem ~= nil and (self.savedHeadItem).id ~= (PlayerDataCenter.inforData).avatarId then
    (NetworkManager:GetNetwork(NetworkTypeID.Object)):CS_User_AvatarModify((self.savedHeadItem).id, function()
    -- function num : 0_2_0 , upvalues : self
    (self.infoUI):RefreshUserHead((self.savedHeadItem).id)
  end
)
  end
  if self.savedHeadFrameItem ~= nil and (self.savedHeadFrameItem).id ~= (PlayerDataCenter.inforData).avatarFrameId then
    (NetworkManager:GetNetwork(NetworkTypeID.Object)):CS_User_AvatarFrameMod((self.savedHeadFrameItem).id, function()
    -- function num : 0_2_1 , upvalues : self
    (self.infoUI):RefreshUserHeadFrame((self.savedHeadFrameItem).id)
  end
)
  end
  ;
  (self._onCloseCallback)()
end

UIHeadRight.SaveHead = function(self, itemHeadCfg)
  -- function num : 0_3
  if itemHeadCfg == nil or (self.itemHeadCfg).count == 0 then
    self.savedHeadItem = nil
    return 
  end
  self.savedHeadItem = itemHeadCfg
end

UIHeadRight.SaveHeadFrame = function(self, itemHeadFrameCfg)
  -- function num : 0_4
  if itemHeadFrameCfg == nil or (self.itemHeadFrameCfg).count == 0 then
    self.savedHeadFrameItem = nil
    return 
  end
  self.savedHeadFrameItem = itemHeadFrameCfg
end

UIHeadRight.changeHeadState = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.itemHeadCfg ~= nil and (self.itemHeadCfg).cfg ~= nil then
    self.resHeadName = ((self.itemHeadCfg).cfg).icon
  else
    return 
  end
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  if (string.IsNullOrEmpty)(self.resHeadName) ~= nil then
    ((self.ui).img_UserHead).sprite = CRH:GetSprite(self.resHeadName, CommonAtlasType.HeroHeadIcon)
  end
  if (self.itemHeadCfg).count == 0 then
    (((self.ui).btn_Confirm).gameObject):SetActive(false)
    ;
    ((self.ui).img_Locked):SetActive(true)
    ;
    (((self.ui).tex_CurEquip).gameObject):SetActive(false)
  else
    ;
    (((self.ui).btn_Confirm).gameObject):SetActive(true)
    ;
    ((self.ui).img_Locked):SetActive(false)
    ;
    (((self.ui).tex_CurEquip).gameObject):SetActive(true)
  end
  ;
  (((self.ui).tex_Condition).gameObject):SetActive(true)
  -- DECOMPILER ERROR at PC81: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Condition).text = (LanguageUtil.GetLocaleText)(((self.itemHeadCfg).cfg).describe_name)
  -- DECOMPILER ERROR at PC90: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_ItemName).text = (LanguageUtil.GetLocaleText)(((self.itemHeadCfg).cfg).name)
end

UIHeadRight.changeHeadFrameState = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self.itemHeadFrameCfg ~= nil and (self.itemHeadFrameCfg).cfg ~= nil then
    self.resHeadFrameName = ((self.itemHeadFrameCfg).cfg).icon
  else
    ;
    (((self.ui).img_Frame).gameObject):SetActive(false)
    return 
  end
  if (string.IsNullOrEmpty)(self.resHeadFrameName) ~= nil then
    (((self.ui).img_Frame).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Frame).sprite = CRH:GetSprite(self.resHeadFrameName, CommonAtlasType.HeroHeadIcon)
  end
  if (self.itemHeadFrameCfg).count == 0 then
    (((self.ui).btn_Confirm).gameObject):SetActive(false)
    ;
    ((self.ui).img_Locked):SetActive(true)
    ;
    (((self.ui).tex_CurEquip).gameObject):SetActive(false)
  else
    ;
    (((self.ui).btn_Confirm).gameObject):SetActive(true)
    ;
    ((self.ui).img_Locked):SetActive(false)
    ;
    (((self.ui).tex_CurEquip).gameObject):SetActive(true)
  end
  ;
  (((self.ui).tex_Condition).gameObject):SetActive(true)
  -- DECOMPILER ERROR at PC93: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Condition).text = (LanguageUtil.GetLocaleText)(((self.itemHeadFrameCfg).cfg).achieve_name)
  -- DECOMPILER ERROR at PC102: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_ItemName).text = (LanguageUtil.GetLocaleText)(((self.itemHeadFrameCfg).cfg).name)
end

UIHeadRight.OnDelte = function(self)
  -- function num : 0_7 , upvalues : base
  (base.OnDelete)(self)
end

return UIHeadRight

