-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.Sector.Ctrl.SectorCtrlBase")
local SectorCameraCtrl = class("SectorCameraCtrl", base)
local CS_LeanTouch = ((CS.Lean).Touch).LeanTouch
local CS_LeanGesture = ((CS.Lean).Touch).LeanGesture
local CS_CmCoreState = ((CS.Cinemachine).CinemachineCore).Stage
local CS_RenderManager = CS.RenderManager
SectorCameraCtrl.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.__onGesture = BindCallback(self, self.OnGesture)
  self.__onFingerInactive = BindCallback(self, self.OnFingerInactive)
end

SectorCameraCtrl.InitSectorCameraCtrl = function(self)
  -- function num : 0_1 , upvalues : CS_LeanTouch, CS_CmCoreState
  (CS_LeanTouch.OnGesture)("+", self.__onGesture)
  ;
  (CS_LeanTouch.OnFingerInactive)("+", self.__onFingerInactive)
  self.cmFramingTransposer = (((self.sctCtrl).bind).cMvcam_SectorMain):GetCinemachineComponent(CS_CmCoreState.Body)
  self.defaultCamDistance = (self.cmFramingTransposer).m_CameraDistance
  self.enableDrag = true
end

SectorCameraCtrl.OnGesture = function(self, fingerList)
  -- function num : 0_2 , upvalues : _ENV, CS_LeanGesture, CS_RenderManager
  if not self.enableDrag or fingerList.Count == 0 or (fingerList[0]).StartedOverGui then
    return 
  end
  if GuideManager.inGuide then
    return 
  end
  local camDistanceScale = (self.cmFramingTransposer).m_CameraDistance / self.defaultCamDistance
  local screenDelta = (CS_LeanGesture.GetScreenDelta)(fingerList) * (CS_RenderManager.Instance).ScreenScaleRatio * camDistanceScale
  do
    if screenDelta.x ~= 0 or screenDelta.y ~= 0 then
      local pos = ((((self.sctCtrl).bind).camTarget).transform).position
      pos.x = pos.x + screenDelta.x * (((self.sctCtrl).bind).camSpeed).x
      pos.z = pos.z + screenDelta.y * (((self.sctCtrl).bind).camSpeed).y
      pos.x = (math.clamp)(pos.x, (((self.sctCtrl).bind).camRangeX).x, (((self.sctCtrl).bind).camRangeX).y)
      pos.z = (math.clamp)(pos.z, (((self.sctCtrl).bind).camRangeY).x, (((self.sctCtrl).bind).camRangeY).y)
      -- DECOMPILER ERROR at PC86: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((((self.sctCtrl).bind).camTarget).transform).position = pos
      self.inCamMove = true
    end
    local delta = 1 - (CS_LeanGesture.GetPinchScale)(fingerList)
    if delta ~= 0 then
      local distance = (self.cmFramingTransposer).m_CameraDistance + delta * ((self.sctCtrl).bind).camScaleSpeed
      distance = (math.clamp)(distance, (((self.sctCtrl).bind).camDistanceRange).x, (((self.sctCtrl).bind).camDistanceRange).y)
      -- DECOMPILER ERROR at PC115: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (self.cmFramingTransposer).m_CameraDistance = distance
      self.inCamScale = true
    end
  end
end

SectorCameraCtrl.OnFingerInactive = function(self, leanFinger)
  -- function num : 0_3 , upvalues : CS_LeanTouch
  if (CS_LeanTouch.Fingers).Count == 0 then
    self.inCamMove = false
    self.inCamScale = false
  end
end

SectorCameraCtrl.InSctCamDrag = function(self)
  -- function num : 0_4
  if not self.inCamMove then
    return self.inCamScale
  end
end

SectorCameraCtrl.EnableSctCamDrag = function(self, enable)
  -- function num : 0_5
  self.enableDrag = enable
end

SectorCameraCtrl.IsSctCamDragEnable = function(self)
  -- function num : 0_6
  return self.enableDrag
end

SectorCameraCtrl.OnDelete = function(self)
  -- function num : 0_7 , upvalues : CS_LeanTouch, base
  (CS_LeanTouch.OnGesture)("-", self.__onGesture)
  ;
  (CS_LeanTouch.OnFingerInactive)("-", self.__onFingerInactive)
  ;
  (base.OnDelete)(self)
end

return SectorCameraCtrl

-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.Sector.Ctrl.SectorCtrlBase")
local SectorCameraCtrl = class("SectorCameraCtrl", base)
local CS_LeanTouch = ((CS.Lean).Touch).LeanTouch
local CS_LeanGesture = ((CS.Lean).Touch).LeanGesture
local CS_CmCoreState = ((CS.Cinemachine).CinemachineCore).Stage
local CS_RenderManager = CS.RenderManager
SectorCameraCtrl.ctor = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.__onGesture = BindCallback(self, self.OnGesture)
    self.__onFingerInactive = BindCallback(self, self.OnFingerInactive)
end

SectorCameraCtrl.InitSectorCameraCtrl = function(self)
    -- function num : 0_1 , upvalues : CS_LeanTouch, CS_CmCoreState
    (CS_LeanTouch.OnGesture)("+", self.__onGesture);
    (CS_LeanTouch.OnFingerInactive)("+", self.__onFingerInactive)
    self.cmFramingTransposer =
        (((self.sctCtrl).bind).cMvcam_SectorMain):GetCinemachineComponent(
            CS_CmCoreState.Body)
    self.defaultCamDistance = (self.cmFramingTransposer).m_CameraDistance
    self.enableDrag = true
end

SectorCameraCtrl.OnGesture = function(self, fingerList)
    -- function num : 0_2 , upvalues : _ENV, CS_LeanGesture, CS_RenderManager
    if not self.enableDrag or fingerList.Count == 0 or
        (fingerList[0]).StartedOverGui then return end
    if GuideManager.inGuide then return end
    local camDistanceScale = (self.cmFramingTransposer).m_CameraDistance /
                                 self.defaultCamDistance
    local screenDelta = (CS_LeanGesture.GetScreenDelta)(fingerList) *
                            (CS_RenderManager.Instance).ScreenScaleRatio *
                            camDistanceScale
    do
        if screenDelta.x ~= 0 or screenDelta.y ~= 0 then
            local pos = ((((self.sctCtrl).bind).camTarget).transform).position
            pos.x = pos.x + screenDelta.x * (((self.sctCtrl).bind).camSpeed).x
            pos.z = pos.z + screenDelta.y * (((self.sctCtrl).bind).camSpeed).y
            pos.x = (math.clamp)(pos.x, (((self.sctCtrl).bind).camRangeX).x,
                                 (((self.sctCtrl).bind).camRangeX).y)
            pos.z = (math.clamp)(pos.z, (((self.sctCtrl).bind).camRangeY).x,
                                 (((self.sctCtrl).bind).camRangeY).y) -- DECOMPILER ERROR at PC86: Confused about usage of register: R5 in 'UnsetPending'
            ;
            ((((self.sctCtrl).bind).camTarget).transform).position = pos
            self.inCamMove = true
        end
        local delta = 1 - (CS_LeanGesture.GetPinchScale)(fingerList)
        if delta ~= 0 then
            local distance =
                (self.cmFramingTransposer).m_CameraDistance + delta *
                    ((self.sctCtrl).bind).camScaleSpeed
            distance = (math.clamp)(distance,
                                    (((self.sctCtrl).bind).camDistanceRange).x,
                                    (((self.sctCtrl).bind).camDistanceRange).y) -- DECOMPILER ERROR at PC115: Confused about usage of register: R6 in 'UnsetPending'
            ;
            (self.cmFramingTransposer).m_CameraDistance = distance
            self.inCamScale = true
        end
    end
end

SectorCameraCtrl.OnFingerInactive = function(self, leanFinger)
    -- function num : 0_3 , upvalues : CS_LeanTouch
    if (CS_LeanTouch.Fingers).Count == 0 then
        self.inCamMove = false
        self.inCamScale = false
    end
end

SectorCameraCtrl.InSctCamDrag = function(self)
    -- function num : 0_4
    if not self.inCamMove then return self.inCamScale end
end

SectorCameraCtrl.EnableSctCamDrag = function(self, enable)
    -- function num : 0_5
    self.enableDrag = enable
end

SectorCameraCtrl.IsSctCamDragEnable = function(self)
    -- function num : 0_6
    return self.enableDrag
end

SectorCameraCtrl.OnDelete = function(self)
    -- function num : 0_7 , upvalues : CS_LeanTouch, base
    (CS_LeanTouch.OnGesture)("-", self.__onGesture);
    (CS_LeanTouch.OnFingerInactive)("-", self.__onFingerInactive);
    (base.OnDelete)(self)
end

return SectorCameraCtrl

