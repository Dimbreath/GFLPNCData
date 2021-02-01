-- params : ...
-- function num : 0 , upvalues : _ENV
local OasisBuildEffectEntity = class("OasisBuildEffectEntity")
local cs_RenderManager_Ins = (CS.RenderManager).Instance
OasisBuildEffectEntity.ctor = function(self, gameObject, effectName)
  -- function num : 0_0 , upvalues : cs_RenderManager_Ins, _ENV
  self.gameObject = gameObject
  self.transform = gameObject.transform
  self.effectName = effectName
  cs_RenderManager_Ins:ApplyEffectObjectLevel(self.transform)
  self.bind = {}
  ;
  (UIUtil.LuaUIBindingTable)(gameObject, self.bind)
end

OasisBuildEffectEntity.InitOasisBuildEffectEntity = function(self, position, parent, returnFunc)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R4 in 'UnsetPending'

  (self.transform).position = position
  if not IsNull(parent) then
    (self.transform):SetParent(parent)
  end
  self.returnFunc = returnFunc
  if self._returnTimer == nil then
    self._returnTimer = TimerManager:GetTimer((self.bind).duration, self.__ReturnEntity, self, true)
  end
  ;
  (self._returnTimer):Start()
  ;
  (self.gameObject):SetActive(true)
end

OasisBuildEffectEntity.SetOasisBuildEffectHeight = function(self, height)
  -- function num : 0_2 , upvalues : _ENV
  if self.mat == nil then
    for k,particleRenderer in ipairs((self.bind).particleRendererList) do
      if self.mat == nil then
        self.mat = particleRenderer.material
      end
      particleRenderer.sharedMaterial = self.mat
      particleRenderer.trailMaterial = self.mat
    end
  end
  do
    if self.mat ~= nil then
      local heightValue = height / 90
      ;
      (self.mat):SetFloat("_height", heightValue)
    end
  end
end

OasisBuildEffectEntity.__ReturnEntity = function(self)
  -- function num : 0_3
  self._returnTimer = nil
  if self.returnFunc ~= nil then
    (self.returnFunc)(self)
  end
end

OasisBuildEffectEntity.GetOasisBuildEffectEntityName = function(self)
  -- function num : 0_4
  return self.effectName
end

OasisBuildEffectEntity.OnDelete = function(self)
  -- function num : 0_5 , upvalues : _ENV
  DestroyUnityObject(self.gameObject)
  self.gameObject = nil
  self.transform = nil
  DestroyUnityObject(self.mat)
  self.mat = nil
  if self._returnTimer ~= nil then
    (self._returnTimer):Stop()
    self._returnTimer = nil
  end
end

return OasisBuildEffectEntity

