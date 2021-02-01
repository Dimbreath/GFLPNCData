-- params : ...
-- function num : 0 , upvalues : _ENV
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
local OasisEnum = require("Game.Oasis.OasisEnum")
local OasisBuildingItem = require("Game.Oasis.OasisBuildingItem")
local CoordinateConvert = require("Game.Oasis.OasisCoordinateConvert")
local BuildingCanvas = require("Game.Oasis.UI.UIOasisBuildingCanvas")
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")
local BuildingUIModel = require("Game.Oasis.Data.OasisBuildingUIModel")
local util = require("XLua.Common.xlua_util")
local OasisBuildEffectEntity = require("Game.Oasis.Entity.OasisBuildEffectEntity")
local JumpManager = require("Game.Jump.JumpManager")
local InputMode = {None = 0, ConstructBuilding = 1, MoveBuilding = 2, ClickBuilding = 3}
OasisController.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV, InputMode
  self.__onFingerDown = BindCallback(self, self.OnFingerDown)
  self.__onFingerSet = BindCallback(self, self.OnFingerSet)
  self.__onFingerUp = BindCallback(self, self.OnFingerUp)
  self.__onFingerTap = BindCallback(self, self.OnFingerTap)
  self.__selectedBuilding = nil
  self.__selectedBuildingLastPos = nil
  self.__originalPosition = nil
  self.__inputMode = InputMode.None
end

OasisController.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, cs_ResLoader, cs_GameObject, CoordinateConvert, cs_CameraController, util, OasisEnum
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
  self.buildingContent = obj.transform
  obj.name = contentName
  local groundCollider = ((obj.transform):Find("GroundCollider")).gameObject
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
        -- DECOMPILER ERROR at PC116: Confused about usage of register: R14 in 'UnsetPending'

        ;
        (areaGo.transform).localPosition = (Vector3.New)((cfg.offset)[1], (cfg.offset)[2], (cfg.offset)[3])
        local areaX = cfg.size * 2 * (CoordinateConvert.GetHexWidth)()
        -- DECOMPILER ERROR at PC129: Confused about usage of register: R15 in 'UnsetPending'

        ;
        (ground.transform).localScale = (Vector3.New)(areaX, 1, areaX)
      end
    end
  end
  groundCollider:SetActive(false)
  self.buildingRedHex = (obj.transform):Find("RedHex")
  self.buildingRedHexDic = {}
  self:__ShowRedHexAll(false)
  self._effectHolder = (obj.transform):Find("Effects")
  self.topViewDirector = (cs_CameraController.Instance):GetTopViewDirector()
  self.focusDirector = (cs_CameraController.Instance):GetFocusDirector()
  -- DECOMPILER ERROR at PC163: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (cs_CameraController.Instance).OnTriggerEnterEvent = BindCallback(self, self.__OnTriggerEnterCam)
  -- DECOMPILER ERROR at PC169: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (cs_CameraController.Instance).OnTriggerExitEvent = BindCallback(self, self.__OnTriggerExitCam)
  self.__initCo = (GR.StartCoroutine)((util.cs_generator)(BindCallback(self, self.InitBuilding)))
  self.confirmOverEvent = BindCallback(self, self.__SendConfimOver)
  self._returnEffectFunc = BindCallback(self, self.ReturnOasisEffectEntity)
  self._effectPool = {}
  self._effectInUseDic = {}
  self.__oasisState = (OasisEnum.OasisState).None
end

OasisController.InitData = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self.oasisAreaList = {}
  for k,v in ipairs(ConfigData.oasis_area) do
    local oasisArea = {}
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.oasisAreaList)[v.id] = oasisArea
    oasisArea.id = v.id
    oasisArea.buildingMap = {}
    oasisArea.cfg = v
    oasisArea.lock = true
    local radius = (oasisArea.cfg).size
    local n = radius - 1
    for x = -n, n do
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R13 in 'UnsetPending'

      (oasisArea.buildingMap)[x] = {}
    end
    self:BuildInMap(v.id, v.dirty_spots, true)
  end
  self.buildingDatas = PlayerDataCenter.AllBuildingData
end

OasisController.InitBuilding = function(self)
  -- function num : 0_3 , upvalues : _ENV, cs_GameObject
  for k,v in pairs((self.buildingDatas).oasisBuilt) do
    self:CreateBuilding(v)
  end
  for k,item in pairs(self.buildingItems) do
    item:LoadBuildingGo()
    while item:BuildGoIsInLoading() do
      (coroutine.yield)(nil)
    end
  end
  local wait = (self.resloader):LoadABAssetAsyncAwait(PathConsts:GetOasisPrefabPath("FX"))
  ;
  (coroutine.yield)(wait)
  ;
  (wait.Result):Instantiate()
  local ruinsGo = (cs_GameObject.Find)("Ruins")
  local ruinsBind = {}
  ;
  (UIUtil.LuaUIBindingTable)(ruinsGo, ruinsBind)
  self.ruinGoDic = {}
  for k,go in ipairs(ruinsBind.ruinGoList) do
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R9 in 'UnsetPending'

    (self.ruinGoDic)[go.name] = go
  end
  self:UpdateOasisRuins()
end

OasisController.UpdateOasisRuins = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for k,areaData in pairs(self.oasisAreaList) do
    local areaCfg = areaData.cfg
    local lock = not (CheckCondition.CheckLua)(areaCfg.pre_condition, areaCfg.pre_para1, areaCfg.pre_para2)
    local go = (self.ruinGoDic)[areaCfg.lock_prefab]
    if not IsNull(go) then
      go:SetActive(lock)
    else
      error("Cant get oasis ruin gameObject, name = " .. areaCfg.lock_prefab)
    end
    areaData.lock = lock
  end
end

OasisController.InjectJumpEvent = function(self, jumpEvent)
  -- function num : 0_5
  self.jumpEvent = function()
    -- function num : 0_5_0 , upvalues : jumpEvent, self
    jumpEvent()
    self.jumpEvent = nil
  end

end

OasisController.IsOasisNormalState = function(self)
  -- function num : 0_6 , upvalues : OasisEnum
  do return self.__oasisState == (OasisEnum.OasisState).Normal end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

OasisController.EnterOasis = function(self)
  -- function num : 0_7 , upvalues : _ENV, JumpManager, BuildingUIModel, cs_CameraController, cs_LeanTouch, BuildingCanvas, InputMode, OasisEnum, util
  AudioManager:PlayAudioById(3002)
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, (eAuSelct.Home).name, (eAuSelct.Home).oasis)
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
  (cs_CameraController.Instance):EnableTrigger(true)
  ;
  (cs_LeanTouch.OnFingerDown)("+", self.__onFingerDown)
  ;
  (cs_LeanTouch.OnFingerSet)("+", self.__onFingerSet)
  ;
  (cs_LeanTouch.OnFingerUp)("+", self.__onFingerUp)
  ;
  (cs_LeanTouch.OnFingerTap)("+", self.__onFingerTap)
  local enterFunc = function()
    -- function num : 0_7_0 , upvalues : self, BuildingCanvas, _ENV, InputMode, OasisEnum
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
    self.__ConfirmOver = BindCallback(self, self.UpgradeConfirmOver)
    MsgCenter:AddListener(eMsgEventId.BuildingUpgradeComplete, self.__ConfirmOver)
    self.__UpdateProcessEvent = BindCallback(self, self.UpdateProcessEvent)
    MsgCenter:AddListener(eMsgEventId.UpdateBuildingProcess, self.__UpdateProcessEvent)
    self.__onItemRefresh = BindCallback(self, self._OnItemRefresh)
    MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemRefresh)
    MsgCenter:AddListener(eMsgEventId.UpdateARGItem, self.__onItemRefresh)
    UIManager:ShowWindowAsync(UIWindowTypeID.BuildingQueue, function(window)
      -- function num : 0_7_0_0 , upvalues : self, _ENV
      self.queueWindow = window
      ;
      ((window.ui).tween_constructQueue):DORestart()
      window:UpdateBuildingQueue(PlayerDataCenter.timestamp)
      window:SetUIPositionInOasis()
    end
)
    UIManager:ShowWindowAsync(UIWindowTypeID.OasisMain, function(window)
      -- function num : 0_7_0_1 , upvalues : _ENV, self, OasisEnum
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

OasisController.__HideOtherBuilding = function(self)
  -- function num : 0_10 , upvalues : cs_CameraController, cs_Physics, _ENV
  if self._focusToBuilding then
    local bdItem = (self.buildingItems)[(self.selectedBuildingData).id]
    if bdItem == nil then
      bdItem = self.newBuildingItem
    end
    local focusCamPos = (((cs_CameraController.Instance).m_focusCam).transform).position
    local direction = focusCamPos - (bdItem.rootTransform).position
    local hits = (cs_Physics.Raycast)((bdItem.rootTransform).position, direction, 1 << LayerMask.Raycast)
    for i = 0, hits.Length - 1 do
      local hitCollider = (hits[i]).collider
      if not IsNull(hitCollider) and hitCollider.tag == TagConsts.Building then
        local hitName = (hitCollider.gameObject).name
        local hitBdItem = self:__GetBuildingItemByName(hitName)
        -- DECOMPILER ERROR at PC58: Confused about usage of register: R12 in 'UnsetPending'

        if hitBdItem ~= nil and hitBdItem ~= bdItem and (self.hidenBuildingItems)[hitBdItem.id] == nil then
          (self.hidenBuildingItems)[hitBdItem.id] = hitBdItem
          hitBdItem:Show(false)
        end
      end
    end
  else
    do
      for k,v in pairs(self.hidenBuildingItems) do
        v:Show(true)
        -- DECOMPILER ERROR at PC72: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (self.hidenBuildingItems)[k] = nil
      end
    end
  end
end

OasisController.FocusBuildingTween = function(self, toBuilding, buildingItem)
  -- function num : 0_11 , upvalues : cs_CameraController, _ENV
  self._focusToBuilding = toBuilding
  if toBuilding then
    self.isFocusBuilding = true
    if buildingItem ~= nil then
      (cs_CameraController.Instance):SetFocusCamPosition((buildingItem.rootTransform).position, buildingItem:GetUnitySize())
    end
    if self.canvas ~= nil then
      (self.canvas):SetNameRootActive(false)
    end
    if self.focusDirectorStopped == nil then
      self.focusDirectorStopped = BindCallback(self, function(director)
    -- function num : 0_11_0 , upvalues : self, cs_CameraController
    local bdItem = (self.buildingItems)[(self.selectedBuildingData).id]
    if bdItem == nil then
      bdItem = self.newBuildingItem
    end
    if bdItem.buildingData ~= nil and (bdItem.buildingData).waitConfirmOver then
      bdItem:EnterFocusLayer(true)
      ;
      (cs_CameraController.Instance):EnableBlur(true)
      ;
      (cs_CameraController.Instance):SyncCamPosToFocusCam()
      self.focusDirectorStopped = nil
      self.selectBuiltId = nil
    end
  end
, self.focusDirector)
    end
    ;
    ((self.focusDirector).gameObject):SetActive(true)
    ;
    (TimelineUtil.Play)(self.focusDirector, self.focusDirectorStopped)
  else
    if buildingItem ~= nil then
      buildingItem:EnterFocusLayer(false)
    end
    ;
    (cs_CameraController.Instance):EnableBlur(false)
    ;
    (TimelineUtil.Rewind)(self.focusDirector, BindCallback(self, self.__FocusBuildingTweenRewindComplete))
  end
end

OasisController.__FocusBuildingTweenRewindComplete = function(self)
  -- function num : 0_12 , upvalues : InputMode, cs_CameraController
  self.isFocusBuilding = false
  self:__ShowResidentUI(true)
  self.__inputMode = InputMode.ClickBuilding
  ;
  (cs_CameraController.Instance):DragEnable(true)
  ;
  ((self.focusDirector).gameObject):SetActive(false)
  if self.canvas ~= nil then
    (self.canvas):SetNameRootActive(true)
  end
end

OasisController.EnterEditMode = function(self)
  -- function num : 0_13 , upvalues : _ENV, InputMode, OasisEnum
  local editWindow = UIManager:ShowWindow(UIWindowTypeID.OasisEditWindow)
  editWindow:InitOasisEditor(self)
  self.__inputMode = InputMode.None
  self.__oasisState = (OasisEnum.OasisState).EditorBuild
  self:TopViewTween(true)
  self:__ShowRedHexAll(true)
  local window = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if window ~= nil then
    (window.oasisSelectNode):Hide()
  end
  if self.canvas ~= nil then
    (self.canvas):SetBuildCanvasTopMode(true)
  end
  self:UnselectOasisBuilding()
end

OasisController.ExitEditMode = function(self)
  -- function num : 0_14 , upvalues : InputMode, OasisEnum
  if self.newBuildingItem ~= nil then
    self:CancelNewBuilding()
  end
  self.__inputMode = InputMode.ClickBuilding
  self.__oasisState = (OasisEnum.OasisState).Normal
  self:TopViewTween(false)
  self:__ShowRedHexAll(false)
  if self.canvas ~= nil then
    (self.canvas):SetBuildCanvasTopMode(false)
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
  self:__CreateRedHex(buildingData.id, item:GetUnityPostion(), buildingData.size)
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
  (effectEntity.transform):SetParent(self._effectHolder)
  local effectName = effectEntity:GetOasisBuildEffectEntityName()
  local effectList = (self._effectPool)[effectName]
  ;
  (table.insert)(effectList, effectEntity)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self._effectInUseDic)[effectEntity] = nil
end

OasisController.__CreateRedHex = function(self, id, unityPos, size)
  -- function num : 0_19 , upvalues : _ENV
  local name = "RedHex" .. size[1]
  if size[1] == 1 then
    name = name .. "-" .. tostring(size[2])
  end
  local path = PathConsts:GetOasisBuildingPrefabPath(name)
  local prefab = (self.resloader):LoadABAsset(path)
  local go = prefab:Instantiate(self.buildingRedHex)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (go.transform).position = unityPos
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self.buildingRedHexDic)[id] = go
end

OasisController.__ShowRedHexAll = function(self, show)
  -- function num : 0_20
  ((self.buildingRedHex).gameObject):SetActive(show)
end

OasisController.__ShowRedHex = function(self, id, show)
  -- function num : 0_21 , upvalues : _ENV
  local go = (self.buildingRedHexDic)[id]
  if IsNull(go) then
    return 
  end
  go:SetActive(show)
end

OasisController.__MoveRedHex = function(self, id, unityPos)
  -- function num : 0_22 , upvalues : _ENV
  local go = (self.buildingRedHexDic)[id]
  if IsNull(go) then
    return 
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (go.transform).position = unityPos
end

OasisController.__DeleteRedHex = function(self, id)
  -- function num : 0_23 , upvalues : _ENV
  local go = (self.buildingRedHexDic)[id]
  if IsNull(go) then
    return 
  end
  DestroyUnityObject(go)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.buildingRedHexDic)[id] = nil
end

OasisController.__GetBuildablePos = function(self, oasisPos, size, areaId)
  -- function num : 0_24 , upvalues : _ENV, CoordinateConvert
  local oasisArea = (self.oasisAreaList)[areaId]
  if oasisArea == nil then
    error("Cant\'t find oasisArea, areaId = " .. tostring(areaId))
    return 
  end
  local areaList = (CoordinateConvert.GetHexArea)(oasisPos, size)
  local overlap = self:CheckBuildingOverlap(areaId, areaList)
  if not overlap then
    return oasisPos, oasisArea.id
  end
  local radius = (oasisArea.cfg).size
  local n = radius - 1
  for x = -n, n do
    for y = (math.max)(-n, -x - n), (math.min)(n, -x + n) do
      oasisPos = (Vector2.New)(x, y)
      areaList = (CoordinateConvert.GetHexArea)(oasisPos, size)
      overlap = self:CheckBuildingOverlap(areaId, areaList)
      if not overlap then
        return oasisPos, oasisArea.id
      end
    end
  end
  for k,v in ipairs(self.oasisAreaList) do
    if k ~= areaId then
      oasisArea = v
      local radius = (oasisArea.cfg).size
      local n = radius - 1
      for x = -n, n do
        for y = (math.max)(-n, -x - n), (math.min)(n, -x + n) do
          oasisPos = (Vector2.New)(x, y)
          areaList = (CoordinateConvert.GetHexArea)(oasisPos, size)
          overlap = self:CheckBuildingOverlap(k, areaList)
          if not overlap then
            return oasisPos, oasisArea.id
          end
        end
      end
    end
  end
  error("没有找到合适的部署位置")
end

OasisController.NewBuilding = function(self, buildingData)
  -- function num : 0_25 , upvalues : CoordinateConvert, _ENV, cs_CameraController, InputMode
  local dynData = buildingData.dynData
  local prefabName = ((dynData.levelConfig)[1]).modol
  self.__newAreaPos = self:__GetBuildablePos(dynData.position, dynData.size, dynData.area)
  local unityPosition = (CoordinateConvert.ToUnity)(self.__newAreaPos, dynData.size)
  local item = self:CreateBuildingItem(unityPosition, dynData.size, dynData.height, self.__newAreaId)
  item:LoadBuildingGo(prefabName)
  self.newBuildingItem = item
  self.selectedBuildingData = buildingData
  local window = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if window ~= nil then
    (window.oasisSelectNode):InitOasisBuildSelect(buildingData, item, self)
    ;
    (window.oasisSelectNode):EnableBuildConfirmBtn(true)
  end
  ;
  (cs_CameraController.Instance):Cam2BuildingTopPos(item.rootTransform)
  self.__inputMode = InputMode.None
end

OasisController.CancelNewBuilding = function(self)
  -- function num : 0_26 , upvalues : _ENV, InputMode
  if self.newBuildingItem ~= nil then
    self:__DeleteRedHex((self.newBuildingItem).id)
    ;
    (self.newBuildingItem):OnDelete()
    ;
    (self.newBuildingItem):DeleteEntity()
    self.newBuildingItem = nil
  end
  self.selectedBuildingData = nil
  local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if mainWindow ~= nil then
    (mainWindow.oasisSelectNode):Hide()
  end
  local editWindow = UIManager:GetWindow(UIWindowTypeID.OasisEditWindow)
  if editWindow ~= nil then
    editWindow:ShowOasisEditorSideTween(true)
  end
  self.__inputMode = InputMode.None
end

OasisController.StartConstruct = function(self)
  -- function num : 0_27 , upvalues : cs_MessageCommon, _ENV, CoordinateConvert
  local oasisPos = self.__newAreaPos
  local size = (self.selectedBuildingData).size
  local areaId = self.__newAreaId
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
  -- function num : 0_28 , upvalues : _ENV, InputMode
  local buildingData = ((self.buildingDatas).built)[id]
  local editWindow = UIManager:GetWindow(UIWindowTypeID.OasisEditWindow)
  if editWindow ~= nil then
    editWindow:ShowOasisEditorSideTween(true)
  end
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.buildingItems)[id] = self.newBuildingItem
  ;
  (self.newBuildingItem):SetPosition(buildingData.position)
  ;
  (self.newBuildingItem):SetBuildingData(buildingData)
  ;
  (self.newBuildingItem):SetCanvas(self.canvas)
  ;
  (self.newBuildingItem):UpdateState()
  self:__CreateRedHex(id, (self.newBuildingItem):GetUnityPostion(), buildingData.size)
  self:UpdateBuildingMap(buildingData)
  local effectEntity = self:GetOasisEffectEntity(((buildingData.dynData).stcData).construct_effect)
  local buildTrans = (self.newBuildingItem).rootTransform
  effectEntity:InitOasisBuildEffectEntity(buildTrans.position, buildTrans, self._returnEffectFunc)
  self.newBuildingItem = nil
  self.selectedBuildingData = buildingData
  self.__inputMode = InputMode.None
end

OasisController.StartUpgrade = function(self, buildingData)
  -- function num : 0_29 , upvalues : cs_MessageCommon, _ENV
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
  -- function num : 0_30 , upvalues : _ENV
  local builtData = ((self.buildingDatas).built)[id]
  local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if mainWindow ~= nil then
    (mainWindow.buildDetailNode):HideOasisBuildDetail()
    ;
    (mainWindow.oasisSelectNode):RefreshOasisSelectState()
  end
  local buildingItem = (self.buildingItems)[id]
  local prefabName = ((builtData.levelConfig)[builtData.level]).modol
  buildingItem:LoadBuildingGo(prefabName, function(buildItem)
    -- function num : 0_30_0 , upvalues : self
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
  -- function num : 0_31
  (self.networkCtrl):SendBuildingCancel((self.selectedBuildingData).id)
end

OasisController.__SendConfimAcc = function(self, id, cost)
  -- function num : 0_32
  (self.networkCtrl):SendBuildingAccelerate(id, cost)
end

OasisController.__SendConfimOver = function(self, id)
  -- function num : 0_33 , upvalues : cs_MessageCommon, _ENV
  local builtData = ((self.buildingDatas).built)[id]
  if not builtData.waitConfirmOver then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Building_Incomplete))
    return 
  end
  ;
  (self.networkCtrl):SendBuildingConfirmOver(id)
end

OasisController.UpgradeConfirmOver = function(self, id)
  -- function num : 0_34 , upvalues : _ENV, cs_MessageCommon
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

OasisController.MoveComplete = function(self, id)
  -- function num : 0_35 , upvalues : CoordinateConvert
  local item = (self.buildingItems)[id]
  local buildingData = item.buildingData
  self:UpdateBuildingMap(buildingData)
  local oasisArea = (self.oasisAreaList)[buildingData.area]
  local unityLocalPosition = (CoordinateConvert.ToUnity)(buildingData.position, buildingData.size)
  local worldPos = (oasisArea.transform):TransformPoint(unityLocalPosition)
  self:__MoveRedHex(id, worldPos)
  self:__ShowRedHex(buildingData.id, true)
end

OasisController.CollectOasisRes = function(self, id)
  -- function num : 0_36 , upvalues : _ENV
  if GuideManager.collectResGuideUnComplete and id == 1003 then
    GuideManager:UncompleteCollectResGuide(false)
    local topWindow = UIManager:GetWindow(UIWindowTypeID.TopStatus)
    ;
    (topWindow.resGroup):UpdateResourceGroupTopCurrencys()
    self:CollectComplete(1003, {
{id = 1004, count = 1}
})
    return 
  end
  do
    if self:__checkCollectAvailable(id) then
      (self.networkCtrl):SendBuildingCollect(id)
    end
  end
end

OasisController.__checkCollectAvailable = function(self, buildingId)
  -- function num : 0_37
  local buildingData = ((self.buildingDatas).built)[buildingId]
  return buildingData:CanGetBuildRes(true)
end

OasisController.CollectComplete = function(self, id, resTab)
  -- function num : 0_38 , upvalues : _ENV, cs_MessageCommon
  local buildingItem = (self.buildingItems)[id]
  if buildingItem ~= nil then
    buildingItem:UpdateBuildingResUI()
  end
  for k,v in ipairs(resTab) do
    local item = (ConfigData.item)[v.id]
    if not IsNull(item) then
      local msg = ConfigData:GetTipContent(TipContent.Building_GainReward) .. (LanguageUtil.GetLocaleText)(item.name) .. " x " .. tostring(v.count)
      ;
      (cs_MessageCommon.ShowMessageTips)(msg, true)
    end
  end
end

OasisController.CollectAllOasisBuildingRes = function(self)
  -- function num : 0_39 , upvalues : _ENV
  local buildIdDict = {}
  local buildingCount = 0
  for buildId,buildData in pairs((PlayerDataCenter.AllBuildingData).oasisBuilt) do
    if buildData:IsBuildResPeriodOk() and self:__checkCollectAvailable(buildId) then
      buildingCount = buildingCount + 1
      buildIdDict[buildId] = true
    end
  end
  if buildingCount > 0 then
    if self._CollectAllResCompleteFunc == nil then
      self._CollectAllResCompleteFunc = BindCallback(self, self._OnCollectAllResComplete)
    end
    ;
    (self.networkCtrl):SendBuildingCollectGroup(buildIdDict, self._CollectAllResCompleteFunc)
  end
end

OasisController._OnCollectAllResComplete = function(self, objList)
  -- function num : 0_40 , upvalues : _ENV, cs_MessageCommon
  if objList.Count ~= 1 then
    error("objList.Count error:" .. tostring(objList.Count))
    return 
  end
  local resDic = objList[0]
  for resId,resNum in pairs(resDic) do
    local itemCfg = (ConfigData.item)[resId]
    if itemCfg ~= nil then
      local msg = ConfigData:GetTipContent(TipContent.Building_GainReward) .. (LanguageUtil.GetLocaleText)(itemCfg.name) .. " x " .. tostring(resNum)
      ;
      (cs_MessageCommon.ShowMessageTips)(msg, true)
    end
  end
end

OasisController.SendCancelEvent = function(self)
  -- function num : 0_41
  (self.networkCtrl):SendBuildingCancel((self.newBuildingItem).id)
end

OasisController.CancelComplete = function(self, id, oldState)
  -- function num : 0_42 , upvalues : _ENV
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
        local prefabName = ((buildingData.levelConfig)[buildingData.level]).modol
        local unityPosition = (buildingItem.rootTransform).localPosition
        buildingItem:LoadBuildingGo(prefabName)
        buildingItem:UpdateState()
      end
    end
  end
end

OasisController.UpdateBuilding = function(self, id)
  -- function num : 0_43 , upvalues : _ENV
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
  -- function num : 0_44 , upvalues : _ENV
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

OasisController.UpdateBuildingRes = function(self, id)
  -- function num : 0_45
end

OasisController.OnUpdate = function(self)
  -- function num : 0_46 , upvalues : _ENV
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
  if self.queueWindow ~= nil then
    (self.queueWindow):Update(timestamp, isSecond)
  end
end

OasisController.OnLateUpdate = function(self)
  -- function num : 0_47 , upvalues : _ENV
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
    local window = UIManager:GetWindow(UIWindowTypeID.OasisMain)
    if window ~= nil then
      (window.oasisSelectNode):RefreshOasisSelectPos()
      window:ShowOasisMainCollectResBtn(canCollect)
    end
    for k,v in pairs(self.buildingItems) do
      v:BuiltItemLateUpdate()
    end
  end
end

OasisController.OnFingerDown = function(self, leanFinger)
  -- function num : 0_48 , upvalues : InputMode, cs_InputUtility, cs_Physics, _ENV, cs_CameraController
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
      if self.__inputMode == InputMode.ConstructBuilding and self.__selectedBuilding == nil and self.newBuildingItem ~= nil and hitObj == (self.newBuildingItem).gameObject then
        self.__selectedBuilding = self.newBuildingItem
        self.__selectedBuildingLastPos = (self.__selectedBuilding).newOasisPos
        self.__originalPosition = ((self.__selectedBuilding).rootTransform).position
        self.__fingerId = leanFinger.Index
        ;
        (cs_CameraController.Instance):DragEnable(false)
      else
        if self.__inputMode == InputMode.MoveBuilding and self.__selectedBuilding == nil then
          local item = self:__GetBuildingItemByName(hitName)
          if item ~= nil then
            local buildingData = item.buildingData
            self.__selectedBuilding = item
            self.__selectedBuildingLastPos = buildingData.position
            self.__originalPosition = ((self.__selectedBuilding).rootTransform).position
            item:Select(true)
            item:Overlap(false)
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
  -- function num : 0_49 , upvalues : cs_InputUtility, InputMode, cs_CameraController, cs_Physics, _ENV
  if leanFinger.StartedOverGui or leanFinger.IsOverGui or self.__fingerId ~= leanFinger.Index or (leanFinger.ScreenDelta).x == 0 and (leanFinger.ScreenDelta).y == 0 then
    return 
  end
  if not self.__isDrag and self.__lastMousePos ~= cs_InputUtility.MousePosition then
    self.__isDrag = true
    if self.__inputMode == InputMode.MoveBuilding and self.__selectedBuilding ~= nil then
      local buildingData = (self.__selectedBuilding).buildingData
      self:BuildInMap(buildingData.area, buildingData:GetArea(), false)
      self:__ShowRedHex(buildingData.id, false)
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
          if oasisArea ~= nil then
            (self.__selectedBuilding):SetItemArea(oasisArea.transform)
            local localPosition = hit.point - (oasisArea.transform).position
            local oasisPos, unityPos, areaList = (self.__selectedBuilding):SetRoundPosition(localPosition, false, true)
            self.__newAreaList = areaList
            self.__newAreaId = areaId
            self.overlap = self:CheckBuildingOverlap(areaId, areaList)
            ;
            (self.__selectedBuilding):Overlap(self.overlap)
            ;
            (self.__selectedBuilding):UpdateCanvasItemPos()
            if oasisPos ~= self.__selectedBuildingLastPos then
              self.__selectedBuildingLastPos = oasisPos
              ;
              ((self.__selectedBuilding).rootTransform):DOLocalMove(unityPos, 0.1)
            end
          end
          break
        end
      end
    end
  end
end

OasisController.OnFingerUp = function(self, leanFinger)
  -- function num : 0_50 , upvalues : InputMode, cs_Physics, _ENV, cs_CameraController
  if leanFinger.StartedOverGui or self.__fingerId ~= leanFinger.Index then
    return 
  end
  if self.__selectedBuilding ~= nil then
    if self.__inputMode == InputMode.MoveBuilding then
      (self.__selectedBuilding):Select(false)
    end
    if self.__isDrag then
      local buildingData = (self.__selectedBuilding).buildingData
      if self.__inputMode == InputMode.MoveBuilding then
        self.overlap = self:CheckBuildingOverlap(self.__newAreaId, self.__newAreaList)
        ;
        (self.__selectedBuilding):Overlap(self.overlap)
        if self.overlap or buildingData.position == (self.__selectedBuilding).newOasisPos then
          (self.__selectedBuilding):SetItemArea(((self.oasisAreaList)[buildingData.area]).transform)
          ;
          (self.__selectedBuilding):SetPosition(buildingData.position, true)
          self:BuildInMap(buildingData.area, buildingData:GetArea(), true)
          self:__ShowRedHex((self.__selectedBuilding).id, true)
        else
          ;
          (self.networkCtrl):SendBuildingMove((self.__selectedBuilding).id, (self.__selectedBuilding).newOasisPos, self.__newAreaId)
        end
        ;
        (self.__selectedBuilding):UpdateCanvasItemPos()
      end
      self.__isDrag = false
    else
      do
        if self.__inputMode == InputMode.ClickBuilding then
          local hits = (cs_Physics.Raycast)(self.__mainCam, 1 << LayerMask.Raycast)
          for i = 0, hits.Length - 1 do
            local hitCollider = (hits[i]).collider
            if not IsNull(hitCollider) and hitCollider.tag == TagConsts.Building then
              local hitName = (hitCollider.gameObject).name
              local buildingItem = self:__GetBuildingItemByName(hitName)
              if buildingItem ~= nil and buildingItem == self.__selectedBuilding and self.isFocusBuilding then
                return 
              end
            end
          end
        end
        do
          self.__selectedBuilding = nil
          ;
          (cs_CameraController.Instance):DragEnable(true)
          self.__fingerId = nil
        end
      end
    end
  end
end

OasisController.OnFingerTap = function(self, leanFinger)
  -- function num : 0_51 , upvalues : InputMode, cs_Physics, _ENV
  if leanFinger.StartedOverGui or leanFinger.IsOverGui or self.__inputMode == InputMode.None then
    return 
  end
  if self.__inputMode == InputMode.ClickBuilding then
    local hits = (cs_Physics.Raycast)(self.__mainCam, 1 << LayerMask.Raycast)
    for i = 0, hits.Length - 1 do
      local hitCollider = (hits[i]).collider
      if not IsNull(hitCollider) and hitCollider.tag == TagConsts.Building then
        local hitName = (hitCollider.gameObject).name
        local buildingItem = self:__GetBuildingItemByName(hitName)
        if buildingItem ~= nil then
          if self.isFocusBuilding then
            return 
          end
          if (buildingItem.buildingData):CanGetBuildRes() then
            self:CollectOasisRes(buildingItem.id)
          else
            self:SelectOasisBuilding(buildingItem)
          end
          return 
        end
      end
    end
    self:UnselectOasisBuilding()
  end
end

OasisController.SelectOasisBuilding = function(self, buildingItem)
  -- function num : 0_52 , upvalues : _ENV
  if self.__selectedBuilding == buildingItem then
    return 
  end
  if self.__selectedBuilding ~= nil then
    if self.canvas ~= nil then
      (self.canvas):ShowBuildingName3dItem((self.__selectedBuilding).id, true)
    end
    local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
    if mainWindow ~= nil then
      (mainWindow.oasisResNode):ShowOasisResUIItem((self.__selectedBuilding).id, true)
    end
  end
  do
    self.__selectedBuilding = buildingItem
    if self.canvas ~= nil then
      (self.canvas):ShowBuildingName3dItem(buildingItem.id, false)
    end
    local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
    if mainWindow ~= nil then
      (mainWindow.oasisSelectNode):InitOasisBuildSelect(buildingItem.buildingData, buildingItem, self)
      ;
      (mainWindow.oasisResNode):ShowOasisResUIItem(buildingItem.id, false)
    end
  end
end

OasisController.UnselectOasisBuilding = function(self)
  -- function num : 0_53 , upvalues : _ENV
  if self.__selectedBuilding == nil then
    return 
  end
  if self.canvas ~= nil then
    (self.canvas):ShowBuildingName3dItem((self.__selectedBuilding).id, true)
  end
  local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if mainWindow ~= nil then
    (mainWindow.oasisSelectNode):Hide()
    ;
    (mainWindow.oasisResNode):ShowOasisResUIItem((self.__selectedBuilding).id, true)
  end
  self.__selectedBuilding = nil
end

OasisController.__LerpMoveBuilding = function(self, from, to)
  -- function num : 0_54 , upvalues : _ENV
  (Vector3.Slerp)(from, to, Time.deltaTime)
end

OasisController.GetBuildingItemByGo = function(self, gameObject)
  -- function num : 0_55 , upvalues : _ENV
  for _,v in pairs(self.buildingItems) do
    if v.gameObject == gameObject then
      return v
    end
  end
  return nil
end

OasisController.CheckBuildingOverlap = function(self, areaId, areaList)
  -- function num : 0_56 , upvalues : _ENV, CoordinateConvert
  local oasisArea = (self.oasisAreaList)[areaId]
  local oasisAreaCfg = (ConfigData.oasis_area)[areaId]
  if oasisAreaCfg == nil then
    error("Can\'t find oasisAreaCfg, id = " .. tostring(areaId))
    return 
  end
  local radius = oasisAreaCfg.size
  for k,position in ipairs(areaList) do
    local distance = (CoordinateConvert.HexDistance2Center)(position)
    if radius <= distance then
      return true
    end
    if (oasisArea.buildingMap)[position.x] ~= nil and ((oasisArea.buildingMap)[position.x])[position.y] ~= nil then
      return true
    end
  end
  return false
end

OasisController.UpdateBuildingMap = function(self, buildingData, oldAreaId, oldPosList)
  -- function num : 0_57
  if oldPosList ~= nil then
    self:BuildInMap(oldAreaId, oldPosList, false)
  end
  local posList = buildingData:GetArea()
  self:BuildInMap(buildingData.area, posList, true)
end

OasisController.BuildInMap = function(self, areaId, positionList, build)
  -- function num : 0_58 , upvalues : _ENV, CoordinateConvert
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
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R13 in 'UnsetPending'

    if (oasisArea.buildingMap)[position.x] == nil then
      (oasisArea.buildingMap)[position.x] = {}
    end
    local value = nil
    if build then
      value = true
    end
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R14 in 'UnsetPending'

    ;
    ((oasisArea.buildingMap)[position.x])[position.y] = value
  end
end

OasisController.__GetBuildingItemByName = function(self, name)
  -- function num : 0_59 , upvalues : _ENV
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

OasisController.__OnTriggerEnterCam = function(self, name)
  -- function num : 0_60
  local buildItem = self:__GetBuildingItemByName(name)
  if buildItem ~= nil then
    buildItem:Show(false)
  end
end

OasisController.__OnTriggerExitCam = function(self, name)
  -- function num : 0_61
  local buildItem = self:__GetBuildingItemByName(name)
  if buildItem ~= nil then
    buildItem:Show(true)
  end
end

OasisController.__ShowResidentUI = function(self, show)
  -- function num : 0_62 , upvalues : _ENV
  if show then
    local mainWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
    if mainWindow ~= nil then
      mainWindow:OnEnterOasisEditMode(false)
    end
    if self.queueWindow ~= nil then
      (self.queueWindow):Show()
    end
  else
    do
      if self.queueWindow ~= nil then
        (self.queueWindow):Hide()
      end
    end
  end
end

OasisController.UpdateProcessEvent = function(self, id, progress, remainTimeText, waitConfirmOver)
  -- function num : 0_63
  local buildingItem = (self.buildingItems)[id]
  if buildingItem ~= nil then
    buildingItem:UpdateProcessUI(progress, remainTimeText, waitConfirmOver)
  end
end

OasisController.OasisBackToHome = function(self)
  -- function num : 0_64
  if self.backToHomeEvent ~= nil then
    (self.backToHomeEvent)()
    self.backToHomeEvent = nil
  end
end

OasisController.OnExitOasis = function(self)
  -- function num : 0_65 , upvalues : JumpManager, OasisEnum, _ENV, cs_CameraController, cs_LeanTouch
  JumpManager.couldUseItemJump = false
  self.__selectedBuilding = nil
  self.__oasisState = (OasisEnum.OasisState).None
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, (eAuSelct.Home).name, (eAuSelct.Home).base)
  if self.__enterCoroutine ~= nil then
    (GR.StopCoroutine)(self.__enterCoroutine)
  end
  MsgCenter:RemoveListener(eMsgEventId.BuildingUpgradeComplete, self.__ConfirmOver)
  MsgCenter:RemoveListener(eMsgEventId.UpdateBuildingProcess, self.__UpdateProcessEvent)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemRefresh)
  MsgCenter:RemoveListener(eMsgEventId.UpdateARGItem, self.__onItemRefresh)
  self.isEnter = false
  ;
  (cs_CameraController.Instance):DragEnable(false)
  ;
  (cs_CameraController.Instance):EnableTrigger(false)
  UIManager:DeleteWindow(UIWindowTypeID.OasisEditWindow)
  UIManager:DeleteWindow(UIWindowTypeID.OasisMain)
  UIManager:DeleteWindow(UIWindowTypeID.BuildingQueue)
  self.queueWindow = nil
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
end

OasisController.OnDelete = function(self)
  -- function num : 0_66 , upvalues : _ENV, base
  UpdateManager:RemoveUpdate(self.__update__handle)
  UpdateManager:RemoveLateUpdate(self.__lateUpdateHandle)
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
  self:OnExitOasis()
  self.jumpEvent = nil
  ;
  (base.OnDelete)(self)
end

return OasisController

