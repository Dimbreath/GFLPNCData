-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHomeSide = class("UIHomeSide", UIBaseWindow)
local base = UIBaseWindow
UIHomeSide.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.AddButtonListener)((self.ui).btn_Return, self, self.CloseSide)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Mail, self, self.OnMailClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Option, self, self.OnSettingClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Friend, self, self.OnIntimacyClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Train, self, self.OnTrainingClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_OpenSide, self, self.OpenSide)
  ;
  (((self.ui).tween_side).onRewind):AddListener(BindCallback(self, self.OnClose))
  ;
  ((self.ui).obj_MainSide):SetActive(false)
end

UIHomeSide.InitSide = function(self)
  -- function num : 0_1
  self:InitSideUnlock()
  self:InitRedDotEvent()
end

UIHomeSide.OpenSide = function(self)
  -- function num : 0_2
  (((self.ui).btn_OpenSide).gameObject):SetActive(false)
  ;
  ((self.ui).obj_MainSide):SetActive(true)
  ;
  ((self.ui).tween_side):DOPlayForward()
end

UIHomeSide.CloseSide = function(self)
  -- function num : 0_3
  ((self.ui).tween_side):DOPlayBackwards()
end

UIHomeSide.OnClose = function(self)
  -- function num : 0_4
  (((self.ui).btn_OpenSide).gameObject):SetActive(true)
  ;
  ((self.ui).obj_MainSide):SetActive(false)
end

UIHomeSide.InitSideUnlock = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true))
  local funcUnLockCrtl = nil
  local unlockDes = nil
  local isTrainingUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Training)
  self:OnTrainingUnlock(isTrainingUnlock)
  local isMailUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Mail)
  self:OnMailUnlock(isMailUnlock)
end

UIHomeSide.OnTrainingUnlock = function(self, active)
  -- function num : 0_6
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).btn_Train).interactable = active
end

UIHomeSide.OnMailUnlock = function(self, active)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).btn_Mail).interactable = active
end

UIHomeSide.OnTrainingClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.Training)
  self:CloseSide()
end

UIHomeSide.OnMailClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.Mail)
  self:CloseSide()
end

UIHomeSide.OnIntimacyClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.FriendShip)
  self:CloseSide()
end

UIHomeSide.OnSettingClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.Setting)
  self:CloseSide()
end

UIHomeSide.InitRedDotEvent = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local ok, trainingNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Training)
  ;
  ((self.ui).obj_TrainRedDot):SetActive(trainingNode:GetRedDotCount() > 0)
  self.__onRedDotTrainingChanged = function(node)
    -- function num : 0_12_0 , upvalues : self
    ((self.ui).obj_TrainRedDot):SetActive(node:GetRedDotCount() > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

  RedDotController:AddListener(trainingNode.nodePath, self.__onRedDotTrainingChanged)
  local ok, mailNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Mail)
  ;
  ((self.ui).obj_MailRedDot):SetActive(mailNode:GetRedDotCount() > 0)
  self.__onRedDotMailChanged = function(node)
    -- function num : 0_12_1 , upvalues : self
    ((self.ui).obj_MailRedDot):SetActive(node:GetRedDotCount() > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

  RedDotController:AddListener(mailNode.nodePath, self.__onRedDotMailChanged)
  local ok, mainsideNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide)
  ;
  ((self.ui).obj_MainSideRedDot):SetActive(mainsideNode:GetRedDotCount() > 0)
  self.__onRedDotMainSideChanged = function(node)
    -- function num : 0_12_2 , upvalues : self
    ((self.ui).obj_MainSideRedDot):SetActive(node:GetRedDotCount() > 0)
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

  RedDotController:AddListener(mainsideNode.nodePath, self.__onRedDotMainSideChanged)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIHomeSide.RemoveRedDotEvent = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local ok, trainingNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Training)
  RedDotController:RemoveListener(trainingNode.nodePath, self.__onRedDotTrainingChanged)
  local ok, mailNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Mail)
  RedDotController:RemoveListener(mailNode.nodePath, self.__onRedDotMailChanged)
  local ok, mainsideNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide)
  RedDotController:RemoveListener(mainsideNode.nodePath, self.__onRedDotMainSideChanged)
end

UIHomeSide.OnDelete = function(self)
  -- function num : 0_14 , upvalues : base
  self:RemoveRedDotEvent()
  ;
  (base.OnDelete)(self)
end

return UIHomeSide

