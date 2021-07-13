-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonBattleBaseCtrl = class("DungeonBattleBaseCtrl")
local CS_BattleManager_Ins = (CS.BattleManager).Instance
DungeonBattleBaseCtrl.eBattleEndType = {Victory = 0, Failure = 1, Retreat = 2, Restart = 3, Sneak = 5}
DungeonBattleBaseCtrl.GetHeroObjectDic = function(self)
  -- function num : 0_0
end

DungeonBattleBaseCtrl.OnBattleStateChange = function(self, battleCtrl, stateId, isDeployRoom)
  -- function num : 0_1
end

DungeonBattleBaseCtrl.GetRoleAppearEffect = function(self)
  -- function num : 0_2
end

DungeonBattleBaseCtrl.GetRoleDisappearEffect = function(self)
  -- function num : 0_3
end

DungeonBattleBaseCtrl.BattleLoadReady = function(self, battleController)
  -- function num : 0_4
end

DungeonBattleBaseCtrl.OnBattleStart = function(self, battleCtrl)
  -- function num : 0_5 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.BattleCrazyMode, function(window)
    -- function num : 0_5_0 , upvalues : battleCtrl
    if window == nil then
      return 
    end
    window:InjectCrazyTime(battleCtrl.CrazyTime)
    window:OnBattleStartCrazyMode(battleCtrl)
  end
)
end

DungeonBattleBaseCtrl.ReqStartBattle = function(self, battleRoomData, originRoleList, battleAction)
  -- function num : 0_6 , upvalues : _ENV
  local uiBattle = UIManager:GetWindow(UIWindowTypeID.Battle)
  if uiBattle ~= nil and uiBattle.active then
    uiBattle:HideRetreatAndCampBondBtn()
  end
end

DungeonBattleBaseCtrl.OnBattleEnd = function(self, battleEndState, evenId, dealBattleEndEvent)
  -- function num : 0_7
  dealBattleEndEvent(evenId)
end

DungeonBattleBaseCtrl.ReqBattleSettle = function(self, battleEndState, requestData)
  -- function num : 0_8
end

DungeonBattleBaseCtrl.StoreInputCmdToSettleMsg = function(self, csbattlePlayerController)
  -- function num : 0_9 , upvalues : _ENV
  local inputData = {}
  if csbattlePlayerController ~= nil then
    local inputs = csbattlePlayerController:GetInputCmd()
    if inputs ~= nil and inputs.Count > 0 then
      for i = 0, inputs.Count - 1 do
        local inputModel = self:PackInputModel(inputs[i])
        ;
        (table.insert)(inputData, inputModel)
      end
    end
  end
  do
    if #inputData > 0 then
      return inputData
    end
    return nil
  end
end

DungeonBattleBaseCtrl.PackInputModel = function(self, csInputCmd)
  -- function num : 0_10 , upvalues : _ENV
  local inputModel = {}
  inputModel.frame = csInputCmd.frameId
  inputModel.skillId = csInputCmd.skillId
  inputModel.casterId = csInputCmd.casterId
  inputModel.ultimateSkill = csInputCmd.isUltSkill
  local selectTiles = csInputCmd.selectTiles
  inputModel.select_role_coords = {}
  if selectTiles ~= nil and selectTiles.Count > 0 then
    for i = 0, selectTiles.Count - 1 do
      (table.insert)(inputModel.select_role_coords, selectTiles[i])
    end
  end
  do
    inputModel.inputcoord = csInputCmd.selectCoord
    return inputModel
  end
end

DungeonBattleBaseCtrl.VictoryBattleEndCoroutine = function(self, battleEndState, resultData)
  -- function num : 0_11
end

DungeonBattleBaseCtrl.ReqBattleFreshFormation = function(self, battleController)
  -- function num : 0_12
end

DungeonBattleBaseCtrl.ReqGiveUpBattle = function(self, battleController)
  -- function num : 0_13
end

DungeonBattleBaseCtrl.ReqRestartBattle = function(self, battleController)
  -- function num : 0_14
  battleController:RestartBattle()
end

DungeonBattleBaseCtrl.OnDeployCoordChanged = function(self, battleController)
  -- function num : 0_15 , upvalues : _ENV
  MsgCenter:Broadcast(eMsgEventId.OnDeployCoordChanged)
end

DungeonBattleBaseCtrl.OnBattleEffectClicked = function(self, battleController, battleEffectGrid)
  -- function num : 0_16 , upvalues : _ENV
  local worldPos = nil
  if battleEffectGrid.onBench then
    worldPos = (battleController.battleFieldData):GetBenchUnityPos(battleEffectGrid.y)
  else
    worldPos = (battleController.battleFieldData):GetGridUnityPos(battleEffectGrid.x, battleEffectGrid.y)
  end
  ;
  (UIManager:ShowWindow(UIWindowTypeID.BattleEffectGirdInfo)):InitBattleGridInfo(battleEffectGrid.gridData, worldPos)
  AudioManager:PlayAudioById(1079)
end

DungeonBattleBaseCtrl.OnBattleObjectLoadComplete = function(self, battleController)
  -- function num : 0_17
end

DungeonBattleBaseCtrl.OnDelete = function(self)
  -- function num : 0_18 , upvalues : CS_BattleManager_Ins
  CS_BattleManager_Ins:ClearBattleCache()
end

return DungeonBattleBaseCtrl

