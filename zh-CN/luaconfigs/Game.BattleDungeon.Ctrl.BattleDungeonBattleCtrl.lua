-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonBattleBaseCtrl = require("Game.Common.CommonGameCtrl.DungeonBattleBaseCtrl")
local BattleDungeonBattleCtrl = class("BattleDungeonBattleCtrl", DungeonBattleBaseCtrl)
local base = DungeonBattleBaseCtrl
local DungeonConst = require("Game.BattleDungeon.DungeonConst")
local DungeonBattleRoom = require("Game.BattleDungeon.Data.DungeonBattleRoom")
local ChipData = require("Game.PlayerData.Item.ChipData")
local JumpManager = require("Game.Jump.JumpManager")
local util = require("XLua.Common.xlua_util")
BattleDungeonBattleCtrl.ctor = function(self, bdCtrl)
  -- function num : 0_0 , upvalues : _ENV, DungeonConst
  self.bdCtrl = bdCtrl
  ;
  (table.insert)((self.bdCtrl).ctrls, self)
  self.__battleStepLogic = BindCallback(self, self.DungeonBattleStepLogic)
  ;
  (self.bdCtrl):RegisterDungeonLogic((DungeonConst.LogicType).BattleStep, self.__battleStepLogic)
  self.__chipStepLogic = BindCallback(self, self.DungeonChipStepLogic)
  ;
  (self.bdCtrl):RegisterDungeonLogic((DungeonConst.LogicType).ChipStep, self.__chipStepLogic)
  self.__OnTimelineNoticeOpenResultUI = BindCallback(self, self.OnTimelineNoticeOpenResultUI)
  MsgCenter:AddListener(eMsgEventId.OnTimelineNoticeCreateResultUI, self.__OnTimelineNoticeOpenResultUI)
end

BattleDungeonBattleCtrl.GetEffectPoolCtrl = function(self)
  -- function num : 0_1
  return ((self.bdCtrl).sceneCtrl).effectPoolCtrl
end

BattleDungeonBattleCtrl.GetHeroObjectDic = function(self)
  -- function num : 0_2
  return ((self.bdCtrl).sceneCtrl).heroObjectDic
end

BattleDungeonBattleCtrl.GetRoleAppearEffect = function(self)
  -- function num : 0_3
  return ((self.bdCtrl).sceneCtrl):GetRoleAppearEffect()
end

BattleDungeonBattleCtrl.GetRoleDisappearEffect = function(self)
  -- function num : 0_4
  return ((self.bdCtrl).sceneCtrl):GetRoleDisappearEffect()
end

BattleDungeonBattleCtrl.DungeonBattleStepLogic = function(self, monsterGroup)
  -- function num : 0_5 , upvalues : DungeonBattleRoom, _ENV
  local battleRoomData = (DungeonBattleRoom.CreateBattleDungeonRoom)(self.bdCtrl, monsterGroup, (self.bdCtrl).dungeonCfg, (self.bdCtrl).dynPlayer)
  self.battleRoomData = battleRoomData
  local btlMgr = (CS.BattleManager).Instance
  local IsWithFormation = (self.battleRoomData).formation
  local battleCtrl = btlMgr:StartNewBattle(battleRoomData, (self.bdCtrl).dynPlayer, self, not IsWithFormation)
  if IsWithFormation then
    battleCtrl:StartEnterDeployState()
  else
    battleCtrl:StartBattleSkipDeploy()
  end
  if isEditorMode and ((CS.GMController).Instance).isBattleOffLine then
    return 
  end
  if ((self.bdCtrl).sceneCtrl).sceneWave ~= nil then
    UIManager:CreateWindowAsync(UIWindowTypeID.DungeonWaveTip, function(window)
    -- function num : 0_5_0 , upvalues : self
    window:InjectWave(((self.bdCtrl).sceneCtrl).sceneWave, (self.bdCtrl).dungeonId)
    window:Show()
  end
)
  end
end

BattleDungeonBattleCtrl.BattleLoadReady = function(self)
  -- function num : 0_6
end

BattleDungeonBattleCtrl.ReqStartBattle = function(self, battleRoomData, originRoleList, battleAction)
  -- function num : 0_7 , upvalues : _ENV, base
  if (self.battleRoomData).formation then
    local roleCount = originRoleList.Count
    local sendMsg = {}
    sendMsg.data = {}
    for i = 0, roleCount - 1 do
      local role = originRoleList[i]
      local heroId = role.roleDataId
      local pos = (BattleUtil.XYCoord2Pos)(role.x, role.y)
      local uid = (((self.bdCtrl).dynPlayer):GetDynHeroByDataId(heroId)).uid
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R14 in 'UnsetPending'

      ;
      (sendMsg.data)[uid] = pos
    end
    ;
    ((self.bdCtrl).battleNetwork):CS_BATTLE_StartBattleWithForm(sendMsg, function(objList)
    -- function num : 0_7_0 , upvalues : battleAction, base, self, battleRoomData, originRoleList
    if battleAction ~= nil then
      local randomSeed = 0
      if objList ~= nil and objList.Count > 0 then
        randomSeed = objList[0]
      end
      battleAction(randomSeed)
      ;
      (base.ReqStartBattle)(self, battleRoomData, originRoleList, battleAction)
    end
  end
)
  else
    do
      if battleAction ~= nil then
        battleAction()
        ;
        (base.ReqStartBattle)(self, battleRoomData, originRoleList, battleAction)
      end
    end
  end
end

BattleDungeonBattleCtrl.ReqBattleSettle = function(self, battleEndState, requestData)
  -- function num : 0_8 , upvalues : _ENV, DungeonBattleBaseCtrl
  self.__waitSettleResult = true
  local win = battleEndState.win
  local battleCtrl = battleEndState.battleController
  local playerRoleSettle = requestData.playerRoleSettle
  local battlePlayerController = battleCtrl.PlayerController
  local sendMsg = {}
  sendMsg.hero = {}
  sendMsg.win = win
  sendMsg.misc = {}
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (sendMsg.misc).totalFrame = battleCtrl.frame
  local score = {}
  for k,v in pairs(requestData.gameScore) do
    score[k] = v
  end
  sendMsg.valid = {}
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (sendMsg.valid).score = score
  for k,v in pairs(playerRoleSettle) do
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R14 in 'UnsetPending'

    (sendMsg.hero)[k] = v.hpPer
  end
  sendMsg.hmp = ((self.bdCtrl).dynPlayer).playerUltSkillMp
  sendMsg.mp = ((self.bdCtrl).dynPlayer).playerSkillMp
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (sendMsg.misc).inputData = (DungeonBattleBaseCtrl.StoreInputCmdToSettleMsg)(self, battlePlayerController)
  ;
  ((self.bdCtrl).battleNetwork):CS_BATTLE_BattleSettle(sendMsg, function(dataList)
    -- function num : 0_8_0 , upvalues : win, _ENV, battleEndState, self
    if not win then
      UIManager:ShowWindowAsync(UIWindowTypeID.DungeonFailureResult, function(window)
      -- function num : 0_8_0_0 , upvalues : battleEndState, self, _ENV
      if window == nil then
        return 
      end
      window:FailExploration(function()
        -- function num : 0_8_0_0_0 , upvalues : battleEndState
        battleEndState:EndBattleAndClear()
      end
, function()
        -- function num : 0_8_0_0_1 , upvalues : self
        (self.bdCtrl):ExitBattleDungeon(false)
      end
, function()
        -- function num : 0_8_0_0_2 , upvalues : window, _ENV, battleEndState
        window:Hide()
        UIManager:ShowWindowAsync(UIWindowTypeID.ResultSkada, function(SkadaWindow)
          -- function num : 0_8_0_0_2_0 , upvalues : _ENV, battleEndState, window
          if SkadaWindow == nil then
            return 
          end
          SkadaWindow:InitBattleSkada((CS.BattleStatistics).Instance, ((battleEndState.battleController).PlayerTeamController).battleOriginRoleList, ((battleEndState.battleController).EnemyTeamController).battleOriginRoleList)
          SkadaWindow:SetSkadaCloseCallback(function()
            -- function num : 0_8_0_0_2_0_0 , upvalues : window
            window:Show()
          end
)
        end
)
      end
)
    end
)
    end
    ;
    (self.bdCtrl):StartRunNextLogic()
    self.__waitSettleResult = false
  end
)
end

BattleDungeonBattleCtrl.VictoryBattleEndCoroutine = function(self, battleEndState, resultData)
  -- function num : 0_9 , upvalues : _ENV, JumpManager, util
  local wave = ((self.bdCtrl).sceneCtrl).sceneWave
  if wave.total ~= wave.cur then
    battleEndState:PlayRecycleRoleEffect()
    battleEndState:EndBattleAndClear()
    return 
  end
  local battleController = battleEndState.battleController
  local CS_CameraController_Ins = (CS.CameraController).Instance
  self.__settleTimelinePause = false
  self.__showResultUI = false
  local mvpGrade = (BattleUtil.GenMvp)(resultData.playerRoleList)
  local battleEndCoroutine = function()
    -- function num : 0_9_0 , upvalues : _ENV, CS_CameraController_Ins, battleController, mvpGrade, self, battleEndState, resultData, JumpManager
    local isGuide = BattleDungeonManager:GetIsGuide()
    if not isGuide then
      UIManager:CreateWindow(UIWindowTypeID.DungeonResult)
    end
    CS_CameraController_Ins:PlaySettlementCut(battleController, mvpGrade.role)
    while self.__waitSettleResult do
      (coroutine.yield)()
    end
    if self.__settleTimelinePause then
      CS_CameraController_Ins:PauseSettlementCut(false)
    end
    while not self.__showResultUI do
      (coroutine.yield)()
    end
    if ((self.bdCtrl).objectCtrl).dontShowResult then
      (self.bdCtrl):ExitBattleDungeon(true)
      self.battleEndState = battleEndState
      return 
    end
    local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
    cvCtr:PlayCv((mvpGrade.role).roleDataId, ConfigData:GetVoicePointRandom(5))
    UIManager:ShowWindowAsync(UIWindowTypeID.DungeonResult, function(window)
      -- function num : 0_9_0_0 , upvalues : _ENV, self, resultData, mvpGrade, battleEndState, JumpManager
      if window == nil then
        return 
      end
      local isGuide = BattleDungeonManager:GetIsGuide()
      window:CompleteDungeon(isGuide, ((self.bdCtrl).objectCtrl).rewardMsg, resultData, mvpGrade, (self.battleRoomData).dungeonType, (self.bdCtrl).ATHRewardInfo, (self.bdCtrl).hasDailyDouble)
      local winEvent = BattleDungeonManager:GetBattleWinEvent()
      if winEvent ~= nil then
        winEvent()
      end
      window:SetContinueCallback(function()
        -- function num : 0_9_0_0_0 , upvalues : battleEndState, self
        battleEndState:EndBattleAndClear()
        ;
        (self.bdCtrl):ExitBattleDungeon(true, true)
      end
)
      if not isGuide then
        window:SetPlayeAgain(function()
        -- function num : 0_9_0_0_1 , upvalues : _ENV, JumpManager, battleEndState
        if (PlayerDataCenter.stamina):GetCurrentStamina() < (BattleDungeonManager.dungeonStageData):GetStaminaCost() then
          JumpManager:Jump((JumpManager.eJumpTarget).BuyStamina)
          return 
        end
        battleEndState:EndBattleAndClear()
        if BattleDungeonManager.battleRestartEvent ~= nil then
          local formationId = BattleDungeonManager:GetFormationId()
          ;
          (BattleDungeonManager.battleRestartEvent)(formationId)
        end
      end
, BattleDungeonManager.dungeonStageData)
      end
    end
)
  end

  return (util.cs_generator)(battleEndCoroutine)
end

BattleDungeonBattleCtrl.OnTimelineNoticeOpenResultUI = function(self)
  -- function num : 0_10 , upvalues : _ENV
  self.__showResultUI = true
  if self.__waitSettleResult then
    ((CS.CameraController).Instance):PauseSettlementCut(true)
    self.__settleTimelinePause = true
  end
end

BattleDungeonBattleCtrl.ReqBattleFreshFormation = function(self, battleController)
  -- function num : 0_11
end

BattleDungeonBattleCtrl.DungeonChipStepLogic = function(self, chipDataGroup)
  -- function num : 0_12 , upvalues : _ENV, ChipData
  local rewardChipList = {}
  for k,v in ipairs(chipDataGroup.alg) do
    local chipData = (ChipData.NewChipForServer)(v)
    rewardChipList[k] = chipData
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.SelectChip, function(window)
    -- function num : 0_12_0 , upvalues : _ENV, rewardChipList, self
    if window == nil then
      return 
    end
    MsgCenter:Broadcast(eMsgEventId.OnSettleMentTimeLinePlayToEnd)
    window:InitSelectChip(false, rewardChipList, (self.bdCtrl).dynPlayer, BindCallback(self, self.__SelectChipComplete), BindCallback(self, self.__GiveSelectChipComplect), false, nil)
  end
)
end

BattleDungeonBattleCtrl.__SelectChipComplete = function(self, index, selectComplete)
  -- function num : 0_13
  index = index - 1
  ;
  ((self.bdCtrl).battleNetwork):CS_BATTLE_AlgSelect(index, function(dataList)
    -- function num : 0_13_0 , upvalues : self, selectComplete
    (self.bdCtrl):StartRunNextLogic()
    if selectComplete ~= nil then
      selectComplete()
    end
  end
)
end

BattleDungeonBattleCtrl.__GiveSelectChipComplect = function(self, selectComplete)
  -- function num : 0_14
  (self.epNetwork):CS_BATTLE_AlgGiveUp(function()
    -- function num : 0_14_0 , upvalues : selectComplete, self
    if selectComplete ~= nil then
      selectComplete()
    end
    self:CheckChipSelect()
  end
)
end

BattleDungeonBattleCtrl.ReqGiveUpBattle = function(self, battleController)
  -- function num : 0_15 , upvalues : _ENV
  (battleController.fsm):ChangeState((CS.eBattleState).End)
  ;
  ((battleController.fsm).currentState):EndBattleAndClear()
  ;
  ((self.bdCtrl).battleNetwork):CS_BATTLE_Quit(function()
    -- function num : 0_15_0 , upvalues : _ENV
    BattleDungeonManager:ExitDungeon()
  end
)
end

BattleDungeonBattleCtrl.OnDelete = function(self)
  -- function num : 0_16 , upvalues : _ENV, DungeonConst, DungeonBattleBaseCtrl
  if ((self.bdCtrl).objectCtrl).dontShowResult then
    PlayerDataCenter:UnlockCommanderSkill()
    if self.battleEndState ~= nil then
      (self.battleEndState):EndBattleAndClear()
    end
    return 
  end
  ;
  (self.bdCtrl):UnRegisterDungeonLogic((DungeonConst.LogicType).BattleStep, self.__battleStepLogic)
  ;
  (self.bdCtrl):UnRegisterDungeonLogic((DungeonConst.LogicType).ChipStep, self.__chipStepLogic)
  MsgCenter:RemoveListener(eMsgEventId.OnTimelineNoticeCreateResultUI, self.__OnTimelineNoticeOpenResultUI)
  ;
  (DungeonBattleBaseCtrl.OnDelete)(self)
end

return BattleDungeonBattleCtrl

