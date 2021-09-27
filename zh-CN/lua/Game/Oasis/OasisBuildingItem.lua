local OasisBuildingItem = class("OasisBuildingItem")
local cs_GameObject = (CS.UnityEngine).GameObject
local cs_ResLoader = CS.ResLoader
local CoordinateConvert = require("Game.Oasis.OasisCoordinateConvert")
OasisBuildingItem.Initialize = function(self, unityPosition, size, height, areaTransform)
  -- function num : 0_0 , upvalues : cs_GameObject, _ENV, cs_ResLoader, CoordinateConvert
  self.rootGameObject = cs_GameObject()
  self.rootTransform = (self.rootGameObject).transform
  local upgradingEffectRootGo = cs_GameObject("UpgradingEffectRoot")
  self.upgradingEffectTrans = upgradingEffectRootGo.transform
  ;
  (self.upgradingEffectTrans):SetParent(self.rootTransform)
  ;
  (self.rootTransform):SetLayer(LayerMask.Raycast)
  self.resloader = (cs_ResLoader.Create)()
  self.size = size
  self.height = height
  self.unitySize = (Vector3.New)()
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.unitySize).y = self.height
  if #self.size ~= 2 then
    error("building size cfg error")
  end
  local sizeType = (self.size)[1]
  if sizeType == 1 then
    local areaX = (self.size)[2] * 2 * (CoordinateConvert.GetHexWidth)()
    local areaZ = (((self.size)[2] * 2 - 1) * 3 / 4 + 1) * (CoordinateConvert.GetHexHeight)()
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.unitySize).x = areaX
    -- DECOMPILER ERROR at PC62: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.unitySize).z = areaZ
  else
    do
      -- DECOMPILER ERROR at PC70: Confused about usage of register: R7 in 'UnsetPending'

      if sizeType == 2 then
        (self.unitySize).x = 2 * (CoordinateConvert.GetHexWidth)()
        -- DECOMPILER ERROR at PC75: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (self.unitySize).z = 1.75 * (CoordinateConvert.GetHexHeight)()
      else
        -- DECOMPILER ERROR at PC83: Confused about usage of register: R7 in 'UnsetPending'

        if sizeType == 3 then
          (self.unitySize).x = 2 * (CoordinateConvert.GetHexWidth)()
          -- DECOMPILER ERROR at PC88: Confused about usage of register: R7 in 'UnsetPending'

          ;
          (self.unitySize).z = 2.5 * (CoordinateConvert.GetHexHeight)()
        end
      end
      self:SetItemArea(areaTransform)
      -- DECOMPILER ERROR at PC93: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self.rootTransform).localPosition = unityPosition
    end
  end
end

OasisBuildingItem.LoadBuildingGo = function(self, prefabName, callBack)
  -- function num : 0_1 , upvalues : _ENV, cs_ResLoader
  if prefabName == nil then
    if ((self.buildingData).levelConfig)[(self.buildingData).level] == nil then
      error("请检查OasisBuilding配表，配置的" .. (self.buildingData).id .. "-等级[" .. (self.buildingData).level .. "]配置为空")
    end
    local modelId = (((self.buildingData).levelConfig)[(self.buildingData).level]).modol
    prefabName = ((ConfigData.oasis_building_model)[modelId]).model
  end
  do
    if self.__isInLoadingObj then
      (self.resloader):Put2Pool()
      self.resloader = (cs_ResLoader.Create)()
    end
    self.__isInLoadingObj = true
    local path = PathConsts:GetOasisBuildingPrefabPath(prefabName)
    ;
    (self.resloader):LoadABAssetAsync(path, function(prefab)
    -- function num : 0_1_0 , upvalues : self, callBack
    if prefab == nil then
      self.__isInLoadingObj = false
      return 
    end
    local go = prefab:Instantiate()
    self:SetGameObject(go)
    self.__isInLoadingObj = false
    self:UpdateCanvasItemPos()
    if callBack ~= nil then
      callBack(self)
    end
  end
)
  end
end

OasisBuildingItem.SetGameObject = function(self, gameObject)
  -- function num : 0_2 , upvalues : _ENV
  if IsNull(self.rootGameObject) then
    return 
  end
  local oldParent = nil
  local isReplace = false
  if not IsNull(self.gameObject) then
    isReplace = true
    oldParent = (self.transform).parent
    DestroyUnityObject(self.gameObject)
  end
  ;
  (gameObject.transform):SetParent(self.rootTransform)
  self.gameObject = gameObject
  self.transform = gameObject.transform
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.transform).localPosition = Vector3.zero
  ;
  (self.transform):SetLayer((self.rootGameObject).layer)
  local scale = (self.upgradingEffectTrans).localScale
  scale.x = (self.unitySize).x
  scale.z = (self.unitySize).z
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.upgradingEffectTrans).localScale = scale
  if isReplace then
    self:SetItemArea(oldParent)
    self:SetPosition((self.buildingData).position)
  end
  if self.buildingData ~= nil then
    local name = tostring((self.buildingData).id)
    -- DECOMPILER ERROR at PC62: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.rootGameObject).name = name
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.gameObject).name = name
  end
end

OasisBuildingItem.SetCanvas = function(self, canvas)
  -- function num : 0_3
  self.canvas = canvas
  local UIbulidData = {name = (self.buildingData).name, nameEn = (self.buildingData).nameEn, level = (self.buildingData).level, canLvUp = (self.buildingData):CanUpgrade()}
  ;
  (self.canvas):CreateNameItem(self.id, UIbulidData)
  self:UpdateCanvasItemPos()
end

OasisBuildingItem.SetBuildingData = function(self, data)
  -- function num : 0_4 , upvalues : _ENV
  self.id = data.id
  self.buildingData = data
  local name = tostring(data.id)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.rootGameObject).name = name
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  if not IsNull(self.gameObject) then
    (self.gameObject).name = name
  end
end

OasisBuildingItem.Update = function(self, timestamp, isSecond)
  -- function num : 0_5
  if isSecond then
    self.__timeSecond = timestamp
    self:__TimerUpdate(timestamp)
  end
end

OasisBuildingItem.__TimerUpdate = function(self, timestamp)
  -- function num : 0_6 , upvalues : _ENV
  local needUpdate = false
  if self.id ~= nil then
    local builtData = self.buildingData
    if builtData ~= nil and builtData.resDatas ~= nil then
      for resId,res in pairs(builtData.resDatas) do
        if not res.resMax then
          needUpdate = true
        end
      end
    end
  end
  do
    if needUpdate then
      self:UpdateBuildingResUI()
    end
  end
end

OasisBuildingItem.UpdateProcessUI = function(self, progress, remainTimeText, waitConfirmOver)
  -- function num : 0_7
  local position = self:GetUIProcessPos()
  local canvasProgressText = waitConfirmOver and "点击完成" or remainTimeText
  if self.canvas ~= nil then
    (self.canvas):UpdateProcess(self.id, position, progress, canvasProgressText)
  end
end

OasisBuildingItem.UpdateBuildLevel = function(self, builtData)
  -- function num : 0_8
  (self.canvas):UpdateNameItemLevel(self.id, builtData.level)
end

OasisBuildingItem.SetRoundPosition = function(self, unityPosition, setPosition, getAreaList)
  -- function num : 0_9 , upvalues : CoordinateConvert
  if setPosition == nil then
    setPosition = true
  end
  local oasisPosition = (CoordinateConvert.UnityCenterToOasis)(unityPosition, self.size)
  unityPosition = (CoordinateConvert.ToUnityCenterPos)(oasisPosition, self.size)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

  if setPosition then
    (self.rootTransform).localPosition = unityPosition
  end
  local areaList = nil
  if getAreaList then
    areaList = (CoordinateConvert.GetHexArea)(oasisPosition, self.size)
  end
  return oasisPosition, unityPosition, areaList
end

OasisBuildingItem.SetItemArea = function(self, areaTransform)
  -- function num : 0_10
  if (self.rootTransform).parent ~= areaTransform then
    (self.rootTransform):SetParent(areaTransform)
  end
end

OasisBuildingItem.SetPosition = function(self, oasisPos, needTween)
  -- function num : 0_11 , upvalues : CoordinateConvert
  local unityPosition = (CoordinateConvert.ToUnityCenterPos)(oasisPos, self.size)
  if needTween then
    self:_ClearMoveTween()
    self._moveTween = ((self.rootTransform):DOLocalMove(unityPosition, 0.1)):OnUpdate(function()
    -- function num : 0_11_0 , upvalues : self
    self:UpdateCanvasItemPos()
  end
)
  else
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self.rootTransform).localPosition = unityPosition
    self:UpdateCanvasItemPos()
  end
end

OasisBuildingItem.GetBuildItemHeight = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local modelId = (((self.buildingData).levelConfig)[(self.buildingData).level or 1]).modol
  local posCfg = ((ConfigData.oasis_building_model)[modelId]).res_pos
  return posCfg[2]
end

OasisBuildingItem.__GetModelCfgPos = function(self, param)
  -- function num : 0_13 , upvalues : _ENV
  local modelId = (((self.buildingData).levelConfig)[(self.buildingData).level or 1]).modol
  local posCfg = ((ConfigData.oasis_building_model)[modelId])[param]
  local position = (self.rootTransform).position
  position.x = position.x + posCfg[1]
  position.y = position.y + posCfg[2]
  position.z = position.z + posCfg[3]
  return position
end

OasisBuildingItem.GetUIResPos = function(self)
  -- function num : 0_14
  return self:__GetModelCfgPos("res_pos")
end

OasisBuildingItem.GetUINamePos = function(self)
  -- function num : 0_15
  return self:__GetModelCfgPos("name_pos")
end

OasisBuildingItem.GetBuildSelectUIPos = function(self)
  -- function num : 0_16
  return self:__GetModelCfgPos("select_pos")
end

OasisBuildingItem.GetUIProcessPos = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local uiPosition = (self.rootTransform).position + (Vector3.New)(-(self.unitySize).y * 0.5, 7, 0)
  return uiPosition
end

OasisBuildingItem.UpdateBuildingResUI = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local builtData = self.buildingData
  local resDatas = builtData:GetResDatas()
  if resDatas == nil then
    return 
  end
  if self._resTabSort == nil then
    self._resTabSort = {}
  else
    for i = 1, #self._resTabSort do
      (table.remove)(self._resTabSort)
    end
  end
  do
    for k,v in pairs(resDatas) do
      (table.insert)(self._resTabSort, v)
    end
    ;
    (table.sort)(self._resTabSort, function(a, b)
    -- function num : 0_18_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    local window = UIManager:GetWindow(UIWindowTypeID.OasisMain)
    if window ~= nil then
      if (self.buildingData):IsBuildResPeriodOk() then
        (window.oasisResNode):TryCreateOasisResItem(self.id, ((self._resTabSort)[1]).id)
        ;
        (window.oasisResNode):UpdateOasisResData(self.id, self._resTabSort)
      else
        ;
        (window.oasisResNode):RecycleOasisResItem(self.id)
      end
    end
    self.resItemId = ((self._resTabSort)[1]).id
    MsgCenter:Broadcast(eMsgEventId.BuildingProduceUpdate, self.id, self._resTabSort)
  end
end

OasisBuildingItem.UpdateCanvasItemPos = function(self)
  -- function num : 0_19
  if self.buildingData == nil or self.canvas == nil then
    return 
  end
  local namePos = self:GetUINamePos()
  if namePos ~= nil then
    (self.canvas):UpdateNamePos(self.id, namePos)
  end
  local processPos = self:GetUIProcessPos()
  ;
  (self.canvas):UpdateProcessPos(self.id, processPos)
end

OasisBuildingItem.Show = function(self, show)
  -- function num : 0_20 , upvalues : _ENV
  if show then
    (self.rootTransform):SetLayer(LayerMask.Raycast)
  else
    ;
    (self.rootTransform):SetLayer(LayerMask.Hide)
  end
end

OasisBuildingItem.UpdateState = function(self)
  -- function num : 0_21 , upvalues : _ENV
  local builtData = self.buildingData
  -- DECOMPILER ERROR at PC15: Unhandled construct in 'MakeBoolean' P1

  if builtData.state == proto_object_BuildingState.BuildingStateNormal and self.canvas ~= nil then
    (self.canvas):SetBuildName3dItemCanLevelUp(self.id, (self.buildingData):CanUpgrade())
  end
  if builtData.state == proto_object_BuildingState.BuildingStateCreate or builtData.state == proto_object_BuildingState.BuildingStateUpgrade then
  end
end

OasisBuildingItem.GetUnitySize = function(self)
  -- function num : 0_22
  return self.unitySize
end

OasisBuildingItem.EnterFocusLayer = function(self, enter)
  -- function num : 0_23 , upvalues : _ENV
  if enter then
    (self.rootTransform):SetLayer(LayerMask.Focus)
  else
    ;
    (self.rootTransform):SetLayer(LayerMask.Raycast)
  end
end

OasisBuildingItem.GetUnityPostion = function(self)
  -- function num : 0_24
  return (self.rootTransform).position
end

OasisBuildingItem.BuildGoIsInLoading = function(self)
  -- function num : 0_25
  return self.__isInLoadingObj
end

OasisBuildingItem._ClearMoveTween = function(self)
  -- function num : 0_26
  if self._moveTween ~= nil then
    (self._moveTween):Kill()
    self._moveTween = nil
  end
end

OasisBuildingItem.GetResItemId = function(self)
  -- function num : 0_27
  return self.resItemId
end

OasisBuildingItem.GetBuildingId = function(self)
  -- function num : 0_28
  return (self.buildingData).id
end

OasisBuildingItem.OnDelete = function(self)
  -- function num : 0_29
  self:_ClearMoveTween()
  if self.canvas ~= nil then
    (self.canvas):RecycleUI(self.id)
    self.canvas = nil
  end
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
end

OasisBuildingItem.DeleteEntity = function(self)
  -- function num : 0_30 , upvalues : cs_GameObject
  if self.rootGameObject ~= nil then
    (cs_GameObject.Destroy)(self.rootGameObject)
    self.rootGameObject = nil
  end
end

return OasisBuildingItem

