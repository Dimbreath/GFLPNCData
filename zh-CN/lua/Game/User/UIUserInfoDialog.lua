local UIUserInfoDialog = class("UIUserInfoDialog", UIBaseWindow)
local base = UIBaseWindow
local UINChangeName = require("Game.User.Dialogs.UIChangeName")
local UINChangeUserHead = require("Game.User.Dialogs.UIChangeUserHead")
local UINChangeDressUp = require("Game.User.Dialogs.UIChangeDressUp")
local UINChangePro = require("Game.User.Dialogs.UINChangePro")
UIUserInfoDialog.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_background, self, self.Cancle)
  ;
  ((self.ui).changeName):SetActive(false)
  ;
  ((self.ui).changeUserHead):SetActive(false)
  ;
  ((self.ui).changeDressUp):SetActive(false)
  ;
  ((self.ui).changeChangePro):SetActive(false)
end

UIUserInfoDialog.OpenChangeNameDialogFromStore = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINChangeName
  (UIUtil.HideTopStatus)()
  if self.changeName == nil then
    self.changeName = (UINChangeName.New)()
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self.changeName).CloseFunction = BindCallback(self, self.Cancle)
    ;
    (self.changeName):Init((self.ui).changeName)
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.changeName).isFromStore = true
  ;
  (self.changeName):Show()
end

UIUserInfoDialog.OpenChangeNameDialog = function(self)
  -- function num : 0_2 , upvalues : _ENV, UINChangeName
  (UIUtil.HideTopStatus)()
  if self.changeName == nil then
    self.changeName = (UINChangeName.New)()
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self.changeName).CloseFunction = BindCallback(self, self.Cancle)
    ;
    (self.changeName):Init((self.ui).changeName)
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.changeName).isFromStore = false
  ;
  (self.changeName):Show()
end

UIUserInfoDialog.OpenChangeUserHeadDialog = function(self)
  -- function num : 0_3 , upvalues : _ENV, UINChangeUserHead
  (UIUtil.HideTopStatus)()
  if self.changeUserHead == nil then
    self.changeUserHead = (UINChangeUserHead.New)()
    ;
    (self.changeUserHead):Init((self.ui).changeUserHead)
    ;
    (self.changeUserHead):BindCloseFun(BindCallback(self, self.Cancle))
  end
  ;
  (self.changeUserHead):Show()
end

UIUserInfoDialog.OpenChangeDressUpDialog = function(self)
  -- function num : 0_4 , upvalues : _ENV, UINChangeDressUp
  (UIUtil.HideTopStatus)()
  if self.changeDressUp == nil then
    self.changeDressUp = (UINChangeDressUp.New)()
    ;
    (self.changeDressUp):Init((self.ui).changeDressUp)
  end
  ;
  (self.changeDressUp):RefreshChangeDressUp(BindCallback(self, self.Cancle))
end

UIUserInfoDialog.OpenChangePro = function(self)
  -- function num : 0_5 , upvalues : _ENV, UINChangePro
  (UIUtil.HideTopStatus)()
  if self.changePro == nil then
    self.changePro = (UINChangePro.New)()
    ;
    (self.changePro):Init((self.ui).changeChangePro)
  end
  ;
  (self.changePro):_ShowUI()
  ;
  (self.changePro):BindCloseFun(BindCallback(self, self.Cancle))
end

UIUserInfoDialog.Cancle = function(self)
  -- function num : 0_6
  self:OnCloseWin()
  self:OnDelete()
end

UIUserInfoDialog.OnShow = function(self)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.OnShow)(self)
  AudioManager:PlayAudioById(1066)
end

UIUserInfoDialog.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  (UIUtil.ReShowTopStatus)()
  if self.changeName ~= nil then
    (self.changeName):OnDelete()
  end
  if self.changeUserHead ~= nil then
    (self.changeUserHead):OnDelete()
  end
  if self.changeDressUp ~= nil then
    (self.changeDressUp):OnDelete()
  end
  if self.changePro ~= nil then
    (self.changePro):OnDelete()
  end
  ;
  (base.Delete)(self)
end

return UIUserInfoDialog

