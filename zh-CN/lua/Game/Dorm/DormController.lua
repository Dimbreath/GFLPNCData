local DormController = class("DormController", ControllerBase)
local DormUtil = require("Game.Dorm.DormUtil")
local util = require("XLua.Common.xlua_util")
local AllDormData = require("Game.Dorm.Data.AllDormData")
local DormEnum = require("Game.Dorm.DormEnum")
local DormHouseCtrl = require("Game.Dorm.Ctrl.DormHouseCtrl")
local DormRoomCtrl = require("Game.Dorm.Ctrl.DormRoomCtrl")
local DormShopCtrl = require("Game.Dorm.Ctrl.DormShopCtrl")
local DormCharacterCtrl = require("Game.Dorm.Ctrl.DormCharacterCtrl")
local DormCmderCtrl = require("Game.Dorm.Ctrl.DormCmderCtrl")
local DormAStarPathCtrl = require("Game.Dorm.Ctrl.DormAStarPathCtrl")
local CS_LeanTouch = ((CS.Lean).Touch).LeanTouch
local cs_MessageCommon = CS.MessageCommon
DormController.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.dormNetwork = NetworkManager:GetNetwork(NetworkTypeID.Dorm)
  self.__onChangeDormBindComplete = BindCallback(self, self.OnChangeDormBindComplete)
end

DormController.PreInitDorm = function(self)
  -- function num : 0_1 , upvalues : DormEnum, _ENV, DormHouseCtrl, DormRoomCtrl, DormShopCtrl, DormAStarPathCtrl, DormCharacterCtrl, DormCmderCtrl
  self.state = (DormEnum.eDormState).None
  self.__onDormTouchTap = BindCallback(self, self.OnDormTouchTap)
  self.__onDormTouchGesture = BindCallback(self, self.OnDormTouchGesture)
  self.ctrls = {}
  self.houseCtrl = (DormHouseCtrl.New)(self)
  self.roomCtrl = (DormRoomCtrl.New)(self)
  self.shopCtrl = (DormShopCtrl.New)(self)
  self.astarPathCtrl = (DormAStarPathCtrl.New)(self)
  self.characterCtrl = (DormCharacterCtrl.New)(self)
  self.cmderCtrl = (DormCmderCtrl.New)(self)
end

DormController.EnterDorm = function(self)
  -- function num : 0_2
  (self.dormNetwork):CS_DORM_GlobalDetail()
end

DormController.RecvDormDetailData = function(self, msg)
  -- function num : 0_3 , upvalues : AllDormData, _ENV, DormUtil, DormEnum, util
  self:PreInitDorm()
  self.allDormData = (AllDormData.New)()
  ;
  (self.allDormData):InitDormData(msg)
  UIManager:DeleteAllWindow()
  self.comResloader = ((CS.ResLoader).Create)()
  self.comRes = {}
  local preLoadFunc = function()
    -- function num : 0_3_0 , upvalues : self, _ENV, DormUtil
    local roomWait = (self.comResloader):LoadABAssetAsyncAwait(PathConsts:GetDormPath("CommonPrefab/Room"))
    local lockRoomWait = (self.comResloader):LoadABAssetAsyncAwait(PathConsts:GetDormPath("CommonPrefab/LockDormRoom"))
    local defaultFloorWait = (self.comResloader):LoadABAssetAsyncAwait(PathConsts:GetDormPath("CommonPrefab/DefaultFloor"))
    local defaultWallWait = (self.comResloader):LoadABAssetAsyncAwait(PathConsts:GetDormPath("CommonPrefab/DefaultWall"))
    local effectWait = (self.comResloader):LoadABAssetAsyncAwait("Res/Effect/Prefabs/FX_Pick.prefab")
    local fntBottomWait = (self.comResloader):LoadABAssetAsyncAwait(PathConsts:GetDormFntPath("FntBottom"))
    local gridWallWait = (self.comResloader):LoadABAssetAsyncAwait(PathConsts:GetDormRoomPath("DormWallGrid"))
    local gridFloorWait = (self.comResloader):LoadABAssetAsyncAwait(PathConsts:GetDormRoomPath("DormFloorGrid"))
    local selectRoleWait = (self.comResloader):LoadABAssetAsyncAwait(PathConsts:GetDormFntPath("SelectCharacter"))
    local greetRoleWait = (self.comResloader):LoadABAssetAsyncAwait("FX/Common/FX_Talk/FXP_Talk1-new.prefab")
    local cmderPrefabWait = (self.comResloader):LoadABAssetAsyncAwait(PathConsts:GetCharacterDormModelPath((DormUtil.GetDormCmderResName)()))
    local cmderHeadFxWait = (self.comResloader):LoadABAssetAsyncAwait(PathConsts:GetDormPath("CommonPrefab/Fx_CmdHeadGem"))
    local dormConfigAssetWait = (self.comResloader):LoadABAssetAsyncAwait("Res/ScriptableConfig/DormConfigAsset.asset")
    local moveRoomGoEffectWait = (self.comResloader):LoadABAssetAsyncAwait("FX/UI_effct/DormitoryEffcet/FXP_Shelter_go.prefab")
    local moveRoomInEffectWait = (self.comResloader):LoadABAssetAsyncAwait("FX/UI_effct/DormitoryEffcet/FXP_Shelter_in.prefab")
    ;
    (coroutine.yield)(roomWait)
    -- DECOMPILER ERROR at PC97: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (self.comRes).roomPrefab = roomWait.Result
    ;
    (coroutine.yield)(lockRoomWait)
    -- DECOMPILER ERROR at PC104: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (self.comRes).lockRoomPrefab = lockRoomWait.Result
    ;
    (coroutine.yield)(defaultFloorWait)
    -- DECOMPILER ERROR at PC111: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (self.comRes).defaultFloorPrefab = defaultFloorWait.Result
    ;
    (coroutine.yield)(defaultWallWait)
    -- DECOMPILER ERROR at PC118: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (self.comRes).defaultWallPrefab = defaultWallWait.Result
    ;
    (coroutine.yield)(effectWait)
    -- DECOMPILER ERROR at PC125: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (self.comRes).selectRoomEffectPrefab = effectWait.Result
    ;
    (coroutine.yield)(fntBottomWait)
    -- DECOMPILER ERROR at PC132: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (self.comRes).fntBottomPrefab = fntBottomWait.Result
    ;
    (coroutine.yield)(gridWallWait)
    -- DECOMPILER ERROR at PC139: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (self.comRes).gridWallPrefab = gridWallWait.Result
    ;
    (coroutine.yield)(gridFloorWait)
    -- DECOMPILER ERROR at PC146: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (self.comRes).gridFloorPrefab = gridFloorWait.Result
    ;
    (coroutine.yield)(selectRoleWait)
    -- DECOMPILER ERROR at PC153: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (self.comRes).selectRolePrefab = selectRoleWait.Result
    ;
    (coroutine.yield)(greetRoleWait)
    -- DECOMPILER ERROR at PC160: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (self.comRes).greetRolePrefab = greetRoleWait.Result
    ;
    (coroutine.yield)(cmderPrefabWait)
    -- DECOMPILER ERROR at PC167: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (self.comRes).cmderPrefab = cmderPrefabWait.Result
    ;
    (coroutine.yield)(cmderHeadFxWait)
    -- DECOMPILER ERROR at PC174: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (self.comRes).cmderHeadFxPrefab = cmderHeadFxWait.Result
    ;
    (coroutine.yield)(dormConfigAssetWait)
    -- DECOMPILER ERROR at PC181: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (self.comRes).dormConfigAsset = dormConfigAssetWait.Result
    ;
    ((self.comRes).dormConfigAsset):FirstLoadDormConfig()
    ;
    (coroutine.yield)(moveRoomGoEffectWait)
    -- DECOMPILER ERROR at PC192: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (self.comRes).moveRoomGoEffectPrefab = moveRoomGoEffectWait.Result
    ;
    (coroutine.yield)(moveRoomInEffectWait)
    -- DECOMPILER ERROR at PC199: Confused about usage of register: R15 in 'UnsetPending'

    ;
    (self.comRes).moveRoomInEffectPrefab = moveRoomInEffectWait.Result
    UIManager:ShowWindowAsync(UIWindowTypeID.DormMain)
    repeat
      (coroutine.yield)(nil)
      self.dormWindow = UIManager:GetWindow(UIWindowTypeID.DormMain)
    until self.dormWindow
  end

  ;
  (UIManager:GetWindow(UIWindowTypeID.Loading)):SetLoadingTipsSystemId(3)
  ;
  ((CS.GSceneManager).Instance):LoadSceneAsyncByAB((Consts.SceneName).Dorm, function(ok)
    -- function num : 0_3_1 , upvalues : _ENV, self, DormEnum
    AudioManager:PlayAudioById(3001)
    AudioManager:PlayAudioById(1088)
    ;
    ((CS.RenderManager).Instance):SetUnityShadow(true)
    self.__oldShadowDistance = ((CS.UnityEngine).QualitySettings).shadowDistance
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((CS.UnityEngine).QualitySettings).shadowDistance = DormEnum.DormShadowDistance
    self:InitDorm()
    self:EnterDormDefaultHouse()
  end
, (util.cs_generator)(preLoadFunc))
end

DormController.ExitDorm = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self:__ClearData()
  UIManager:DeleteAllWindow()
  ;
  (UIManager:GetWindow(UIWindowTypeID.Loading)):SetLoadingTipsSystemId(3)
  ;
  ((CS.RenderManager).Instance):SetUnityShadow(false)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  if self.__oldShadowDistance ~= nil then
    ((CS.UnityEngine).QualitySettings).shadowDistance = self.__oldShadowDistance
    self.__oldShadowDistance = nil
  end
  ;
  ((CS.GSceneManager).Instance):LoadSceneAsyncByAB((Consts.SceneName).Main, function(ok)
    -- function num : 0_4_0 , upvalues : _ENV
    (ControllerManager:GetController(ControllerTypeId.HomeController, true)):OnEnterHome()
    UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
      -- function num : 0_4_0_0 , upvalues : _ENV
      if window == nil then
        return 
      end
      window:SetFrom2Home(AreaConst.Sector, true)
    end
)
  end
)
end

DormController.GetDormState = function(self)
  -- function num : 0_5
  return self.state
end

DormController.IsDormState = function(self, state)
  -- function num : 0_6
  do return self.state == state end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DormController.GetDormConfigAsset = function(self)
  -- function num : 0_7
  return (self.comRes).dormConfigAsset
end

DormController.InitDorm = function(self)
  -- function num : 0_8 , upvalues : _ENV, CS_LeanTouch
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
  -- function num : 0_9
  if #(self.allDormData).houseIdList == 0 then
    return 
  end
  local defaultId = ((self.allDormData).houseIdList)[1]
  ;
  (self.houseCtrl):EnterDormHouse(defaultId)
end

DormController.GetCurHouse = function(self)
  -- function num : 0_10
  return (self.houseCtrl).curHouse
end

DormController.GetCurRoomEntity = function(self)
  -- function num : 0_11
  return (self.roomCtrl).roomEntity
end

DormController.GetCurRoom = function(self)
  -- function num : 0_12
  local roomEntity = self:GetCurRoomEntity()
  if roomEntity == nil then
    return nil
  end
  return roomEntity.roomData
end

DormController.GetBindFntDataList = function(self)
  -- function num : 0_13 , upvalues : DormEnum
  if self.state == (DormEnum.eDormState).House or self.state == (DormEnum.eDormState).HouseEdit then
    local houseData = self:GetCurHouse()
    local bindFntDataList = houseData:GetHouseBindFntDataList()
    return bindFntDataList
  else
    do
      if self.state == (DormEnum.eDormState).Room or self.state == (DormEnum.eDormState).RoomEdit then
        local roomData = self:GetCurRoom()
        return roomData:GetRoomCanBindList()
      end
    end
  end
end

DormController.GetAllBindFntData = function(self)
  -- function num : 0_14
  return (self.allDormData):GetAllBindFntData()
end

DormController.SetAllBindFntDataDirty = function(self)
  -- function num : 0_15
  (self.allDormData):SetAllBindFntDataDirty()
end

DormController.ChangeDormBind = function(self, fntData, newHeroId)
  -- function num : 0_16
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
  -- function num : 0_17
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
  -- function num : 0_18 , upvalues : _ENV
  print("UIWindowTypeID.DormOverview: the prefab is Delete")
end

DormController.RecvPurchaseHouse = function(self, houseId)
  -- function num : 0_19 , upvalues : _ENV
  (self.allDormData):AddNewHouse(houseId)
  print("UIWindowTypeID.DormOverview: the prefab is Delete")
  if self.dormWindow ~= nil then
    (self.dormWindow):RefreshDormWindow()
  end
end

DormController.EmitEnterDormHouse = function(self)
  -- function num : 0_20 , upvalues : DormEnum, _ENV
  self.state = (DormEnum.eDormState).House
  for _,v in pairs(self.ctrls) do
    v:OnEnterDormHouse()
  end
end

DormController.EmitEnterDormHouseEditMode = function(self)
  -- function num : 0_21 , upvalues : DormEnum, _ENV
  self.state = (DormEnum.eDormState).HouseEdit
  for _,v in pairs(self.ctrls) do
    v:OnEnterDormHouseEditMode()
  end
end

DormController.EmitExitDormHouseEditMode = function(self, success)
  -- function num : 0_22 , upvalues : DormEnum, _ENV
  self.state = (DormEnum.eDormState).House
  for _,v in pairs(self.ctrls) do
    v:OnExitDormHouseEditMode(success)
  end
end

DormController.EmitEnterDormRoomEditMode = function(self, roomEntity)
  -- function num : 0_23 , upvalues : DormEnum, _ENV
  self.state = (DormEnum.eDormState).RoomEdit
  for _,v in pairs(self.ctrls) do
    v:OnEnterDormRoomEditMode(roomEntity)
  end
end

DormController.EmitExitDormRoomEditMode = function(self, roomEntity, success)
  -- function num : 0_24 , upvalues : DormEnum, _ENV
  self.state = (DormEnum.eDormState).Room
  for _,v in pairs(self.ctrls) do
    v:OnExitDormRoomEditMode(roomEntity, success)
  end
end

DormController.EmitEnterDormRoomStart = function(self, roomEntity)
  -- function num : 0_25 , upvalues : DormEnum, _ENV
  self.state = (DormEnum.eDormState).House2Room
  UIManager:HideWindow(UIWindowTypeID.DormMain)
  for _,v in pairs(self.ctrls) do
    v:OnEnterDormRoomStart(roomEntity)
  end
end

DormController.EmitEnterDormRoomEnd = function(self)
  -- function num : 0_26 , upvalues : DormEnum, _ENV
  self.state = (DormEnum.eDormState).Room
  local roomEntity = self:GetCurRoomEntity()
  if roomEntity == nil then
    return 
  end
  for _,v in pairs(self.ctrls) do
    v:OnEnterDormRoomEnd(roomEntity)
  end
end

DormController.EmitExitDormRoomStart = function(self, toOtherRoom)
  -- function num : 0_27 , upvalues : DormEnum, _ENV
  self.state = (DormEnum.eDormState).Room2House
  local roomEntity = self:GetCurRoomEntity()
  if roomEntity == nil then
    return 
  end
  for _,v in pairs(self.ctrls) do
    v:OnExitDormRoomStart(roomEntity, toOtherRoom)
  end
end

DormController.EmitExitDormRoomEnd = function(self)
  -- function num : 0_28 , upvalues : DormEnum, _ENV
  self.state = (DormEnum.eDormState).House
  UIManager:ShowWindowOnly(UIWindowTypeID.DormMain)
  for _,v in pairs(self.ctrls) do
    v:OnExitDormRoomEnd()
  end
end

DormController.EnterDormEditor = function(self, callback)
  -- function num : 0_29 , upvalues : DormEnum
  if not self:IsDormState((DormEnum.eDormState).House) then
    return 
  end
  self:EmitEnterDormHouseEditMode()
  ;
  (self.dormWindow):ShowDormEditMode(true)
end

DormController.OpenDormShop = function(self)
  -- function num : 0_30
  (self.shopCtrl):EnterDormShop()
end

DormController.OpenDormWarehouse = function(self)
  -- function num : 0_31 , upvalues : DormEnum
  if (self.state == (DormEnum.eDormState).HouseEdit and self.state == (DormEnum.eDormState).Room) or self.state == (DormEnum.eDormState).RoomEdit then
    (self.roomCtrl):ShowFntWarehouse(true)
  end
end

DormController.OnDormTouchTap = function(self, finger)
  -- function num : 0_32 , upvalues : DormEnum, _ENV
  if finger.StartedOverGui then
    return 
  end
  if self:IsDormState((DormEnum.eDormState).House) then
    if self.dormWindow ~= nil then
      (self.dormWindow):Show()
    end
    UIManager:ShowWindowOnly(UIWindowTypeID.TopStatus)
  end
  if self.state == (DormEnum.eDormState).Room then
    UIManager:ShowWindowOnly(UIWindowTypeID.DormRoom)
    UIManager:ShowWindowOnly(UIWindowTypeID.TopStatus)
    UIManager:ShowWindowOnly(UIWindowTypeID.DormInput)
    UIManager:ShowWindowOnly(UIWindowTypeID.DormInteract)
  end
end

DormController.OnDormTouchGesture = function(self, fingerList)
  -- function num : 0_33
end

DormController.ReqDormTimingProductPick = function(self, tmProductData, callback)
  -- function num : 0_34 , upvalues : _ENV
  if not tmProductData:CanTmProductRes(true) then
    return 
  end
  self._reqTmProductPickCallback = callback
  if not self._OnDormTimingProductPickFunc then
    self._OnDormTimingProductPickFunc = BindCallback(self, self.OnDormTimingProductPick)
    ;
    (NetworkManager:GetNetwork(NetworkTypeID.TimingProduct)):CS_TimingProduct_Pick(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm, tmProductData.id, self._OnDormTimingProductPickFunc)
  end
end

DormController.OnDormTimingProductPick = function(self, objList)
  -- function num : 0_35 , upvalues : _ENV
  if self._reqTmProductPickCallback ~= nil then
    (self._reqTmProductPickCallback)()
  end
  if objList.Count == 0 then
    error("objList.Count == 0")
    return 
  end
  local addItemDic = objList[0]
  self:_OnGetRes(addItemDic)
end

DormController.ReqDormTimingProductPickAll = function(self, callback)
  -- function num : 0_36 , upvalues : _ENV, cs_MessageCommon
  local tmProductGroupDic = (PlayerDataCenter.allTimingProduct):GetTimingProductDataGroupItemId(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm)
  local fullWareHouseItemDic = {}
  local cantGetOne = false
  for k,tmProductDic in pairs(tmProductGroupDic) do
    for k2,tmProductData in pairs(tmProductDic) do
      local cantGet = tmProductData:CanTmProductRes(false, fullWareHouseItemDic)
      if cantGet then
        cantGetOne = true
      end
    end
  end
  for name,_ in pairs(fullWareHouseItemDic) do
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(name .. ConfigData:GetTipContent(TipContent.ItemInWarehouseFull), true)
  end
  if not cantGetOne then
    return 
  end
  self._reqTmProductPickAllCallback = callback
  if not self._OnDormTimingProductPickAllFunc then
    self._OnDormTimingProductPickAllFunc = BindCallback(self, self.OnDormTimingProductPickAll)
    ;
    (NetworkManager:GetNetwork(NetworkTypeID.TimingProduct)):CS_TimingProduct_PickAll(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm, self._OnDormTimingProductPickAllFunc)
  end
end

DormController.OnDormTimingProductPickAll = function(self, objList)
  -- function num : 0_37 , upvalues : _ENV
  if self._reqTmProductPickAllCallback ~= nil then
    (self._reqTmProductPickAllCallback)()
  end
  if objList.Count == 0 then
    error("objList.Count == 0")
    return 
  end
  local addItemDic = objList[0]
  self:_OnGetRes(addItemDic)
end

DormController._OnGetRes = function(self, addItemDic)
  -- function num : 0_38 , upvalues : _ENV, cs_MessageCommon
  for resId,resNum in pairs(addItemDic) do
    local itemCfg = (ConfigData.item)[resId]
    if itemCfg ~= nil then
      local msg = ConfigData:GetTipContent(TipContent.Building_GainReward) .. (LanguageUtil.GetLocaleText)(itemCfg.name) .. " x " .. tostring(resNum)
      ;
      (cs_MessageCommon.ShowMessageTips)(msg, true)
    end
  end
  AudioManager:PlayAudioById(1090)
end

DormController.__ClearData = function(self)
  -- function num : 0_39 , upvalues : DormEnum, CS_LeanTouch, _ENV
  self.state = (DormEnum.eDormState).None
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
  -- function num : 0_40
  self:__ClearData()
end

return DormController

