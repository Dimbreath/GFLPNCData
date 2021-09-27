local ExplorationSceneCtrl = require("Game.Exploration.Ctrl.ExplorationSceneCtrl")
local EpLightSceneCtrl = class("EpLightSceneCtrl", ExplorationSceneCtrl)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
EpLightSceneCtrl.ctor = function(self, epCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.__onBattleToBattlComplete = BindCallback(self, self.OnBattleToBattleComplete)
end

EpLightSceneCtrl.SwithCameraCtrlState = function(self, cameraState)
  -- function num : 0_1
end

EpLightSceneCtrl.SetLightInBattleScene = function(self, flag)
  -- function num : 0_2
  self.inBattleScene = flag
end

EpLightSceneCtrl.InBattleScene = function(self)
  -- function num : 0_3
  return self.inBattleScene
end

EpLightSceneCtrl.__PlaySceneStartTimeline = function(self)
  -- function num : 0_4 , upvalues : ExplorationEnum, _ENV
  self.loadRoleComplete = true
  ;
  (self.__onStartTimelineCompleteGeneral)()
  self:ChangeEpSceneState((ExplorationEnum.eEpSceneState).InBattleScene)
  for k,heroGo in pairs(self.heroObjectDic) do
    heroGo:SetActive(true)
  end
end

EpLightSceneCtrl.BattleToBattleSceneNormal = function(self, epToBattleAction)
  -- function num : 0_5 , upvalues : ExplorationEnum
  self:SceneResetBattleCamera()
  self.__epToBattleAction = epToBattleAction
  self:SwithCameraCtrlState((ExplorationEnum.eEpCamControlState).None)
  ;
  (self.epSceneEntity):PlayBattleEndToBattle(self.__onBattleToBattlComplete)
  self:ChangeEpSceneState((ExplorationEnum.eEpSceneState).InTimeline)
  if self.skipEpTimeline then
    (self.epSceneEntity):EndOnStartBattleTimeLine()
  else
    self:ShowSkipWindow()
  end
end

EpLightSceneCtrl.OnBattleToBattleComplete = function(self)
  -- function num : 0_6 , upvalues : ExplorationEnum
  self:DeleteSkipWindow()
  self:ChangeEpSceneState((ExplorationEnum.eEpSceneState).InBattleScene)
  if self.__epToBattleAction ~= nil then
    (self.__epToBattleAction)()
    self.__epToBattleAction = nil
  end
end

EpLightSceneCtrl.OnPlayerMoveComplete = function(self, roomData)
  -- function num : 0_7
end

return EpLightSceneCtrl

