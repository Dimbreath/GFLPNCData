local ExplorationSceneCtrl = require("Game.Exploration.Ctrl.ExplorationSceneCtrl")
local ExplorationTDSceneCtrl = class("ExplorationTDSceneCtrl", ExplorationSceneCtrl)
local CS_RenderMgr = (CS.RenderManager).Instance
ExplorationTDSceneCtrl.__PlaySceneStartTimeline = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.loadRoleComplete = true
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((CS.CameraController).Instance).MainCamera).depthTextureMode = ((CS.UnityEngine).DepthTextureMode).Depth
  ;
  (self.__onStartTimelineCompleteGeneral)(true)
  self:SetEpMapCameraCullMask(LayerMask.UI3D)
end

ExplorationTDSceneCtrl.OnPlayerMoveComplete = function(self, roomData)
  -- function num : 0_1
end

ExplorationTDSceneCtrl.SetTDInBattleScene = function(self, flag)
  -- function num : 0_2
  self.inBattleScene = flag
end

ExplorationTDSceneCtrl.InBattleScene = function(self)
  -- function num : 0_3
  return self.inBattleScene
end

ExplorationTDSceneCtrl.ReSetShaderGlobal = function(self)
  -- function num : 0_4 , upvalues : CS_RenderMgr
  CS_RenderMgr:ResetShaderLODGlobal()
end

return ExplorationTDSceneCtrl

