-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHomeMain = class("UIHomeMain", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local CS_OasisCameraController = CS.OasisCameraController
local CS_CmCoreState = ((CS.Cinemachine).CinemachineCore).Stage
local HomeAdjutant = require("Game.Home.HomeAdjutant")
local UINHomeUp = require("Game.Home.UI.UINHomeUp")
local UINHomeLeft = require("Game.Home.UI.UINHomeLeft")
local UINHomeRight = require("Game.Home.UI.UINHomeRight")
local JumpManager = require("Game.Jump.JumpManager")
local COST_TIME_RATE = 0.4
UIHomeMain.OnInit = function(self)
  -- function num : 0_0 , upvalues : cs_ResLoader, _ENV, CS_OasisCameraController, CS_CmCoreState, HomeAdjutant, UINHomeUp, UINHomeLeft, UINHomeRight
  self.resloader = (cs_ResLoader.Create)()
  self.homeController = ControllerManager:GetController(ControllerTypeId.HomeController, true)
  self.fakeCameraHome = (((CS.UnityEngine).GameObject).Find)("FakeCameraHome")
  self:AlignToFakeCamera((self.fakeCameraHome):GetComponent("Camera"))
  self.__fakeCameraPos = ((self.fakeCameraHome).transform).position
  self.fakeCameraHomeConstraint = (self.fakeCameraHome):GetComponent("PositionConstraint")
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.fakeCameraHomeConstraint).constraintActive = true
  self.bind = {}
  ;
  (UIUtil.LuaUIBindingTable)((CS_OasisCameraController.Instance).transform, self.bind)
  self.home2SectorVCBody = ((self.bind).toSectorVHomeCam):GetCinemachineComponent(CS_CmCoreState.Body)
  self.home2OasisCamVCBody = ((self.bind).toOasiaVHomeCam):GetCinemachineComponent(CS_CmCoreState.Body)
  self.homeAdjutant = (HomeAdjutant.New)()
  ;
  (self.homeAdjutant):InitHomeAdjutant(self.bind, (self.ui).heroHolder)
  self.homeUpNdoe = (UINHomeUp.New)()
  ;
  (self.homeUpNdoe):Init((self.ui).obj_upper)
  ;
  (self.homeUpNdoe):InitHomeUpNode(self)
  self.homeLeftNode = (UINHomeLeft.New)()
  ;
  (self.homeLeftNode):Init((self.ui).obj_left)
  ;
  (self.homeLeftNode):InitHomeLeftNode(self)
  self.homeRightNode = (UINHomeRight.New)()
  ;
  (self.homeRightNode):Init((self.ui).obj_right)
  ;
  (self.homeRightNode):InitHomeRightNode(self)
  local eventTrigger = ((CS.EventTriggerListener).Get)(((self.ui).scrollRect_pageList).gameObject)
  eventTrigger:onBeginDrag("+", BindCallback(self, self.OnBeginDragRight))
  eventTrigger:onEndDrag("+", BindCallback(self, self.OnEndDragRight))
  self.__OnUpdateHome = BindCallback(self, self.OnUpdateHome)
  UpdateManager:AddUpdate(self.__OnUpdateHome)
  if isEditorMode and ((CS.GMController).Instance).battleShortcut and ExplorationManager:HasUncompletedEp() then
    ExplorationManager:ContinueLastExploration()
  end
  GuideManager:TryTriggerGuide(eGuideCondition.FInHome)
  ;
  (self.homeController):OnInitHomeUI()
  self.__isUnfold = false
  self.__flag = 1
end

UIHomeMain.OnShow = function(self, isFromOasis)
  -- function num : 0_1 , upvalues : _ENV, base
  (self.homeController):OnShowHomeUI(isFromOasis)
  ;
  (self.homeUpNdoe):OnHomeShow()
  ;
  (self.homeLeftNode):OnHomeShow()
  ;
  (self.homeRightNode):OnHomeShow()
  ;
  (((self.ui).scrollRect_pageList).onValueChanged):AddListener(BindCallback(self, self.OnValueChange))
  ;
  (base.OnShow)(self)
end

UIHomeMain.ShowTween = function(self)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).canvasGroup).alpha = 0
  ;
  (((self.ui).canvasGroup):DOFade(1, 0.5)):SetLink(((self.ui).canvasGroup).gameObject)
end

UIHomeMain.m_SetMainCameraEnabled = function(self, enabled)
  -- function num : 0_3 , upvalues : CS_OasisCameraController
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((CS_OasisCameraController.Instance).MainCamera).enabled = enabled
end

UIHomeMain.SetFrom2Home = function(self, from, playReturnHomeCv)
  -- function num : 0_4 , upvalues : _ENV, JumpManager
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  if from == AreaConst.Sector or from == AreaConst.FactoryDorm then
    (self.homeController).isRewindingBack2HomeTimeLine = true
    self.__flag = 1
    if ((self.bind).homeToSectorGo).activeInHierarchy then
      (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
      ;
      ((self.bind).homeToSectorGo):SetActive(true)
      ;
      ((self.bind).homeToOasisGo):SetActive(false)
      ;
      ((self.bind).homeToMenuGo):SetActive(false)
      self.__curVCBody = self.home2SectorVCBody
      local timeline = nil
      if from == AreaConst.Sector then
        timeline = (self.bind).sectorPlayableDirector
      else
        timeline = (self.bind).factorydormPlayableDirector
      end
      self.__tlSectorCo = (TimelineUtil.Rewind)(timeline, function()
    -- function num : 0_4_0 , upvalues : _ENV, JumpManager, self
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    JumpManager:TryCallBack2HomeMsgFunc((UIUtil.backStack):Empty())
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (self.homeController).isRewindingBack2HomeTimeLine = false
  end
)
    end
  else
    do
      if from == AreaConst.Oasis then
        self.__flag = -1
        ;
        ((self.bind).homeToSectorGo):SetActive(false)
        ;
        ((self.bind).homeToOasisGo):SetActive(true)
        ;
        ((self.bind).homeToMenuGo):SetActive(false)
        self.__curVCBody = self.home2OasisCamVCBody
      end
      if playReturnHomeCv then
        (self.homeController):PlayVoReturnHome()
      end
    end
  end
end

UIHomeMain.SetTo = function(self, to)
  -- function num : 0_5 , upvalues : _ENV
  if to == AreaConst.Sector or to == AreaConst.FactoryDorm then
    ((self.bind).homeToSectorGo):SetActive(true)
    ;
    ((self.bind).homeToOasisGo):SetActive(false)
    ;
    ((self.bind).homeToMenuGo):SetActive(false)
    self.__curVCBody = self.home2SectorVCBody
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self.fakeCameraHomeConstraint).constraintActive = false
  else
    if to == AreaConst.Oasis then
      ((self.bind).homeToSectorGo):SetActive(false)
      ;
      ((self.bind).homeToOasisGo):SetActive(true)
      ;
      ((self.bind).homeToMenuGo):SetActive(false)
      self.__curVCBody = self.home2OasisCamVCBody
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (self.fakeCameraHomeConstraint).constraintActive = false
    end
  end
end

UIHomeMain.OpenOtherWin = function(self)
  -- function num : 0_6
  self:m_SetMainCameraEnabled(false)
  self:Hide()
end

UIHomeMain.OpenOtherCoverWin = function(self)
  -- function num : 0_7
  (self.homeController):OnCoverHomeUI()
end

UIHomeMain.BackFromOtherWin = function(self)
  -- function num : 0_8
  self:m_SetMainCameraEnabled(true)
  self:Show()
end

UIHomeMain.BackFromOtherCoverWin = function(self)
  -- function num : 0_9
  (self.homeController):OnShowHomeUI()
end

UIHomeMain.SetHomeShowMainUI = function(self, bool)
  -- function num : 0_10
  if bool then
    (self.homeUpNdoe):Show()
    ;
    (self.homeLeftNode):Show()
    ;
    (self.homeRightNode):Show()
  else
    ;
    (self.homeUpNdoe):Hide()
    ;
    (self.homeLeftNode):Hide()
    ;
    (self.homeRightNode):Hide()
  end
end

UIHomeMain.OnBeginDragRight = function(self, go, pointerEvent)
  -- function num : 0_11
  self.__couldUpdateList = false
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  if not (self.fakeCameraHomeConstraint).constraintActive then
    (self.fakeCameraHomeConstraint).constraintActive = true
  end
end

UIHomeMain.OnEndDragRight = function(self, go, pointerEvent)
  -- function num : 0_12 , upvalues : COST_TIME_RATE
  if ((self.ui).scrollRect_pageList).horizontalNormalizedPosition > 0.1 and not self.__isUnfold then
    self.__isUnfold = true
  else
    if ((self.ui).scrollRect_pageList).horizontalNormalizedPosition < 0.9 and self.__isUnfold then
      self.__isUnfold = false
    end
  end
  self.__couldUpdateList = true
  self.currNPos = ((self.ui).scrollRect_pageList).horizontalNormalizedPosition
  self.passedTime = 0
  if self.__isUnfold then
    self.costTime = (1 - self.currNPos) * COST_TIME_RATE
  else
    self.costTime = self.currNPos * COST_TIME_RATE
  end
end

UIHomeMain.OnValueChange = function(self, pos)
  -- function num : 0_13 , upvalues : _ENV
  if IsNull(self.gameObject) then
    return 
  end
  local rate = pos.x
  ;
  (self.homeAdjutant):HomeRightUnfoldRate(rate)
  self:__vCameraUnfoldRate(rate)
  ;
  (self.homeRightNode):UpdateHomeRightUnfoldRate(rate)
end

UIHomeMain.OnUpdateHome = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if self.__couldUpdateList then
    self.passedTime = self.passedTime + Time.deltaTime
    if self.costTime < self.passedTime then
      self:SetIsUnfold(self.__isUnfold)
      return 
    end
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

    if self.__isUnfold then
      ((self.ui).scrollRect_pageList).horizontalNormalizedPosition = self:__GetLerpedNum(self.currNPos, 1, self.passedTime / self.costTime)
    else
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((self.ui).scrollRect_pageList).horizontalNormalizedPosition = self:__GetLerpedNum(self.currNPos, 0, self.passedTime / self.costTime)
    end
  end
end

UIHomeMain.SetIsUnfold = function(self, bool, forceSetCamera)
  -- function num : 0_15
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  if bool then
    ((self.ui).scrollRect_pageList).horizontalNormalizedPosition = 1
  else
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).scrollRect_pageList).horizontalNormalizedPosition = 0
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

    if forceSetCamera then
      ((self.fakeCameraHome).transform).position = self.__fakeCameraPos
    end
  end
  self.__couldUpdateList = false
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

  if self.__curVCBody ~= nil then
    (self.__curVCBody).m_XDamping = 0.2
  end
  ;
  (self.homeRightNode):OnHomeRightIsUnfold(bool)
end

UIHomeMain.__vCameraUnfoldRate = function(self, rate)
  -- function num : 0_16 , upvalues : _ENV
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  if self.__curVCBody ~= nil then
    (self.__curVCBody).m_PathOffset = (Vector3.New)(-2 * rate * self.__flag, 0, 0)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self.__curVCBody).m_XDamping = 0
  end
end

UIHomeMain.__GetLerpedNum = function(self, sV, eV, rate)
  -- function num : 0_17
  rate = rate - 1
  eV = eV - sV
  return (eV) * ((rate) * (rate) * (rate) * (rate) * (rate) + 1) + sV
end

UIHomeMain.SwitchUnfold = function(self)
  -- function num : 0_18 , upvalues : COST_TIME_RATE
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  if not (self.fakeCameraHomeConstraint).constraintActive then
    (self.fakeCameraHomeConstraint).constraintActive = true
  end
  self.__isUnfold = not self.__isUnfold
  self.__couldUpdateList = true
  self.currNPos = ((self.ui).scrollRect_pageList).horizontalNormalizedPosition
  self.passedTime = 0
  if self.__isUnfold then
    self.costTime = (1 - self.currNPos) * COST_TIME_RATE
  else
    self.costTime = self.currNPos * COST_TIME_RATE
  end
  return self.__isUnfold
end

UIHomeMain.OnHide = function(self)
  -- function num : 0_19 , upvalues : _ENV, base
  (self.homeRightNode):OnHomeHide()
  ;
  (self.homeController):OnHideHomeUI()
  ;
  (((self.ui).scrollRect_pageList).onValueChanged):RemoveListener(BindCallback(self, self.OnValueChange))
  ;
  (base.OnHide)(self)
end

UIHomeMain.OnDelete = function(self)
  -- function num : 0_20 , upvalues : _ENV, base
  if self.onHookVoiceTimer ~= nil then
    (self.onHookVoiceTimer):Stop()
    self.onHookVoiceTimer = nil
  end
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  ;
  (self.homeController):OnDeleteHomeUI()
  if self.__tlSectorCo ~= nil then
    (TimelineUtil.StopTlCo)(self.__tlSectorCo)
  end
  if self.homeUpNdoe ~= nil then
    (self.homeUpNdoe):Delete()
  end
  if self.homeLeftNode ~= nil then
    (self.homeLeftNode):Delete()
  end
  if self.homeRightNode ~= nil then
    (self.homeRightNode):Delete()
  end
  if self.homeAdjutant ~= nil then
    (self.homeAdjutant):Delete()
    self.homeAdjutant = nil
  end
  UpdateManager:RemoveUpdate(self.__OnUpdateHome)
  ;
  (base.OnDelete)(self)
end

return UIHomeMain

