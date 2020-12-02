-- params : ...
-- function num : 0 , upvalues : _ENV
local DungeonBattleBaseCtrl = require("Game.Common.CommonGameCtrl.DungeonBattleBaseCtrl")
local BattleDungeonBattleCtrl = class("BattleDungeonBattleCtrl", DungeonBattleBaseCtrl)
local DungeonConst = require("Game.BattleDungeon.DungeonConst")
local DungeonBattleRoom = require("Game.BattleDungeon.Data.DungeonBattleRoom")
local ChipData = require("Game.PlayerData.Item.ChipData")
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
  local battleRoomData = (DungeonBattleRoom.CreateBattleDungeonRoom)(monsterGroup, (self.bdCtrl).dungeonCfg, (self.bdCtrl).dynPlayer)
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
    window:InjectWave(((self.bdCtrl).sceneCtrl).sceneWave)
    window:Show()
  end
)
  end
end

BattleDungeonBattleCtrl.BattleLoadReady = function(self)
  -- function num : 0_6
end

BattleDungeonBattleCtrl.ReqStartBattle = function(self, battleRoomData, originRoleList, battleAction)
  -- function num : 0_7 , upvalues : _ENV
  if (self.battleRoomData).formation then
    local roleCount = originRoleList.Count
    local sendMsg = {}
    sendMsg.data = {}
    for i = 0, roleCount - 1 do
      local role = originRoleList[i]
      local heroId = role.roleDataId
      local pos = (BattleUtil.XYCoord2Pos)(role.x, role.y)
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R13 in 'UnsetPending'

      ;
      (sendMsg.data)[heroId] = pos
    end
    ;
    ((self.bdCtrl).battleNetwork):CS_BATTLE_StartBattleWithForm(sendMsg, function(dataList)
    -- function num : 0_7_0 , upvalues : battleAction
    if battleAction ~= nil then
      battleAction()
    end
  end
)
  else
    do
      if battleAction ~= nil then
        battleAction()
      end
    end
  end
end

BattleDungeonBattleCtrl.ReqBattleSettle = function(self, battleEndState, playerRoleSettle, monsterRoleSettle)
  -- function num : 0_8 , upvalues : _ENV
  self.__waitSettleResult = true
  local win = battleEndState.win
  local sendMsg = {}
  sendMsg.hero = {}
  sendMsg.win = win
  for k,v in pairs(playerRoleSettle) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R11 in 'UnsetPending'

    (sendMsg.hero)[k] = v.hpPer
  end
  ;
  ((self.bdCtrl).battleNetwork):CS_BATTLE_BattleSettle(sendMsg, function(dataList)
    -- function num : 0_8_0 , upvalues : win, _ENV, battleEndState, self
    if not win then
      UIManager:ShowWindowAsync(UIWindowTypeID.DungeonFailureResult, function(window)
      -- function num : 0_8_0_0 , upvalues : battleEndState, self
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
  -- function num : 0_9 , upvalues : _ENV, util
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
    -- function num : 0_9_0 , upvalues : CS_CameraController_Ins, battleController, mvpGrade, self, _ENV, battleEndState, resultData
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
    UIManager:ShowWindowAsync(UIWindowTypeID.DungeonResult, function(window)
      -- function num : 0_9_0_0 , upvalues : self, resultData, mvpGrade, battleEndState
      if window == nil then
        return 
      end
      window:CompleteDungeon(((self.bdCtrl).objectCtrl).rewardMsg, resultData, mvpGrade, (self.battleRoomData).dungeonType, (self.bdCtrl).ATHRewardInfo, (self.bdCtrl).hasDailyDouble)
      window:SetContinueCallback(function()
        -- function num : 0_9_0_0_0 , upvalues : battleEndState, self
        battleEndState:EndBattleAndClear()
        ;
        (self.bdCtrl):ExitBattleDungeon(true)
      end
)
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
    local chipData = (ChipData.New)(v, 1)
    rewardChipList[k] = chipData
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.SelectChip, function(window)
    -- function num : 0_12_0 , upvalues : _ENV, rewardChipList, self
    if window == nil then
      return 
    end
    MsgCenter:Broadcast(eMsgEventId.OnSettleMentTimeLinePlayToEnd)
    window:InitSelectChip(rewardChipList, (self.bdCtrl).dynPlayer, BindCallback(self, self.__SelectChipComplete), false)
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

BattleDungeonBattleCtrl.ReqGiveUpBattle = function(self, battleController)
  -- function num : 0_14 , upvalues : _ENV
  (battleController.fsm):ChangeState((CS.eBattleState).End)
  ;
  ((battleController.fsm).currentState):EndBattleAndClear()
  ;
  ((self.bdCtrl).battleNetwork):CS_BATTLE_Quit(function()
    -- function num : 0_14_0 , upvalues : _ENV
    BattleDungeonManager:ExitDungeon()
  end
)
end

BattleDungeonBattleCtrl.OnDelete = function(self)
  -- function num : 0_15 , upvalues : _ENV, DungeonConst, DungeonBattleBaseCtrl
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

