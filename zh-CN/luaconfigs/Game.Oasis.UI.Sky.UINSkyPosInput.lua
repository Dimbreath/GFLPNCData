-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSkyPosInput = class("UINSkyPosInput", UIBaseNode)
local base = UIBaseNode
UINSkyPosInput.ctor = function(self, uiSkyRoot)
  -- function num : 0_0
  self.uiSkyRoot = uiSkyRoot
end

UINSkyPosInput.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_bg, self, self._OnClickClose)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self._OnClickClose)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self._OnClickConfirm)
  ;
  (UIUtil.AddButtonListenerWithArg)((self.ui).btn_S, self, self._OnClickLatitude, false)
  ;
  (UIUtil.AddButtonListenerWithArg)((self.ui).btn_N, self, self._OnClickLatitude, true)
  ;
  (UIUtil.AddButtonListenerWithArg)((self.ui).btn_W, self, self._OnClickLongitude, false)
  ;
  (UIUtil.AddButtonListenerWithArg)((self.ui).btn_E, self, self._OnClickLongitude, true)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).inputField_SN, self, self._OnValueChange_Latitude)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).inputField_WE, self, self._OnValueChange_Longitude)
end

UINSkyPosInput.InitSkyPosInput = function(self, latitude, longitude)
  -- function num : 0_2 , upvalues : _ENV
  self:Show()
  ;
  (UIUtil.HideTopStatus)()
  self.isN = latitude >= 0
  self.isE = longitude >= 0
  self.latitude = (math.abs)(latitude)
  self.longitude = (math.abs)(longitude)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).inputField_SN).text = tostring(self.latitude)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).inputField_WE).text = tostring(self.longitude)
  self:_UpdSNTog()
  self:_UpdWETog()
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINSkyPosInput._UpdSNTog = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local pos = ((self.ui).img_SelectSN).anchoredPosition
  pos.x = (math.abs)(pos.x) * (self.isN and 1 or -1)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_SelectSN).anchoredPosition = pos
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

  if not self.isN or not (self.ui).selectTogColor then
    ((self.ui).tex_N).color = Color.white
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

    if not self.isN or not Color.white then
      ((self.ui).tex_S).color = (self.ui).selectTogColor
    end
  end
end

UINSkyPosInput._UpdWETog = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local pos = ((self.ui).img_SelectWE).anchoredPosition
  pos.x = (math.abs)(pos.x) * (self.isE and 1 or -1)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_SelectWE).anchoredPosition = pos
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

  if not self.isE or not (self.ui).selectTogColor then
    ((self.ui).tex_E).color = Color.white
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

    if not self.isE or not Color.white then
      ((self.ui).tex_W).color = (self.ui).selectTogColor
    end
  end
end

UINSkyPosInput._OnValueChange_Latitude = function(self, value)
  -- function num : 0_5 , upvalues : _ENV
  local latitudeValue = tonumber(value)
  if latitudeValue == nil then
    return 
  end
  local latitude = (math.clamp)(latitudeValue, 0, 90)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  if latitude ~= latitudeValue then
    ((self.ui).inputField_SN).text = tostring(latitude)
  end
  self.latitude = latitude
end

UINSkyPosInput._OnValueChange_Longitude = function(self, value)
  -- function num : 0_6 , upvalues : _ENV
  local longitudeValue = tonumber(value)
  if longitudeValue == nil then
    return longitudeValue
  end
  local longitude = (math.clamp)(longitudeValue, 0, 180)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

  if longitude ~= longitudeValue then
    ((self.ui).inputField_WE).text = tostring(longitude)
  end
  self.longitude = longitude
end

UINSkyPosInput._OnClickLatitude = function(self, isN)
  -- function num : 0_7
  if self.isN == isN then
    return 
  end
  self.isN = isN
  self:_UpdSNTog()
end

UINSkyPosInput._OnClickLongitude = function(self, isE)
  -- function num : 0_8
  if self.isE == isE then
    return 
  end
  self.isE = isE
  self:_UpdWETog()
end

UINSkyPosInput._OnClickConfirm = function(self)
  -- function num : 0_9
  ;
  (self.uiSkyRoot):UpdSkySystemLocation(self.latitude * (self.isN and 1 or -1), self.longitude * (self.isE and 1 or -1), true)
  self:_OnClickClose()
end

UINSkyPosInput._OnClickClose = function(self)
  -- function num : 0_10 , upvalues : _ENV
  self:Hide()
  ;
  (UIUtil.ReShowTopStatus)()
end

UINSkyPosInput.OnDelete = function(self)
  -- function num : 0_11 , upvalues : base
  (base.OnDelete)(self)
end

return UINSkyPosInput

