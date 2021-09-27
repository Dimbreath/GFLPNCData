local base = require("Game.Exploration.MainCtrl.EpMainCtrlBase")
local EpTDMainCtrl = class("EpTDMainCtrl", base)
local ExplorationTDBattleCtrl = require("Game.BattleTowerDefence.Ctrl.ExplorationTDBattleCtrl")
local ExplorationTDPlayerCtrl = require("Game.BattleTowerDefence.Ctrl.ExplorationTDPlayerCtrl")
local ExplorationTDSceneCtrl = require("Game.Exploration.TowerDefense.Ctrl.ExplorationTDSceneCtrl")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local cs_MessageCommon = CS.MessageCommon
EpTDMainCtrl.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  print("todo是塔防")
end

EpTDMainCtrl.InitEpMainSubCtrls = function(self)
  -- function num : 0_1 , upvalues : base, ExplorationTDBattleCtrl, ExplorationTDPlayerCtrl, ExplorationTDSceneCtrl
  (base.InitEpMainSubCtrls)(self)
  self.battleCtrl = (ExplorationTDBattleCtrl.New)(self)
  self.playerCtrl = (ExplorationTDPlayerCtrl.New)(self)
  self.sceneCtrl = (ExplorationTDSceneCtrl.New)(self)
end

EpTDMainCtrl.__OnEnterEpSceneComplete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.__TryShowOperationBeforeEpSceneComplete)(self)
end

EpTDMainCtrl.__EnterBattleScene = function(self, roomData, isReconnect)
  -- function num : 0_3 , upvalues : base
  (base.__EnterBattleScene)(self, roomData, isReconnect)
  ;
  (self.sceneCtrl):SetTDInBattleScene(true)
  local csbattleCtrl = (self.battleCtrl):StartNewEpBattle(roomData, self.dynPlayer)
  csbattleCtrl:StartEnterDeployState()
end

EpTDMainCtrl.OnStartTimelineComplete = function(self)
  -- function num : 0_4 , upvalues : base
  self.__isStartInTheFloor = true
  ;
  (base.OnStartTimelineComplete)(self)
end

EpTDMainCtrl.OutsideTheRoom = function(self)
  -- function num : 0_5 , upvalues : base
  if not (base.OutsideTheRoom)(self) and self.__isStartInTheFloor then
    self:TryEnterNextTDRoom()
  end
end

EpTDMainCtrl.ContinueExploration = function(self, isRevive)
  -- function num : 0_6 , upvalues : base
  (self.sceneCtrl):SetTDInBattleScene(false)
  ;
  (base.ContinueExploration)(self, isRevive)
end

EpTDMainCtrl.TryEnterNextTDRoom = function(self)
  -- function num : 0_7 , upvalues : _ENV, cs_MessageCommon
  self.__isStartInTheFloor = nil
  local curRoomData = self:GetCurrentRoomData()
  local enterNextFunc = function()
    -- function num : 0_7_0 , upvalues : curRoomData, self
    local nextRoomList = curRoomData:GetNextRoom()
    local nextRoomData = nextRoomList[1]
    ;
    (self.playerCtrl):Move(nextRoomData)
  end

  ;
  (self.sceneCtrl):ReSetShaderGlobal()
  if curRoomData:IsEndColRoom() then
    self:StartCompleteExploration()
  else
    if curRoomData:IsRealBossRoom() and (self.mapData):HasOverBossRoom() then
      local stageId = (ExplorationManager:GetSectorStageCfg()).id
      local curFloor = ExplorationManager:GetCurLevelIndex() + 1
      ;
      (ControllerManager:GetController(ControllerTypeId.AvgPlay, true)):TryPlayAvg(eAvgTriggerType.MainAvgEp, stageId, curFloor, 3, function()
    -- function num : 0_7_1 , upvalues : cs_MessageCommon, _ENV, enterNextFunc, self
    (cs_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(255), function()
      -- function num : 0_7_1_0 , upvalues : _ENV, enterNextFunc
      AudioManager:PlayAudioById(1125)
      enterNextFunc()
    end
, function()
      -- function num : 0_7_1_1 , upvalues : _ENV, self
      AudioManager:PlayAudioById(1125)
      self:StartCompleteExploration()
    end
)
  end
)
    else
      do
        enterNextFunc()
      end
    end
  end
end

EpTDMainCtrl.CheckAfterOutSide = function(self)
  -- function num : 0_8 , upvalues : base, _ENV
  (base.CheckAfterOutSide)(self)
  if not self._outsideTheRoomFunc then
    self._outsideTheRoomFunc = function()
    -- function num : 0_8_0 , upvalues : self
    self:TryEnterNextTDRoom()
  end

    local opDetail = (self.dynPlayer):GetOperatorDetail()
    local opState = opDetail.state
    if opState ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
      return 
    end
    if not (self.residentStoreCtrl):CheckEpResidentStore(self._outsideTheRoomFunc) then
      (self._outsideTheRoomFunc)()
    end
  end
end

return EpTDMainCtrl

