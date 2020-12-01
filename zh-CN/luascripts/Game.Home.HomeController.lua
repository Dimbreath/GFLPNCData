-- params : ...
-- function num : 0 , upvalues : _ENV
local HomeController = class("HomeController", ControllerBase)
local base = ControllerBase
local HomeEnum = require("Game.Home.HomeEnum")
local UIBannerData = require("Game.CommonUI.Container.Model.ContainerData")
local HomeSideNoticeData = require("Game.Home.HomeSideNoticeData")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local JumpManager = require("Game.Jump.JumpManager")
HomeController.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, HomeEnum
  self.oasisController = nil
  self.funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
  self.homeState = (HomeEnum.eHomeState).None
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
  self.__OnUpdateOasisBuilding = BindCallback(self, self.OnUpdateOasisBuilding)
  MsgCenter:AddListener(eMsgEventId.BuildingUpgradeComplete, self.__OnUpdateOasisBuilding)
  self.__ListernToNotice = BindCallback(self, self.ListernToNotice)
  MsgCenter:AddListener(eMsgEventId.NewNotice, self.__ListernToNotice)
  self.__ListernToNoticeClean = BindCallback(self, self.ListernToNoticeClean)
  MsgCenter:AddListener(eMsgEventId.CleanNotice, self.__ListernToNoticeClean)
  self.__OnUpdateARG = BindCallback(self, self.OnUpdateARG)
  MsgCenter:AddListener(eMsgEventId.UpdateARGItem, self.__OnUpdateARG)
end

HomeController.OnShowHomeUI = function(self)
  -- function num : 0_1 , upvalues : HomeEnum, _ENV
  if self.homeState == (HomeEnum.eHomeState).Covered then
    self.homeState = (HomeEnum.eHomeState).Normal
    GuideManager:TryTriggerGuide(eGuideCondition.InHome)
    self:OnUpdate(true)
    return 
  end
  self.oasisController = ControllerManager:GetController(ControllerTypeId.OasisController, true)
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  AudioManager:PlayAudioById(3002)
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, (eAuSelct.Home).name, (eAuSelct.Home).base)
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  self.__RefreshBatteryAndTime = BindCallback(homeUI, homeUI.RefreshBatteryAndTime)
  if self.BatteryTimer ~= nil then
    (self.BatteryTimer):Stop()
    self.BatteryTimer = nil
  end
  self.BatteryTimer = (TimerManager:GetTimer(1, self.__RefreshBatteryAndTime, nil, false, false, true)):Start()
  if self.homeState ~= (HomeEnum.eHomeState).Normal then
    self.homeState = (HomeEnum.eHomeState).Normal
    GuideManager:TryTriggerGuide(eGuideCondition.InHome)
    self:OnUpdate(true)
  end
end

HomeController.OnCoverHomeUI = function(self)
  -- function num : 0_2 , upvalues : HomeEnum
  self.homeState = (HomeEnum.eHomeState).Covered
end

HomeController.OnHideHomeUI = function(self)
  -- function num : 0_3 , upvalues : HomeEnum
  self.homeState = (HomeEnum.eHomeState).Hided
  if self.BatteryTimer ~= nil then
    (self.BatteryTimer):Stop()
    self.BatteryTimer = nil
  end
end

HomeController.OnDeleteHomeUI = function(self)
  -- function num : 0_4 , upvalues : _ENV, HomeEnum
  ControllerManager:DeleteController(ControllerTypeId.OasisController)
  self:RemoveAllRedDotEvent()
  self.homeState = (HomeEnum.eHomeState).None
end

HomeController.OnUpdate = function(self, isForce)
  -- function num : 0_5 , upvalues : _ENV
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
  if ((isForce or isSecond) and isForce) or isMin then
    self:UpdateCouldOperateBuilding()
  end
end

HomeController.SetNeedUpdateProduction = function(self, bool, updateEvent)
  -- function num : 0_6
  self.needUpdateProduction = true
  self.updateProductionEvent = updateEvent
end

local m_AddBuildRes = function(allResDic, resData, countMax)
  -- function num : 0_7
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

HomeController.OnUpdateBuildingProduction = function(self)
  -- function num : 0_8 , upvalues : _ENV, m_AddBuildRes, HomeEnum
  if not self.needUpdateProduction then
    return 
  end
  local allResDic = {}
  local allBuildDic = {}
  local hasRes = false
  for buildId,builtData in pairs((PlayerDataCenter.AllBuildingData).built) do
    if builtData ~= nil and builtData.resDatas ~= nil then
      local resDatas = builtData:GetResDatas()
      for itemId,resData in pairs(resDatas) do
        local countMax = (ConfigData.game_config).oasisBuildingOutputCeiling * (resData.speed + resData.effSpeed) // 100
        m_AddBuildRes(allResDic, resData, countMax)
        hasRes = true
        allBuildDic[builtData.id] = true
      end
    end
  end
  local needClean = false
  local stillHaveFull = false
  for resId,data in pairs(allResDic) do
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R11 in 'UnsetPending'

    -- DECOMPILER ERROR at PC61: Unhandled construct in 'MakeBoolean' P1

    if not (self.isNewFull)[data.id] and data.countMax <= data.count then
      (self.isNewFull)[data.id] = true
      stillHaveFull = true
      MsgCenter:Broadcast(eMsgEventId.NewNotice, (HomeEnum.eNoticeType).ResourceGenerateOverflow, PlayerDataCenter.timestamp, nil)
    end
    if data.count < data.countMax then
      if (self.isNewFull)[data.id] then
        needClean = true
      end
      -- DECOMPILER ERROR at PC86: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (self.isNewFull)[data.id] = false
    else
      data.progress = 0
    end
  end
  if needClean and not stillHaveFull then
    MsgCenter:Broadcast(eMsgEventId.CleanNotice, (HomeEnum.eNoticeType).ResourceGenerateOverflow)
  end
  if self.updateProductionEvent ~= nil then
    (self.updateProductionEvent)(allResDic, allBuildDic)
  end
end

HomeController.SetNeedUpdateConstruct = function(self, bool, updateEvent)
  -- function num : 0_9
  self.needUpdateConstruct = bool
  self.updateConstructEvent = updateEvent
end

HomeController.OnUpdateBuildingConstruct = function(self)
  -- function num : 0_10 , upvalues : BuildingBelong, _ENV
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
  -- function num : 0_11 , upvalues : _ENV, HomeEnum
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
    MsgCenter:Broadcast(eMsgEventId.NewNotice, (HomeEnum.eNoticeType).HasOasisBuildingOperate, PlayerDataCenter.timestamp, nil)
  else
    if self.isOasisHasCOB and not curHasOasisCOB then
      MsgCenter:Broadcast(eMsgEventId.CleanNotice, (HomeEnum.eNoticeType).HasOasisBuildingOperate)
      self.isOasisHasCOB = curHasOasisCOB
    end
  end
  if not self.isSectorHasCOB and curHasSectorCOB then
    self.isSectorHasCOB = curHasSectorCOB
    MsgCenter:Broadcast(eMsgEventId.NewNotice, (HomeEnum.eNoticeType).HasSectorBuildingOperate, PlayerDataCenter.timestamp, nil)
  else
    if self.isSectorHasCOB and not curHasSectorCOB then
      MsgCenter:Broadcast(eMsgEventId.CleanNotice, (HomeEnum.eNoticeType).HasSectorBuildingOperate)
      self.isSectorHasCOB = curHasSectorCOB
    end
  end
end

HomeController.OnUpdatePlayerName = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    homeUI:RefreshName()
  end
end

HomeController.OnUpdateTask = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    homeUI:RefreshTaskBtn()
  end
end

HomeController.ShowOasisUI = function(self)
  -- function num : 0_14
  (self.oasisController):EnterOasis()
end

HomeController.OnUpdateUncompletedEp = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.rightList):RefreshContinueEp()
  end
end

HomeController.OnUpdateStamina = function(self)
  -- function num : 0_16 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.rightList):RefreshStamina()
  end
end

HomeController.OnUpdateFactoryEnergy = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.rightList):RefreshFactoryEnergy()
  end
end

HomeController.OnUpdateHeroCollectRate = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.rightList):RefreshCollectRate()
  end
end

HomeController.OnUpdateOasisBuilding = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeUI ~= nil then
    (homeUI.rightList):RefreshBuiltRate()
  end
end

HomeController.OnUpdateARG = function(self, changedItemNumDic)
  -- function num : 0_20
  self:OnUpdateFactoryEnergy()
end

HomeController.IsFuncUnlock = function(self, funcId)
  -- function num : 0_21
  local isUnlock = (self.funcUnLockCrtl):ValidateUnlock(funcId)
  if not isUnlock then
    local unlockDes = (self.funcUnLockCrtl):GetFuncUnlockDecription(funcId)
    return isUnlock, unlockDes
  else
    do
      do return isUnlock, nil end
    end
  end
end

HomeController.AddRedDotEvent = function(self, redDotCallback, ...)
  -- function num : 0_22 , upvalues : _ENV
  local ok, node = RedDotController:GetRedDotNode(...)
  redDotCallback(node:GetRedDotCount())
  local redDotFunc = function(node)
    -- function num : 0_22_0 , upvalues : redDotCallback
    redDotCallback(node:GetRedDotCount())
  end

  -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.redDotFuncDic)[redDotFunc] = node
  RedDotController:AddListener(node.nodePath, redDotFunc)
end

HomeController.RemoveAllRedDotEvent = function(self)
  -- function num : 0_23 , upvalues : _ENV
  for redDotFunc,node in pairs(self.redDotFuncDic) do
    RedDotController:RemoveListener(node.nodePath, redDotFunc)
  end
  self.redDotFuncDic = {}
end

HomeController.GetAdjutant = function(self)
  -- function num : 0_24 , upvalues : _ENV
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

HomeController.GetBannerDatas = function(self)
  -- function num : 0_25 , upvalues : _ENV, UIBannerData
  local channel_id = self:ExchangeChannelId(((CS.MicaSDKManager).Instance).channelId)
  channel_id = 1 << channel_id
  local bannerCfgs = ConfigData.banner
  if bannerCfgs == nil then
    return 
  end
  if self.bannerDatas == nil then
    self.bannerDatas = {}
    for _,v in ipairs(bannerCfgs) do
      if self:CheckBannerValid(channel_id, v) then
        local bannerData = (UIBannerData.New)()
        bannerData:Init(v.pic, v.type, v.jump)
        ;
        (table.insert)(self.bannerDatas, bannerData)
      end
    end
  end
  do
    return self.bannerDatas
  end
end

HomeController.ExchangeChannelId = function(self, channel_id)
  -- function num : 0_26 , upvalues : _ENV
  if channel_id == (Consts.GameChannelType).QATest then
    channel_id = (Consts.GameChannelType).Official
  end
  return channel_id
end

HomeController.CheckBannerValid = function(self, stChannelId, bannerCfg)
  -- function num : 0_27
  if bannerCfg == nil then
    return false
  end
  if bannerCfg.channel & stChannelId > 0 then
    return true
  end
  return false
end

HomeController.GetNoticeData = function(self)
  -- function num : 0_28
  return self.sideNoticeList
end

local noticeFuncTable = {[(HomeEnum.eNoticeType).Mail] = function(self, type, timestamp, data)
  -- function num : 0_29 , upvalues : JumpManager
  self:DeleteNoticeByType(type)
  self:AddNotice2List(timestamp, type, {jumpType = (JumpManager.eJumpTarget).Mail, argList = nil})
end
, [(HomeEnum.eNoticeType).Achievement] = function(self, type, timestamp, data)
  -- function num : 0_30 , upvalues : _ENV, JumpManager
  if self:IsFuncUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement) then
    self:DeleteNoticeByType(type)
    self:AddNotice2List(timestamp, type, {jumpType = (JumpManager.eJumpTarget).Achieve4System, argList = nil})
  end
end
, [(HomeEnum.eNoticeType).ResourceGenerateOverflow] = function(self, type, timestamp, data)
  -- function num : 0_31
  self:DeleteNoticeByType(type)
  self:AddNotice2List(timestamp, type, nil, nil)
end
, [(HomeEnum.eNoticeType).HasOasisBuildingOperate] = function(self, type, timestamp, data)
  -- function num : 0_32 , upvalues : JumpManager
  self:DeleteNoticeByType(type)
  self:AddNotice2List(timestamp, type, {jumpType = (JumpManager.eJumpTarget).Oasis, argList = nil}, nil)
end
, [(HomeEnum.eNoticeType).HasSectorBuildingOperate] = function(self, type, timestamp, data)
  -- function num : 0_33 , upvalues : JumpManager
  self:DeleteNoticeByType(type)
  self:AddNotice2List(timestamp, type, {jumpType = (JumpManager.eJumpTarget).Sector, 
argList = {true}
}, nil)
end
, [(HomeEnum.eNoticeType).FragDungeonRefresh] = function(self, type, timestamp, data)
  -- function num : 0_34 , upvalues : _ENV, JumpManager
  self:DeleteNoticeByType(type)
  local heroId = (ConfigData.game_config).firtBoardHeroID
  self:AddNotice2List(timestamp, type, {jumpType = (JumpManager.eJumpTarget).fragDungeon, 
argList = {heroId}
}, nil)
end
, [(HomeEnum.eNoticeType).ResDungeonRefresh] = function(self, type, timestamp, data)
  -- function num : 0_35 , upvalues : JumpManager
  self:DeleteNoticeByType(type)
  self:AddNotice2List(timestamp, type, {jumpType = (JumpManager.eJumpTarget).resourceDungeon, 
argList = {data.targetId}
}, nil)
end
}
HomeController.AddNotice2List = function(self, timeStamp, type, jumpInfo, noticeStrList, extrId)
  -- function num : 0_36 , upvalues : HomeSideNoticeData, _ENV, HomeEnum
  local left = 1
  local right = #self.sideNoticeList
  local mid = nil
  while 1 do
    while 1 do
      if left <= right then
        mid = (left + right) // 2
        if timeStamp <= ((self.sideNoticeList)[mid]).timeStamp then
          left = mid + 1
          -- DECOMPILER ERROR at PC14: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC14: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC14: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC14: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    right = mid - 1
  end
  local noticeData = (HomeSideNoticeData.CreateNoticeData)(timeStamp, type, jumpInfo, noticeStrList, extrId)
  ;
  (table.insert)(self.sideNoticeList, left, noticeData)
  if self.homeState ~= (HomeEnum.eHomeState).Hided then
    local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeUI ~= nil then
      homeUI:AddNewNotice(noticeData)
    end
  end
end

HomeController.DeleteNotice = function(self, noticeData)
  -- function num : 0_37 , upvalues : _ENV
  (table.removebyvalue)(self.sideNoticeList, noticeData)
end

HomeController.DeleteNoticeByType = function(self, type)
  -- function num : 0_38 , upvalues : _ENV
  for i = #self.sideNoticeList, 1, -1 do
    if ((self.sideNoticeList)[i]).type == type then
      (table.remove)(self.sideNoticeList, i)
    end
  end
end

HomeController.ListernToNotice = function(self, type, timestamp, data)
  -- function num : 0_39 , upvalues : noticeFuncTable, _ENV
  if noticeFuncTable[type] ~= nil then
    (noticeFuncTable[type])(self, type, timestamp, data)
  end
  if self.sideNoticeList ~= nil then
    local noticeNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Notice)
    local redDotCount = self:FilterRedDotCount(self.sideNoticeList)
    noticeNode:SetRedDotCount(redDotCount)
  end
end

HomeController.ListernToNoticeClean = function(self, type, ...)
  -- function num : 0_40 , upvalues : _ENV, HomeEnum
  local num = select("#", ...)
  if num > 0 then
    if type == (HomeEnum.eNoticeType).OasisBuildingFinish then
      local buildingId = select(1, ...)
      for index,data in ipairs(self.sideNoticeList) do
        if buildingId == data.extrId then
          self:DeleteNotice(data)
        end
      end
    else
      do
        if type == (HomeEnum.eNoticeType).SectorBuildingFinish then
          local buildingId = select(1, ...)
          for index,data in ipairs(self.sideNoticeList) do
            if buildingId == data.extrId then
              self:DeleteNotice(data)
            end
          end
        end
        do
          self:DeleteNoticeByType(type)
          if self.sideNoticeList ~= nil then
            local redDotCount = self:FilterRedDotCount(self.sideNoticeList)
            local noticeNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.MainSide, RedDotStaticTypeId.Notice)
            noticeNode:SetRedDotCount(redDotCount)
          end
        end
      end
    end
  end
end

HomeController.FilterRedDotCount = function(self, sideNoticeList)
  -- function num : 0_41 , upvalues : _ENV, HomeEnum
  local redDotCount = #sideNoticeList
  for k,v in ipairs(sideNoticeList) do
    if v ~= nil and (v.type == (HomeEnum.eNoticeType).OasisBuildingFinish or v.type == (HomeEnum.eNoticeType).SectorBuildingFinish or v.type == (HomeEnum.eNoticeType).ResourceGenerateOverflow or v.type == (HomeEnum.eNoticeType).HasOasisBuildingOperate or v.type == (HomeEnum.eNoticeType).HasSectorBuildingOperate) then
      redDotCount = redDotCount - 1
    end
  end
  return redDotCount
end

HomeController.OnDelete = function(self)
  -- function num : 0_42 , upvalues : _ENV, base
  UpdateManager:RemoveUpdate(self.__OnUpdate)
  MsgCenter:RemoveListener(eMsgEventId.UserNameChanged, self.__OnUpdatePlayerName)
  MsgCenter:RemoveListener(eMsgEventId.TaskSyncFinish, self.__OnUpdateTask)
  MsgCenter:RemoveListener(eMsgEventId.UIOasisShow, self.__UIOasisShow)
  MsgCenter:RemoveListener(eMsgEventId.OnHasUncompletedEp, self.__onUpdateUncompletedEp)
  MsgCenter:RemoveListener(eMsgEventId.StaminaUpdate, self.__OnUpdateStamina)
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__OnUpdateHeroCollectRate)
  MsgCenter:RemoveListener(eMsgEventId.NewNotice, self.__ListernToNotice)
  MsgCenter:RemoveListener(eMsgEventId.CleanNotice, self.__ListernToNoticeClean)
  MsgCenter:RemoveListener(eMsgEventId.BuildingUpgradeComplete, self.__OnUpdateOasisBuilding)
  self.oasisController = nil
  self:RemoveAllRedDotEvent()
  ;
  (base.OnDelete)(self)
end

return HomeController

-- params : ...
-- function num : 0 , upvalues : _ENV
local HomeController = class("HomeController", ControllerBase)
local base = ControllerBase
local HomeEnum = require("Game.Home.HomeEnum")
local UIBannerData = require("Game.CommonUI.Container.Model.ContainerData")
local HomeSideNoticeData = require("Game.Home.HomeSideNoticeData")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local JumpManager = require("Game.Jump.JumpManager")
HomeController.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, HomeEnum
    self.oasisController = nil
    self.funcUnLockCrtl = ControllerManager:GetController(
                              ControllerTypeId.FunctionUnlock, true)
    self.homeState = (HomeEnum.eHomeState).None
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
    self.__OnUpdate = BindCallback(self, self.OnUpdate)
    UpdateManager:AddUpdate(self.__OnUpdate)
    self.__OnUpdatePlayerName = BindCallback(self, self.OnUpdatePlayerName)
    MsgCenter:AddListener(eMsgEventId.UserNameChanged, self.__OnUpdatePlayerName)
    self.__OnUpdateTask = BindCallback(self, self.OnUpdateTask)
    MsgCenter:AddListener(eMsgEventId.TaskSyncFinish, self.__OnUpdateTask)
    self.__UIOasisShow = BindCallback(self, self.ShowOasisUI)
    MsgCenter:AddListener(eMsgEventId.UIOasisShow, self.__UIOasisShow)
    self.__onUpdateUncompletedEp =
        BindCallback(self, self.OnUpdateUncompletedEp)
    MsgCenter:AddListener(eMsgEventId.OnHasUncompletedEp,
                          self.__onUpdateUncompletedEp)
    self.__OnUpdateStamina = BindCallback(self, self.OnUpdateStamina)
    MsgCenter:AddListener(eMsgEventId.StaminaUpdate, self.__OnUpdateStamina)
    self.__OnUpdateHeroCollectRate = BindCallback(self,
                                                  self.OnUpdateHeroCollectRate)
    MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__OnUpdateHeroCollectRate)
    self.__OnUpdateOasisBuilding =
        BindCallback(self, self.OnUpdateOasisBuilding)
    MsgCenter:AddListener(eMsgEventId.BuildingUpgradeComplete,
                          self.__OnUpdateOasisBuilding)
    self.__ListernToNotice = BindCallback(self, self.ListernToNotice)
    MsgCenter:AddListener(eMsgEventId.NewNotice, self.__ListernToNotice)
    self.__ListernToNoticeClean = BindCallback(self, self.ListernToNoticeClean)
    MsgCenter:AddListener(eMsgEventId.CleanNotice, self.__ListernToNoticeClean)
    self.__OnUpdateARG = BindCallback(self, self.OnUpdateARG)
    MsgCenter:AddListener(eMsgEventId.UpdateARGItem, self.__OnUpdateARG)
end

HomeController.OnShowHomeUI = function(self)
    -- function num : 0_1 , upvalues : HomeEnum, _ENV
    if self.homeState == (HomeEnum.eHomeState).Covered then
        self.homeState = (HomeEnum.eHomeState).Normal
        GuideManager:TryTriggerGuide(eGuideCondition.InHome)
        self:OnUpdate(true)
        return
    end
    self.oasisController = ControllerManager:GetController(
                               ControllerTypeId.OasisController, true)
    self.factoryController = ControllerManager:GetController(
                                 ControllerTypeId.Factory, false)
    AudioManager:PlayAudioById(3002)
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource,
                                        (eAuSelct.Home).name,
                                        (eAuSelct.Home).base)
    local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
    self.__RefreshBatteryAndTime = BindCallback(homeUI,
                                                homeUI.RefreshBatteryAndTime)
    if self.BatteryTimer ~= nil then
        (self.BatteryTimer):Stop()
        self.BatteryTimer = nil
    end
    self.BatteryTimer = (TimerManager:GetTimer(1, self.__RefreshBatteryAndTime,
                                               nil, false, false, true)):Start()
    if self.homeState ~= (HomeEnum.eHomeState).Normal then
        self.homeState = (HomeEnum.eHomeState).Normal
        GuideManager:TryTriggerGuide(eGuideCondition.InHome)
        self:OnUpdate(true)
    end
end

HomeController.OnCoverHomeUI = function(self)
    -- function num : 0_2 , upvalues : HomeEnum
    self.homeState = (HomeEnum.eHomeState).Covered
end

HomeController.OnHideHomeUI = function(self)
    -- function num : 0_3 , upvalues : HomeEnum
    self.homeState = (HomeEnum.eHomeState).Hided
    if self.BatteryTimer ~= nil then
        (self.BatteryTimer):Stop()
        self.BatteryTimer = nil
    end
end

HomeController.OnDeleteHomeUI = function(self)
    -- function num : 0_4 , upvalues : _ENV, HomeEnum
    ControllerManager:DeleteController(ControllerTypeId.OasisController)
    self:RemoveAllRedDotEvent()
    self.homeState = (HomeEnum.eHomeState).None
end

HomeController.OnUpdate = function(self, isForce)
    -- function num : 0_5 , upvalues : _ENV
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
    if ((isForce or isSecond) and isForce) or isMin then
        self:UpdateCouldOperateBuilding()
    end
end

HomeController.SetNeedUpdateProduction =
    function(self, bool, updateEvent)
        -- function num : 0_6
        self.needUpdateProduction = true
        self.updateProductionEvent = updateEvent
    end

local m_AddBuildRes = function(allResDic, resData, countMax)
    -- function num : 0_7
    local allResData = allResDic[resData.id]
    if allResData == nil then
        allResData = {
            id = resData.id,
            name = resData.name,
            count = resData.count,
            speed = resData.speed,
            effSpeed = resData.effSpeed,
            progress = resData.progress,
            countMax = countMax
        }
        allResDic[resData.id] = allResData
    else
        allResData.effSpeed = allResData.effSpeed + resData.effSpeed
        allResData.speed = allResData.speed + resData.speed
        allResData.count = allResData.count + resData.count
        allResData.countMax = allResData.countMax + countMax
    end
end

HomeController.OnUpdateBuildingProduction =
    function(self)
        -- function num : 0_8 , upvalues : _ENV, m_AddBuildRes, HomeEnum
        if not self.needUpdateProduction then return end
        local allResDic = {}
        local allBuildDic = {}
        local hasRes = false
        for buildId, builtData in
            pairs((PlayerDataCenter.AllBuildingData).built) do
            if builtData ~= nil and builtData.resDatas ~= nil then
                local resDatas = builtData:GetResDatas()
                for itemId, resData in pairs(resDatas) do
                    local countMax =
                        (ConfigData.game_config).oasisBuildingOutputCeiling *
                            (resData.speed + resData.effSpeed) // 100
                    m_AddBuildRes(allResDic, resData, countMax)
                    hasRes = true
                    allBuildDic[builtData.id] = true
                end
            end
        end
        local needClean = false
        local stillHaveFull = false
        for resId, data in pairs(allResDic) do
            -- DECOMPILER ERROR at PC61: Confused about usage of register: R11 in 'UnsetPending'

            -- DECOMPILER ERROR at PC61: Unhandled construct in 'MakeBoolean' P1

            if not (self.isNewFull)[data.id] and data.countMax <= data.count then
                (self.isNewFull)[data.id] = true
                stillHaveFull = true
                MsgCenter:Broadcast(eMsgEventId.NewNotice,
                                    (HomeEnum.eNoticeType).ResourceGenerateOverflow,
                                    PlayerDataCenter.timestamp, nil)
            end
            if data.count < data.countMax then
                if (self.isNewFull)[data.id] then
                    needClean = true
                end -- DECOMPILER ERROR at PC86: Confused about usage of register: R11 in 'UnsetPending'
                
                (self.isNewFull)[data.id] = false
            else
                data.progress = 0
            end
        end
        if needClean and not stillHaveFull then
            MsgCenter:Broadcast(eMsgEventId.CleanNotice,
                                (HomeEnum.eNoticeType).ResourceGenerateOverflow)
        end
        if self.updateProductionEvent ~= nil then
            (self.updateProductionEvent)(allResDic, allBuildDic)
        end
    end

HomeController.SetNeedUpdateConstruct = function(self, bool, updateEvent)
    -- function num : 0_9
    self.needUpdateConstruct = bool
    self.updateConstructEvent = updateEvent
end

HomeController.OnUpdateBuildingConstruct =
    function(self)
        -- function num : 0_10 , upvalues : BuildingBelong, _ENV
        if not self.needUpdateConstruct then return end
        local constructingBuildingLists =
            {[BuildingBelong.Oasis] = {}, [BuildingBelong.Sector] = {}}
        for _, builtData in ipairs((PlayerDataCenter.AllBuildingData).builtSort) do
            builtData:GetProcess(PlayerDataCenter.timestamp)
            if builtData.state == proto_object_BuildingState.BuildingStateCreate or
                builtData.state ==
                proto_object_BuildingState.BuildingStateUpgrade then
                (table.insert)(constructingBuildingLists[builtData.belong],
                               builtData)
            end
        end
        if self.updateConstructEvent ~= nil then
            (self.updateConstructEvent)(constructingBuildingLists)
        end
    end

HomeController.UpdateCouldOperateBuilding =
    function(self)
        -- function num : 0_11 , upvalues : _ENV, HomeEnum
        local curHasSectorCOB, curHasOasisCOB = nil, nil
        local isSectorBuildingUnlock = self:IsFuncUnlock(
                                           proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding)
        for id, data in pairs((PlayerDataCenter.AllBuildingData).unbuilt) do
            if data:IsSectorBuilding() and not curHasSectorCOB and
                isSectorBuildingUnlock and data:CanBuild() then
                curHasSectorCOB = true
            end
            if not curHasOasisCOB and data:CanBuild() then
                curHasOasisCOB = true
            end
        end
        for id, data in pairs((PlayerDataCenter.AllBuildingData).built) do
            if (data.dynData):IsSectorBuilding() and not curHasSectorCOB and
                isSectorBuildingUnlock and data:CanUpgrade() then
                curHasSectorCOB = true
            end
            if not curHasOasisCOB and data:CanUpgrade() then
                curHasOasisCOB = true
            end
        end
        if not self.isOasisHasCOB and curHasOasisCOB then
            self.isOasisHasCOB = curHasOasisCOB
            MsgCenter:Broadcast(eMsgEventId.NewNotice,
                                (HomeEnum.eNoticeType).HasOasisBuildingOperate,
                                PlayerDataCenter.timestamp, nil)
        else
            if self.isOasisHasCOB and not curHasOasisCOB then
                MsgCenter:Broadcast(eMsgEventId.CleanNotice,
                                    (HomeEnum.eNoticeType).HasOasisBuildingOperate)
                self.isOasisHasCOB = curHasOasisCOB
            end
        end
        if not self.isSectorHasCOB and curHasSectorCOB then
            self.isSectorHasCOB = curHasSectorCOB
            MsgCenter:Broadcast(eMsgEventId.NewNotice,
                                (HomeEnum.eNoticeType).HasSectorBuildingOperate,
                                PlayerDataCenter.timestamp, nil)
        else
            if self.isSectorHasCOB and not curHasSectorCOB then
                MsgCenter:Broadcast(eMsgEventId.CleanNotice,
                                    (HomeEnum.eNoticeType).HasSectorBuildingOperate)
                self.isSectorHasCOB = curHasSectorCOB
            end
        end
    end

HomeController.OnUpdatePlayerName = function(self)
    -- function num : 0_12 , upvalues : _ENV
    local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeUI ~= nil then homeUI:RefreshName() end
end

HomeController.OnUpdateTask = function(self)
    -- function num : 0_13 , upvalues : _ENV
    local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeUI ~= nil then homeUI:RefreshTaskBtn() end
end

HomeController.ShowOasisUI = function(self)
    -- function num : 0_14
    (self.oasisController):EnterOasis()
end

HomeController.OnUpdateUncompletedEp = function(self)
    -- function num : 0_15 , upvalues : _ENV
    local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeUI ~= nil then (homeUI.rightList):RefreshContinueEp() end
end

HomeController.OnUpdateStamina = function(self)
    -- function num : 0_16 , upvalues : _ENV
    local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeUI ~= nil then (homeUI.rightList):RefreshStamina() end
end

HomeController.OnUpdateFactoryEnergy = function(self)
    -- function num : 0_17 , upvalues : _ENV
    local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeUI ~= nil then (homeUI.rightList):RefreshFactoryEnergy() end
end

HomeController.OnUpdateHeroCollectRate =
    function(self)
        -- function num : 0_18 , upvalues : _ENV
        local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
        if homeUI ~= nil then (homeUI.rightList):RefreshCollectRate() end
    end

HomeController.OnUpdateOasisBuilding = function(self)
    -- function num : 0_19 , upvalues : _ENV
    local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeUI ~= nil then (homeUI.rightList):RefreshBuiltRate() end
end

HomeController.OnUpdateARG = function(self, changedItemNumDic)
    -- function num : 0_20
    self:OnUpdateFactoryEnergy()
end

HomeController.IsFuncUnlock = function(self, funcId)
    -- function num : 0_21
    local isUnlock = (self.funcUnLockCrtl):ValidateUnlock(funcId)
    if not isUnlock then
        local unlockDes = (self.funcUnLockCrtl):GetFuncUnlockDecription(funcId)
        return isUnlock, unlockDes
    else
        do do return isUnlock, nil end end
    end
end

HomeController.AddRedDotEvent = function(self, redDotCallback, ...)
    -- function num : 0_22 , upvalues : _ENV
    local ok, node = RedDotController:GetRedDotNode(...)
    redDotCallback(node:GetRedDotCount())
    local redDotFunc = function(node)
        -- function num : 0_22_0 , upvalues : redDotCallback
        redDotCallback(node:GetRedDotCount())
    end -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'
    ;
    (self.redDotFuncDic)[redDotFunc] = node
    RedDotController:AddListener(node.nodePath, redDotFunc)
end

HomeController.RemoveAllRedDotEvent = function(self)
    -- function num : 0_23 , upvalues : _ENV
    for redDotFunc, node in pairs(self.redDotFuncDic) do
        RedDotController:RemoveListener(node.nodePath, redDotFunc)
    end
    self.redDotFuncDic = {}
end

HomeController.GetAdjutant = function(self)
    -- function num : 0_24 , upvalues : _ENV
    if PlayerDataCenter.showGirlId == nil or PlayerDataCenter.showGirlId == 0 then
        local firtBoardHeroID = (ConfigData.game_config).firtBoardHeroID
        if (PlayerDataCenter.heroDic)[firtBoardHeroID] == nil then
            error("default board hero data is nil id " .. firtBoardHeroID)
        else
            return (PlayerDataCenter.heroDic)[firtBoardHeroID]
        end
    else
        do
            do
                return (PlayerDataCenter.heroDic)[PlayerDataCenter.showGirlId]
            end
        end
    end
end

HomeController.GetBannerDatas = function(self)
    -- function num : 0_25 , upvalues : _ENV, UIBannerData
    local channel_id = self:ExchangeChannelId(
                           ((CS.MicaSDKManager).Instance).channelId)
    channel_id = 1 << channel_id
    local bannerCfgs = ConfigData.banner
    if bannerCfgs == nil then return end
    if self.bannerDatas == nil then
        self.bannerDatas = {}
        for _, v in ipairs(bannerCfgs) do
            if self:CheckBannerValid(channel_id, v) then
                local bannerData = (UIBannerData.New)()
                bannerData:Init(v.pic, v.type, v.jump);
                (table.insert)(self.bannerDatas, bannerData)
            end
        end
    end
    do return self.bannerDatas end
end

HomeController.ExchangeChannelId = function(self, channel_id)
    -- function num : 0_26 , upvalues : _ENV
    if channel_id == (Consts.GameChannelType).QATest then
        channel_id = (Consts.GameChannelType).Official
    end
    return channel_id
end

HomeController.CheckBannerValid = function(self, stChannelId, bannerCfg)
    -- function num : 0_27
    if bannerCfg == nil then return false end
    if bannerCfg.channel & stChannelId > 0 then return true end
    return false
end

HomeController.GetNoticeData = function(self)
    -- function num : 0_28
    return self.sideNoticeList
end

local noticeFuncTable = {
    [(HomeEnum.eNoticeType).Mail] = function(self, type, timestamp, data)
        -- function num : 0_29 , upvalues : JumpManager
        self:DeleteNoticeByType(type)
        self:AddNotice2List(timestamp, type, {
            jumpType = (JumpManager.eJumpTarget).Mail,
            argList = nil
        })
    end,
    [(HomeEnum.eNoticeType).Achievement] = function(self, type, timestamp, data)
        -- function num : 0_30 , upvalues : _ENV, JumpManager
        if self:IsFuncUnlock(
            proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement) then
            self:DeleteNoticeByType(type)
            self:AddNotice2List(timestamp, type, {
                jumpType = (JumpManager.eJumpTarget).Achieve4System,
                argList = nil
            })
        end
    end,
    [(HomeEnum.eNoticeType).ResourceGenerateOverflow] = function(self, type,
                                                                 timestamp, data)
        -- function num : 0_31
        self:DeleteNoticeByType(type)
        self:AddNotice2List(timestamp, type, nil, nil)
    end,
    [(HomeEnum.eNoticeType).HasOasisBuildingOperate] = function(self, type,
                                                                timestamp, data)
        -- function num : 0_32 , upvalues : JumpManager
        self:DeleteNoticeByType(type)
        self:AddNotice2List(timestamp, type, {
            jumpType = (JumpManager.eJumpTarget).Oasis,
            argList = nil
        }, nil)
    end,
    [(HomeEnum.eNoticeType).HasSectorBuildingOperate] = function(self, type,
                                                                 timestamp, data)
        -- function num : 0_33 , upvalues : JumpManager
        self:DeleteNoticeByType(type)
        self:AddNotice2List(timestamp, type, {
            jumpType = (JumpManager.eJumpTarget).Sector,
            argList = {true}
        }, nil)
    end,
    [(HomeEnum.eNoticeType).FragDungeonRefresh] = function(self, type,
                                                           timestamp, data)
        -- function num : 0_34 , upvalues : _ENV, JumpManager
        self:DeleteNoticeByType(type)
        local heroId = (ConfigData.game_config).firtBoardHeroID
        self:AddNotice2List(timestamp, type, {
            jumpType = (JumpManager.eJumpTarget).fragDungeon,
            argList = {heroId}
        }, nil)
    end,
    [(HomeEnum.eNoticeType).ResDungeonRefresh] = function(self, type, timestamp,
                                                          data)
        -- function num : 0_35 , upvalues : JumpManager
        self:DeleteNoticeByType(type)
        self:AddNotice2List(timestamp, type, {
            jumpType = (JumpManager.eJumpTarget).resourceDungeon,
            argList = {data.targetId}
        }, nil)
    end
}
HomeController.AddNotice2List = function(self, timeStamp, type, jumpInfo,
                                         noticeStrList, extrId)
    -- function num : 0_36 , upvalues : HomeSideNoticeData, _ENV, HomeEnum
    local left = 1
    local right = #self.sideNoticeList
    local mid = nil
    while 1 do
        while 1 do
            if left <= right then
                mid = (left + right) // 2
                if timeStamp <= ((self.sideNoticeList)[mid]).timeStamp then
                    left = mid + 1
                    -- DECOMPILER ERROR at PC14: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC14: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC14: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC14: LeaveBlock: unexpected jumping out IF_STMT

                end
            end
        end
        right = mid - 1
    end
    local noticeData = (HomeSideNoticeData.CreateNoticeData)(timeStamp, type,
                                                             jumpInfo,
                                                             noticeStrList,
                                                             extrId);
    (table.insert)(self.sideNoticeList, left, noticeData)
    if self.homeState ~= (HomeEnum.eHomeState).Hided then
        local homeUI = UIManager:GetWindow(UIWindowTypeID.Home)
        if homeUI ~= nil then homeUI:AddNewNotice(noticeData) end
    end
end

HomeController.DeleteNotice = function(self, noticeData)
    -- function num : 0_37 , upvalues : _ENV
    (table.removebyvalue)(self.sideNoticeList, noticeData)
end

HomeController.DeleteNoticeByType = function(self, type)
    -- function num : 0_38 , upvalues : _ENV
    for i = #self.sideNoticeList, 1, -1 do
        if ((self.sideNoticeList)[i]).type == type then
            (table.remove)(self.sideNoticeList, i)
        end
    end
end

HomeController.ListernToNotice = function(self, type, timestamp, data)
    -- function num : 0_39 , upvalues : noticeFuncTable, _ENV
    if noticeFuncTable[type] ~= nil then
        (noticeFuncTable[type])(self, type, timestamp, data)
    end
    if self.sideNoticeList ~= nil then
        local noticeNode = RedDotController:AddRedDotNode(
                               RedDotStaticTypeId.Main,
                               RedDotStaticTypeId.MainSide,
                               RedDotStaticTypeId.Notice)
        local redDotCount = self:FilterRedDotCount(self.sideNoticeList)
        noticeNode:SetRedDotCount(redDotCount)
    end
end

HomeController.ListernToNoticeClean = function(self, type, ...)
    -- function num : 0_40 , upvalues : _ENV, HomeEnum
    local num = select("#", ...)
    if num > 0 then
        if type == (HomeEnum.eNoticeType).OasisBuildingFinish then
            local buildingId = select(1, ...)
            for index, data in ipairs(self.sideNoticeList) do
                if buildingId == data.extrId then
                    self:DeleteNotice(data)
                end
            end
        else
            do
                if type == (HomeEnum.eNoticeType).SectorBuildingFinish then
                    local buildingId = select(1, ...)
                    for index, data in ipairs(self.sideNoticeList) do
                        if buildingId == data.extrId then
                            self:DeleteNotice(data)
                        end
                    end
                end
                do
                    self:DeleteNoticeByType(type)
                    if self.sideNoticeList ~= nil then
                        local redDotCount =
                            self:FilterRedDotCount(self.sideNoticeList)
                        local noticeNode =
                            RedDotController:AddRedDotNode(
                                RedDotStaticTypeId.Main,
                                RedDotStaticTypeId.MainSide,
                                RedDotStaticTypeId.Notice)
                        noticeNode:SetRedDotCount(redDotCount)
                    end
                end
            end
        end
    end
end

HomeController.FilterRedDotCount = function(self, sideNoticeList)
    -- function num : 0_41 , upvalues : _ENV, HomeEnum
    local redDotCount = #sideNoticeList
    for k, v in ipairs(sideNoticeList) do
        if v ~= nil and
            (v.type == (HomeEnum.eNoticeType).OasisBuildingFinish or v.type ==
                (HomeEnum.eNoticeType).SectorBuildingFinish or v.type ==
                (HomeEnum.eNoticeType).ResourceGenerateOverflow or v.type ==
                (HomeEnum.eNoticeType).HasOasisBuildingOperate or v.type ==
                (HomeEnum.eNoticeType).HasSectorBuildingOperate) then
            redDotCount = redDotCount - 1
        end
    end
    return redDotCount
end

HomeController.OnDelete = function(self)
    -- function num : 0_42 , upvalues : _ENV, base
    UpdateManager:RemoveUpdate(self.__OnUpdate)
    MsgCenter:RemoveListener(eMsgEventId.UserNameChanged,
                             self.__OnUpdatePlayerName)
    MsgCenter:RemoveListener(eMsgEventId.TaskSyncFinish, self.__OnUpdateTask)
    MsgCenter:RemoveListener(eMsgEventId.UIOasisShow, self.__UIOasisShow)
    MsgCenter:RemoveListener(eMsgEventId.OnHasUncompletedEp,
                             self.__onUpdateUncompletedEp)
    MsgCenter:RemoveListener(eMsgEventId.StaminaUpdate, self.__OnUpdateStamina)
    MsgCenter:RemoveListener(eMsgEventId.UpdateHero,
                             self.__OnUpdateHeroCollectRate)
    MsgCenter:RemoveListener(eMsgEventId.NewNotice, self.__ListernToNotice)
    MsgCenter:RemoveListener(eMsgEventId.CleanNotice,
                             self.__ListernToNoticeClean)
    MsgCenter:RemoveListener(eMsgEventId.BuildingUpgradeComplete,
                             self.__OnUpdateOasisBuilding)
    self.oasisController = nil
    self:RemoveAllRedDotEvent();
    (base.OnDelete)(self)
end

return HomeController

