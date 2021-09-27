local UINHomeUp = class("UINHomeUp", UIBaseNode)
local base = UIBaseNode
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UINHomeResourceItem = require("Game.Home.UI.UINHomeResourceItem")
local UINHomeGeneralBtn = require("Game.Home.UI.UINHomeGeneralBtn")
UINHomeUp.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINResourceGroup
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.resourceGroup = (UINResourceGroup.New)()
  ;
  (self.resourceGroup):Init((self.ui).obj_resourceGroup)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Mail, self, self.OnClickMail)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Setting, self, self.OnClickSetting)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_userInfo, self, self.OnClickUserInfo)
end

UINHomeUp.InitHomeUpNode = function(self, homeUI)
  -- function num : 0_1
  self.homeUI = homeUI
  self.homeController = homeUI.homeController
  self:RefershUserInfo()
  self:RefreshMailBtn()
end

UINHomeUp.OnHomeShow = function(self)
  -- function num : 0_2
end

UINHomeUp.RefershUserInfo = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_CommanderInformation)
  ;
  (((self.ui).tex_UserName).gameObject):SetActive(isUnlock)
  ;
  (((self.ui).tex_UserID).gameObject):SetActive(isUnlock)
  ;
  (((self.ui).tex_UserLevel).gameObject):SetActive(isUnlock)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).btn_userInfo).enabled = isUnlock
  if not isUnlock then
    return 
  end
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_UserName).text = PlayerDataCenter.playerName
  ;
  ((self.ui).tex_UserID):SetIndex(0, PlayerDataCenter.strPlayerId)
  local curLevel = (PlayerDataCenter.playerLevel).level or 1
  local empty = ""
  if curLevel <= 9 then
    empty = "0"
  end
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_UserLevel).text = empty .. tostring(curLevel)
end

UINHomeUp.RefreshMailBtn = function(self)
  -- function num : 0_4 , upvalues : UINHomeGeneralBtn, _ENV
  if self.mailBtn == nil then
    self.mailBtn = (UINHomeGeneralBtn.New)()
    ;
    (self.mailBtn):Init(((self.ui).btn_Mail).gameObject)
    ;
    (self.homeController):AddRedDotEvent((self.mailBtn):GetRedDotFunc(), RedDotStaticTypeId.Main, RedDotStaticTypeId.Mail)
  end
  local isUnlock, unlockDes = (self.homeController):IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Mail)
  ;
  (self.mailBtn):RefeshUnlockInfo(isUnlock)
  local moveX = 0
  local mailActive = (((self.ui).btn_Mail).gameObject).activeSelf
  if not isUnlock and mailActive then
    moveX = 135
  else
    if isUnlock and not mailActive then
      moveX = -135
    end
  end
  local resPos = (((self.ui).obj_resourceGroup).transform).localPosition
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (((self.ui).obj_resourceGroup).transform).localPosition = (Vector3.New)(resPos.x + moveX, resPos.y, resPos.z)
  ;
  (((self.ui).btn_Mail).gameObject):SetActive(isUnlock)
end

UINHomeUp.OnClickMail = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if (self.mailBtn).isUnlock then
    UIManager:ShowWindowAsync(UIWindowTypeID.Mail, function(win)
    -- function num : 0_5_0 , upvalues : self, _ENV
    if win ~= nil then
      (self.homeUI):OpenOtherCoverWin()
      win:SetFromWhichUI(eBaseWinFromWhere.homeCorver)
    end
  end
)
  end
end

UINHomeUp.OnClickSetting = function(self)
  -- function num : 0_6 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.Setting, function(win)
    -- function num : 0_6_0 , upvalues : self, _ENV
    if win ~= nil then
      (self.homeUI):OpenOtherCoverWin()
      win:SetFromWhichUI(eBaseWinFromWhere.homeCorver)
      win:InitSettingByFrom(UIWindowTypeID.homeCorver)
    end
  end
)
end

UINHomeUp.OnClickUserInfo = function(self)
  -- function num : 0_7 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.UserInfo, function(win)
    -- function num : 0_7_0 , upvalues : self, _ENV
    if win ~= nil then
      (self.homeUI):OpenOtherWin()
      win:SetFromWhichUI(eBaseWinFromWhere.home)
      win:InitUserInfo()
    end
  end
)
end

UINHomeUp.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (self.resourceGroup):Delete()
  ;
  (base.OnDelete)(self)
end

return UINHomeUp

