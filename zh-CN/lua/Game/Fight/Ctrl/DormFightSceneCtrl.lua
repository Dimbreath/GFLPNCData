local CS_UnityEngine_GameObject = (CS.UnityEngine).GameObject
local CS_UnityEngine_Collider = (CS.UnityEngine).Collider
local DormFightCtrlBase = require("Game.Fight.Ctrl.DormFightCtrlBase")
local DormFightSceneCtrl = class("DormFightSceneCtrl", DormFightCtrlBase)
DormFightSceneCtrl.ctor = function(self)
  -- function num : 0_0
  self._walls = nil
end

DormFightSceneCtrl.OnEnterFightScene = function(self)
  -- function num : 0_1 , upvalues : CS_UnityEngine_GameObject, _ENV, CS_UnityEngine_Collider
  self._walls = {}
  local transObjects = ((CS_UnityEngine_GameObject.Find)("Objects")).transform
  local transWallRoot = transObjects:Find("Wall")
  local childCount = transWallRoot.childCount
  for i = 0, childCount - 1 do
    local transWall = transWallRoot:GetChild(i)
    local colliderWall = transWall:GetComponent(typeof(CS_UnityEngine_Collider))
    if not IsNull(colliderWall) then
      (table.insert)(self._walls, colliderWall)
    end
  end
end

DormFightSceneCtrl.OnExitFightScene = function(self)
  -- function num : 0_2
  self._walls = nil
end

DormFightSceneCtrl.GetWallList = function(self)
  -- function num : 0_3
  if not self._walls then
    return {}
  end
end

DormFightCtrlBase.OnUpdate = function(self, deltaTime)
  -- function num : 0_4
end

return DormFightSceneCtrl

