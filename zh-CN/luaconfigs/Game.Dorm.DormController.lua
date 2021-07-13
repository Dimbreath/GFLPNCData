-- params : ...
-- function num : 0 , upvalues : _ENV
local DormController = class("DormController", ControllerBase)
local util = require("XLua.Common.xlua_util")
local AllDormData = require("Game.Dorm.Data.AllDormData")
local eDormState = require("Game.Dorm.Enum.eDormState")
local DormHouseCtrl = require("Game.Dorm.Ctrl.DormHouseCtrl")
local DormRoomCtrl = require("Game.Dorm.Ctrl.DormRoomCtrl")
local DormShopCtrl = require("Game.Dorm.Ctrl.DormShopCtrl")
local DormCharacterCtrl = require("Game.Dorm.Ctrl.DormCharacterCtrl")
local DormCmderCtrl = require("Game.Dorm.Ctrl.DormCmderCtrl")
local DormAStarPathCtrl = require("Game.Dorm.Ctrl.DormAStarPathCtrl")
local CS_LeanTouch = ((CS.Lean).Touch).LeanTouch
DormController.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.__isInDormScene = false
  self.__onChangeDormBindComplete = BindCallback(self, self.OnChangeDormBindComplete)
end

DormController.PreInitDorm = function(self)
  -- function num : 0_1 , upvalues : eDormState, _ENV, DormHouseCtrl, DormRoomCtrl, DormShopCtrl, DormAStarPathCtrl, DormCharacterCtrl, DormCmderCtrl
  self.state = eDormState.None
  self.__onDormTouchTap = BindCallback(self, self.OnDormTouchTap)
  self.__onDormTouchGesture = BindCallback(self, self.OnDormTouchGesture)
  self.ctrls = {}
  self.houseCtrl = (DormHouseCtrl.New)(self)
  self.roomCtrl = (DormRoomCtrl.New)(self)
  self.shopCtrl = (DormShopCtrl.New)(self)
  self.astarPathCtrl = (DormAStarPathCtrl.New)(self)
  self.characterCtrl = (DormCharacterCtrl.New)(self)
  self.cmderCtrl = (DormCmderCtrl.New)(self)
  self.dormNetwork = NetworkManager:GetNetwork(NetworkTypeID.Dorm)
end

DormController.EnterDorm = function(self)
  -- function num : 0_2 , upvalues : _ENV, util
  self:PreInitDorm()
  ;
  (self.dormNetwork):CS_DORM_GlobalDetail()
  UIManager:DeleteAllWindow()
  self.comResloader = ((CS.ResLoader).Create)()
  self.comRes = {}
  local preLoadFunc = function()
    -- function num : 0_2_0 , upvalues : self, _ENV
    local effectWait = (self.comResloader):LoadABAssetAsyncAwait("Res/Effect/Prefabs/FX_Pick.prefab")
    local interPointWait = (self.comResloader):LoadABAssetAsyncAwait("Res/Effect/Prefabs/DragPoint.prefab")
    local fntBottomWait = (self.comResloader):LoadABAssetAsyncAwait(PathConsts:GetDormFntPath("FntBottom"))
    local gridWallWait = (self.comResloader):LoadABAssetAsyncAwait(PathConsts:GetDormRoomPath("DormWallGrid"))
    local gridFloorWait = (self.comResloader):LoadABAssetAsyncAwait(PathConsts:GetDormRoomPath("DormFloorGrid"))
    local cmderPrefabWait = (self.comResloader):LoadABAssetAsyncAwait(PathConsts:GetCharacterDormModelPath("professor"))
    local enterRoomEffectWait = (self.comResloader):LoadABAssetAsyncAwait("FX/Common/FX_Transition/FXP_Transition.prefab")
    local exitRoomEffectWait = (self.comResloader):LoadABAssetAsyncAwait("FX/Common/FX_Transition/FXP_Transition_Back.prefab")
    local dormConfigAssetWait = (self.comResloader):LoadABAssetAsyncAwait("Res/ScriptableConfig/DormConfigAsset.asset")
    ;
    (coroutine.yield)(effectWait)
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.comRes).selectRoomEffectPrefab = effectWait.Result
    ;
    (coroutine.yield)(interPointWait)
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.comRes).interPointPrefab = interPointWait.Result
    ;
    (coroutine.yield)(fntBottomWait)
    -- DECOMPILER ERROR at PC68: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.comRes).fntBottomPrefab = fntBottomWait.Result
    ;
    (coroutine.yield)(gridWallWait)
    -- DECOMPILER ERROR at PC75: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.comRes).gridWallPrefab = gridWallWait.Result
    ;
    (coroutine.yield)(gridFloorWait)
    -- DECOMPILER ERROR at PC82: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.comRes).gridFloorPrefab = gridFloorWait.Result
    ;
    (coroutine.yield)(cmderPrefabWait)
    -- DECOMPILER ERROR at PC89: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.comRes).cmderPrefab = cmderPrefabWait.Result
    ;
    (coroutine.yield)(enterRoomEffectWait)
    -- DECOMPILER ERROR at PC96: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.comRes).enterRoomEffectPrefab = enterRoomEffectWait.Result
    ;
    (coroutine.yield)(exitRoomEffectWait)
    -- DECOMPILER ERROR at PC103: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.comRes).exitRoomEffectPrefab = exitRoomEffectWait.Result
    ;
    (coroutine.yield)(dormConfigAssetWait)
    -- DECOMPILER ERROR at PC110: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.comRes).dormConfigAsset = dormConfigAssetWait.Result
    UIManager:ShowWindowAsync(UIWindowTypeID.Dorm)
    ;
    (coroutine.yield)(nil)
    repeat
      self.dormWindow = UIManager:GetWindow(UIWindowTypeID.Dorm)
      ;
      (coroutine.yield)(nil)
    until self.dormWindow
  end

  ;
  (UIManager:GetWindow(UIWindowTypeID.Loading)):SetLoadingTipsSystemId(3)
  ;
  ((CS.GSceneManager).Instance):LoadSceneAsyncByAB((Consts.SceneName).Dorm, function(ok)
    -- function num : 0_2_1 , upvalues : _ENV, self
    ((CS.RenderManager).Instance):SetUnityShadow(true)
    self.__isInDormScene = true
    self:InitDorm()
    if self.allDormData ~= nil then
      self:EnterDormDefaultHouse()
    end
  end
, (util.cs_generator)(preLoadFunc))
end

DormController.ExitDorm = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self:__ClearData()
  UIManager:DeleteAllWindow()
  ;
  (UIManager:GetWindow(UIWindowTypeID.Loading)):SetLoadingTipsSystemId(3)
  ;
  ((CS.RenderManager).Instance):SetUnityShadow(false)
  ;
  ((CS.GSceneManager).Instance):LoadSceneAsyncByAB((Consts.SceneName).Main, function(ok)
    -- function num : 0_3_0 , upvalues : _ENV
    (ControllerManager:GetController(ControllerTypeId.HomeController, true)):OnEnterHome()
    UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
      -- function num : 0_3_0_0 , upvalues : _ENV
      if window == nil then
        return 
      end
      window:SetFrom2Home(AreaConst.Sector, true)
    end
)
  end
)
end

DormController.GetDormConfigAsset = function(self)
  -- function num : 0_4
  return (self.comRes).dormConfigAsset
end

DormController.RecvDormDetailData = function(self, msg)
  -- function num : 0_5 , upvalues : AllDormData, eDormState
  self.allDormData = (AllDormData.New)()
  ;
  (self.allDormData):InitDormData(msg)
  if self.__isInDormScene and self.state == eDormState.None then
    self:EnterDormDefaultHouse()
  end
end

DormController.InitDorm = function(self)
  -- function num : 0_6 , upvalues : eDormState, _ENV, CS_LeanTouch
  self.state = eDormState.House
  self.bind = {}
  ;
  (UIUtil.LuaUIBindingTable)((((CS.DormCameraController).Instance).transform).parent, self.bind)
  ;
  (CS_LeanTouch.OnFingerTap)("+", self.__onDormTouchTap)
  ;
  (CS_LeanTouch.OnGesture)("+", self.__onDormTouchGesture)
  for _,v in pairs(self.ctrls) do
    v:OnEnterDormScene()
  end
end

DormController.EnterDormDefaultHouse = function(self)
  -- function num : 0_7
  if #(self.allDormData).houseIdList == 0 then
    return 
  end
  local defaultId = ((self.allDormData).houseIdList)[1]
  ;
  (self.houseCtrl):EnterDormHouse(defaultId)
end

DormController.GetCurHouse = function(self)
  -- function num : 0_8
  return (self.houseCtrl).curHouse
end

DormController.GetCurRoom = function(self)
  -- function num : 0_9
  if (self.roomCtrl).roomEntity == nil then
    return 
  end
  return ((self.roomCtrl).roomEntity).roomData
end

DormController.GetBindFntDataList = function(self)
  -- function num : 0_10 , upvalues : eDormState
  if self.state == eDormState.House or self.state == eDormState.HouseEdit then
    local houseData = self:GetCurHouse()
    local bindFntDataList = houseData:GetHouseBindFntDataList()
    return bindFntDataList
  else
    do
      if self.state == eDormState.Room or self.state == eDormState.RoomEdit then
        local roomData = self:GetCurRoom()
        return roomData:GetRoomCanBindList()
      end
    end
  end
end

DormController.GetAllBindFntData = function(self)
  -- function num : 0_11
  return (self.allDormData):GetAllBindFntData()
end

DormController.SetAllBindFntDataDirty = function(self)
  -- function num : 0_12
  (self.allDormData):SetAllBindFntDataDirty()
end

DormController.ChangeDormBind = function(self, fntData, newHeroId)
  -- function num : 0_13
  local oldHeroId = fntData:GetFntParam()
  if oldHeroId == newHeroId then
    return 
  end
  local curRoomData = fntData:GetFntRoom()
  self._dormBindDatas = {newHeroId = newHeroId, fntData = fntData}
  local houseId = ((self.houseCtrl).curHouse).id
  local roomPos = curRoomData.spos
  local bind = newHeroId ~= 0
  local heroId = bind and newHeroId or oldHeroId
  local index = curRoomData:GetFntDataIndex(fntData) - 1
  ;
  (self.dormNetwork):CS_DORM_BindUnbindHero(heroId, bind, houseId, roomPos, index, self.__onChangeDormBindComplete)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

DormController.OnChangeDormBindComplete = function(self, dataList)
  -- function num : 0_14
  local success = dataList[0]
  if success then
    local oldBindId = ((self._dormBindDatas).fntData):GetFntParam()
    ;
    ((self._dormBindDatas).fntData):SetFntParam((self._dormBindDatas).newHeroId)
    local curRoomData = ((self._dormBindDatas).fntData):GetFntRoom()
    local allBindFntData = self:GetAllBindFntData()
    local newHeroBindFntData = (allBindFntData.boundDic)[(self._dormBindDatas).newHeroId]
    if newHeroBindFntData ~= nil then
      newHeroBindFntData:SetFntParam(0)
      local newheroRoomData = nil
      newheroRoomData = newHeroBindFntData:GetFntRoom()
      if newheroRoomData ~= curRoomData then
        local fntDatas = newheroRoomData:GetFntDatas()
        newheroRoomData:UpdateRoomFntData(fntDatas, false)
      end
    end
    do
      do
        local newfntDatas = curRoomData:GetFntDatas()
        curRoomData:UpdateRoomFntData(newfntDatas, false)
        self:SetAllBindFntDataDirty()
        ;
        (self.characterCtrl):SetBindCharacterChange((self._dormBindDatas).fntData, oldBindId, (self._dormBindDatas).newHeroId)
        if self.dormWindow ~= nil then
          (self.dormWindow):RefreshDormHeroList()
        end
        self._dormBindDatas = nil
      end
    end
  end
end

DormController.EnterDormOverview = function(self)
  -- function num : 0_15 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.DormOverview, function(window)
    -- function num : 0_15_0 , upvalues : self
    if window == nil then
      return 
    end
    window:InitDormOverview(self.allDormData)
  end
)
end

DormController.RecvPurchaseHouse = function(self, houseId)
  -- function num : 0_16 , upvalues : _ENV
  (self.allDormData):AddNewHouse(houseId)
  local uiDormOverview = UIManager:GetWindow(UIWindowTypeID.DormOverview)
  if uiDormOverview ~= nil then
    uiDormOverview:RefreshDormOverview()
  end
  if self.dormWindow ~= nil then
    (self.dormWindow):RefreshDormWindow()
  end
end

DormController.EmitEnterDormHouse = function(self)
  -- function num : 0_17 , upvalues : _ENV
  for _,v in pairs(self.ctrls) do
    v:OnEnterDormHouse()
  end
end

DormController.EmitEnterDormHouseEditMode = function(self)
  -- function num : 0_18 , upvalues : _ENV
  for _,v in pairs(self.ctrls) do
    v:OnEnterDormHouseEditMode()
  end
end

DormController.EmitExitDormHouseEditMode = function(self, success)
  -- function num : 0_19 , upvalues : _ENV
  (self.dormWindow):Show()
  for _,v in pairs(self.ctrls) do
    v:OnExitDormHouseEditMode(success)
  end
end

DormController.EmitEnterDormRoomEditMode = function(self, roomEntity)
  -- function num : 0_20 , upvalues : _ENV
  for _,v in pairs(self.ctrls) do
    v:OnEnterDormRoomEditMode(roomEntity)
  end
end

DormController.EmitExitDormRoomEditMode = function(self, roomEntity, success)
  -- function num : 0_21 , upvalues : _ENV
  for _,v in pairs(self.ctrls) do
    v:OnExitDormRoomEditMode(roomEntity, success)
  end
end

DormController.EmitEnterDormRoom = function(self)
  -- function num : 0_22 , upvalues : _ENV
  local roomEntity = (self.roomCtrl).roomEntity
  if roomEntity == nil then
    return 
  end
  for _,v in pairs(self.ctrls) do
    v:OnEnterDormRoom(roomEntity)
  end
end

DormController.EmitExitDormRoom = function(self)
  -- function num : 0_23 , upvalues : _ENV
  local roomEntity = (self.roomCtrl).roomEntity
  if roomEntity == nil then
    return 
  end
  for _,v in pairs(self.ctrls) do
    v:OnExitDormRoom(roomEntity)
  end
end

DormController.EnterDormEditor = function(self, callback)
  -- function num : 0_24 , upvalues : eDormState, _ENV
  if self.dormWindow ~= nil then
    (self.dormWindow):Hide()
  end
  if self.state == eDormState.House or self.state == eDormState.HouseEdit then
    if self.state == eDormState.House then
      self.state = eDormState.HouseEdit
      self:EmitEnterDormHouseEditMode()
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.DormEdit, function(window)
    -- function num : 0_24_0 , upvalues : callback
    if window == nil then
      return 
    end
    window:InitDormEdit()
    if callback ~= nil then
      callback(window)
    end
  end
)
  else
    if self.state == eDormState.Room then
      (self.roomCtrl):EnterDormRoomEdit()
    end
  end
end

DormController.OpenDormShop = function(self)
  -- function num : 0_25
  (self.shopCtrl):EnterDormShop()
end

DormController.OpenDormWarehouse = function(self)
  -- function num : 0_26 , upvalues : eDormState
  if (self.state == eDormState.HouseEdit and self.state == eDormState.Room) or self.state == eDormState.RoomEdit then
    (self.roomCtrl):ShowFntWarehouse(true)
  end
end

DormController.OnDormTouchTap = function(self, finger)
  -- function num : 0_27 , upvalues : eDormState
  if finger.StartedOverGui then
    return 
  end
  if (self.state == eDormState.House or self.state == eDormState.Room) and self.dormWindow ~= nil then
    (self.dormWindow):Show()
  end
end

DormController.OnDormTouchGesture = function(self, fingerList)
  -- function num : 0_28
end

DormController.__ClearData = function(self)
  -- function num : 0_29 , upvalues : eDormState, CS_LeanTouch, _ENV
  self.state = eDormState.None
  self.__isInDormScene = false
  self.bind = nil
  self.allDormData = nil
  if self.__onDormTouchTap ~= nil then
    (CS_LeanTouch.OnFingerTap)("-", self.__onDormTouchTap)
    self.__onDormTouchTap = nil
  end
  if self.__onDormTouchGesture ~= nil then
    (CS_LeanTouch.OnGesture)("-", self.__onDormTouchGesture)
    self.__onDormTouchGesture = nil
  end
  if self.comResloader ~= nil then
    (self.comResloader):Put2Pool()
    self.comResloader = nil
  end
  self.comRes = nil
  if self.ctrls ~= nil then
    for _,v in pairs(self.ctrls) do
      v:OnDelete()
    end
    self.ctrls = nil
  end
end

DormController.OnDelete = function(self)
  -- function num : 0_30
  self:__ClearData()
end

return DormController

