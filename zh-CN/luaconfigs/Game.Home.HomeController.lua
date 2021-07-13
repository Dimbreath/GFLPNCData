-- params : ...
-- function num : 0 , upvalues : _ENV
local HomeController = class("HomeController", ControllerBase)
local base = ControllerBase
local HomeEnum = require("Game.Home.HomeEnum")
local UIBannerData = require("Game.CommonUI.Container.Model.ContainerData")
local NoticeData = require("Game.Notice.NoticeData")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local JumpManager = require("Game.Jump.JumpManager")
local util = require("XLua.Common.xlua_util")
local cs_Input = (CS.UnityEngine).Input
local CS_LeanTouch = ((CS.Lean).Touch).LeanTouch
HomeController.OnInit = function(self)
  -- function num : 0_0 , upvalues : HomeEnum, _ENV
  self.oasisController = nil
  self:_ChangeHomeState((HomeEnum.eHomeState).None)
  self.homeCurrAdjutantHeroData = nil
  self.redDotFuncDic = {}
  self.sideNoticeList = {}
  self.m_timeSecond = 0
  self.m_timeSecond2 = 0
  self.needUpdateProduction = false
  self.updateProductionEvent = nil
  self.isNewFull = {}
  self.needUpdateConstruct = false
  self.updateConstructEvent = false
  self.isOasisHasCOB = false
  self.isSectorHasCOB = false
  self.isRewindingBack2HomeTimeLine = false
  self._AfterShowHomeCoFunc = BindCallback(self, self._AfterShowHomeCo)
  self.__OnUpdate = BindCallback(self, self.OnUpdate)
  UpdateManager:AddUpdate(self.__OnUpdate)
  self.__OnUpdatePlayerName = BindCallback(self, self.OnUpdatePlayerName)
  MsgCenter:AddListener(eMsgEventId.UserNameChanged, self.__OnUpdatePlayerName)
  self.__OnUpdateTask = BindCallback(self, self.OnUpdateTask)
  MsgCenter:AddListener(eMsgEventId.TaskSyncFinish, self.__OnUpdateTask)
  self.__UIOasisShow = BindCallback(self, self.ShowOasisUI)
  MsgCenter:AddListener(eMsgEventId.UIOasisShow, self.__UIOasisShow)
  self.__onUpdateUncompletedEp = BindCallback(self, self.OnUpdateUncompletedEp)
  MsgCenter:AddListener(eMsgEventId.OnHasUncompletedEp, self.__onUpdateUncompletedEp)
  self.__OnUpdateStamina = BindCallback(self, self.OnUpdateStamina)
  MsgCenter:AddListener(eMsgEventId.StaminaUpdate, self.__OnUpdateStamina)
  self.__OnUpdateHeroCollectRate = BindCallback(self, self.OnUpdateHeroCollectRate)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__OnUpdateHeroCollectRate)
  self.__OnUpdateARG = BindCallback(self, self.OnUpdateARG)
  MsgCenter:AddListener(eMsgEventId.UpdateARGItem, self.__OnUpdateARG)
  self.__OnUpdateItem = BindCallback(self, self.OnUpdateItem)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnUpdateItem)
  self.__OnActivityShowChange = BindCallback(self, self.OnActivityShowChange)
  MsgCenter:AddListener(eMsgEventId.ActivityShowChange, self.__OnActivityShowChange)
  self.AutoShowCommandList = {}
  self.__onGesture = BindCallback(self, self.OnGesture)
end

HomeController.OnInitHomeUI = function(self)
  -- function num : 0_1 , upvalues : _ENV, CS_LeanTouch
  self.onHookVoiceTimer = (TimerManager:GetTimer((ConfigData.buildinConfig).HomeOnHookVoiceTime, function()
    -- function num : 0_1_0 , upvalues : self
    self:PlayVoHomeOnHook()
  end
, nil, false)):Start()
  ;
  (CS_LeanTouch.OnGesture)("+", self.__onGesture)
end

HomeController.OnEnterHome = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.oasisController = ControllerManager:GetController(ControllerTypeId.OasisController, true)
end

HomeController.OnShowHomeUI = function(self, isFromOasis)
  -- function num : 0_3 , upvalues : HomeEnum, _ENV, JumpManager
  self:PauseHomeOnHookTimer(false)
  local homeOldState = self.homeState
  if self.homeState == (HomeEnum.eHomeState).Covered then
    self:_ChangeHomeState((HomeEnum.eHomeState).Normal)
    TimerManager:AddLateCommand(function()
    -- function num : 0_3_0 , upvalues : JumpManager, _ENV
    if JumpManager:IsHaveBack2Home() then
      return 
    end
    GuideManager:TryTriggerGuide(eGuideCondition.InHome)
  end
)
    self:OnUpdate(true)
    TimerManager:AddLateCommand(function()
    -- function num : 0_3_1 , upvalues : self, JumpManager, _ENV
    self:_StartShowHomeCo()
    JumpManager:TryCallBack2HomeMsgFunc((UIUtil.backStack):Empty())
  end
)
    MsgCenter:Broadcast(eMsgEventId.OnOpenHomeUI)
    return 
  end
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  if self.homeState ~= (HomeEnum.eHomeState).Normal then
    self:_ChangeHomeState((HomeEnum.eHomeState).Normal)
    TimerManager:AddLateCommand(function()
    -- function num : 0_3_2 , upvalues : JumpManager, _ENV
    if JumpManager:IsHaveBack2Home() then
      return 
    end
    GuideManager:TryTriggerGuide(eGuideCondition.InHome)
  end
)
    self:OnUpdate(true)
  end
  TimerManager:AddLateCommand(function()
    -- function num : 0_3_3 , upvalues : self, JumpManager, _ENV
    self:_StartShowHomeCo()
    if not self.isRewindingBack2HomeTimeLine then
      JumpManager:TryCallBack2HomeMsgFunc((UIUtil.backStack):Empty())
    end
  end
)
  MsgCenter:Broadcast(eMsgEventId.OnOpenHomeUI)
end

HomeController.OnCoverHomeUI = function(self)
  -- function num : 0_4 , upvalues : HomeEnum, _ENV
  self:_ChangeHomeState((HomeEnum.eHomeState).Covered)
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    self:PauseHomeOnHookTimer(true)
  end
end

HomeController.OnHideHomeUI = function(self)
  -- function num : 0_5 , upvalues : HomeEnum, _ENV
  self:_ChangeHomeState((HomeEnum.eHomeState).Hided)
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    self:PauseHomeOnHookTimer(true)
  end
end

HomeController.OnDeleteHomeUI = function(self)
  -- function num : 0_6 , upvalues : _ENV, HomeEnum, CS_LeanTouch
  ControllerManager:DeleteController(ControllerTypeId.OasisController)
  self:RemoveAllRedDotEvent()
  self:_ChangeHomeState((HomeEnum.eHomeState).None)
  ;
  (CS_LeanTouch.OnGesture)("-", self.__onGesture)
  self:PauseHomeOnHookTimer(true)
end

HomeController._ChangeHomeState = function(self, state)
  -- function num : 0_7 , upvalues : cs_Input, HomeEnum, JumpManager, _ENV
  self.homeState = state
  cs_Input.multiTouchEnabled = state ~= (HomeEnum.eHomeState).Normal
  JumpManager.couldUseItemJump = state == (HomeEnum.eHomeState).Normal
  ;
  ((CS.RenderManager).Instance):SetShaderLODGlobal(self:IsNormalState() and 400 or 600)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

HomeController.IsNormalState = function(self)
  -- function num : 0_8 , upvalues : HomeEnum
  do return self.homeState == (HomeEnum.eHomeState).Normal end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HomeController.ValidCouldOpenSinginReward = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if GuideManager.inGuide or not self:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SignIn) then
    return 
  end
  local mailController = ControllerManager:GetController(ControllerTypeId.Mail, false)
  if mailController == nil then
    return 
  end
  local notPickedSinginMailUIDList = mailController:GetSignInRewardMailUIDs(self.__isNotFirstGetSignInReward, true)
  if #notPickedSinginMailUIDList <= 0 then
    return 
  end
  return true
end

HomeController.TryCollectSinginReward = function(self, isCoroutine)
  -- function num : 0_10 , upvalues : _ENV
  if not self:ValidCouldOpenSinginReward() then
    return 
  end
  local mailController = ControllerManager:GetController(ControllerTypeId.Mail, false)
  local notPickedSinginMailUIDList = mailController:GetSignInRewardMailUIDs(self.__isNotFirstGetSignInReward)
  self.__isNotFirstGetSignInReward = true
  UIManager:ShowWindowAsync(UIWindowTypeID.EventSignin, function(window)
    -- function num : 0_10_0 , upvalues : notPickedSinginMailUIDList
    window:InitEventSignin(nil, notPickedSinginMailUIDList)
  end
)
  while 1 do
    if isCoroutine then
      if UIManager:GetWindow(UIWindowTypeID.EventSignin) == nil then
        (coroutine.yield)(nil)
        -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out IF_STMT

        -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  while UIManager:GetWindow(UIWindowTypeID.EventSignin) ~= nil do
    (coroutine.yield)(nil)
  end
end

HomeController.ValidCouldOpenNoviceSign = function(self, id)
  -- function num : 0_11 , upvalues : _ENV
  if GuideManager.inGuide then
    return 
  end
  local data = ((PlayerDataCenter.eventNoviceSignData).dataDic)[id]
  if data == nil then
    return 
  end
  if not data:IsCanPop() then
    return 
  end
  return true
end

HomeController.TryShowEventNoviceSign = function(self, id, isCoroutine)
  -- function num : 0_12 , upvalues : _ENV
  if not self:ValidCouldOpenNoviceSign(id) then
    return 
  end
  local data = ((PlayerDataCenter.eventNoviceSignData).dataDic)[id]
  data:SetPoped()
  UIManager:ShowWindowAsync(UIWindowTypeID.EventNoviceSign, function(window)
    -- function num : 0_12_0 , upvalues : id
    window:InitNoviceSign(id, true)
  end
)
  while 1 do
    if isCoroutine then
      if UIManager:GetWindow(UIWindowTypeID.EventNoviceSign) == nil then
        (coroutine.yield)(nil)
        -- DECOMPILER ERROR at PC31: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC31: LeaveBlock: unexpected jumping out IF_STMT

        -- DECOMPILER ERROR at PC31: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC31: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  while UIManager:GetWindow(UIWindowTypeID.EventNoviceSign) ~= nil do
    (coroutine.yield)(nil)
  end
end

HomeController._StartShowHomeCo = function(self)
  -- function num : 0_13 , upvalues : JumpManager, HomeEnum, _ENV, util
  self:_ClearAfterShowCo()
  if not JumpManager:IsHaveBack2Home() then
    self.AutoShowCommandList = {}
    if self:ValidCouldOpenSinginReward() then
      self.homeState = (HomeEnum.eHomeState).Covered
      ;
      (table.insert)(self.AutoShowCommandList, (HomeEnum.eAutoShwoCommand).Singin)
    end
    for k,v in pairs((PlayerDataCenter.eventNoviceSignData).dataDic) do
      if self:ValidCouldOpenNoviceSign(k) then
        self.homeState = (HomeEnum.eHomeState).Covered
        ;
        (table.insert)(self.AutoShowCommandList, (HomeEnum.eAutoShwoCommand).NoviceSign)
        break
      end
    end
    do
      self._afterShowCo = (GR.StartCoroutine)((util.cs_generator)(self._AfterShowHomeCoFunc))
    end
  end
end

HomeController.AddAutoShowGuide = function(self, autoShowGuide)
  -- function num : 0_14 , upvalues : JumpManager, _ENV, util
  if JumpManager:IsHaveBack2Home() then
    return 
  end
  local window = UIManager:GetWindow(UIWindowTypeID.Home)
  if window == nil or not window.active then
    return 
  end
  ;
  (table.insert)(self.AutoShowCommandList, 1, autoShowGuide)
  if self._afterShowCo ~= nil then
    return 
  end
  self._afterShowCo = (GR.StartCoroutine)((util.cs_generator)(self._AfterShowHomeCoFunc))
end

HomeController._AfterShowHomeCo = function(self)
  -- function num : 0_15 , upvalues : _ENV, HomeEnum, util
  (ControllerManager:GetController(ControllerTypeId.Pay, true)):TryShowPayResult()
  self._afterShowCoList = {}
  if #self.AutoShowCommandList > 0 then
    NoticeManager:PuaseShowNotice()
  end
  while 1 do
    if #self.AutoShowCommandList > 0 then
      local index = #self.AutoShowCommandList
      local command = (self.AutoShowCommandList)[index]
      if command == (HomeEnum.eAutoShwoCommand).NoviceSign then
        for k,v in pairs((PlayerDataCenter.eventNoviceSignData).dataDic) do
          do
            local co = (GR.StartCoroutine)((util.cs_generator)(function()
    -- function num : 0_15_0 , upvalues : self, k
    self:TryShowEventNoviceSign(k, true)
  end
))
            ;
            (table.insert)(self._afterShowCoList, co)
            ;
            (coroutine.yield)(co)
          end
        end
      else
        do
          do
            do
              if command == (HomeEnum.eAutoShwoCommand).Singin then
                local co = (GR.StartCoroutine)((util.cs_generator)(function()
    -- function num : 0_15_1 , upvalues : self
    self:TryCollectSinginReward(true)
  end
))
                ;
                (table.insert)(self._afterShowCoList, co)
                ;
                (coroutine.yield)(co)
              end
              ;
              (table.remove)(self.AutoShowCommandList, index)
              -- DECOMPILER ERROR at PC78: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC78: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC78: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC78: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC78: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC78: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
  self._afterShowCo = nil
  self._afterShowCoList = {}
  NoticeManager:ContinueShowNotice()
end

HomeController._ClearAfterShowCo = function(self)
  -- function num : 0_16 , upvalues : _ENV
  if self._afterShowCo ~= nil then
    (GR.StopCoroutine)(self._afterShowCo)
    self._afterShowCo = nil
  end
  if self._afterShowCoList ~= nil then
    for i,v in ipairs(self._afterShowCoList) do
      if v ~= nil then
        (GR.StopCoroutine)(v)
      end
    end
    self._afterShowCoList = {}
  end
end

HomeController.OnUpdate = function(self, isForce)
  -- function num : 0_17 , upvalues : _ENV
  if self.m_timeSecond2 == nil then
    self.m_timeSecond2 = 0
  else
    self.m_timeSecond2 = self.m_timeSecond2 + Time.deltaTime
  end
  local isMin = false
  if self.m_timeSecond2 > 60 then
    self.m_timeSecond2 = 0
    isMin = true
  end
  if isForce or isMin then
    self:UpdateCouldOperateBuilding()
    self:UpdateOasisGenResourceFull()
  end
end

HomeController.SetNeedUpdateProduction = function(self, bool, updateEvent)
  -- function num : 0_18
  self.needUpdateProduction = true
  self.updateProductionEvent = updateEvent
end

local m_AddBuildRes = function(allResDic, resData, countMax)
  -- function num : 0_19
  local allResData = allResDic[resData.id]
  if allResData == nil then
    allResData = {id = resData.id, name = resData.name, count = resData.count, speed = resData.speed, effSpeed = resData.effSpeed, progress = resData.progress, countMax = countMax}
    allResDic[resData.id] = allResData
  else
    allResData.effSpeed = allResData.effSpeed + resData.effSpeed
    allResData.speed = allResData.speed + resData.speed
    allResData.count = allResData.count + resData.count
    allResData.countMax = allResData.countMax + countMax
  end
end

HomeController.SetNeedUpdateConstruct = function(self, bool, updateEvent)
  -- function num : 0_20
  self.needUpdateConstruct = bool
  self.updateConstructEvent = updateEvent
end

HomeController.OnUpdateBuildingConstruct = function(self)
  -- function num : 0_21 , upvalues : BuildingBelong, _ENV
  if not self.needUpdateConstruct then
    return 
  end
  local constructingBuildingLists = {
[BuildingBelong.Oasis] = {}
, 
[BuildingBelong.Sector] = {}
}
  for _,builtData in ipairs((PlayerDataCenter.AllBuildingData).builtSort) do
    builtData:GetProcess(PlayerDataCenter.timestamp)
    if builtData.state == proto_object_BuildingState.BuildingStateCreate or builtData.state == proto_object_BuildingState.BuildingStateUpgrade then
      (table.insert)(constructingBuildingLists[builtData.belong], builtData)
    end
  end
  if self.updateConstructEvent ~= nil then
    (self.updateConstructEvent)(constructingBuildingLists)
  end
end

HomeController.UpdateCouldOperateBuilding = function(self)
  -- function num : 0_22 , upvalues : _ENV, NoticeData, JumpManager
  local curHasSectorCOB, curHasOasisCOB = nil, nil
  local isSectorBuildingUnlock = self:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding)
  for id,data in pairs((PlayerDataCenter.AllBuildingData).unbuilt) do
    if data:IsSectorBuilding() and not curHasSectorCOB and isSectorBuildingUnlock and data:CanBuild() then
      curHasSectorCOB = true
    end
    if not curHasOasisCOB and data:CanBuild() then
      curHasOasisCOB = true
    end
  end
  for id,data in pairs((PlayerDataCenter.AllBuildingData).built) do
    if (data.dynData):IsSectorBuilding() and not curHasSectorCOB and isSectorBuildingUnlock and data:CanUpgrade() then
      curHasSectorCOB = true
    end
    if not curHasOasisCOB and data:CanUpgrade() then
      curHasOasisCOB = true
    end
  end
  if not self.isOasisHasCOB and curHasOasisCOB then
    self.isOasisHasCOB = curHasOasisCOB
    NoticeManager:AddNotice((NoticeData.CreateNoticeData)(PlayerDataCenter.timestamp, (NoticeManager.eNoticeType).HasOasisBuildingOperate, {jumpType = (JumpManager.eJumpTarget).Oasis, argList = nil}, nil, nil))
  else
    if self.isOasisHasCOB and not curHasOasisCOB then
      NoticeManager:DeleteNoticeByType((NoticeManager.eNoticeType).HasOasisBuildingOperate)
      self.isOasisHasCOB = curHasOasisCOB
    end
  end
  if not self.isSectorHasCOB and curHasSectorCOB then
    self.isSectorHasCOB = curHasSectorCOB
    NoticeManager:AddNotice((NoticeData.CreateNoticeData)(PlayerDataCenter.timestamp, (NoticeManager.eNoticeType).HasSectorBuildingOperate, {jumpType = (JumpManager.eJumpTarget).Sector, 
argList = {true}
}, nil, nil))
  else
    if self.isSectorHasCOB and not curHasSectorCOB then
      NoticeManager:DeleteNoticeByType((NoticeManager.eNoticeType).HasSectorBuildingOperate)
      self.isSectorHasCOB = curHasSectorCOB
    end
  end
end

HomeController.UpdateOasisGenResourceFull = function(self)
  -- function num : 0_23 , upvalues : _ENV, NoticeData, JumpManager
  for _,buildingData in pairs((PlayerDataCenter.AllBuildingData).oasisBuilt) do
    local datas = buildingData:GetResDatas()
    if datas ~= nil then
      for resId,data in pairs(datas) do
        if data.countMax <= data.count then
          if not self.isOasisHasFullResource then
            self.isOasisHasFullResource = true
            NoticeManager:AddNotice((NoticeData.CreateNoticeData)(PlayerDataCenter.timestamp, (NoticeManager.eNoticeType).ResourceGenerateOverflow, {jumpType = (JumpManager.eJumpTarget).Oasis, argList = nil}, nil, nil))
          end
          return 
        end
      end
    end
  end
  if self.isOasisHasFullResource then
    self.isOasisHasFullResource = false
    NoticeManager:DeleteNoticeByType((NoticeManager.eNoticeType).ResourceGenerateOverflow)
  end
end

HomeController.OnUpdatePlayerName = function(self)
  -- function num : 0_24 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.homeUpNdoe):RefershUserInfo()
  end
end

HomeController.OnUpdateTask = function(self)
  -- function num : 0_25 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.homeLeftNode):RefreshTaskBtn()
  end
end

HomeController.ShowOasisUI = function(self)
  -- function num : 0_26
  if self.isInEnterOasis then
    (self.oasisController):EnterOasis()
  end
end

HomeController.IsEnterOasis = function(self, isEnter)
  -- function num : 0_27
  self.isInEnterOasis = isEnter
end

HomeController.OnUpdateUncompletedEp = function(self)
  -- function num : 0_28 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.homeRightNode):RefreshContinueEp()
  end
end

HomeController.OnUpdateStamina = function(self)
  -- function num : 0_29 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.homeRightNode):RefreshStamina()
  end
end

HomeController.OnUpdateFactoryEnergy = function(self)
  -- function num : 0_30 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.homeRightNode):RefreshFactoryEnergy()
  end
end

HomeController.OnUpdateLotteryCost = function(self, fromeAuto)
  -- function num : 0_31 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.homeRightNode):RefreshLotteryCost(fromeAuto)
  end
end

HomeController.OnUpdateHeroCollectRate = function(self)
  -- function num : 0_32 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.homeRightNode):RefreshCollectRate()
  end
end

HomeController.OnUpdateOasisBuilding = function(self)
  -- function num : 0_33 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.homeRightNode):RefreshBuiltRate()
  end
  self:OnUpdateFactoryEnergy()
end

HomeController.OnUpdateARG = function(self, changedItemNumDic)
  -- function num : 0_34
  self:OnUpdateLotteryCost(true)
end

HomeController.OnUpdateItem = function(self, itemUpdate)
  -- function num : 0_35 , upvalues : _ENV
  self:OnUpdateLotteryCost()
  if itemUpdate[(ConfigData.game_config).factoryEnergyItemId] ~= nil then
    self:OnUpdateFactoryEnergy()
  end
end

HomeController.OnActivityShowChange = function(self)
  -- function num : 0_36 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.homeLeftNode):RefreshActivityShow()
  end
end

HomeController.IsFuncUnlock = function(self, funcId)
  -- function num : 0_37 , upvalues : _ENV
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(funcId)
  if not isUnlock then
    local unlockDes = FunctionUnlockMgr:GetFuncUnlockDecription(funcId)
    return isUnlock, unlockDes
  else
    do
      do return isUnlock, nil end
    end
  end
end

HomeController.AddRedDotEvent = function(self, redDotCallback, ...)
  -- function num : 0_38 , upvalues : _ENV
  local ok, node = RedDotController:GetRedDotNode(...)
  redDotCallback(node:GetRedDotCount())
  local redDotFunc = function(node)
    -- function num : 0_38_0 , upvalues : redDotCallback
    redDotCallback(node:GetRedDotCount())
  end

  -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.redDotFuncDic)[redDotFunc] = node
  RedDotController:AddListener(node.nodePath, redDotFunc)
end

HomeController.RemoveAllRedDotEvent = function(self)
  -- function num : 0_39 , upvalues : _ENV
  for redDotFunc,node in pairs(self.redDotFuncDic) do
    RedDotController:RemoveListener(node.nodePath, redDotFunc)
  end
  self.redDotFuncDic = {}
end

HomeController.GetAdjutant = function(self)
  -- function num : 0_40 , upvalues : _ENV
  if PlayerDataCenter.showGirlId == nil or PlayerDataCenter.showGirlId == 0 then
    local firtBoardHeroID = (ConfigData.game_config).firtBoardHeroID
    if (PlayerDataCenter.heroDic)[firtBoardHeroID] == nil then
      error("default board hero data is nil id " .. firtBoardHeroID)
    else
      return (PlayerDataCenter.heroDic)[firtBoardHeroID]
    end
  else
    do
      do return (PlayerDataCenter.heroDic)[PlayerDataCenter.showGirlId] end
    end
  end
end

HomeController.GetAdjutantHeroId = function(self)
  -- function num : 0_41
  local heroData = self:GetAdjutant()
  if heroData == nil then
    return nil
  end
  return heroData.dataId
end

HomeController.PlayLoginHeroGreeting = function(self)
  -- function num : 0_42 , upvalues : _ENV
  if self.dontPlayCvNextReturnHome then
    self:NextReturnHomeDontPlayCv(false)
    return 
  end
  ;
  (self:GetAdjutantHeroId())
  local heroId = nil
  local voiceId = nil
  local curHour = (TimestampToDate((os.time)())).hour
  if curHour >= 0 and curHour < 6 then
    voiceId = eVoiceType.MIDNIGHT
  else
    if curHour >= 6 and curHour < 12 then
      voiceId = eVoiceType.MORNING
    else
      if curHour >= 12 and curHour < 18 then
        voiceId = eVoiceType.AFTERNOON
      else
        voiceId = eVoiceType.EVENING
      end
    end
  end
  self:PlayHomeVoice(heroId, voiceId)
end

HomeController.PlayVoReturnHome = function(self)
  -- function num : 0_43 , upvalues : _ENV
  if self.dontPlayCvNextReturnHome then
    self:NextReturnHomeDontPlayCv(false)
    return 
  end
  local voiceId = ConfigData:GetVoicePointRandom(1)
  local heroId = self:GetAdjutantHeroId()
  self:PlayHomeVoice(heroId, voiceId)
end

HomeController.PlayVoHomeOnHook = function(self)
  -- function num : 0_44 , upvalues : _ENV
  local voiceId = ConfigData:GetVoicePointRandom(2)
  local heroId = self:GetAdjutantHeroId()
  self:PlayHomeVoice(heroId, voiceId)
end

HomeController.PlayHomeVoice = function(self, heroId, voiceId)
  -- function num : 0_45 , upvalues : _ENV
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  if self.voiceNum == nil then
    self.voiceNum = 0
  end
  if not cvCtr:HasCv(heroId) then
    return 
  end
  local window = UIManager:GetWindow(UIWindowTypeID.Home)
  do
    if window ~= nil then
      local text = cvCtr:GetCvText(heroId, voiceId)
      ;
      (window.homeLeftNode):ShowHeroVoiceText(true, text)
      self.voiceNum = self.voiceNum + 1
    end
    cvCtr:PlayCv(heroId, voiceId, function()
    -- function num : 0_45_0 , upvalues : self, _ENV
    self.voiceNum = self.voiceNum - 1
    if self.voiceNum == 0 then
      local window = UIManager:GetWindow(UIWindowTypeID.Home)
      if window ~= nil then
        (window.homeLeftNode):ShowHeroVoiceText(false)
      end
    end
  end
)
  end
end

HomeController.NextReturnHomeDontPlayCv = function(self, isFrom)
  -- function num : 0_46
  self.dontPlayCvNextReturnHome = isFrom
end

HomeController.OnGesture = function(self, fingerList)
  -- function num : 0_47
  if self.onHookVoiceTimer == nil then
    return 
  end
  ;
  (self.onHookVoiceTimer):Reset()
end

HomeController.PauseHomeOnHookTimer = function(self, pause)
  -- function num : 0_48
  if self.onHookVoiceTimer == nil then
    return 
  end
  if pause then
    (self.onHookVoiceTimer):Pause()
  else
    ;
    (self.onHookVoiceTimer):Reset()
    ;
    (self.onHookVoiceTimer):Resume()
  end
end

HomeController.StopHomeOnHookTimer = function(self)
  -- function num : 0_49 , upvalues : CS_LeanTouch
  if self.onHookVoiceTimer ~= nil then
    (self.onHookVoiceTimer):Stop()
    self.onHookVoiceTimer = nil
    ;
    (CS_LeanTouch.OnGesture)("-", self.__onGesture)
  end
end

HomeController.OnDelete = function(self)
  -- function num : 0_50 , upvalues : _ENV, base
  UpdateManager:RemoveUpdate(self.__OnUpdate)
  MsgCenter:RemoveListener(eMsgEventId.UserNameChanged, self.__OnUpdatePlayerName)
  MsgCenter:RemoveListener(eMsgEventId.TaskSyncFinish, self.__OnUpdateTask)
  MsgCenter:RemoveListener(eMsgEventId.UIOasisShow, self.__UIOasisShow)
  MsgCenter:RemoveListener(eMsgEventId.OnHasUncompletedEp, self.__onUpdateUncompletedEp)
  MsgCenter:RemoveListener(eMsgEventId.StaminaUpdate, self.__OnUpdateStamina)
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__OnUpdateHeroCollectRate)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnUpdateItem)
  MsgCenter:RemoveListener(eMsgEventId.ActivityShowChange, self.__OnActivityShowChange)
  self:_ClearAfterShowCo()
  self.oasisController = nil
  self:RemoveAllRedDotEvent()
  ;
  (base.OnDelete)(self)
end

return HomeController

