local UINSkyMap = class("UINSkyMap", UIBaseNode)
local base = UIBaseNode
local CS_EventTriggerListener = CS.EventTriggerListener
UINSkyMap.ctor = function(self, uiSkyRoot)
  -- function num : 0_0
  self.uiSkyRoot = uiSkyRoot
end

UINSkyMap.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, CS_EventTriggerListener
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).slider, self, self._OnScaleValueChange)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).slider).minValue = 1
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).slider).maxValue = 2
  ;
  ((CS_EventTriggerListener.Get)((self.ui).scrollMap)):onClick("+", BindCallback(self, self._OnMapClick))
  ;
  ((CS_EventTriggerListener.Get)(((self.ui).slider).gameObject)):onBeginDrag("+", BindCallback(self, self._OnScaleSliderBeginDrag))
  ;
  ((CS_EventTriggerListener.Get)(((self.ui).slider).gameObject)):onEndDrag("+", BindCallback(self, self._OnScaleSliderEndDrag))
end

UINSkyMap.InitSkyMap = function(self, latitude, longitude)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).slider).value = 1
  self:SetSkyMapLocation(latitude, longitude)
end

UINSkyMap._OnMapClick = function(self, go, eventData)
  -- function num : 0_3 , upvalues : _ENV
  if eventData.dragging then
    return 
  end
  local uiPos = UIManager:Screen2UIPosition(eventData.position, (self.ui).map)
  local latitude, longitude = self:_UIPos2Location(uiPos)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).posItem).anchoredPosition = uiPos
  ;
  (self.uiSkyRoot):UpdSkySystemLocation(latitude, longitude, true, true)
end

UINSkyMap._OnScaleSliderBeginDrag = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local mapSize = ((self.ui).map).sizeDelta
  local curPos = ((self.ui).posItem).anchoredPosition
  local newPivot = (Vector2.New)(curPos.x / mapSize.x, curPos.y / mapSize.y)
  local mapPos = ((self.ui).map).anchoredPosition
  local mapPosOffset = mapSize * (((self.ui).map).localScale).x
  mapPos.x = mapPos.x + mapPosOffset.x * newPivot.x
  mapPos.y = mapPos.y + mapPosOffset.y * newPivot.y
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).map).pivot = newPivot
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).map).anchoredPosition = mapPos
end

UINSkyMap._OnScaleSliderEndDrag = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local pivot = ((self.ui).map).pivot
  local mapPos = ((self.ui).map).anchoredPosition
  local mapPosOffset = ((self.ui).map).sizeDelta * (((self.ui).map).localScale).x
  mapPos.x = mapPos.x - mapPosOffset.x * pivot.x
  mapPos.y = mapPos.y - mapPosOffset.y * pivot.y
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).map).pivot = Vector2.zero
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).map).anchoredPosition = mapPos
end

UINSkyMap._Location2UIPos = function(self, lat, lon)
  -- function num : 0_6 , upvalues : _ENV
  local L = 6381372 * math.pi * 2
  local W = L
  local H = L / 2
  local mill = 2.3
  local x = lon * math.pi / 180
  local y = lat * math.pi / 180
  y = 1.25 * (math.log)((math.tan)(0.25 * math.pi + 0.4 * y))
  x = W / 2 + W / (2 * math.pi) * x
  y = H / 2 - H / (2 * mill) * (y)
  x = (x) / W
  y = 1 - (y) / H
  return (Vector2.New)(x * (((self.ui).map).sizeDelta).x, (y) * (((self.ui).map).sizeDelta).y)
end

UINSkyMap._UIPos2Location = function(self, pos)
  -- function num : 0_7 , upvalues : _ENV
  local x = pos.x / (((self.ui).map).sizeDelta).x
  local y = 1 - pos.y / (((self.ui).map).sizeDelta).y
  local L = 6381372 * math.pi * 2
  local W = L
  local H = L / 2
  x = x * W
  y = y * H
  local mill = 2.3
  local lat = nil
  lat = (H / 2 - y) * 2 * mill / (1.25 * H)
  lat = ((math.atan)((math.exp)(lat)) - 0.25 * math.pi) * 180 / (0.4 * math.pi)
  local lon = nil
  lon = (x - W / 2) * 360 / W
  lat = (math.floor)(lat)
  lon = (math.floor)(lon)
  return lat, lon
end

UINSkyMap._OnScaleValueChange = function(self, value)
  -- function num : 0_8 , upvalues : _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).map).localScale = (Vector3.New)(value, value, value)
  local posItemScale = 1 / value
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).posItem).localScale = (Vector3.New)(posItemScale, posItemScale, posItemScale)
end

UINSkyMap.SetSkyMapLocation = function(self, latitude, longitude)
  -- function num : 0_9 , upvalues : _ENV
  local uiPos = self:_Location2UIPos(latitude, longitude)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).posItem).anchoredPosition = uiPos
  local mapSize = ((self.ui).map).sizeDelta
  local uiPos = ((self.ui).posItem).anchoredPosition
  local posRatioX = uiPos.x / mapSize.x
  local posRatioY = uiPos.y / mapSize.y
  local scale = (((self.ui).map).localScale).x
  local scrollSize = ((((self.ui).scrollMap).transform).rect).size
  local posX = (mapSize.x * scale - scrollSize.x) * posRatioX
  local posY = (mapSize.y * scale - scrollSize.y) * posRatioY
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R12 in 'UnsetPending'

  ;
  ((self.ui).map).anchoredPosition = (Vector2.New)(-posX, -posY)
end

UINSkyMap.OnDelete = function(self)
  -- function num : 0_10 , upvalues : base
  (base.OnDelete)(self)
end

return UINSkyMap

