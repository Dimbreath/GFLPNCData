local HomeController = class("HomeController", ControllerBase)
local base = ControllerBase
local HomeEnum = require("Game.Home.HomeEnum")
local UIBannerData = require("Game.CommonUI.Container.Model.ContainerData")
local NoticeData = require("Game.Notice.NoticeData")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local JumpManager = require("Game.Jump.JumpManager")
local util = require("XLua.Common.xlua_util")
local CheckerTypeId, _ = (table.unpack)(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
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
  self.isLive2D = false
  self.__isLogin = true
  self.__live2DOver = true
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
  self.__OnPlayerLevelChange = BindCallback(self, self.OnPlayerLevelChange)
  MsgCenter:AddListener(eMsgEventId.UpdatePlayerLevel, self.__OnPlayerLevelChange)
  self.AutoShowCommandList = {}
  self.__onGesture = BindCallback(self, self.OnGesture)
  self.__tryRunNextAutoShow = BindCallback(self, self.__TryRunNextAutoShow)
end

HomeController.OnInitHomeUI = function(self)
  -- function num : 0_1 , upvalues : _ENV, CS_LeanTouch
  if self.onHookVoiceTimerId == nil then
    self.onHookVoiceTimerId = TimerManager:StartTimer((ConfigData.buildinConfig).HomeOnHookVoiceTime, function()
    -- function num : 0_1_0 , upvalues : self
    self:PlayVoHomeOnHook()
  end
, nil, false)
  else
    self:PauseHomeOnHookTimer(false)
  end
  ;
  (CS_LeanTouch.OnGesture)("+", self.__onGesture)
  self.SceneBingding = nil
  local mainCamera = UIManager:GetMainCamera()
  local bind = mainCamera:FindComponent(eUnityComponentID.LuaBinding)
  self._warfareEffect = bind:GetBind("warfareEffect")
  self._centerImgRender = bind:GetBind("commandCentre_Image")
  self._mat_scene_Warfare = bind:GetBind("mat_scene_Warfare")
  self._mat_scene_Day = bind:GetBind("mat_scene_Day")
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
    self.__wait4Guide = true
    self:_ChangeHomeState((HomeEnum.eHomeState).Normal)
    TimerManager:AddLateCommand(function()
    -- function num : 0_3_0 , upvalues : JumpManager, _ENV, self
    if JumpManager:IsHaveBack2Home() then
      JumpManager:TryCallBack2HomeMsgFunc((UIUtil.backStack):Empty())
      return 
    end
    if JumpManager.isJumping then
      return 
    end
    GuideManager:TryTriggerGuide(eGuideCondition.InHome)
    self.__wait4Guide = false
    self:__StartShowHomeCo()
  end
)
    self:OnUpdate(true)
    MsgCenter:Broadcast(eMsgEventId.OnOpenHomeUI)
    return 
  end
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  if self.homeState ~= (HomeEnum.eHomeState).Normal then
    self.__wait4Guide = true
    self:_ChangeHomeState((HomeEnum.eHomeState).Normal)
    TimerManager:AddLateCommand(function()
    -- function num : 0_3_1 , upvalues : JumpManager, self, _ENV
    if JumpManager:IsHaveBack2Home() and not self.isRewindingBack2HomeTimeLine then
      JumpManager:TryCallBack2HomeMsgFunc((UIUtil.backStack):Empty())
    end
    do return  end
    if JumpManager.isJumping then
      return 
    end
    GuideManager:TryTriggerGuide(eGuideCondition.InHome)
    self.__wait4Guide = false
    self:__StartShowHomeCo()
  end
)
    self:OnUpdate(true)
  end
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
  self:HideWarfarEffect()
  if self.__CheckInWarfarStage ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.PreCondition, self.__CheckInWarfarStage)
    self.__CheckInWarfarStage = nil
  end
  self._warfareEffect = nil
  self._centerImgRender = nil
  self._mat_scene_Warfare = nil
  self._mat_scene_Day = nil
end

HomeController._ChangeHomeState = function(self, state)
  -- function num : 0_7 , upvalues : cs_Input, HomeEnum, JumpManager, _ENV
  self.homeState = state
  cs_Input.multiTouchEnabled = state ~= (HomeEnum.eHomeState).Normal
  JumpManager.couldUseItemJump = state == (HomeEnum.eHomeState).Normal
  ;
  ((CS.RenderManager).Instance):SetShaderLODGlobal(self:IsNormalState() and 400 or 600)
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    local fakeCameraHome = homeUI.fakeCameraHome
    local camera = fakeCameraHome:GetComponent("Camera")
    homeUI:AlignToFakeCamera(camera, self:IsNormalState() and camera or nil)
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

HomeController.IsNormalState = function(self)
  -- function num : 0_8 , upvalues : HomeEnum
  do return self.homeState == (HomeEnum.eHomeState).Normal end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HomeController.OnAutoShowOver = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self.__startOpenHomeAutoShow and self.__isLogin then
    self:PlayLoginHeroGreeting()
    self.__startOpenHomeAutoShow = nil
    self.__isLogin = false
  end
  self.isRunningAutoShow = false
  NoticeManager:ContinueShowNotice("homePop")
  NoticeManager:ForceContinueShowNotice()
end

HomeController.__TryRunNextAutoShow = function(self, isEnter)
  -- function num : 0_10 , upvalues : _ENV, HomeEnum
  if isEnter then
    self.isRunningAutoShow = true
    if #self.AutoShowCommandList > 0 then
      NoticeManager:PuaseShowNotice("homePop")
    end
  end
  if self.homeState ~= (HomeEnum.eHomeState).Normal then
    self.isRunningAutoShow = false
    return 
  end
  if #self.AutoShowCommandList <= 0 then
    self:OnAutoShowOver()
  end
  local command = (table.remove)(self.AutoShowCommandList, 1)
  if command == (HomeEnum.eAutoShwoCommand).Pay then
    (ControllerManager:GetController(ControllerTypeId.Pay, true)):TryShowPayResult(self.__tryRunNextAutoShow)
    return 
  end
  if command == (HomeEnum.eAutoShwoCommand).GameNotice then
    self:TryShowGameNotice()
    return 
  end
  do
    if command == (HomeEnum.eAutoShwoCommand).NoviceSign then
      local signIdList = (PlayerDataCenter.eventNoviceSignData):GetSortSignDataIdList()
      for k,signId in ipairs(signIdList) do
        if self:TryShowEventNoviceSign(signId) then
          return 
        end
      end
      return 
    end
    if command == (HomeEnum.eAutoShwoCommand).Singin then
      self:TryCollectSinginReward()
      return 
    end
  end
end

HomeController.__StartShowHomeCo = function(self)
  -- function num : 0_11 , upvalues : _ENV, HomeEnum
  self.__startOpenHomeAutoShow = true
  self.AutoShowCommandList = {}
  if GuideManager.inGuide then
    return 
  end
  if (ControllerManager:GetController(ControllerTypeId.Pay, true)):GetCouldSHowPayResult() then
    (table.insert)(self.AutoShowCommandList, (HomeEnum.eAutoShwoCommand).Pay)
  end
  if self:ValidCouldOpenGameNotice() then
    (table.insert)(self.AutoShowCommandList, (HomeEnum.eAutoShwoCommand).GameNotice)
  end
  for activityId,data in pairs((PlayerDataCenter.eventNoviceSignData).dataDic) do
    if self:ValidCouldOpenNoviceSign(activityId) then
      (table.insert)(self.AutoShowCommandList, (HomeEnum.eAutoShwoCommand).NoviceSign)
    end
  end
  if self:ValidCouldOpenSinginReward() then
    (table.insert)(self.AutoShowCommandList, (HomeEnum.eAutoShwoCommand).Singin)
  end
  if not self.isRunningAutoShow then
    self:__TryRunNextAutoShow(true)
  end
end

HomeController.AddAutoShowGuide = function(self, autoShowType, isNolyAddGuide)
  -- function num : 0_12 , upvalues : _ENV
  (table.insert)(self.AutoShowCommandList, autoShowType)
  if isNolyAddGuide then
    return 
  end
  self:TryRunAutoShow()
end

HomeController.TryRunAutoShow = function(self)
  -- function num : 0_13 , upvalues : JumpManager, HomeEnum
  if not JumpManager.isJumping and not self.__wait4Guide and not self.isRunningAutoShow and self.homeState == (HomeEnum.eHomeState).Normal then
    self:__TryRunNextAutoShow(true)
  end
end

HomeController.ValidCouldOpenSinginReward = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if GuideManager.inGuide or not self:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SignIn) then
    return false
  end
  local mailController = ControllerManager:GetController(ControllerTypeId.Mail, false)
  if mailController == nil then
    return false
  end
  local notPickedSinginMailUIDList = mailController:GetSignInRewardMailUIDs(self.__isNotFirstGetSignInReward, true)
  if #notPickedSinginMailUIDList <= 0 then
    return false
  end
  return true
end

HomeController.TryCollectSinginReward = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if not self:ValidCouldOpenSinginReward() then
    self:__TryRunNextAutoShow()
    return 
  end
  local mailController = ControllerManager:GetController(ControllerTypeId.Mail, false)
  local notPickedSinginMailUIDList = mailController:GetSignInRewardMailUIDs(self.__isNotFirstGetSignInReward)
  self.__isNotFirstGetSignInReward = true
  UIManager:ShowWindowAsync(UIWindowTypeID.EventSignin, function(window)
    -- function num : 0_15_0 , upvalues : self, notPickedSinginMailUIDList
    window:SetCloseCallback(self.__tryRunNextAutoShow)
    window:InitEventSignin(nil, notPickedSinginMailUIDList)
  end
)
  return true
end

HomeController.ValidCouldOpenNoviceSign = function(self, id)
  -- function num : 0_16 , upvalues : _ENV
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

HomeController.TryShowEventNoviceSign = function(self, id)
  -- function num : 0_17 , upvalues : _ENV
  if not self:ValidCouldOpenNoviceSign(id) then
    return 
  end
  local data = ((PlayerDataCenter.eventNoviceSignData).dataDic)[id]
  data:SetPoped()
  if data:IsFestivalSign() then
    UIManager:ShowWindowAsync(UIWindowTypeID.EventFestivalSignIn, function(window)
    -- function num : 0_17_0 , upvalues : self, id
    window:SetCloseCallback(self.__tryRunNextAutoShow)
    window:InitEventFestivalSignIn(id, true)
  end
)
  else
    UIManager:ShowWindowAsync(UIWindowTypeID.EventNoviceSign, function(window)
    -- function num : 0_17_1 , upvalues : self, id
    window:SetCloseCallback(self.__tryRunNextAutoShow)
    window:InitNoviceSign(id, true)
  end
)
  end
  return true
end

HomeController.ValidCouldOpenGameNotice = function(self)
  -- function num : 0_18 , upvalues : _ENV
  if GuideManager.inGuide then
    return false
  end
  if (CS.ClientConsts).IsAudit then
    return false
  end
  local ctrl = ControllerManager:GetController(ControllerTypeId.GameNotice)
  local canPush = ctrl:CanAutoPushGameNotice()
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Notice)
  return not canPush or isUnlock
end

HomeController.TryShowGameNotice = function(self)
  -- function num : 0_19 , upvalues : _ENV
  if not self:ValidCouldOpenGameNotice() then
    self:__TryRunNextAutoShow()
    return 
  end
  UIManager:CreateWindowAsync(UIWindowTypeID.GameNotice, function(win)
    -- function num : 0_19_0 , upvalues : self
    if win == nil then
      return 
    end
    win:SetCloseCallback(self.__tryRunNextAutoShow)
    win:InitUIGameNotice(false)
  end
)
  return true
end

HomeController.OnUpdate = function(self, isForce)
  -- function num : 0_20 , upvalues : _ENV
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
  if isMin then
    (PlayerDataCenter.friendDataCenter):RefreshFriendApplyReddotNum()
  end
  if isForce or isMin then
    self:UpdateCouldOperateBuilding()
    self:UpdateOasisGenResourceFull()
    self:UpdateIsFactoryLineOver()
  end
end

HomeController.SetNeedUpdateProduction = function(self, bool, updateEvent)
  -- function num : 0_21
  self.needUpdateProduction = true
  self.updateProductionEvent = updateEvent
end

local m_AddBuildRes = function(allResDic, resData, countMax)
  -- function num : 0_22
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
  -- function num : 0_23
  self.needUpdateConstruct = bool
  self.updateConstructEvent = updateEvent
end

HomeController.OnUpdateBuildingConstruct = function(self)
  -- function num : 0_24 , upvalues : BuildingBelong, _ENV
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
  -- function num : 0_25 , upvalues : _ENV, NoticeData, JumpManager
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
  -- function num : 0_26 , upvalues : _ENV, NoticeData, JumpManager
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

HomeController.UpdateIsFactoryLineOver = function(self)
  -- function num : 0_27 , upvalues : _ENV
  local isFactoryUnlock = self:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Factory)
  if isFactoryUnlock then
    local factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
    if factoryController == nil or factoryController.factoryMainUI ~= nil then
      return 
    end
    factoryController:RefreshFactoryRedDot()
  end
end

HomeController.OnUpdatePlayerName = function(self)
  -- function num : 0_28 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.homeUpNdoe):RefershUserInfo()
  end
end

HomeController.OnUpdateTask = function(self)
  -- function num : 0_29 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.homeLeftNode):RefreshTaskBtn()
  end
end

HomeController.ShowOasisUI = function(self)
  -- function num : 0_30
  if self.isInEnterOasis then
    (self.oasisController):EnterOasis()
  end
end

HomeController.IsEnterOasis = function(self, isEnter)
  -- function num : 0_31
  self.isInEnterOasis = isEnter
end

HomeController.OnUpdateUncompletedEp = function(self)
  -- function num : 0_32 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.homeRightNode):RefreshContinueEp()
  end
end

HomeController.OnUpdateStamina = function(self)
  -- function num : 0_33 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.homeRightNode):RefreshStamina()
  end
end

HomeController.OnUpdateFactoryEnergy = function(self)
  -- function num : 0_34 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.homeRightNode):RefreshFactoryEnergy()
  end
end

HomeController.OnUpdateLotteryCost = function(self, fromeAuto)
  -- function num : 0_35 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.homeRightNode):RefreshLotteryCost(fromeAuto)
  end
end

HomeController.OnUpdateHeroCollectRate = function(self)
  -- function num : 0_36 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.homeRightNode):RefreshCollectRate()
  end
end

HomeController.OnUpdateOasisBuilding = function(self)
  -- function num : 0_37 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.homeRightNode):RefreshBuiltRate()
  end
  self:OnUpdateFactoryEnergy()
end

HomeController.OnUpdateARG = function(self, changedItemNumDic)
  -- function num : 0_38
  self:OnUpdateLotteryCost(true)
end

HomeController.OnUpdateItem = function(self, itemUpdate)
  -- function num : 0_39 , upvalues : _ENV
  self:OnUpdateLotteryCost()
  if itemUpdate[(ConfigData.game_config).factoryEnergyItemId] ~= nil then
    self:OnUpdateFactoryEnergy()
  end
end

HomeController.OnActivityShowChange = function(self)
  -- function num : 0_40 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.homeLeftNode):RefreshActivityShow()
  end
end

HomeController.OnPlayerLevelChange = function(self)
  -- function num : 0_41 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.homeUpNdoe):RefershUserInfo()
  end
end

HomeController.IsFuncUnlock = function(self, funcId)
  -- function num : 0_42 , upvalues : _ENV
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
  -- function num : 0_43 , upvalues : _ENV
  local ok, node = RedDotController:GetRedDotNode(...)
  redDotCallback(node:GetRedDotCount())
  local redDotFunc = function(node)
    -- function num : 0_43_0 , upvalues : redDotCallback
    redDotCallback(node:GetRedDotCount())
  end

  -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.redDotFuncDic)[redDotFunc] = node
  RedDotController:AddListener(node.nodePath, redDotFunc)
end

HomeController.RemoveAllRedDotEvent = function(self)
  -- function num : 0_44 , upvalues : _ENV
  for redDotFunc,node in pairs(self.redDotFuncDic) do
    RedDotController:RemoveListener(node.nodePath, redDotFunc)
  end
  self.redDotFuncDic = {}
end

HomeController.GetAdjutant = function(self)
  -- function num : 0_45 , upvalues : _ENV
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
  -- function num : 0_46
  local heroData = self:GetAdjutant()
  if heroData == nil then
    return nil
  end
  return heroData.dataId
end

HomeController.setIsLive2D = function(self, flag)
  -- function num : 0_47 , upvalues : _ENV
  self.isLive2D = flag
  self.__live2DOver = true
  TimerManager:StopTimer(self.__animTimerId)
end

HomeController.PlayLoginHeroGreeting = function(self)
  -- function num : 0_48 , upvalues : _ENV
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
  local window = (UIManager:GetWindow(UIWindowTypeID.Home))
  local IsCvOverBank = nil
  if window ~= nil and window.homeAdjutant ~= nil and (window.homeAdjutant).heroCubismInteration ~= nil then
    ((window.homeAdjutant).heroCubismInteration):PlayLoginAnimation(voiceId)
    IsCvOverBank = ((window.homeAdjutant).heroCubismInteration).IsCvOverBank
  end
  self:PlayHomeVoice(heroId, voiceId, IsCvOverBank)
end

HomeController.TryPlayVoReturnHome = function(self)
  -- function num : 0_49 , upvalues : _ENV
  if self.dontPlayCvNextReturnHome then
    self:NextReturnHomeDontPlayCv(false)
    return false
  end
  if self.isLive2D == false then
    local voiceId = ConfigData:GetVoicePointRandom(1)
    local heroId = self:GetAdjutantHeroId()
    self:PlayHomeVoice(heroId, voiceId)
  else
    do
      do
        local window = UIManager:GetWindow(UIWindowTypeID.Home)
        if window == nil or window.homeAdjutant == nil or (window.homeAdjutant).heroCubismInteration == nil then
          return false
        end
        ;
        ((window.homeAdjutant).heroCubismInteration):PlayHeroLive2DWait()
        return true
      end
    end
  end
end

HomeController.PlayVoHomeOnHook = function(self)
  -- function num : 0_50 , upvalues : _ENV
  if self.isLive2D == false then
    local voiceId = ConfigData:GetVoicePointRandom(2)
    local heroId = self:GetAdjutantHeroId()
    self:PlayHomeVoice(heroId, voiceId)
  end
end

HomeController.PlayHomeVoice = function(self, heroId, voiceId, cvOverBackFun, animLength)
  -- function num : 0_51 , upvalues : _ENV
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
    if cvOverBackFun ~= nil then
      cvOverBackFun(false)
    end
    local OpenMouseListen = self:JudgeMouseOpen()
    if animLength ~= nil and self.isLive2D then
      self.__live2DOver = false
      TimerManager:StopTimer(self.__animTimerId)
      self.__animTimerId = TimerManager:StartTimer(animLength, function()
    -- function num : 0_51_0 , upvalues : self
    self.__live2DOver = true
    self:TryResetShowHeroVoice()
  end
)
    end
    cvCtr:PlayCv(heroId, voiceId, function()
    -- function num : 0_51_1 , upvalues : self, cvOverBackFun
    self.voiceNum = self.voiceNum - 1
    self:TryResetShowHeroVoice()
    if cvOverBackFun ~= nil then
      cvOverBackFun(true)
    end
  end
, OpenMouseListen)
  end
end

HomeController.TryResetShowHeroVoice = function(self)
  -- function num : 0_52 , upvalues : _ENV
  if self.voiceNum == 0 and self.__live2DOver then
    local window = UIManager:GetWindow(UIWindowTypeID.Home)
    if window ~= nil then
      (window.homeLeftNode):ShowHeroVoiceText(false)
    end
  end
end

HomeController.JudgeMouseOpen = function(self)
  -- function num : 0_53 , upvalues : _ENV
  if self.homeCurrAdjutantHeroData == nil then
    return false
  end
  local search = nil
  if (self.homeCurrAdjutantHeroData).skinId == 0 then
    search = (self.homeCurrAdjutantHeroData).dataId
  else
    search = (self.homeCurrAdjutantHeroData).skinId
  end
  if (ConfigData.skin_live2d)[search] == nil or ((ConfigData.skin_live2d)[search]).mouth_shape == 1 then
    return true
  else
    return false
  end
end

HomeController.NextReturnHomeDontPlayCv = function(self, isFrom)
  -- function num : 0_54
  self.dontPlayCvNextReturnHome = isFrom
end

HomeController.OnGesture = function(self, fingerList)
  -- function num : 0_55 , upvalues : _ENV
  if self.onHookVoiceTimerId == nil then
    return 
  end
  TimerManager:ResetTimer(self.onHookVoiceTimerId)
end

HomeController.PauseHomeOnHookTimer = function(self, pause)
  -- function num : 0_56 , upvalues : _ENV
  if self.onHookVoiceTimerId == nil then
    return 
  end
  if self.isLive2D then
    local window = UIManager:GetWindow(UIWindowTypeID.Home)
    if window ~= nil then
      (window.homeAdjutant):IsOpenLive2DWait(not pause)
    end
  else
    do
      if pause then
        TimerManager:PauseTimer(self.onHookVoiceTimerId)
      else
        TimerManager:ResetTimer(self.onHookVoiceTimerId)
        TimerManager:ResumeTimer(self.onHookVoiceTimerId)
      end
    end
  end
end

HomeController.StopHomeOnHookTimer = function(self)
  -- function num : 0_57 , upvalues : _ENV, CS_LeanTouch
  if self.onHookVoiceTimerId ~= nil then
    TimerManager:StopTimer(self.onHookVoiceTimerId)
    self.onHookVoiceTimerId = nil
    ;
    (CS_LeanTouch.OnGesture)("-", self.__onGesture)
  end
end

HomeController.HideWarfarEffect = function(self)
  -- function num : 0_58
  self:__SetWarfarState(false)
end

HomeController.CheckAndSetWarfarStage = function(self, conditionId)
  -- function num : 0_59 , upvalues : CheckerTypeId, _ENV, HomeEnum
  if conditionId ~= nil and conditionId ~= CheckerTypeId.CompleteStage then
    return 
  end
  local isEnd = (PlayerDataCenter.sectorStage):IsStageComplete((ConfigData.game_config).warfarEndEpl)
  if isEnd and self.__CheckInWarfarStage ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.PreCondition, self.__CheckInWarfarStage)
    self.__CheckInWarfarStage = nil
  else
    if not isEnd and self.__CheckInWarfarStage == nil then
      self.__CheckInWarfarStage = BindCallback(self, self.CheckAndSetWarfarStage)
      MsgCenter:AddListener(eMsgEventId.PreCondition, self.__CheckInWarfarStage)
    end
  end
  local isInDuring = (not isEnd and (PlayerDataCenter.sectorStage):IsStageComplete((ConfigData.game_config).warfarStartEpl))
  isInDuring = not isInDuring or self.homeState == (HomeEnum.eHomeState).Normal
  self:__SetWarfarState(isInDuring)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

HomeController.__SetWarfarState = function(self, flag)
  -- function num : 0_60 , upvalues : _ENV
  if IsNull(self._warfareEffect) or (self._warfareEffect).activeInHierarchy == flag then
    return 
  end
  ;
  (self._warfareEffect):SetActive(flag)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

  if not IsNull(self._centerImgRender) and (not flag or not self._mat_scene_Warfare) then
    (self._centerImgRender).material = self._mat_scene_Day
  end
end

HomeController.ResetWarfarState = function(self)
  -- function num : 0_61 , upvalues : _ENV
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  if not IsNull(self._centerImgRender) and ((self._centerImgRender).gameObject).activeInHierarchy then
    (self._centerImgRender).material = self._mat_scene_Warfare
  end
end

HomeController.OnDelete = function(self)
  -- function num : 0_62 , upvalues : _ENV, base
  UpdateManager:RemoveUpdate(self.__OnUpdate)
  MsgCenter:RemoveListener(eMsgEventId.UserNameChanged, self.__OnUpdatePlayerName)
  MsgCenter:RemoveListener(eMsgEventId.TaskSyncFinish, self.__OnUpdateTask)
  MsgCenter:RemoveListener(eMsgEventId.UIOasisShow, self.__UIOasisShow)
  MsgCenter:RemoveListener(eMsgEventId.OnHasUncompletedEp, self.__onUpdateUncompletedEp)
  MsgCenter:RemoveListener(eMsgEventId.StaminaUpdate, self.__OnUpdateStamina)
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__OnUpdateHeroCollectRate)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnUpdateItem)
  MsgCenter:RemoveListener(eMsgEventId.ActivityShowChange, self.__OnActivityShowChange)
  MsgCenter:RemoveListener(eMsgEventId.UpdatePlayerLevel, self.__OnPlayerLevelChange)
  if self.__CheckInWarfarStage ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.PreCondition, self.__CheckInWarfarStage)
    self.__CheckInWarfarStage = nil
  end
  self.oasisController = nil
  TimerManager:StopTimer(self.__animTimerId)
  self:RemoveAllRedDotEvent()
  ;
  (base.OnDelete)(self)
end

return HomeController

