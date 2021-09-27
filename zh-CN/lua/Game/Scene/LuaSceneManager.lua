local LuaSceneManager = {}
local cs_GSceneManager_Ins = (CS.GSceneManager).Instance
LuaSceneManager.Init = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_GSceneManager_Ins
  self.__onSceneLoaded = BindCallback(self, self.OnSceneLoaded)
  self.__onAfterSceneLoaded = BindCallback(self, self.OnAfterSceneLoaded)
  self.__onSceneUnloaded = BindCallback(self, self.OnSceneUnloaded)
  self.__onActiveSceneChanged = BindCallback(self, self.OnActiveSceneChanged)
  cs_GSceneManager_Ins:onSceneLoaded("+", self.__onSceneLoaded)
  cs_GSceneManager_Ins:onAfterSceneLoaded("+", self.__onAfterSceneLoaded)
  cs_GSceneManager_Ins:onSceneUnLoaded("+", self.__onSceneUnloaded)
  cs_GSceneManager_Ins:onActiveSceneChanged("+", self.__onActiveSceneChanged)
end

LuaSceneManager.OnSceneLoaded = function(self, scene, loadSceneMode)
  -- function num : 0_1 , upvalues : _ENV
  if scene.name == (Consts.SceneName).Main then
    local mainCamera = UIManager:GetMainCamera()
    if not IsNull(mainCamera) then
      local bind = mainCamera:FindComponent(eUnityComponentID.LuaBinding)
      local oasisLockNode = bind:GetBind("oasisLockNode")
      local isOasisMask = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BuildingMask)
      if not IsNull(oasisLockNode) then
        oasisLockNode:SetActive(not isOasisMask)
      end
    end
  end
end

LuaSceneManager.OnAfterSceneLoaded = function(self, scene, loadSceneMode, isBeforeCallback)
  -- function num : 0_2
  if isBeforeCallback then
    self:OnSceneLoadedBefore(scene, loadSceneMode)
  else
    self:OnSceneLoadedAfter(scene, loadSceneMode)
  end
end

LuaSceneManager.OnSceneLoadedBefore = function(self, scene, loadSceneMode)
  -- function num : 0_3 , upvalues : _ENV
  if scene.name ~= (Consts.SceneName).Main or GuideManager:TryTriggerGuide(eGuideCondition.InMainScene) then
  end
end

LuaSceneManager.OnSceneLoadedAfter = function(self, scene, loadSceneMode)
  -- function num : 0_4 , upvalues : _ENV
  if scene.name == (Consts.SceneName).Sector then
    GuideManager:TryTriggerGuide(eGuideCondition.FInSectorScene)
  end
end

LuaSceneManager.OnSceneUnloaded = function(self, scene)
  -- function num : 0_5 , upvalues : _ENV
  (UIUtil.ClearTopHome)()
end

LuaSceneManager.OnActiveSceneChanged = function(self, scene1, scene2)
  -- function num : 0_6
end

LuaSceneManager:Init()
return LuaSceneManager

