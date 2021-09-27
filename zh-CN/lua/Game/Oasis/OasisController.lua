local OasisController = class("OasisController", ControllerBase)
local base = ControllerBase
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local cs_Physics = CS.PhysicsUtility
local cs_InputUtility = CS.InputUtility
local cs_Camera = (CS.UnityEngine).Camera
local cs_CameraController = CS.OasisCameraController
local cs_GameObject = (CS.UnityEngine).GameObject
local cs_LeanTouch = ((CS.Lean).Touch).LeanTouch
local cs_SkyController = CS.SkyController
local OasisEnum = require("Game.Oasis.OasisEnum")
local OasisBuildingItem = require("Game.Oasis.OasisBuildingItem")
local CoordinateConvert = require("Game.Oasis.OasisCoordinateConvert")
local BuildingCanvas = require("Game.Oasis.UI.UIOasisBuildingCanvas")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local BuildingUIModel = require("Game.Oasis.Data.OasisBuildingUIModel")
local util = require("XLua.Common.xlua_util")
local OasisBuildEffectEntity = require("Game.Oasis.Entity.OasisBuildEffectEntity")
local OasisAreaEntity = require("Game.Oasis.Entity.OasisAreaEntity")
local JumpManager = require("Game.Jump.JumpManager")
local OasisSkyCtrl = require("Game.Oasis.Ctrl.OasisSkyCtrl")
local InputMode = {None = 0, ConstructBuilding = 1, MoveBuilding = 2, ClickBuilding = 3}
local eBuildMapState = {Obstacle = 1, Built = 2}
OasisController.ctor = function(self)
  -- function num : 0_0 , upvalues : OasisSkyCtrl, _ENV, InputMode
  self.ctrls = {}
  self.oasisSkyCtrl = (OasisSkyCtrl.New)(self)
  self.__onFingerDown = BindCallback(self, self.OnFingerDown)
  self.__onFingerSet = BindCallback(self, self.OnFingerSet)
  self.__onFingerUp = BindCallback(self, self.OnFingerUp)
  self.__onFingerTap = BindCallback(self, self.OnFingerTap)
  self.__cancelNewBuilding = BindCallback(self, self.CancelNewBuilding)
  self.__startConstruct = BindCallback(self, self.StartConstruct)
  self.__cancelBuildMove = BindCallback(self, self.CancelBuildMove)
  self.__reqBuildMove = BindCallback(self, self.ReqBuildMove)
  self.__ChangeBgmFunc = BindCallback(self, self.__ChangeBgm)
  self.__selectedBuilding = nil
  self.__originalPosition = nil
  self.__inputMode = InputMode.None
end

OasisController.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, cs_ResLoader, cs_GameObject, CoordinateConvert, cs_SkyController, cs_CameraController, util, OasisEnum
  (self.oasisSkyCtrl):InitOasisSkyCtrl()
  self.__update__handle = BindCallback(self, self.OnUpdate)
  UpdateManager:AddUpdate(self.__update__handle)
  self.__lateUpdateHandle = BindCallback(self, self.OnLateUpdate)
  UpdateManager:AddLateUpdate(self.__lateUpdateHandle)
  self.buildingItems = {}
  self.hidenBuildingItems = {}
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Building)
  self.oldBuildingItem = nil
  self.newBuildingItem = nil
  self.resloader = (cs_ResLoader.Create)()
  self.screenEdge = 20
  self.edgeMoveSpeed = 60
  self:InitData()
  local contentName = "BuildingContent"
  local path = PathConsts:GetOasisBuildingPrefabPath(contentName)
  local prefab = (self.resloader):LoadABAsset(path)
  local obj = prefab:Instantiate()
  obj.name = contentName
  self.buildingContent = obj.transform
  self.bind = {}
  ;
  (UIUtil.LuaUIBindingTable)(obj, self.bind)
  ;
  (((self.bind).effects).gameObject):SetActive(false)
  local groundCollider = (self.bind).groundCollider
  for k,oasisArea in ipairs(self.oasisAreaList) do
    local areaGo = cs_GameObject("Area" .. tostring(k))
    ;
    (areaGo.transform):SetParent(self.buildingContent)
    oasisArea.gameObject = areaGo
    oasisArea.transform = areaGo.transform
    local ground = groundCollider:Instantiate(areaGo.transform)
    ground.name = tostring(k)
    local cfg = (ConfigData.oasis_area)[k]
    if cfg == nil then
      error("Can\'t find oasis_area, id = " .. tostring(k))
    else
      if #cfg.offset ~= 3 then
        error("oasis_area offset error, id = " .. tostring(k))
      else
        -- DECOMPILER ERROR at PC129: Confused about usage of register: R14 in 'UnsetPending'

        ;
        (areaGo.transform).localPosition = (Vector3.New)((cfg.offset)[1], (cfg.offset)[2], (cfg.offset)[3])
        local areaX = cfg.size * 2 * (CoordinateConvert.GetHexWidth)()
        -- DECOMPILER ERROR at PC142: Confused about usage of register: R15 in 'UnsetPending'

        ;
        (ground.transform).localScale = (Vector3.New)(areaX, 1, areaX)
      end
    end
  end
  groundCollider:SetActive(false)
  -- DECOMPILER ERROR at PC150: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (cs_SkyController.Instance).OnDayChange = self.__ChangeBgmFunc
  self.topViewDirector = (cs_CameraController.Instance):GetTopViewDirector()
  self.focusDirector = (cs_CameraController.Instance):GetFocusDirector()
  self.__initCo = (GR.StartCoroutine)((util.cs_generator)(BindCallback(self, self.InitBuilding)))
  self.confirmOverEvent = BindCallback(self, self.__SendConfimOver)
  self._returnEffectFunc = BindCallback(self, self.ReturnOasisEffectEntity)
  self._effectPool = {}
  self._effectInUseDic = {}
  self.__oasisState = (OasisEnum.OasisState).None
end

OasisController.InitData = function(self)
  -- function num : 0_2 , upvalues : _ENV, eBuildMapState
  self.oasisAreaList = {}
  for k,v in ipairs(ConfigData.oasis_area) do
    local oasisArea = {}
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.oasisAreaList)[v.id] = oasisArea
    oasisArea.id = v.id
    oasisArea.buildingMap = {}
    oasisArea.cfg = v
    local radius = (oasisArea.cfg).size
    local n = radius - 1
    for x = -n, n do
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R13 in 'UnsetPending'

      (oasisArea.buildingMap)[x] = {}
    end
    self:BuildInMap(v.id, v.dirty_spots, true, eBuildMapState.Obstacle)
  end
  self.buildingDatas = PlayerDataCenter.AllBuildingData
end

OasisController.InitBuilding = function(self)
  -- function num : 0_3 , upvalues : _ENV, OasisAreaEntity, cs_SkyController
  self.areaRuinEntityDic = {}
  self.areaRuinGoDic = {}
  self.areaLockFxDic = {}
  while not (PlayerDataCenter.AllBuildingData):IsBuildingDataInited() do
    (coroutine.yield)(nil)
  end
  for k,v in pairs((self.buildingDatas).oasisBuilt) do
    self:CreateBuilding(v)
  end
  for k,item in pairs(self.buildingItems) do
    item:LoadBuildingGo()
    while item:BuildGoIsInLoading() do
      (coroutine.yield)(nil)
    end
  end
  for areaId,areaData in ipairs(self.oasisAreaList) do
    local areaCfg = areaData.cfg
    local unlock = (PlayerDataCenter.AllBuildingData):OsisAreaUnlock(areaId)
    if not unlock then
      local ruinWait = (self.resloader):LoadABAssetAsyncAwait(PathConsts:GetOasisPrefabPath("Ruins/" .. areaCfg.lock_prefab))
      ;
      (coroutine.yield)(ruinWait)
      local go = (ruinWait.Result):Instantiate((self.bind).ruinsHolder)
      local areaEntity = (OasisAreaEntity.New)(go)
      areaEntity:InitOasisAreaEntity(areaId)
      -- DECOMPILER ERROR at PC81: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (self.areaRuinEntityDic)[areaId] = areaEntity
      -- DECOMPILER ERROR at PC83: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (self.areaRuinGoDic)[go] = areaEntity
      local fxPath = "Area/" .. areaCfg.lock_fx
      local fxWait = (self.resloader):LoadABAssetAsyncAwait(PathConsts:GetOasisBuildingEffetPrefabPath(fxPath))
      ;
      (coroutine.yield)(fxWait)
      local effectEntity = self:GetOasisEffectEntity(fxPath)
      effectEntity:InitOasisBuildEffectEntity(nil, (self.bind).effects)
      effectEntity:UpdateOasisAreaFxState(areaId)
      -- DECOMPILER ERROR at PC110: Confused about usage of register: R14 in 'UnsetPending'

      ;
      (self.areaLockFxDic)[areaId] = effectEntity
    end
  end
  ;
  (cs_SkyController.Instance):RefreshEmission()
end

OasisController.InjectJumpEvent = function(self, jumpEvent)
  -- function num : 0_4
  self.jumpEvent = function()
    -- function num : 0_4_0 , upvalues : jumpEvent, self
    jumpEvent()
    self.jumpEvent = nil
  end

end

OasisController.IsOasisNormalState = function(self)
  -- function num : 0_5 , upvalues : OasisEnum
  do return self.__oasisState == (OasisEnum.OasisState).Normal end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

OasisController.__ChangeBgm = function(self, isDay)
  -- function num : 0_6 , upvalues : _ENV
  if not self.isEnter then
    local isEnd = (PlayerDataCenter.sectorStage):IsStageComplete((ConfigData.game_config).warfarEndEpl)
    local isInDuring = (not isEnd and (PlayerDataCenter.sectorStage):IsStageComplete((ConfigData.game_config).warfarStartEpl))
    if isInDuring then
      AudioManager:PlayAudioById(3004)
      local homeCtrl = ControllerManager:GetController(ControllerTypeId.HomeController)
      if homeCtrl ~= nil then
        homeCtrl:ResetWarfarState()
      end
      return 
    end
  end
  AudioManager:PlayAudioById(3002)
  if isDay then
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, (eAuSelct.Home).name, (eAuSelct.Home).oasisDay)
  elseif self.isEnter then
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, (eAuSelct.Home).name, (eAuSelct.Home).oasisNight)
  else
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, (eAuSelct.Home).name, (eAuSelct.Home).base)
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

OasisController.EnterOasis = function(self)
  -- function num : 0_7 , upvalues : JumpManager, BuildingUIModel, cs_CameraController, cs_LeanTouch, _ENV, BuildingCanvas, InputMode, cs_SkyController, BuildingBelong, OasisEnum, util
  JumpManager.couldUseItemJump = true
  if self.oasisUIModel == nil then
    self.oasisUIModel = (BuildingUIModel.New)(self.buildingDatas)
  else
    ;
    (self.oasisUIModel):UpdateBuildingData(self.buildingDatas)
  end
  self.__mainCam = (cs_CameraController.Instance).MainCamera
  ;
  (cs_CameraController.Instance):DragEnable(true)
  ;
  (cs_LeanTouch.OnFingerDown)("+", self.__onFingerDown)
  ;
  (cs_LeanTouch.OnFingerSet)("+", self.__onFingerSet)
  ;
  (cs_LeanTouch.OnFingerUp)("+", self.__onFingerUp)
  ;
  (cs_LeanTouch.OnFingerTap)("+", self.__onFingerTap)
  local enterFunc = function()
    -- function num : 0_7_0 , upvalues : _ENV, self, BuildingCanvas, InputMode, cs_SkyController, BuildingBelong, OasisEnum
    for areaId,areaData in ipairs(self.oasisAreaList) do
      local effectEntity = (self.areaLockFxDic)[areaId]
      if effectEntity ~= nil and (PlayerDataCenter.AllBuildingData):OsisAreaUnlock(areaId) then
        self:ReturnOasisEffectEntity(effectEntity)
        -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (self.areaLockFxDic)[areaId] = nil
      end
    end
    ;
    (((self.bind).effects).gameObject):SetActive(true)
    self.canvas = (BuildingCanvas.New)()
    local canvasWait = (self.resloader):LoadABAssetAsyncAwait(PathConsts:GetUIPrefabPath("BuildingCanvasOasis"))
    ;
    (coroutine.yield)(canvasWait)
    local go = (canvasWait.Result):Instantiate()
    ;
    (self.canvas):Init(go)
    for k,v in pairs(self.buildingItems) do
      v:SetCanvas(self.canvas)
      v:UpdateState()
    end
    self.__inputMode = InputMode.ClickBuilding
    self.isEnter = true
    self:__ChangeBgm((cs_SkyController.Instance).IsDay)
    self.__ConfirmOver = BindCallback(self, self.UpgradeConfirmOver)
    MsgCenter:AddListener(eMsgEventId.BuildingUpgradeComplete, self.__ConfirmOver)
    self.__UpdateProcessEvent = BindCallback(self, self.UpdateProcessEvent)
    MsgCenter:AddListener(eMsgEventId.UpdateBuildingProcess, self.__UpdateProcessEvent)
    self.__onItemRefresh = BindCallback(self, self._OnItemRefresh)
    MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemRefresh)
    MsgCenter:AddListener(eMsgEventId.UpdateARGItem, self.__onItemRefresh)
    self.__onSectorStageStateChange = BindCallback(self, self.__OnSctStageStateChange)
    MsgCenter:AddListener(eMsgEventId.OnSectorStageStateChange, self.__onSectorStageStateChange)
    local queueCtrl = ControllerManager:GetController(ControllerTypeId.BuildingQueue, true)
    queueCtrl:InitBuildQueueCtrl(BuildingBelong.Oasis)
    UIManager:ShowWindowAsync(UIWindowTypeID.OasisMain, function(window)
      -- function num : 0_7_0_0 , upvalues : _ENV, self, OasisEnum
      if window == nil then
        return 
      end
      UIManager:HideWindow(UIWindowTypeID.ClickContinue)
      window:InitOasisMain(self)
      self.__oasisState = (OasisEnum.OasisState).Normal
      if GuideManager:TryTriggerGuide(eGuideCondition.InOassisBuildingDetail) then
      end
    end
)
    ;
    (coroutine.yield)(((CS.UnityEngine).WaitForSeconds)(2))
    while UIManager:GetWindow(UIWindowTypeID.OasisMain) == nil do
      (coroutine.yield)(nil)
    end
    for k,v in pairs(self.buildingItems) do
      v:UpdateBuildingResUI()
    end
  end

  self.__enterCoroutine = (GR.StartCoroutine)((util.cs_generator)(enterFunc))
end

OasisController.TopViewTween = function(self, toTop)
  -- function num : 0_8 , upvalues : _ENV
  if toTop then
    ((self.topViewDirector).gameObject):SetActive(true)
    ;
    (TimelineUtil.Play)(self.topViewDirector)
    self:__ShowResidentUI(false)
  else
    ;
    (TimelineUtil.Rewind)(self.topViewDirector, BindCallback(self, self.__TopViewTweenRewindCompelte))
  end
end

OasisController.__TopViewTweenRewindCompelte = function(self)
  -- function num : 0_9
  self:__ShowResidentUI(true)
  ;
  ((self.topViewDirector).gameObject):SetActive(false)
end

OasisController.EnterEditMode = function(self)
  -- function num : 0_10 , upvalues : _ENV, InputMode, OasisEnum
  local editWindow = UIManager:ShowWindow(UIWindowTypeID.OasisEditWindow)
  editWindow:InitOasisEditor(self)
  self.__inputMode = InputMode.MoveBuilding
  self.__oasisState = (OasisEnum.OasisState).EditorBuild
  self:TopViewTween(true)
  local window = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if window ~= nil then
    (window.oasisSelectNode):Hide()
  end
  if self.canvas ~= nil then
    (self.canvas):SetBuildCanvasTopMode(true)
  end
  self:UnselectOasisBuilding(true)
end

OasisController.ExitEditMode = function(self)
  -- function num : 0_11 , upvalues : InputMode, OasisEnum
  if self.newBuildingItem ~= nil then
    self:CancelNewBuilding()
  end
  self.__inputMode = InputMode.ClickBuilding
  self.__oasisState = (OasisEnum.OasisState).Normal
  self:__ResetSelectedBuilding()
  self:UnselectOasisBuilding(false)
  self:TopViewTween(false)
  if self.canvas ~= nil then
    (self.canvas):SetBuildCanvasTopMode(false)
  end
end

OasisController.EnterOasisSkyMode = function(self)
  -- function num : 0_12 , upvalues : _ENV, InputMode, OasisEnum
  AudioManager:PlayAudioById(1035)
  ;
  (self.oasisSkyCtrl):ShowOasisSkySetting()
  UIManager:HideWindow(UIWindowTypeID.OasisMain)
  self.__inputMode = InputMode.None
  self.__oasisState = (OasisEnum.OasisState).SkyControl
  self:UnselectOasisBuilding(true)
  if self.canvas ~= nil then
    (self.canvas):Hide()
  end
end

OasisController.ExitOasisSkyMode = function(self)
  -- function num : 0_13 , upvalues : InputMode, OasisEnum, _ENV
  self.__inputMode = InputMode.ClickBuilding
  self.__oasisState = (OasisEnum.OasisState).Normal
  AudioManager:PlayAudioById(1036)
  UIManager:ShowWindowOnly(UIWindowTypeID.OasisMain)
  if self.canvas ~= nil then
    (self.canvas):Show()
  end
end

OasisController.ShowOasisUI = function(self, show)
  -- function num : 0_14 , upvalues : InputMode, OasisEnum, _ENV
  if show then
    self.__inputMode = InputMode.ClickBuilding
    self.__oasisState = (OasisEnum.OasisState).Normal
    ;
    (UIUtil.ReShowTopStatus)()
    UIManager:ShowWindowOnly(UIWindowTypeID.OasisMain)
    if self.canvas ~= nil then
      (self.canvas):Show()
    end
  else
    self.__inputMode = InputMode.None
    self.__oasisState = (OasisEnum.OasisState).HideUI
    AudioManager:PlayAudioById(1104)
    ;
    (UIUtil.HideTopStatus)()
    UIManager:HideWindow(UIWindowTypeID.OasisMain)
    if self.canvas ~= nil then
      (self.canvas):Hide()
    end
  end
end

OasisController.CreateBuilding = function(self, buildingData)
  -- function num : 0_15 , upvalues : CoordinateConvert
  local unityPosition = (CoordinateConvert.ToUnityCenterPos)(buildingData.position, buildingData.size)
  local item = self:CreateBuildingItem(unityPosition, buildingData.size, buildingData.height, buildingData.area)
  item:SetBuildingData(buildingData)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.buildingItems)[buildingData.id] = item
  self:UpdateBuildingMap(buildingData)
end

OasisController.CreateBuildingItem = function(self, unityPosition, size, height, areaId)
  -- function num : 0_16 , upvalues : OasisBuildingItem
  local item = (OasisBuildingItem.New)()
  item:Initialize(unityPosition, size, height, ((self.oasisAreaList)[areaId]).transform)
  return item
end

OasisController.GetOasisEffectEntity = function(self, effectName)
  -- function num : 0_17 , upvalues : _ENV, OasisBuildEffectEntity
  if (string.IsNullOrEmpty)(effectName) then
    error("OasisEffect name is null")
    return 
  end
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  if (self._effectPool)[effectName] == nil then
    (self._effectPool)[effectName] = {}
  end
  local effectList = (self._effectPool)[effectName]
  local entity = nil
  if #effectList == 0 then
    local abPath = PathConsts:GetOasisBuildingEffetPrefabPath(effectName)
    local prefab = (self.resloader):LoadABAsset(abPath)
    local effectObj = prefab:Instantiate()
    entity = (OasisBuildEffectEntity.New)(effectObj, effectName)
  else
    do
      entity = (table.remove)(effectList)
      -- DECOMPILER ERROR at PC45: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (self._effectInUseDic)[entity] = true
      return entity
    end
  end
end

OasisController.ReturnOasisEffectEntity = function(self, effectEntity)
  -- function num : 0_18 , upvalues : _ENV
  (effectEntity.gameObject):SetActive(false)
  ;
  (effectEntity.transform):SetParent((self.bind).effects)
  local effectName = effectEntity:GetOasisBuildEffectEntityName()
  local effectList = (self._effectPool)[effectName]
  ;
  (table.insert)(effectList, effectEntity)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._effectInUseDic)[effectEntity] = nil
end

OasisController.__ShowSelectBuildFx = function(self, buildItem, size)
  -- function num : 0_19 , upvalues : _ENV
  local name = "SelectBuilding/SelectHex" .. size[1]
  if size[1] == 1 then
    name = name .. "-" .. tostring(size[2])
  end
  local effectEntity = self:GetOasisEffectEntity(name)
  effectEntity:InitOasisBuildEffectEntity((buildItem.rootTransform).position, buildItem.rootTransform)
  self.__selectedBuildFx = effectEntity
end

OasisController.__HideSelectBuildFx = function(self)
  -- function num : 0_20
  if self.__selectedBuildFx == nil then
    return 
  end
  self:ReturnOasisEffectEntity(self.__selectedBuildFx)
  self.__selectedBuildFx = nil
end

OasisController.__GetBuildablePos = function(self, oasisPos, size, areaId)
  -- function num : 0_21 , upvalues : _ENV, CoordinateConvert
  local oasisArea = (self.oasisAreaList)[areaId]
  if oasisArea == nil then
    error("Cant\'t find oasisArea, areaId = " .. tostring(areaId))
    return 
  end
  local standbyAreaId, standbyOasisPos = nil, nil
  if (PlayerDataCenter.AllBuildingData):OsisAreaUnlock(areaId) then
    local newOasisPos = oasisPos
    local areaList = (CoordinateConvert.GetHexArea)(newOasisPos, size)
    local overlap = self:CheckBuildingOverlap(areaId, areaList)
    if not overlap then
      return newOasisPos, oasisArea.id
    end
    local radius = (oasisArea.cfg).size
    local n = radius - 1
    for x = -n, n do
      for y = (math.max)(-n, -x - n), (math.min)(n, -x + n) do
        newOasisPos = (Vector2.New)(x, y)
        areaList = (CoordinateConvert.GetHexArea)(newOasisPos, size)
        overlap = self:CheckBuildingOverlap(areaId, areaList)
        if not overlap then
          return newOasisPos, oasisArea.id
        end
      end
    end
    standbyAreaId = areaId
    standbyOasisPos = oasisPos
  end
  do
    for k,oasisArea in ipairs(self.oasisAreaList) do
      if k ~= areaId and (PlayerDataCenter.AllBuildingData):OsisAreaUnlock(k) then
        local radius = (oasisArea.cfg).size
        local n = radius - 1
        for x = -n, n do
          for y = (math.max)(-n, -x - n), (math.min)(n, -x + n) do
            local newOasisPos = (Vector2.New)(x, y)
            local areaList = (CoordinateConvert.GetHexArea)(newOasisPos, size)
            local overlap = self:CheckBuildingOverlap(k, areaList)
            if not overlap then
              return newOasisPos, oasisArea.id
            end
          end
        end
        if standbyAreaId == nil then
          standbyAreaId = k
          standbyOasisPos = Vector3.zero
        end
      end
    end
    print("[OasisController:__GetBuildablePos] Cant get buildable position")
    return standbyOasisPos or oasisPos, standbyAreaId or areaId
  end
end

OasisController.NewBuilding = function(self, buildingData)
  -- function num : 0_22 , upvalues : _ENV, CoordinateConvert, cs_SkyController, cs_CameraController, InputMode
  local dynData = buildingData.dynData
  local prefabName = ((ConfigData.oasis_building_model)[((dynData.levelConfig)[1]).modol]).model
  self.__buildNewOasisPos = self:__GetBuildablePos(dynData.position, dynData.size, dynData.area)
  local unityPosition = (CoordinateConvert.ToUnityCenterPos)(self.__buildNewOasisPos, dynData.size)
  local item = self:CreateBuildingItem(unityPosition, dynData.size, dynData.height, self.__newAreaId)
  item:SetBuildingData(buildingData)
  item:LoadBuildingGo(prefabName, function()
    -- function num : 0_22_0 , upvalues : cs_SkyController
    (cs_SkyController.Instance):RefreshEmission()
  end
)
  self:__ShowSelectBuildFx(item, dynData.size)
  self.newBuildingItem = item
  self.selectedBuildingData = buildingData
  self.__selectedBuilding = item
  local areaList = (CoordinateConvert.GetHexArea)(self.__buildNewOasisPos, dynData.size)
  local overlap = self:CheckBuildingOverlap(self.__newAreaId, areaList)
  ;
  (self.__selectedBuildFx):SetBuildSelectFxValid(not overlap)
  local window = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if window ~= nil then
    (window.oasisSelectNode):InitOasisBuildSelect(buildingData, item, false, false)
    ;
    (window.oasisSelectNode):SetOasisBuildSelectFunc(self.__startConstruct, self.__cancelNewBuilding)
    ;
    (window.oasisSelectNode):EnableBuildConfirmBtn(not overlap)
  end
  ;
  (cs_CameraController.Instance):Cam2BuildingTopPos(item.rootTransform)
  self.__inputMode = InputMode.ConstructBuilding
end

OasisController.CancelNewBuilding = function(self)
  -- function num : 0_23 , upvalues : _ENV, InputMode
  self:__HideSelectBuildFx()
  if self.newBuildingItem ~= nil then
    (self.newBuildingItem):OnDelete()
    ;
    (self.newBuildingItem):DeleteEntity()
    self.newBuildingItem = nil
  end
  self.selectedBuildingData = nil
  self.__selectedBuilding = nil
  local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if mainWindow ~= nil then
    (mainWindow.oasisSelectNode):Hide()
  end
  local editWindow = UIManager:GetWindow(UIWindowTypeID.OasisEditWindow)
  if editWindow ~= nil then
    editWindow:ShowOasisEditorSideTween(true)
  end
  self.__inputMode = InputMode.MoveBuilding
end

OasisController.StartConstruct = function(self)
  -- function num : 0_24 , upvalues : _ENV, cs_MessageCommon, CoordinateConvert
  local oasisPos = self.__buildNewOasisPos
  local size = (self.selectedBuildingData).size
  local areaId = self.__newAreaId
  if not ((PlayerDataCenter.AllBuildingData).oasisAreaDic)[areaId] then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.OaisaAreaUnlock))
    return 
  end
  local errorTips = nil
  if (self.buildingDatas):FullOasisBuildQue() then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Building_ConstructQueueFull))
    return 
  end
  if not ((self.selectedBuildingData).dynData):CanBuild() then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Building_NotFillConstructCodition))
    return 
  end
  local areaList = (CoordinateConvert.GetHexArea)(oasisPos, size)
  if self:CheckBuildingOverlap(areaId, areaList) then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Oasis_Building_Overlapping))
    return 
  end
  ;
  (self.networkCtrl):SendBuildingConstruct((self.selectedBuildingData).id, oasisPos, areaId)
end

OasisController.ConstructComplete = function(self, id)
  -- function num : 0_25 , upvalues : _ENV, InputMode
  local buildingData = ((self.buildingDatas).built)[id]
  local editWindow = UIManager:GetWindow(UIWindowTypeID.OasisEditWindow)
  if editWindow ~= nil then
    editWindow:ShowOasisEditorSideTween(true)
  end
  local newBuildingItem = self.newBuildingItem
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.buildingItems)[id] = newBuildingItem
  newBuildingItem:SetPosition(buildingData.position)
  newBuildingItem:SetBuildingData(buildingData)
  newBuildingItem:SetCanvas(self.canvas)
  newBuildingItem:UpdateState()
  self:__HideSelectBuildFx()
  self:UpdateBuildingMap(buildingData)
  local effectEntity = self:GetOasisEffectEntity(((buildingData.dynData).stcData).construct_effect)
  local buildTrans = newBuildingItem.rootTransform
  effectEntity:InitOasisBuildEffectEntity(buildTrans.position, buildTrans, self._returnEffectFunc)
  self.newBuildingItem = nil
  self.__selectedBuilding = nil
  self.selectedBuildingData = buildingData
  local window = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if window ~= nil then
    (window.oasisSelectNode):Hide()
  end
  self.__inputMode = InputMode.MoveBuilding
end

OasisController.StartUpgrade = function(self, buildingData)
  -- function num : 0_26 , upvalues : cs_MessageCommon, _ENV
  local nextLevel = buildingData.level + 1
  if buildingData.maxLevel < nextLevel then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Building_LevelFull))
    return 
  end
  if (self.buildingDatas):FullOasisBuildQue() then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Building_ConstructQueueFull))
    return 
  end
  if not buildingData:CanUpgrade() then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Building_NotFitUpgradeStatue))
    return 
  end
  ;
  (self.networkCtrl):SendBuildingUpgrade(buildingData.id)
  return 
end

OasisController.UpgradeComplete = function(self, id)
  -- function num : 0_27 , upvalues : _ENV
  local builtData = ((self.buildingDatas).built)[id]
  local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if mainWindow ~= nil then
    (mainWindow.buildDetailNode):HideOasisBuildDetail()
    ;
    (mainWindow.oasisSelectNode):RefreshOasisSelectState()
  end
  local buildingItem = (self.buildingItems)[id]
  local prefabName = ((ConfigData.oasis_building_model)[((builtData.levelConfig)[builtData.level]).modol]).model
  buildingItem:LoadBuildingGo(prefabName, function(buildItem)
    -- function num : 0_27_0 , upvalues : self
    local effectEntity = self:GetOasisEffectEntity((((buildItem.buildingData).dynData).stcData).upgrading_effect)
    local buildTrans = buildItem.rootTransform
    effectEntity:InitOasisBuildEffectEntity(buildTrans.position, buildTrans, self._returnEffectFunc)
    local height = buildItem:GetBuildItemHeight()
    effectEntity:SetOasisBuildEffectHeight(height)
  end
)
  buildingItem:UpdateState()
end

OasisController.__OnCancelUpgrade = function(self)
  -- function num : 0_28
  (self.networkCtrl):SendBuildingCancel((self.selectedBuildingData).id)
end

OasisController.__SendConfimAcc = function(self, id, cost)
  -- function num : 0_29
  (self.networkCtrl):SendBuildingAccelerate(id, cost)
end

OasisController.__SendConfimOver = function(self, id)
  -- function num : 0_30 , upvalues : cs_MessageCommon, _ENV
  local builtData = ((self.buildingDatas).built)[id]
  if not builtData.waitConfirmOver then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Building_Incomplete))
    return 
  end
  ;
  (self.networkCtrl):SendBuildingConfirmOver(id)
end

OasisController.UpgradeConfirmOver = function(self, id)
  -- function num : 0_31 , upvalues : _ENV, cs_MessageCommon
  local builtData = ((self.buildingDatas).built)[id]
  local buildingItem = (self.buildingItems)[id]
  if buildingItem == nil then
    return 
  end
  AudioManager:PlayAudioById(1013)
  buildingItem:UpdateBuildLevel(builtData)
  self:UpdateBuilding(id)
  local tipsId = nil
  if builtData.level == 1 then
    tipsId = 5001
  else
    tipsId = 5002
  end
  ;
  (cs_MessageCommon.ShowMessageTips)((string.format)(ConfigData:GetTipContent(tipsId), builtData.name))
end

OasisController.CancelBuildMove = function(self)
  -- function num : 0_32 , upvalues : eBuildMapState
  local buildingData = (self.__selectedBuilding).buildingData
  ;
  (self.__selectedBuilding):SetItemArea(((self.oasisAreaList)[buildingData.area]).transform)
  ;
  (self.__selectedBuilding):SetPosition(buildingData.position, true)
  self:BuildInMap(buildingData.area, buildingData:GetArea(), true, eBuildMapState.Built)
end

OasisController.ReqBuildMove = function(self)
  -- function num : 0_33 , upvalues : _ENV, cs_MessageCommon
  if self.__selectedBuilding == nil or self.__newAreaId == nil then
    return 
  end
  local areaId = self.__newAreaId
  if not ((PlayerDataCenter.AllBuildingData).oasisAreaDic)[areaId] then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.OaisaAreaUnlock))
    return 
  end
  ;
  (self.networkCtrl):SendBuildingMove((self.__selectedBuilding).id, self.__buildNewOasisPos, self.__newAreaId)
end

OasisController.MoveComplete = function(self, id)
  -- function num : 0_34
  local item = (self.buildingItems)[id]
  local buildingData = item.buildingData
  self:UpdateBuildingMap(buildingData)
end

OasisController.CollectOasisRes = function(self, id)
  -- function num : 0_35 , upvalues : _ENV
  if GuideManager.collectResGuideUnComplete and id == 1003 then
    GuideManager:UncompleteCollectResGuide(false)
    local topWindow = UIManager:GetWindow(UIWindowTypeID.TopStatus)
    ;
    (topWindow.resGroup):UpdateResourceGroupTopCurrencys()
    self._collectResDic = {}
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._collectResDic)[id] = 0.1
    self:CollectComplete(1003, {
{id = 1004, count = 1}
})
    return 
  end
  do
    local buildingData = ((self.buildingDatas).built)[id]
    if buildingData:CanGetBuildRes(true) then
      local resDatas = buildingData:GetResDatas()
      self._collectResDic = {}
      for k,v in pairs(resDatas) do
        -- DECOMPILER ERROR at PC51: Confused about usage of register: R9 in 'UnsetPending'

        (self._collectResDic)[id] = v.count / v.countMax
        do break end
      end
      do
        ;
        (self.networkCtrl):SendBuildingCollect(id)
      end
    end
  end
end

OasisController.CollectComplete = function(self, id, resTab)
  -- function num : 0_36 , upvalues : _ENV, cs_MessageCommon
  AudioManager:PlayAudioById(1090)
  local buildingItem = (self.buildingItems)[id]
  if buildingItem ~= nil then
    buildingItem:UpdateBuildingResUI()
  end
  local resDic = {}
  for k,v in ipairs(resTab) do
    resDic[v.id] = v.count
    local item = (ConfigData.item)[v.id]
    if not IsNull(item) then
      local msg = ConfigData:GetTipContent(TipContent.Building_GainReward) .. (LanguageUtil.GetLocaleText)(item.name) .. " x " .. tostring(v.count)
      ;
      (cs_MessageCommon.ShowMessageTips)(msg, true)
    end
  end
  local idDic = {}
  idDic[id] = true
  self:_ShowResCollectParticleTween(idDic, resDic)
end

OasisController.CollectAllOasisBuildingRes = function(self)
  -- function num : 0_37 , upvalues : _ENV, cs_MessageCommon
  local buildIdDict = {}
  local buildingCount = 0
  local fullWareHouseItemDic = {}
  self._collectResDic = {}
  for buildId,buildData in pairs((PlayerDataCenter.AllBuildingData).oasisBuilt) do
    if buildData:IsBuildResPeriodOk() and buildData:CanGetBuildRes(false, fullWareHouseItemDic) then
      buildingCount = buildingCount + 1
      buildIdDict[buildId] = true
      local resDatas = buildData:GetResDatas()
      for k,v in pairs(resDatas) do
        -- DECOMPILER ERROR at PC33: Confused about usage of register: R15 in 'UnsetPending'

        (self._collectResDic)[buildId] = v.count / v.countMax
        do break end
      end
    end
  end
  for name,_ in pairs(fullWareHouseItemDic) do
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(name .. ConfigData:GetTipContent(TipContent.ItemInWarehouseFull), true)
  end
  self.buildIdDict = buildIdDict
  if buildingCount > 0 then
    if self._CollectAllResCompleteFunc == nil then
      self._CollectAllResCompleteFunc = BindCallback(self, self._OnCollectAllResComplete)
    end
    ;
    (self.networkCtrl):SendBuildingCollectGroup(buildIdDict, self._CollectAllResCompleteFunc)
  end
end

OasisController._OnCollectAllResComplete = function(self, objList)
  -- function num : 0_38 , upvalues : _ENV, cs_MessageCommon
  if objList.Count ~= 1 then
    error("objList.Count error:" .. tostring(objList.Count))
    return 
  end
  AudioManager:PlayAudioById(1090)
  local resDic = objList[0]
  for resId,resNum in pairs(resDic) do
    local itemCfg = (ConfigData.item)[resId]
    if itemCfg ~= nil then
      local msg = ConfigData:GetTipContent(TipContent.Building_GainReward) .. (LanguageUtil.GetLocaleText)(itemCfg.name) .. " x " .. tostring(resNum)
      ;
      (cs_MessageCommon.ShowMessageTips)(msg, true)
    end
  end
  self:_ShowResCollectParticleTween(self.buildIdDict, resDic)
end

OasisController._ShowResCollectParticleTween = function(self, idDic, resDic)
  -- function num : 0_39 , upvalues : _ENV
  local topWin = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if topWin == nil then
    return 
  end
  local selBuildItems = {}
  local buildItem = nil
  for id,boolean in pairs(idDic) do
    buildItem = (self.buildingItems)[id]
    if buildItem ~= nil then
      selBuildItems[id] = buildItem
    end
  end
  local topResUIPosDic = {}
  local pos = nil
  for resId,resNum in pairs(resDic) do
    pos = topWin:GetResItemPos(resId)
    if pos ~= nil then
      topResUIPosDic[resId] = pos
    end
  end
  local oasisWin = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if oasisWin ~= nil then
    (oasisWin.paticleNode):Show()
    ;
    (oasisWin.paticleNode):InitOasisParticle(self, topResUIPosDic, selBuildItems, self._collectResDic)
  end
end

OasisController.SendCancelEvent = function(self)
  -- function num : 0_40
  (self.networkCtrl):SendBuildingCancel((self.newBuildingItem).id)
end

OasisController.CancelComplete = function(self, id, oldState)
  -- function num : 0_41 , upvalues : _ENV
  local buildingItem = (self.buildingItems)[id]
  local buildingData = buildingItem.buildingData
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R5 in 'UnsetPending'

  if oldState == proto_object_BuildingState.BuildingStateCreate then
    (self.buildingItems)[id] = nil
    self:BuildInMap(buildingData.area, buildingData:GetArea(), false)
    local unbuiltData = ((self.buildingDatas).unbuilt)[(buildingData.stcData).build_id]
  else
    do
      if oldState == proto_object_BuildingState.BuildingStateUpgrade then
        local buildingItem = (self.buildingItems)[id]
        local prefabName = ((ConfigData.oasis_building_model)[((buildingData.levelConfig)[buildingData.level]).modol]).model
        local unityPosition = (buildingItem.rootTransform).localPosition
        buildingItem:LoadBuildingGo(prefabName)
        buildingItem:UpdateState()
      end
    end
  end
end

OasisController.ReqUnlockOasisArea = function(self, areaId)
  -- function num : 0_42 , upvalues : _ENV, cs_MessageCommon
  local areaCfg = (ConfigData.oasis_area)[areaId]
  do
    if not (CheckCondition.CheckLua)(areaCfg.pre_condition, areaCfg.pre_para1, areaCfg.pre_para2) then
      local lockInfo = (CheckCondition.GetUnlockInfoLua)(areaCfg.pre_condition, areaCfg.pre_para1, areaCfg.pre_para2)
      ;
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(lockInfo)
      return 
    end
    if not self.__OnUnlockAreaFunc then
      self.__OnUnlockAreaFunc = BindCallback(self, self.__OnUnlockOasisArea)
      self._unlockAreaId = areaId
      ;
      (self.networkCtrl):CS_BUILDIN_AreaUnlock(areaId, self.__OnUnlockAreaFunc)
    end
  end
end

OasisController.__OnUnlockOasisArea = function(self)
  -- function num : 0_43 , upvalues : _ENV
  local areaEntity = (self.areaRuinEntityDic)[self._unlockAreaId]
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.areaRuinGoDic)[areaEntity.gameObject] = nil
  areaEntity:OnDelete()
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.areaRuinEntityDic)[self._unlockAreaId] = nil
  local effectEntity = (self.areaLockFxDic)[self._unlockAreaId]
  if effectEntity ~= nil then
    effectEntity:UpdateOasisAreaFxState(self._unlockAreaId)
  end
  local sideNoticeList = NoticeManager:GetSideNoticeList()
  for _,noticeData in pairs(sideNoticeList) do
    if noticeData.type == (NoticeManager.eNoticeType).OasisAreaUnlock and self._unlockAreaId == (noticeData.extraData).areaId then
      NoticeManager:DeleteNotice(noticeData)
      break
    end
  end
end

OasisController.__UpdateAllAreaUnlcokState = function(self)
  -- function num : 0_44 , upvalues : _ENV
  for areaId,effectEntity in pairs(self.areaLockFxDic) do
    effectEntity:UpdateOasisAreaFxState(areaId)
  end
end

OasisController.__OnSctStageStateChange = function(self)
  -- function num : 0_45
  self:__UpdateAllAreaUnlcokState()
end

OasisController.UpdateBuilding = function(self, id)
  -- function num : 0_46 , upvalues : _ENV
  local buildingData = ((self.buildingDatas).built)[id]
  if buildingData == nil then
    return 
  end
  local editWindow = UIManager:GetWindow(UIWindowTypeID.OasisEditWindow)
  if editWindow ~= nil then
    editWindow:RefreshOasisEditSideBar()
  end
  local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if mainWindow ~= nil then
    (mainWindow.buildDetailNode):RefreshOasisBuildDetailState()
    mainWindow:RefreshOasisEditBlueDot()
  end
  if self.canvas ~= nil then
    (self.canvas):SetBuildName3dItemCanLevelUp(buildingData.id, buildingData:CanUpgrade())
  end
  if (self.buildingItems)[id] ~= nil then
    ((self.buildingItems)[id]):UpdateState()
  end
end

OasisController._OnItemRefresh = function(self, itemIdDic)
  -- function num : 0_47 , upvalues : _ENV
  local noChanged = true
  for itemId,_ in pairs(itemIdDic) do
    if ((ConfigData.buildingLevel).resConsumeDic)[itemId] ~= nil then
      noChanged = false
      break
    end
  end
  do
    if noChanged then
      return 
    end
    local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
    if mainWindow ~= nil then
      (mainWindow.buildDetailNode):RefreshOasisBuildDetailState()
      mainWindow:RefreshOasisEditBlueDot()
    end
    if self.canvas ~= nil then
      for k,buildingData in pairs((PlayerDataCenter.AllBuildingData).oasisBuilt) do
        (self.canvas):SetBuildName3dItemCanLevelUp(buildingData.id, buildingData:CanUpgrade())
      end
    end
  end
end

OasisController.OnUpdate = function(self)
  -- function num : 0_48 , upvalues : _ENV
  if not self.isEnter then
    return 
  end
  local timestamp = PlayerDataCenter.timestamp
  if self.__timeSecond == nil then
    self.__timeSecond = timestamp
  end
  local isSecond = false
  if self.__timeSecond + 1 < timestamp then
    self.__timeSecond = self.__timeSecond + 1
    isSecond = true
  end
  for k,v in pairs(self.buildingItems) do
    v:Update(timestamp, isSecond)
  end
  local queueCtrl = ControllerManager:GetController(ControllerTypeId.BuildingQueue)
  if queueCtrl ~= nil then
    queueCtrl:UpdateBuildQueueSecond(timestamp, isSecond)
  end
end

OasisController.OnLateUpdate = function(self)
  -- function num : 0_49 , upvalues : _ENV, cs_CameraController
  if not self.isEnter then
    return 
  end
  local canCollect = false
  for k,buildingData in pairs((PlayerDataCenter.AllBuildingData).oasisBuilt) do
    if buildingData:IsBuildResPeriodOk() then
      canCollect = true
      break
    end
  end
  do
    if not (cs_CameraController.Instance):IsCameraChange() then
      local isCamChange = self.__isDrag
    end
    local window = UIManager:GetWindow(UIWindowTypeID.OasisMain)
    if window ~= nil then
      if isCamChange then
        (window.oasisSelectNode):RefreshOasisSelectPos()
      end
      if canCollect then
        window:ShowOasisMainCollectResBtn(not GuideManager.collectResGuideUnComplete)
        if isCamChange then
          local window = UIManager:GetWindow(UIWindowTypeID.OasisMain)
          if window ~= nil then
            (window.oasisResNode):OasisResOutputLateUpdate()
            ;
            (window.paticleNode):UpdateOasisResPaticlePosAll()
          end
        end
      end
    end
  end
end

OasisController.OnFingerDown = function(self, leanFinger)
  -- function num : 0_50 , upvalues : InputMode, cs_InputUtility, cs_Physics, _ENV, cs_CameraController
  if leanFinger.StartedOverGui or leanFinger.IsOverGui or self.__inputMode == InputMode.None then
    return 
  end
  self.__lastMousePos = cs_InputUtility.MousePosition
  local hits = (cs_Physics.Raycast)(self.__mainCam, 1 << LayerMask.Raycast)
  for i = 0, hits.Length - 1 do
    local hitCollider = (hits[i]).collider
    if not IsNull(hitCollider) and hitCollider.tag == TagConsts.Building then
      local hitObj = hitCollider.gameObject
      local hitName = hitObj.name
      if self.__inputMode == InputMode.ConstructBuilding and self.newBuildingItem ~= nil and hitObj == (self.newBuildingItem).gameObject then
        self.__selectedBuildingLastPos = (self.selectedBuildingData).position
        self.__selectedBuildingLastAreaId = (self.selectedBuildingData).area
        self.__originalPosition = ((self.newBuildingItem).rootTransform).position
        self.__fingerId = leanFinger.Index
        ;
        (cs_CameraController.Instance):DragEnable(false)
      else
        if self.__inputMode == InputMode.MoveBuilding then
          local item = self:__GetBuildingItemByName(hitName)
          if item ~= nil and item == self.__selectedBuilding then
            self.__fingerId = leanFinger.Index
            ;
            (cs_CameraController.Instance):DragEnable(false)
          end
        end
      end
    end
  end
end

OasisController.OnFingerSet = function(self, leanFinger)
  -- function num : 0_51 , upvalues : cs_InputUtility, InputMode, cs_CameraController, cs_Physics, _ENV
  if leanFinger.StartedOverGui or leanFinger.IsOverGui or self.__fingerId ~= leanFinger.Index or (leanFinger.ScreenDelta).x == 0 and (leanFinger.ScreenDelta).y == 0 then
    return 
  end
  if not self.__isDrag and self.__lastMousePos ~= cs_InputUtility.MousePosition then
    self.__isDrag = true
    if self.__inputMode == InputMode.MoveBuilding and self.__selectedBuilding ~= nil then
      local buildingData = (self.__selectedBuilding).buildingData
      self:BuildInMap(buildingData.area, buildingData:GetArea(), false)
    end
  end
  do
    if self.__isDrag and (self.__inputMode == InputMode.MoveBuilding or self.__inputMode == InputMode.ConstructBuilding) and self.__selectedBuilding ~= nil then
      (cs_CameraController.Instance):DragEnable(false)
      ;
      (cs_CameraController.Instance):OnDragBuildingScreenEdge(self.screenEdge, self.edgeMoveSpeed)
      local hits = (cs_Physics.Raycast)(self.__mainCam, 1 << LayerMask.Raycast, true)
      for i = 0, hits.Length - 1 do
        local hit = hits[i]
        local hitCollider = hit.collider
        if not IsNull(hitCollider) and hitCollider.tag == TagConsts.BuildingGround then
          local areaId = tonumber(hitCollider.name)
          local oasisArea = (self.oasisAreaList)[areaId]
          if oasisArea ~= nil and (PlayerDataCenter.AllBuildingData):OsisAreaUnlock(areaId) then
            local localPosition = hit.point - (oasisArea.transform).position
            local diameter = (Vector3.Normalize)(localPosition) * (ConfigData.game_config).OasisHexSize * 1
            local oasisPos, unityPos, areaList = (self.__selectedBuilding):SetRoundPosition(localPosition, false, true)
            local overlap, cantMove = self:CheckBuildingOverlap(areaId, areaList)
            local count = 1
            while cantMove do
              localPosition = localPosition - diameter
              oasisPos = (self.__selectedBuilding):SetRoundPosition(localPosition, false, true)
              overlap = self:CheckBuildingOverlap(areaId, areaList)
              count = count + 1
            end
            if (oasisArea.cfg).size * 2 >= count then
              (self.__selectedBuilding):SetItemArea(oasisArea.transform)
              self.__buildNewOasisPos = oasisPos
              do
                do
                  if self.__inputMode == InputMode.ConstructBuilding then
                    local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
                    if mainWindow ~= nil then
                      (mainWindow.oasisSelectNode):EnableBuildConfirmBtn(not overlap)
                    end
                  end
                  self.__selectBuildOverlap = overlap
                  self.__newAreaList = areaList
                  self.__newAreaId = areaId
                  ;
                  (self.__selectedBuildFx):SetBuildSelectFxValid(not overlap)
                  ;
                  (self.__selectedBuilding):UpdateCanvasItemPos()
                  if oasisPos ~= self.__selectedBuildingLastPos or areaId ~= self.__selectedBuildingLastAreaId then
                    self.__selectedBuildingLastPos = oasisPos
                    self.__selectedBuildingLastAreaId = areaId
                    ;
                    ((self.__selectedBuilding).rootTransform):DOLocalMove(unityPos, 0.1)
                  end
                  do break end
                  -- DECOMPILER ERROR at PC197: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC197: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC197: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC197: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC197: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC197: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC197: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
    end
  end
end

OasisController.OnFingerUp = function(self, leanFinger)
  -- function num : 0_52 , upvalues : InputMode, eBuildMapState, cs_CameraController
  if leanFinger.StartedOverGui or self.__fingerId ~= leanFinger.Index then
    return 
  end
  if self.__selectedBuilding ~= nil and self.__isDrag then
    local buildingData = (self.__selectedBuilding).buildingData
    do
      do
        if self.__inputMode == InputMode.MoveBuilding then
          local overlap = self:CheckBuildingOverlap(self.__newAreaId, self.__newAreaList)
          ;
          (self.__selectedBuildFx):SetBuildSelectFxValid(not overlap)
          if (not overlap or buildingData.position == self.__buildNewOasisPos) and buildingData.area == self.__newAreaId then
            self:BuildInMap(buildingData.area, buildingData:GetArea(), true, eBuildMapState.Built)
          else
            self:ReqBuildMove()
          end
          ;
          (self.__selectedBuilding):UpdateCanvasItemPos()
        end
        self.__isDrag = false
        ;
        (cs_CameraController.Instance):DragEnable(true)
        self.__fingerId = nil
      end
    end
  end
end

OasisController.OnFingerTap = function(self, leanFinger)
  -- function num : 0_53 , upvalues : OasisEnum, _ENV, InputMode, cs_Physics
  if self.__oasisState == (OasisEnum.OasisState).HideUI and not leanFinger.StartedOverGui then
    self:ShowOasisUI(true)
    return 
  end
  if self.__oasisState == (OasisEnum.OasisState).SkyControl and not leanFinger.StartedOverGui and not leanFinger.IsOverGui then
    (UIUtil.OnClickBack)()
    return 
  end
  if leanFinger.StartedOverGui or leanFinger.IsOverGui or self.__inputMode == InputMode.None then
    return 
  end
  if self.__inputMode == InputMode.ClickBuilding then
    local hits = (cs_Physics.Raycast)(self.__mainCam, 1 << LayerMask.Raycast)
    for i = 0, hits.Length - 1 do
      local hitCollider = (hits[i]).collider
      if not IsNull(hitCollider) and not self:_ClickAreaRuin(hitCollider.gameObject) and hitCollider.tag == TagConsts.Building then
        local hitName = (hitCollider.gameObject).name
        local buildingItem = self:__GetBuildingItemByName(hitName)
        if buildingItem ~= nil then
          if self.isFocusBuilding then
            return 
          end
          if (buildingItem.buildingData):CanGetBuildRes() then
            self:CollectOasisRes(buildingItem.id)
          else
            self:SelectOasisBuilding(buildingItem, true)
          end
          return 
        end
      end
    end
    self:UnselectOasisBuilding(true)
  else
    do
      if self.__inputMode == InputMode.MoveBuilding then
        local hits = (cs_Physics.Raycast)(self.__mainCam, 1 << LayerMask.Raycast)
        for i = 0, hits.Length - 1 do
          local hitCollider = (hits[i]).collider
          if not IsNull(hitCollider) and not self:_ClickAreaRuin(hitCollider.gameObject) and hitCollider.tag == TagConsts.Building then
            local hitName = (hitCollider.gameObject).name
            local buildingItem = self:__GetBuildingItemByName(hitName)
            if buildingItem ~= nil then
              local buildingData = buildingItem.buildingData
              self:__ResetSelectedBuilding()
              self:SelectOasisBuilding(buildingItem, false)
              self.__selectedBuildingLastPos = buildingData.position
              self.__selectedBuildingLastAreaId = buildingData.area
              self.__originalPosition = (buildingItem.rootTransform).position
              self:__ShowSelectBuildFx(buildingItem, buildingData.size)
              ;
              (self.__selectedBuildFx):SetBuildSelectFxValid(true)
              self.__selectBuildOverlap = false
              return 
            end
          end
        end
        self:__ResetSelectedBuilding()
        self:UnselectOasisBuilding(false)
      end
    end
  end
end

OasisController._ClickAreaRuin = function(self, gameObject)
  -- function num : 0_54 , upvalues : _ENV, cs_MessageCommon
  local areaEntity = (self.areaRuinGoDic)[gameObject]
  if areaEntity == nil then
    return false
  end
  local areaId = areaEntity:GetOasisAreaEntityId()
  local areaData = (self.oasisAreaList)[areaEntity.areaId]
  local unlock = (PlayerDataCenter.AllBuildingData):OsisAreaUnlock(areaId)
  if not unlock then
    local cfg = areaData.cfg
    if (CheckCondition.CheckLua)(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2) then
      self:ReqUnlockOasisArea(areaId)
    else
      local lockInfo = (CheckCondition.GetUnlockInfoLua)(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2)
      ;
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(lockInfo)
    end
  end
  do
    return true
  end
end

OasisController.SelectOasisBuilding = function(self, buildingItem, isInfo)
  -- function num : 0_55 , upvalues : _ENV
  if self.__selectedBuilding == buildingItem then
    return 
  end
  AudioManager:PlayAudioById(1091)
  local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if self.__selectedBuilding ~= nil then
    if self.canvas ~= nil then
      (self.canvas):ShowBuildingName3dItem((self.__selectedBuilding).id, true)
    end
    if isInfo and mainWindow ~= nil then
      (mainWindow.oasisResNode):ShowOasisResUIItem((self.__selectedBuilding).id, true)
    end
  end
  self.__selectedBuilding = buildingItem
  if self.canvas ~= nil then
    (self.canvas):ShowBuildingName3dItem(buildingItem.id, false)
  end
  if mainWindow ~= nil then
    (mainWindow.oasisSelectNode):InitOasisBuildSelect(buildingItem.buildingData, buildingItem, not isInfo, isInfo)
  end
  -- DECOMPILER ERROR at PC61: Unhandled construct in 'MakeBoolean' P1

  if isInfo and mainWindow ~= nil then
    (mainWindow.oasisResNode):ShowOasisResUIItem(buildingItem.id, false)
  end
  local editWindow = UIManager:GetWindow(UIWindowTypeID.OasisEditWindow)
  if editWindow ~= nil then
    editWindow:ShowOasisEditorSideTween(false)
  end
end

OasisController.UnselectOasisBuilding = function(self, isInfo)
  -- function num : 0_56 , upvalues : _ENV
  if self.__selectedBuilding == nil then
    return 
  end
  self:__HideSelectBuildFx()
  if self.canvas ~= nil then
    (self.canvas):ShowBuildingName3dItem((self.__selectedBuilding).id, true)
  end
  local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if mainWindow ~= nil then
    (mainWindow.oasisSelectNode):Hide()
  end
  -- DECOMPILER ERROR at PC34: Unhandled construct in 'MakeBoolean' P1

  if isInfo and mainWindow ~= nil then
    (mainWindow.oasisResNode):ShowOasisResUIItem((self.__selectedBuilding).id, true)
  end
  do
    local editWindow = UIManager:GetWindow(UIWindowTypeID.OasisEditWindow)
    if editWindow ~= nil then
      editWindow:ShowOasisEditorSideTween(true)
    end
    self.__selectedBuilding = nil
  end
end

OasisController.__ResetSelectedBuilding = function(self)
  -- function num : 0_57
  if self.__selectedBuilding ~= nil then
    self:__HideSelectBuildFx()
    if self.__selectBuildOverlap then
      self:CancelBuildMove()
    end
  end
end

OasisController.__LerpMoveBuilding = function(self, from, to)
  -- function num : 0_58 , upvalues : _ENV
  (Vector3.Slerp)(from, to, Time.deltaTime)
end

OasisController.GetBuildingItemByGo = function(self, gameObject)
  -- function num : 0_59 , upvalues : _ENV
  for _,v in pairs(self.buildingItems) do
    if v.gameObject == gameObject then
      return v
    end
  end
  return nil
end

OasisController.GetOasisBuildItemById = function(self, id)
  -- function num : 0_60
  return (self.buildingItems)[id]
end

OasisController.CheckBuildingOverlap = function(self, areaId, areaList)
  -- function num : 0_61 , upvalues : _ENV, CoordinateConvert, eBuildMapState
  local oasisArea = (self.oasisAreaList)[areaId]
  local oasisAreaCfg = (ConfigData.oasis_area)[areaId]
  if oasisAreaCfg == nil then
    error("Can\'t find oasisAreaCfg, id = " .. tostring(areaId))
    return 
  end
  local radius = oasisAreaCfg.size
  local used = false
  local cantMove = false
  for k,position in ipairs(areaList) do
    local distance = (CoordinateConvert.HexDistance2Center)(position)
    if radius <= distance then
      used = true
      cantMove = true
    end
    if (oasisArea.buildingMap)[position.x] ~= nil then
      if ((oasisArea.buildingMap)[position.x])[position.y] ~= nil then
        used = true
      end
      if ((oasisArea.buildingMap)[position.x])[position.y] == eBuildMapState.Obstacle then
        cantMove = true
      end
    end
  end
  return used, cantMove
end

OasisController.UpdateBuildingMap = function(self, buildingData, oldAreaId, oldPosList)
  -- function num : 0_62 , upvalues : eBuildMapState
  if oldPosList ~= nil then
    self:BuildInMap(oldAreaId, oldPosList, false)
  end
  local posList = buildingData:GetArea()
  self:BuildInMap(buildingData.area, posList, true, eBuildMapState.Built)
end

OasisController.BuildInMap = function(self, areaId, positionList, build, buildMapState)
  -- function num : 0_63 , upvalues : _ENV, CoordinateConvert
  local oasisArea = (self.oasisAreaList)[areaId]
  local oasisAreaCfg = (ConfigData.oasis_area)[areaId]
  if oasisAreaCfg == nil then
    error("Can\'t find oasisAreaCfg, id = " .. tostring(areaId))
    return 
  end
  local radius = oasisAreaCfg.size
  for k,position in ipairs(positionList) do
    local distance = (CoordinateConvert.HexDistance2Center)(position)
    if radius < distance then
      error((string.format)("oasis hex position out of range, areaId:%s, position(%s,%s)", areaId, position.x, position.y))
      return 
    end
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R14 in 'UnsetPending'

    if (oasisArea.buildingMap)[position.x] == nil then
      (oasisArea.buildingMap)[position.x] = {}
    end
    local value = nil
    if build then
      value = buildMapState
    end
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R15 in 'UnsetPending'

    ;
    ((oasisArea.buildingMap)[position.x])[position.y] = value
  end
end

OasisController.__GetBuildingItemByName = function(self, name)
  -- function num : 0_64 , upvalues : _ENV
  if (string.IsNullOrEmpty)(name) then
    return nil
  end
  local id = nil
  if (string.sub)(name, 1, 1) == "#" then
    id = name
  else
    id = tonumber(name)
  end
  return (self.buildingItems)[id]
end

OasisController.__ShowResidentUI = function(self, show)
  -- function num : 0_65 , upvalues : _ENV
  if show then
    local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
    if mainWindow ~= nil then
      mainWindow:OnEnterOasisEditMode(false)
    end
  end
end

OasisController.UpdateProcessEvent = function(self, id, progress, remainTimeText, waitConfirmOver)
  -- function num : 0_66
  local buildingItem = (self.buildingItems)[id]
  if buildingItem ~= nil then
    buildingItem:UpdateProcessUI(progress, remainTimeText, waitConfirmOver)
  end
end

OasisController.OasisBackToHome = function(self)
  -- function num : 0_67
  if self.backToHomeEvent ~= nil then
    (self.backToHomeEvent)()
    self.backToHomeEvent = nil
  end
end

OasisController.OnExitOasis = function(self)
  -- function num : 0_68 , upvalues : JumpManager, OasisEnum, _ENV, cs_SkyController, cs_CameraController, cs_LeanTouch, InputMode
  JumpManager.couldUseItemJump = false
  self.__selectedBuilding = nil
  self.__oasisState = (OasisEnum.OasisState).None
  if self.__enterCoroutine ~= nil then
    (GR.StopCoroutine)(self.__enterCoroutine)
  end
  MsgCenter:RemoveListener(eMsgEventId.BuildingUpgradeComplete, self.__ConfirmOver)
  MsgCenter:RemoveListener(eMsgEventId.UpdateBuildingProcess, self.__UpdateProcessEvent)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemRefresh)
  MsgCenter:RemoveListener(eMsgEventId.UpdateARGItem, self.__onItemRefresh)
  MsgCenter:RemoveListener(eMsgEventId.OnSectorStageStateChange, self.__onSectorStageStateChange)
  self.isEnter = false
  self:__ChangeBgm((cs_SkyController.Instance).IsDay)
  ;
  (cs_CameraController.Instance):DragEnable(false)
  UIManager:DeleteWindow(UIWindowTypeID.OasisEditWindow)
  UIManager:DeleteWindow(UIWindowTypeID.OasisMain)
  UIManager:DeleteWindow(UIWindowTypeID.USkySystem)
  ControllerManager:DeleteController(ControllerTypeId.BuildingQueue)
  if self.canvas ~= nil then
    (self.canvas):OnDelete()
    self.canvas = nil
  end
  if self.focusDirector ~= nil and self.focusDirectorStopped ~= nil then
    (self.focusDirector):stopped("-", self.focusDirectorStopped)
  end
  ;
  (cs_LeanTouch.OnFingerDown)("-", self.__onFingerDown)
  ;
  (cs_LeanTouch.OnFingerSet)("-", self.__onFingerSet)
  ;
  (cs_LeanTouch.OnFingerUp)("-", self.__onFingerUp)
  ;
  (cs_LeanTouch.OnFingerTap)("-", self.__onFingerTap)
  ;
  (((self.bind).effects).gameObject):SetActive(false)
  self.__inputMode = InputMode.None
  local homeCtrl = ControllerManager:GetController(ControllerTypeId.HomeController)
  if homeCtrl ~= nil then
    homeCtrl:CheckAndSetWarfarStage()
  end
end

OasisController.OnDelete = function(self)
  -- function num : 0_69 , upvalues : _ENV, cs_SkyController, base
  UpdateManager:RemoveUpdate(self.__update__handle)
  UpdateManager:RemoveLateUpdate(self.__lateUpdateHandle)
  if self.isEnter then
    self:OnExitOasis()
  end
  if self.__initCo ~= nil then
    (GR.StopCoroutine)(self.__initCo)
    self.__initCo = nil
  end
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  for k,v in pairs(self.buildingItems) do
    v:OnDelete()
  end
  self.buildingItems = {}
  self.oasisUIModel = nil
  if self._effectPool ~= nil then
    for k,effectList in pairs(self._effectPool) do
      for k2,effectEntity in ipairs(effectList) do
        effectEntity:OnDelete()
      end
    end
    self._effectPool = nil
  end
  if self._effectInUseDic ~= nil then
    for effectEntity,_ in pairs(self._effectInUseDic) do
      effectEntity:OnDelete()
    end
    self._effectInUseDic = nil
  end
  self.jumpEvent = nil
  -- DECOMPILER ERROR at PC71: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (cs_SkyController.Instance).OnDayChange = nil
  for k,v in pairs(self.ctrls) do
    v:OnDelete()
  end
  ;
  (base.OnDelete)(self)
end

return OasisController

