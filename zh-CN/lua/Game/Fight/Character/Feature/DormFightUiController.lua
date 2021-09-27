local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCharacterFeatureBase = require("Game.Fight.Character.Feature.DormFightCharacterFeatureBase")
local DormFightUiController = class("DormFightUiController", DormFightCharacterFeatureBase)
DormFightUiController.ctor = function(self)
  -- function num : 0_0
  self._modelCtrl = nil
  self._vitalityCtrl = nil
  self._vitalityBarHandler = nil
  self._namePlateHandler = nil
  self._sceneUiCtrl = nil
end

DormFightUiController.OnInit = function(self)
  -- function num : 0_1 , upvalues : DormFightConst, _ENV
  self._modelCtrl = self:GetFeature((DormFightConst.FeatureEnum).ModelController)
  self._vitalityCtrl = self:GetFeature((DormFightConst.FeatureEnum).VitalityController)
  local dormFightCtrl = ControllerManager:GetController(ControllerTypeId.DormFight)
  self._sceneUiCtrl = dormFightCtrl:GetSceneUiCtrl()
end

DormFightUiController.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : DormFightConst
  if self._sceneUiCtrl == nil then
    return 
  end
  if self._namePlateHandler == nil then
    self._namePlateHandler = (self._sceneUiCtrl):CreateSceneUi((DormFightConst.SceneUiType).NamePlate)
    ;
    (self._sceneUiCtrl):SetName(self._namePlateHandler, (self._owner):GetName())
    ;
    (self._sceneUiCtrl):SetNamePlateStyle(self._namePlateHandler, (self._owner):GetCharacterType() == (DormFightConst.CharacterType).Player)
  end
  if self._vitalityBarHandler == nil then
    self._vitalityBarHandler = (self._sceneUiCtrl):CreateSceneUi((DormFightConst.SceneUiType).VitalityBar)
  end
  if self._modelCtrl ~= nil then
    local headPosition = (self._modelCtrl):GetHeadSpotPosition()
    ;
    (self._sceneUiCtrl):UpdatePosition(self._namePlateHandler, headPosition)
    local footPosition = (self._modelCtrl):GetFootSpotPosition()
    ;
    (self._sceneUiCtrl):UpdatePosition(self._vitalityBarHandler, footPosition)
  end
  do
    if self._vitalityCtrl ~= nil then
      local ratio = (self._vitalityCtrl):GetVitalityRatio()
      ;
      (self._sceneUiCtrl):SetVitalityRatio(self._vitalityBarHandler, ratio)
    end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
end

DormFightUiController.ShowVitalityNode = function(self)
  -- function num : 0_3
  if self._sceneUiCtrl == nil then
    return 
  end
  ;
  (self._sceneUiCtrl):ShowVitalityNode(self._vitalityBarHandler)
end

return DormFightUiController

