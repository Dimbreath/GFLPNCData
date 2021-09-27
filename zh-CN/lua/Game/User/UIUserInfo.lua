local UIUserInfo = class("UIUserNameModify", UIBaseWindow)
local base = UIBaseWindow
local UINUserInfoNode = require("Game.User.UINUserInfoNode")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
UIUserInfo.OnInit = function(self)
  -- function num : 0_0 , upvalues : cs_ResLoader, _ENV, UINUserInfoNode
  self.resLoader = (cs_ResLoader.Create)()
  ;
  (UIUtil.SetTopStatus)(self, self.OnUserInfoReturnClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_toAchievement, self, self.OpenAchievement)
  self._RefreshAchievementInfo = BindCallback(self, self.RefreshAchievementInfo)
  MsgCenter:AddListener(eMsgEventId.UpdatePickedAchivTask, self._RefreshAchievementInfo)
  MsgCenter:AddListener(eMsgEventId.UpdatePlayerLevel, self._RefreshAchievementInfo)
  self.userInfoNode = (UINUserInfoNode.New)()
  ;
  (self.userInfoNode):Init((self.ui).obj_uINUserInfoNode)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ChangeDressUp, self, self._OpenChangeDressUp)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ChangePro, self, self._OpenChangePro)
end

UIUserInfo.InitUserInfo = function(self)
  -- function num : 0_1
  self:RefreshPlayerInfo()
  self:RefreshAchievementInfo()
end

UIUserInfo.RefreshPlayerInfo = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self.userInfoNode):RefershInfoNode(PlayerDataCenter.inforData, BindCallback(self, self.ChangeNameAction), self.resLoader, true)
end

UIUserInfo.RefreshUserHead = function(self, id)
  -- function num : 0_3
  (self.userInfoNode):RefreshUserHead(id)
end

UIUserInfo.RefreshUserHeadFrame = function(self, id)
  -- function num : 0_4
  (self.userInfoNode):RefreshUserHeadFrame(id)
end

UIUserInfo.ChangeNameAction = function(self)
  -- function num : 0_5 , upvalues : _ENV, cs_MessageCommon
  local num = PlayerDataCenter:GetItemCount((ConfigData.game_config).changeNameItemId)
  if num < 1 then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(173))
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.UserInfoDialog, function(window)
    -- function num : 0_5_0
    if window ~= nil then
      window:OpenChangeNameDialog()
    end
  end
)
end

UIUserInfo.RefreshAchievementInfo = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement)
  ;
  (((self.ui).btn_toAchievement).gameObject):SetActive(isUnlock)
  if not isUnlock then
    return 
  end
  ;
  (self.userInfoNode):RefreshUserLevel((PlayerDataCenter.playerLevel).level)
  local cur = (PlayerDataCenter.achivLevelData):GetPickedAchNum() or 0
  local total = (PlayerDataCenter.achivLevelData):GetTotalAchNum() or 0
  local rate = 0
  if cur ~= 0 and total ~= 0 then
    rate = GetPreciseDecimalStr(cur / total * 100, 0)
  end
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_CompleteNum).text = rate .. "%"
end

UIUserInfo.OpenAchievement = function(self)
  -- function num : 0_7 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.AchievementSystem, function(win)
    -- function num : 0_7_0
    if win ~= nil then
      win:InitAchievement(nil, false)
    end
  end
)
end

UIUserInfo.OnUserInfoReturnClick = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (self.userInfoNode):SaveUserSignature()
  self:OnCloseWin()
  if self.fromType == eBaseWinFromWhere.home then
    local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeWin ~= nil then
      (homeWin.homeAdjutant):LoadBoardHero(self.currHeroData, function()
    -- function num : 0_8_0 , upvalues : self
    self:Delete()
  end
)
    end
  else
    do
      self:Delete()
    end
  end
end

UIUserInfo._OpenChangeDressUp = function(self)
  -- function num : 0_9 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.UserInfoDialog, function(window)
    -- function num : 0_9_0
    if window ~= nil then
      window:OpenChangeDressUpDialog()
    end
  end
)
end

UIUserInfo._OpenChangePro = function(self)
  -- function num : 0_10 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.UserInfoDialog, function(window)
    -- function num : 0_10_0
    if window ~= nil then
      window:OpenChangePro()
    end
  end
)
end

UIUserInfo.OnDelete = function(self)
  -- function num : 0_11 , upvalues : _ENV, base
  if self.resLoader ~= nil then
    (self.resLoader):Put2Pool()
    self.resLoader = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.UpdatePickedAchivTask, self._RefreshAchievementInfo)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePlayerLevel, self._RefreshAchievementInfo)
  ;
  (self.userInfoNode):Delete()
  ;
  (base.OnDelete)(self)
end

return UIUserInfo

