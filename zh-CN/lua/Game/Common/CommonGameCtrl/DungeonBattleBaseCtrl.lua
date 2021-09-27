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
  local uiTDBattle = UIManager:GetWindow(UIWindowTypeID.TDBattle)
  if uiTDBattle ~= nil then
    uiTDBattle:OnTdBattleStart()
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

DungeonBattleBaseCtrl.__UpdatePlayerPosOnTDSettle = function(self, roleDataId, x, y)
  -- function num : 0_10 , upvalues : _ENV
  if (ConfigData.buildinConfig).BenchX <= x then
    y = 0
  end
  local dynPlayer = (BattleUtil.GetCurDynPlayer)()
  if dynPlayer == nil then
    return 
  end
  local dynHero = (dynPlayer.heroDic)[roleDataId]
  if dynHero ~= nil then
    dynHero:SetCoordXY(x, y, (ConfigData.buildinConfig).BenchX)
    return dynHero.coord
  end
  return nil
end

DungeonBattleBaseCtrl.PackInputModel = function(self, csInputCmd)
  -- function num : 0_11 , upvalues : _ENV
  local inputModel = {}
  inputModel.frame = csInputCmd.frameId
  inputModel.skillId = csInputCmd.skillId
  inputModel.casterId = csInputCmd.casterId
  inputModel.ultimateSkill = csInputCmd.isUltSkill
  inputModel.inputType = csInputCmd.inputType
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

DungeonBattleBaseCtrl.VictoryBattleEndCoroutine = function(self, battleEndState)
  -- function num : 0_12
end

DungeonBattleBaseCtrl.ReqBattleFreshFormation = function(self, battleController)
  -- function num : 0_13
end

DungeonBattleBaseCtrl.ReqGiveUpBattle = function(self, battleController)
  -- function num : 0_14
end

DungeonBattleBaseCtrl.ReqRestartBattle = function(self, battleController)
  -- function num : 0_15
  battleController:RestartBattle()
end

DungeonBattleBaseCtrl.OnDeployCoordChanged = function(self, battleController)
  -- function num : 0_16 , upvalues : _ENV
  MsgCenter:Broadcast(eMsgEventId.OnDeployCoordChanged)
end

DungeonBattleBaseCtrl.OnBattleEffectClicked = function(self, battleController, battleEffectGrid)
  -- function num : 0_17 , upvalues : _ENV
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
  -- function num : 0_18 , upvalues : _ENV
  MsgCenter:Broadcast(eMsgEventId.OnBattleReady)
end

DungeonBattleBaseCtrl.GetBattleConsumeSkillChipUseTimeDic = function(self, battlePlayerController)
  -- function num : 0_19 , upvalues : _ENV
  local activeAlgConsume = {}
  local skillList = battlePlayerController:GetPlayerSkillList()
  if skillList == nil then
    return nil
  end
  for i = 0, skillList.Count - 1 do
    local battleSkill = skillList[i]
    if battleSkill.skillType == eBattleSkillLogicType.ChipConsume and battleSkill.curUseTime > 0 then
      activeAlgConsume[battleSkill.itemId] = battleSkill.curUseTime
    end
  end
  return activeAlgConsume
end

DungeonBattleBaseCtrl.PlayWinEffect = function(self, mvpRole)
  -- function num : 0_20 , upvalues : _ENV
  local heroCfg = (ConfigData.resource_model)[mvpRole.roleDataId]
  if heroCfg == nil then
    return 
  end
  for _,effectId in ipairs(heroCfg.win_effect_id) do
    local creationCfg = (((CS.GameData).instance).listBattleCreationDatas):GetDataById(effectId)
    if creationCfg ~= nil then
      local target = (CS.BattleTarget)(mvpRole)
      local effect = (((CS.BattleManager).Instance).CurEffectController):AddBattleEffect(creationCfg, creationCfg.SrcName, mvpRole, target)
      if effect then
        if (string.contains)(creationCfg.SrcName, "win_loop") then
          local animator = (mvpRole:GetActionComponent()).Animator
          for i = 0, ((animator.runtimeAnimatorController).animationClips).Length - 1 do
            local animationClip = ((animator.runtimeAnimatorController).animationClips)[i]
            if animationClip.name == "battle_win" then
              TimerManager:StartTimer(animationClip.length, effect.Play, effect, true, false, false)
            end
          end
        else
          do
            do
              effect:Play()
              -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
end

DungeonBattleBaseCtrl.OnDelete = function(self)
  -- function num : 0_21 , upvalues : CS_BattleManager_Ins
  CS_BattleManager_Ins:ClearBattleCache()
end

return DungeonBattleBaseCtrl

