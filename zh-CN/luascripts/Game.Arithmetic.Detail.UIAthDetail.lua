-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAthDetail = class("UIAthDetail", UIBaseWindow)
local base = UIBaseWindow
local UINAthDetailMain = require("Game.Arithmetic.Detail.UINAthDetailMain")
local UINAthDetailSub = require("Game.Arithmetic.Detail.UINAthDetailSub")
UIAthDetail.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  ((self.ui).mainDetailItem):SetActive(false)
  ;
  ((self.ui).subDetailItem):SetActive(false)
  self.athNetwork = NetworkManager:GetNetwork(NetworkTypeID.Arithmetic)
end

UIAthDetail.OnShow = function(self)
  -- function num : 0_1 , upvalues : base
  (base.OnShow)(self)
  if self.detailMain ~= nil and (self.detailMain).active then
    (self.detailMain):RefreshDetail()
  end
  if self.detailSub ~= nil and (self.detailSub).active then
    (self.detailSub):RefreshDetail()
  end
end

UIAthDetail.ShowAthDetailMain = function(self, athData, efficiency, heroId, replaceEvent, uninstallEvent, closeEvent)
  -- function num : 0_2 , upvalues : UINAthDetailMain, _ENV
  if self.detailMain == nil then
    self.detailMain = (UINAthDetailMain.New)()
    ;
    (self.detailMain):Init((self.ui).mainDetailItem)
    ;
    (self.detailMain):SetLockEvent(BindCallback(self, self.LockAth))
  end
  ;
  (self.detailMain):Show()
  ;
  (self.detailMain):InitAthDetailNode(athData, efficiency, heroId, replaceEvent, uninstallEvent)
  ;
  (self.detailMain):SetCloseEvent(closeEvent)
  self:RefreshButtonState()
end

UIAthDetail.CloseAthDetailMain = function(self)
  -- function num : 0_3
  if self.detailMain ~= nil then
    (self.detailMain):OnClickClose()
  end
end

UIAthDetail.ShowAthDetailSub = function(self, athData, efficiency, heroId, installEvent, closeEvent)
  -- function num : 0_4 , upvalues : UINAthDetailSub, _ENV
  if self.detailSub == nil then
    self.detailSub = (UINAthDetailSub.New)()
    ;
    (self.detailSub):Init((self.ui).subDetailItem)
    ;
    (self.detailSub):SetLockEvent(BindCallback(self, self.LockAth))
  end
  ;
  (self.detailSub):Show()
  ;
  (self.detailSub):InitAthDetailNode(athData, efficiency, heroId, installEvent)
  ;
  (self.detailSub):SetCloseEvent(closeEvent)
  self:RefreshButtonState()
end

UIAthDetail.CloseAthDetailSub = function(self)
  -- function num : 0_5
  if self.detailSub ~= nil then
    (self.detailSub):OnClickClose()
  end
end

UIAthDetail.ResetAthDetail = function(self)
  -- function num : 0_6
  self:CloseAthDetailMain()
  self:CloseAthDetailSub()
end

UIAthDetail.RefreshButtonState = function(self)
  -- function num : 0_7
  local isInstall = true
  if self.detailSub ~= nil and self.detailMain ~= nil and (self.detailSub).active and (self.detailMain).active then
    isInstall = false
  end
  local replaceAthData = nil
  if self.detailMain ~= nil and (self.detailMain).active then
    (self.detailMain):EnableReplace(not isInstall)
    replaceAthData = (self.detailMain).athData
  end
  if self.detailSub ~= nil and (self.detailSub).active then
    (self.detailSub):SetInstall(isInstall)
    ;
    (self.detailSub):RefreshSuit(replaceAthData)
  end
end

UIAthDetail.LockAth = function(self, uid)
  -- function num : 0_8 , upvalues : _ENV
  if self.__onLockAthCompleteEvent == nil then
    self.__onLockAthCompleteEvent = BindCallback(self, self.OnLockAthComplete)
  end
  ;
  (self.athNetwork):CS_ATH_AthLock(uid, self.__onLockAthCompleteEvent)
end

UIAthDetail.OnLockAthComplete = function(self)
  -- function num : 0_9
  if self.detailMain ~= nil then
    (self.detailMain):RefreshAthLock()
  end
  if self.detailSub ~= nil then
    (self.detailSub):RefreshAthLock()
  end
end

UIAthDetail.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  if self.detailMain ~= nil then
    (self.detailMain):Delete()
  end
  if self.detailSub ~= nil then
    (self.detailSub):Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UIAthDetail

