-- params : ...
-- function num : 0 , upvalues : _ENV
local LuaSceneManager = {}
local cs_GSceneManager_Ins = (CS.GSceneManager).Instance
LuaSceneManager.Init = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_GSceneManager_Ins
  self.__onSceneLoaded = BindCallback(self, self.OnSceneLoaded)
  self.__onSceneUnloaded = BindCallback(self, self.OnSceneUnloaded)
  self.__onActiveSceneChanged = BindCallback(self, self.OnActiveSceneChanged)
  cs_GSceneManager_Ins:onSceneLoaded("+", self.__onSceneLoaded)
  cs_GSceneManager_Ins:onSceneUnLoaded("+", self.__onSceneUnloaded)
  cs_GSceneManager_Ins:onActiveSceneChanged("+", self.__onActiveSceneChanged)
end

LuaSceneManager.OnSceneLoaded = function(self, scene, loadSceneMode, isBeforeCallback)
  -- function num : 0_1
  if isBeforeCallback then
    self:OnSceneLoadedBefore(scene, loadSceneMode)
  else
    self:OnSceneLoadedAfter(scene, loadSceneMode)
  end
end

LuaSceneManager.OnSceneLoadedBefore = function(self, scene, loadSceneMode)
  -- function num : 0_2 , upvalues : _ENV
  (UIUtil.ClearTopHome)()
  if scene.name == (Consts.SceneName).Main then
    local mainCamera = UIManager:GetMainCamera()
    if not IsNull(mainCamera) then
      local bind = mainCamera:FindComponent(eUnityComponentID.LuaBinding)
      local oasisLockNode = bind:GetBind("oasisLockNode")
      local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock)
      local isOasisMask = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BuildingMask)
      if not IsNull(oasisLockNode) then
        oasisLockNode:SetActive(not isOasisMask)
      end
    end
  end
  do
    if GuideManager:TryTriggerGuide(eGuideCondition.InMainScene) then
    end
  end
end

LuaSceneManager.OnSceneLoadedAfter = function(self, scene, loadSceneMode)
  -- function num : 0_3 , upvalues : _ENV
  if scene.name == (Consts.SceneName).Sector then
    GuideManager:TryTriggerGuide(eGuideCondition.FInSectorScene)
  end
end

LuaSceneManager.OnSceneUnloaded = function(self, scene)
  -- function num : 0_4
end

LuaSceneManager.OnActiveSceneChanged = function(self, scene1, scene2)
  -- function num : 0_5
end

LuaSceneManager:Init()
return LuaSceneManager

