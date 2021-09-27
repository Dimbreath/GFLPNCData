local OasisBuildEffectEntity = class("OasisBuildEffectEntity")
local cs_RenderManager_Ins = (CS.RenderManager).Instance
local cs_MeshRenderer = (CS.UnityEngine).MeshRenderer
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
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R4 in 'UnsetPending'

  if position ~= nil then
    (self.transform).position = position
  end
  if not IsNull(parent) then
    (self.transform):SetParent(parent)
  end
  self.returnFunc = returnFunc
  if self._returnTimerId == nil and returnFunc ~= nil then
    self._returnTimerId = TimerManager:StartTimer((self.bind).duration, self.__ReturnEntity, self, true)
  end
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

OasisBuildEffectEntity.SetBuildSelectFxValid = function(self, valid)
  -- function num : 0_3 , upvalues : _ENV, cs_MeshRenderer
  if self.allSelectRenderList == nil then
    self.allSelectRenderList = (self.transform):GetComponentsInChildren(typeof(cs_MeshRenderer))
  end
  for i = 0, (self.allSelectRenderList).Length - 1 do
    local renderer = (self.allSelectRenderList)[i]
    if not valid or not (self.bind).mat_valid then
      do
        renderer.material = (self.bind).mat_unvalid
        -- DECOMPILER ERROR at PC27: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC27: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  for k,spriteRender in ipairs((self.bind).arrowList) do
    if not valid or not (self.bind).arrowColor_Green then
      do
        spriteRender.color = (self.bind).arrowColor_Red
        -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
end

local eAreaFxState = {Lock = 1, Unlockable = 2, Opening = 3}
OasisBuildEffectEntity.UpdateOasisAreaFxState = function(self, areaId)
  -- function num : 0_4 , upvalues : eAreaFxState, _ENV
  if self._areaFxState == eAreaFxState.Opening then
    return 
  end
  local state = nil
  local unlock = (PlayerDataCenter.AllBuildingData):OsisAreaUnlock(areaId)
  if unlock then
    state = eAreaFxState.Opening
  else
    local cfg = (ConfigData.oasis_area)[areaId]
    if (CheckCondition.CheckLua)(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2) then
      state = eAreaFxState.Unlockable
    else
      state = eAreaFxState.Lock
    end
  end
  do
    ;
    ((self.bind).lock):SetActive(state == eAreaFxState.Lock)
    ;
    ((self.bind).unlockable):SetActive(state == eAreaFxState.Unlockable)
    ;
    ((self.bind).opening):SetActive(state == eAreaFxState.Opening)
    self._areaFxState = state
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

OasisBuildEffectEntity.__ReturnEntity = function(self)
  -- function num : 0_5
  self._returnTimerId = nil
  if self.returnFunc ~= nil then
    (self.returnFunc)(self)
  end
end

OasisBuildEffectEntity.GetOasisBuildEffectEntityName = function(self)
  -- function num : 0_6
  return self.effectName
end

OasisBuildEffectEntity.OnDelete = function(self)
  -- function num : 0_7 , upvalues : _ENV
  DestroyUnityObject(self.gameObject)
  self.gameObject = nil
  self.transform = nil
  DestroyUnityObject(self.mat)
  self.mat = nil
  if self._returnTimerId ~= nil then
    TimerManager:StopTimer(self._returnTimerId)
    self._returnTimerId = nil
  end
end

return OasisBuildEffectEntity

