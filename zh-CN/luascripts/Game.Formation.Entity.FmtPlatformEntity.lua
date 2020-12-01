-- params : ...
-- function num : 0 , upvalues : _ENV
local FmtPlatformEntity = class("FmtPlatformEntity")
local CS_EventTriggerListener = CS.EventTriggerListener
FmtPlatformEntity.InitFmtPlatEntity = function(self, go, fmtIndex, sceneCtrl, clickFunc, isBench, unlock)
  -- function num : 0_0 , upvalues : _ENV, CS_EventTriggerListener
  self.gameObject = go
  self.transform = go.transform
  self.fmtIndex = fmtIndex
  self.sceneCtrl = sceneCtrl
  self.collider = go:FindComponent(eUnityComponentID.BoxCollider)
  self.mesh = go:FindComponent(eUnityComponentID.MeshRenderer)
  self.clickFunc = clickFunc
  self.isBench = isBench
  self.unlock = unlock
  self:ShowFmtPlatform(true)
  local eventTrigger = (CS_EventTriggerListener.Get)(self.gameObject)
  eventTrigger:onClick("+", BindCallback(self, self.OnClick))
  eventTrigger:onBeginDrag("+", BindCallback(self, self.OnBeginDrag))
  eventTrigger:onDrag("+", BindCallback(self, self.OnDrag))
  eventTrigger:onEndDrag("+", BindCallback(self, self.OnEndDrag))
end

FmtPlatformEntity.GetFmtIndex = function(self)
  -- function num : 0_1
  return self.fmtIndex
end

FmtPlatformEntity.OnClick = function(self, go, eventData)
  -- function num : 0_2
  if not self.unlock then
    return 
  end
  if self.clickFunc ~= nil then
    (self.clickFunc)(self.fmtIndex)
  end
end

FmtPlatformEntity.ShowFmtPlatform = function(self, show)
  -- function num : 0_3
  if self.isBench then
    show = false
  end
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.mesh).enabled = show
end

FmtPlatformEntity.IsFmtPlatformUnlock = function(self)
  -- function num : 0_4
  return self.unlock
end

FmtPlatformEntity.SetFmtPlatformDragEvent = function(self, beginDragFunc, dragFunc, endDragFunc)
  -- function num : 0_5
  self.beginDragFunc = beginDragFunc
  self.dragFunc = dragFunc
  self.endDragFunc = endDragFunc
end

FmtPlatformEntity.OnBeginDrag = function(self, go, eventData)
  -- function num : 0_6
  if self.beginDragFunc ~= nil then
    (self.beginDragFunc)(self, eventData)
  end
end

FmtPlatformEntity.OnDrag = function(self, go, eventData)
  -- function num : 0_7
  if self.dragFunc ~= nil then
    (self.dragFunc)(self, eventData)
  end
end

FmtPlatformEntity.OnEndDrag = function(self, go, eventData)
  -- function num : 0_8
  if self.endDragFunc ~= nil then
    (self.endDragFunc)(self, eventData)
  end
end

FmtPlatformEntity.EnableFmtPlatformRaycast = function(self, enable)
  -- function num : 0_9
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self.collider).enabled = enable
end

FmtPlatformEntity.OnDelete = function(self)
  -- function num : 0_10 , upvalues : _ENV
  DestroyUnityObject(self.gameObject)
end

return FmtPlatformEntity

-- params : ...
-- function num : 0 , upvalues : _ENV
local FmtPlatformEntity = class("FmtPlatformEntity")
local CS_EventTriggerListener = CS.EventTriggerListener
FmtPlatformEntity.InitFmtPlatEntity = function(self, go, fmtIndex, sceneCtrl,
                                               clickFunc, isBench, unlock)
    -- function num : 0_0 , upvalues : _ENV, CS_EventTriggerListener
    self.gameObject = go
    self.transform = go.transform
    self.fmtIndex = fmtIndex
    self.sceneCtrl = sceneCtrl
    self.collider = go:FindComponent(eUnityComponentID.BoxCollider)
    self.mesh = go:FindComponent(eUnityComponentID.MeshRenderer)
    self.clickFunc = clickFunc
    self.isBench = isBench
    self.unlock = unlock
    self:ShowFmtPlatform(true)
    local eventTrigger = (CS_EventTriggerListener.Get)(self.gameObject)
    eventTrigger:onClick("+", BindCallback(self, self.OnClick))
    eventTrigger:onBeginDrag("+", BindCallback(self, self.OnBeginDrag))
    eventTrigger:onDrag("+", BindCallback(self, self.OnDrag))
    eventTrigger:onEndDrag("+", BindCallback(self, self.OnEndDrag))
end

FmtPlatformEntity.GetFmtIndex = function(self)
    -- function num : 0_1
    return self.fmtIndex
end

FmtPlatformEntity.OnClick = function(self, go, eventData)
    -- function num : 0_2
    if not self.unlock then return end
    if self.clickFunc ~= nil then (self.clickFunc)(self.fmtIndex) end
end

FmtPlatformEntity.ShowFmtPlatform = function(self, show)
    -- function num : 0_3
    if self.isBench then show = false end -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'
    
    (self.mesh).enabled = show
end

FmtPlatformEntity.IsFmtPlatformUnlock = function(self)
    -- function num : 0_4
    return self.unlock
end

FmtPlatformEntity.SetFmtPlatformDragEvent =
    function(self, beginDragFunc, dragFunc, endDragFunc)
        -- function num : 0_5
        self.beginDragFunc = beginDragFunc
        self.dragFunc = dragFunc
        self.endDragFunc = endDragFunc
    end

FmtPlatformEntity.OnBeginDrag = function(self, go, eventData)
    -- function num : 0_6
    if self.beginDragFunc ~= nil then (self.beginDragFunc)(self, eventData) end
end

FmtPlatformEntity.OnDrag = function(self, go, eventData)
    -- function num : 0_7
    if self.dragFunc ~= nil then (self.dragFunc)(self, eventData) end
end

FmtPlatformEntity.OnEndDrag = function(self, go, eventData)
    -- function num : 0_8
    if self.endDragFunc ~= nil then (self.endDragFunc)(self, eventData) end
end

FmtPlatformEntity.EnableFmtPlatformRaycast =
    function(self, enable)
        -- function num : 0_9
        -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

        (self.collider).enabled = enable
    end

FmtPlatformEntity.OnDelete = function(self)
    -- function num : 0_10 , upvalues : _ENV
    DestroyUnityObject(self.gameObject)
end

return FmtPlatformEntity

