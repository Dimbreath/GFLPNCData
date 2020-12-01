-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBattlePause = class("UIBattlePause", UIBaseWindow)
local base = UIBaseWindow
UIBattlePause.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_GiveUp, self, self.__OnClickGiveUp)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Reload, self, self.__OnClickRestart)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GoOn, self, self.__OnClickContinue)
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock)
  local isUnlockBattleExit = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleExit)
  if not isUnlockBattleExit then
    (((self.ui).btn_GiveUp).gameObject):SetActive(false)
  end
end

UIBattlePause.InitBattlePause = function(self, giveUpBattleFunc, restartFunc, pauseFunc)
  -- function num : 0_1
  self.giveUpBattleFunc = giveUpBattleFunc
  self.restartFunc = restartFunc
  self.pauseFunc = pauseFunc
end

UIBattlePause.__OnClickGiveUp = function(self)
  -- function num : 0_2
  if self.giveUpBattleFunc ~= nil then
    (self.giveUpBattleFunc)()
  end
end

UIBattlePause.__OnClickRestart = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.restartFunc ~= nil then
    (self.restartFunc)()
    self:Hide()
  end
  UIManager:DeleteWindow(UIWindowTypeID.BattleCrazyMode)
end

UIBattlePause.__OnClickContinue = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self.pauseFunc ~= nil then
    (self.pauseFunc)(false)
    self:Hide()
  end
  local win = UIManager:GetWindow(UIWindowTypeID.BattleCrazyMode)
  if win ~= nil then
    win:OnBattleContinue()
  end
end

UIBattlePause.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  (base.OnDelete)(self)
end

return UIBattlePause

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIBattlePause = class("UIBattlePause", UIBaseWindow)
local base = UIBaseWindow
UIBattlePause.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.AddButtonListener)((self.ui).btn_GiveUp, self, self.__OnClickGiveUp);
    (UIUtil.AddButtonListener)((self.ui).btn_Reload, self, self.__OnClickRestart);
    (UIUtil.AddButtonListener)((self.ui).btn_GoOn, self, self.__OnClickContinue)
    local funcUnLockCrtl = ControllerManager:GetController(
                               ControllerTypeId.FunctionUnlock)
    local isUnlockBattleExit = funcUnLockCrtl:ValidateUnlock(
                                   proto_csmsg_SystemFunctionID.SystemFunctionID_BattleExit)
    if not isUnlockBattleExit then
        (((self.ui).btn_GiveUp).gameObject):SetActive(false)
    end
end

UIBattlePause.InitBattlePause = function(self, giveUpBattleFunc, restartFunc,
                                         pauseFunc)
    -- function num : 0_1
    self.giveUpBattleFunc = giveUpBattleFunc
    self.restartFunc = restartFunc
    self.pauseFunc = pauseFunc
end

UIBattlePause.__OnClickGiveUp = function(self)
    -- function num : 0_2
    if self.giveUpBattleFunc ~= nil then (self.giveUpBattleFunc)() end
end

UIBattlePause.__OnClickRestart = function(self)
    -- function num : 0_3 , upvalues : _ENV
    if self.restartFunc ~= nil then
        (self.restartFunc)()
        self:Hide()
    end
    UIManager:DeleteWindow(UIWindowTypeID.BattleCrazyMode)
end

UIBattlePause.__OnClickContinue = function(self)
    -- function num : 0_4 , upvalues : _ENV
    if self.pauseFunc ~= nil then
        (self.pauseFunc)(false)
        self:Hide()
    end
    local win = UIManager:GetWindow(UIWindowTypeID.BattleCrazyMode)
    if win ~= nil then win:OnBattleContinue() end
end

UIBattlePause.OnDelete = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnDelete)(self)
end

return UIBattlePause

