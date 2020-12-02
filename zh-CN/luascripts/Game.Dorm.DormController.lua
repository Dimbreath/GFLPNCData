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
local CS_LeanTouch = ((CS.Lean).Touch).LeanTouch
DormController.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.__isInDormScene = false
  self.__onChangeDormBindComplete = BindCallback(self, self.OnChangeDormBindComplete)
end

DormController.PreInitDorm = function(self)
  -- function num : 0_1 , upvalues : eDormState, _ENV, DormHouseCtrl, DormRoomCtrl, DormShopCtrl, DormCharacterCtrl
  self.state = eDormState.None
  self.__onDormTouchTap = BindCallback(self, self.OnDormTouchTap)
  self.__onDormTouchGesture = BindCallback(self, self.OnDormTouchGesture)
  self.ctrls = {}
  self.houseCtrl = (DormHouseCtrl.New)(self)
  self.roomCtrl = (DormRoomCtrl.New)(self)
  self.shopCtrl = (DormShopCtrl.New)(self)
  self.characterCtrl = (DormCharacterCtrl.New)(self)
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
    ;
    (coroutine.yield)(effectWait)
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

    if not IsNull(effectWait.Result) then
      (self.comRes).selectRoomEffectPrefab = effectWait.Result
    end
    local interPointWait = (self.comResloader):LoadABAssetAsyncAwait("Res/Effect/Prefabs/DragPoint.prefab")
    ;
    (coroutine.yield)(interPointWait)
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R2 in 'UnsetPending'

    if not IsNull(interPointWait) then
      (self.comRes).interPointPrefab = interPointWait.Result
    end
    local fntBottomWait = (self.comResloader):LoadABAssetAsyncAwait(PathConsts:GetDormFntPath("FntBottom"))
    ;
    (coroutine.yield)(fntBottomWait)
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R3 in 'UnsetPending'

    if not IsNull(fntBottomWait.Result) then
      (self.comRes).fntBottomPrefab = fntBottomWait.Result
    end
    local gridWallWait = (self.comResloader):LoadABAssetAsyncAwait(PathConsts:GetDormRoomPath("DormWallGrid"))
    ;
    (coroutine.yield)(gridWallWait)
    -- DECOMPILER ERROR at PC69: Confused about usage of register: R4 in 'UnsetPending'

    if not IsNull(gridWallWait.Result) then
      (self.comRes).gridWallPrefab = gridWallWait.Result
    end
    local gridFloorWait = (self.comResloader):LoadABAssetAsyncAwait(PathConsts:GetDormRoomPath("DormFloorGrid"))
    ;
    (coroutine.yield)(gridFloorWait)
    -- DECOMPILER ERROR at PC88: Confused about usage of register: R5 in 'UnsetPending'

    if not IsNull(gridFloorWait.Result) then
      (self.comRes).gridFloorPrefab = gridFloorWait.Result
    end
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
  ((CS.GSceneManager).Instance):LoadSceneAsyncByAB((Consts.SceneName).Dorm, function(ok)
    -- function num : 0_2_1 , upvalues : self, _ENV
    self.__isInDormScene = true
    for _,v in pairs(self.ctrls) do
      v:OnEnterDormScene()
    end
    if self.allDormData ~= nil then
      self:InitDorm()
    end
  end
, (util.cs_generator)(preLoadFunc))
end

DormController.ExitDorm = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self:__ClearData()
  UIManager:DeleteAllWindow()
  ;
  ((CS.GSceneManager).Instance):LoadSceneAsyncByAB((Consts.SceneName).Main, function(ok)
    -- function num : 0_3_0 , upvalues : _ENV
    UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
      -- function num : 0_3_0_0 , upvalues : _ENV
      if window == nil then
        return 
      end
      window:SetFrom(AreaConst.Sector)
    end
)
  end
)
end

DormController.RecvDormDetailData = function(self, msg)
  -- function num : 0_4 , upvalues : AllDormData, eDormState
  self.allDormData = (AllDormData.New)()
  ;
  (self.allDormData):InitDormData(msg)
  if self.__isInDormScene and self.state == eDormState.None then
    self:InitDorm()
  end
end

DormController.InitDorm = function(self)
  -- function num : 0_5 , upvalues : eDormState, _ENV, CS_LeanTouch
  self.state = eDormState.House
  self.bind = {}
  ;
  (UIUtil.LuaUIBindingTable)((((CS.DormCameraController).Instance).transform).parent, self.bind)
  ;
  (CS_LeanTouch.OnFingerTap)("+", self.__onDormTouchTap)
  ;
  (CS_LeanTouch.OnGesture)("+", self.__onDormTouchGesture)
  if #(self.allDormData).houseIdList == 0 then
    return 
  end
  local defaultId = ((self.allDormData).houseIdList)[1]
  ;
  (self.houseCtrl):EnterDormHouse(defaultId)
end

DormController.GetCurHouse = function(self)
  -- function num : 0_6
  return (self.houseCtrl).curHouse
end

DormController.GetCurRoom = function(self)
  -- function num : 0_7
  if (self.roomCtrl).roomEntity == nil then
    return 
  end
  return ((self.roomCtrl).roomEntity).roomData
end

DormController.GetBindFntDataList = function(self)
  -- function num : 0_8 , upvalues : eDormState
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
  -- function num : 0_9
  return (self.allDormData):GetAllBindFntData()
end

DormController.SetAllBindFntDataDirty = function(self)
  -- function num : 0_10
  (self.allDormData):SetAllBindFntDataDirty()
end

DormController.ChangeDormBind = function(self, fntData, newHeroId)
  -- function num : 0_11
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
  -- function num : 0_12
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
  -- function num : 0_13 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.DormOverview, function(window)
    -- function num : 0_13_0 , upvalues : self
    if window == nil then
      return 
    end
    window:InitDormOverview(self.allDormData)
  end
)
end

DormController.RecvPurchaseHouse = function(self, houseId)
  -- function num : 0_14 , upvalues : _ENV
  (self.allDormData):AddNewHouse(houseId)
  local uiDormOverview = UIManager:GetWindow(UIWindowTypeID.DormOverview)
  if uiDormOverview ~= nil then
    uiDormOverview:RefreshDormOverview()
  end
  if self.dormWindow ~= nil then
    (self.dormWindow):RefreshDormWindow()
  end
end

DormController.EnterDormEditor = function(self, callback)
  -- function num : 0_15 , upvalues : eDormState, _ENV
  if self.dormWindow ~= nil then
    (self.dormWindow):Hide()
  end
  if self.state == eDormState.House or self.state == eDormState.HouseEdit then
    if self.state == eDormState.House then
      (self.houseCtrl):EnterDormEditMode()
      self.state = eDormState.HouseEdit
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.DormEdit, function(window)
    -- function num : 0_15_0 , upvalues : callback
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
  -- function num : 0_16
  (self.shopCtrl):EnterDormShop()
end

DormController.OpenDormWarehouse = function(self)
  -- function num : 0_17 , upvalues : eDormState
  if (self.state == eDormState.HouseEdit and self.state == eDormState.Room) or self.state == eDormState.RoomEdit then
    (self.roomCtrl):ShowFntWarehouse(true)
  end
end

DormController.OnDormTouchTap = function(self, finger)
  -- function num : 0_18 , upvalues : eDormState
  if finger.StartedOverGui then
    return 
  end
  if (self.state == eDormState.House or self.state == eDormState.Room) and self.dormWindow ~= nil then
    (self.dormWindow):Show()
  end
end

DormController.OnDormTouchGesture = function(self, fingerList)
  -- function num : 0_19
end

DormController.__ClearData = function(self)
  -- function num : 0_20 , upvalues : eDormState, CS_LeanTouch, _ENV
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
  -- function num : 0_21
  self:__ClearData()
end

return DormController

