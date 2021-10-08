local DungeonBattleBaseCtrl = require("Game.Common.CommonGameCtrl.DungeonBattleBaseCtrl")
local BattleDungeonBattleCtrl = class("BattleDungeonBattleCtrl", DungeonBattleBaseCtrl)
local base = DungeonBattleBaseCtrl
local DungeonConst = require("Game.BattleDungeon.DungeonConst")
local DungeonBattleRoom = require("Game.BattleDungeon.Data.DungeonBattleRoom")
local ChipData = require("Game.PlayerData.Item.ChipData")
local JumpManager = require("Game.Jump.JumpManager")
local util = require("XLua.Common.xlua_util")
local cs_BattleStatistics = (CS.BattleStatistics).Instance
local eDungeonEnum = require("Game.Dungeon.eDungeonEnum")
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
  local monsterRoleSettle = requestData.monsterRoleSettle
  local battlePlayerController = battleCtrl.PlayerController
  local sendMsg = {}
  sendMsg.hero = {}
  sendMsg.monster = {}
  sendMsg.win = win
  sendMsg.misc = {}
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (sendMsg.misc).totalFrame = battleCtrl.frame
  local score = {}
  for k,v in pairs(requestData.gameScore) do
    score[k] = v
  end
  sendMsg.valid = {}
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R10 in 'UnsetPending'

  ;
  (sendMsg.valid).score = score
  local isInTdMode = (BattleUtil.IsInTDBattle)()
  if isInTdMode then
    sendMsg.tdHeroCoord = {}
    sendMsg.tdHpPer = ((self.bdCtrl).dynPlayer).dungeonRoleHpPerDic
  end
  for k,v in pairs(playerRoleSettle) do
    v.hpPer = (BattleUtil.ReCalculateCharacterHpPer)(v.role)
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R16 in 'UnsetPending'

    ;
    (sendMsg.hero)[k] = v.hpPer
    local role = v.role
    if isInTdMode then
      local coord = self:__UpdatePlayerPosOnTDSettle(role.roleDataId, role.x, role.y)
      -- DECOMPILER ERROR at PC63: Confused about usage of register: R18 in 'UnsetPending'

      if coord ~= nil then
        (sendMsg.tdHeroCoord)[k] = coord
      end
    end
  end
  for k,v in pairs(monsterRoleSettle) do
    v.hpPer = (BattleUtil.ReCalculateCharacterHpPer)(v.role)
    -- DECOMPILER ERROR at PC77: Confused about usage of register: R16 in 'UnsetPending'

    ;
    (sendMsg.monster)[k] = v.hpPer
  end
  sendMsg.hmp = ((self.bdCtrl).dynPlayer).playerUltSkillMp
  sendMsg.mp = ((self.bdCtrl).dynPlayer).playerSkillMp
  sendMsg.tdmp = ((self.bdCtrl).dynPlayer).playerTDMp or 0
  -- DECOMPILER ERROR at PC100: Confused about usage of register: R11 in 'UnsetPending'

  ;
  (sendMsg.misc).inputData = (DungeonBattleBaseCtrl.StoreInputCmdToSettleMsg)(self, battlePlayerController)
  -- DECOMPILER ERROR at PC105: Confused about usage of register: R11 in 'UnsetPending'

  ;
  (sendMsg.valid).activeAlgConsume = self:GetBattleConsumeSkillChipUseTimeDic(battlePlayerController)
  ;
  ((self.bdCtrl).battleNetwork):CS_BATTLE_BattleSettle(sendMsg, function(dataList)
    -- function num : 0_8_0 , upvalues : win, _ENV, self, battleEndState
    if not win then
      if (BattleUtil.IsInDailyDungeon)() then
        self:_DailyDungeonFail(battleEndState)
      else
        self:_NormalDungeonFail(battleEndState)
      end
    end
    ;
    (self.bdCtrl):StartRunNextLogic()
    self.__waitSettleResult = false
  end
)
end

BattleDungeonBattleCtrl._NormalDungeonFail = function(self, battleEndState)
  -- function num : 0_9 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonFailureResult, function(window)
    -- function num : 0_9_0 , upvalues : battleEndState, self, _ENV
    if window == nil then
      return 
    end
    window:FailExploration(function()
      -- function num : 0_9_0_0 , upvalues : battleEndState
      battleEndState:EndBattleAndClear()
    end
, function()
      -- function num : 0_9_0_1 , upvalues : self
      (self.bdCtrl):ExitBattleDungeon(false)
    end
, function()
      -- function num : 0_9_0_2 , upvalues : window, _ENV, battleEndState
      window:Hide()
      UIManager:ShowWindowAsync(UIWindowTypeID.ResultSkada, function(SkadaWindow)
        -- function num : 0_9_0_2_0 , upvalues : _ENV, battleEndState, window
        if SkadaWindow == nil then
          return 
        end
        SkadaWindow:InitBattleSkada((CS.BattleStatistics).Instance, ((battleEndState.battleController).PlayerTeamController).battleOriginRoleList, ((battleEndState.battleController).EnemyTeamController).battleOriginRoleList)
        SkadaWindow:SetSkadaCloseCallback(function()
          -- function num : 0_9_0_2_0_0 , upvalues : window
          window:Show()
        end
)
      end
)
    end
)
    ;
    (BattleDungeonManager.autoCtrl):ExitDungeonAutoModel()
  end
)
end

BattleDungeonBattleCtrl._DailyDungeonFail = function(self, battleEndState)
  -- function num : 0_10 , upvalues : _ENV, cs_BattleStatistics
  UIManager:ShowWindowAsync(UIWindowTypeID.BattleFail, function(win)
    -- function num : 0_10_0 , upvalues : battleEndState, self, _ENV, cs_BattleStatistics
    win:InitBattleFail(function()
      -- function num : 0_10_0_0 , upvalues : battleEndState, self
      battleEndState:EndBattleAndClear()
      ;
      (self.bdCtrl):ExitBattleDungeon(false)
    end
, function()
      -- function num : 0_10_0_1 , upvalues : battleEndState, _ENV, self
      battleEndState:EndBattleAndClear()
      local dailyDgCtrl = ControllerManager:GetController(ControllerTypeId.DailyDungeonLevelCtrl, true)
      dailyDgCtrl:ReqEnterDailyDungeon((self.bdCtrl).dungeonId)
    end
, function()
      -- function num : 0_10_0_2 , upvalues : win, _ENV, cs_BattleStatistics, battleEndState
      win:Hide()
      UIManager:ShowWindowAsync(UIWindowTypeID.ResultSkada, function(SkadaWindow)
        -- function num : 0_10_0_2_0 , upvalues : cs_BattleStatistics, battleEndState, win
        if SkadaWindow == nil then
          return 
        end
        SkadaWindow:InitBattleSkada(cs_BattleStatistics, ((battleEndState.battleController).PlayerTeamController).battleOriginRoleList, ((battleEndState.battleController).EnemyTeamController).battleOriginRoleList)
        SkadaWindow:SetSkadaCloseCallback(function()
          -- function num : 0_10_0_2_0_0 , upvalues : win
          win:Show()
        end
)
      end
)
    end
)
    ;
    (BattleDungeonManager.autoCtrl):ExitDungeonAutoModel()
  end
)
end

BattleDungeonBattleCtrl.VictoryBattleEndCoroutine = function(self, battleEndState)
  -- function num : 0_11 , upvalues : _ENV, util
  local wave = ((self.bdCtrl).sceneCtrl).sceneWave
  local battleController = battleEndState.battleController
  if wave.total ~= wave.cur then
    battleController:PlayRecycleRoleEffect()
    battleEndState:EndBattleAndClear()
    return 
  end
  local CS_CameraController_Ins = (CS.CameraController).Instance
  self.__settleTimelinePause = false
  self.__showResultUI = false
  local playerRoleList = (battleController.PlayerTeamController).battleOriginRoleList
  local enemyRoleList = (battleController.EnemyTeamController).battleOriginRoleList
  local mvpGrade = (BattleUtil.GenMvp)(playerRoleList)
  local resultData = {playerRoleList = playerRoleList, enemyRoleList = enemyRoleList, 
lastHeroList = {}
}
  local dungeonPlayer = battleController.PlayerData
  for _,dynHero in ipairs(dungeonPlayer.heroList) do
    local lastHeroData = {}
    lastHeroData.exp = dynHero:GetCurExp()
    lastHeroData.level = dynHero:GetLevel()
    lastHeroData.totalExp = dynHero:GetTotalExp()
    ;
    (table.insert)(resultData.lastHeroList, lastHeroData)
  end
  local battleEndCoroutine = function()
    -- function num : 0_11_0 , upvalues : _ENV, CS_CameraController_Ins, battleController, mvpGrade, self, battleEndState, playerRoleList, resultData
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
    self.battleEndState = battleEndState
    if ((self.bdCtrl).objectCtrl).dontShowResult then
      (self.bdCtrl):ExitBattleDungeon(true)
      return 
    end
    local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
    cvCtr:PlayCv((mvpGrade.role).roleDataId, ConfigData:GetVoicePointRandom(5))
    self:PlayWinEffect(mvpGrade.role)
    for key,role in pairs(playerRoleList) do
      local roleActionComponent = role:GetActionComponent()
      if roleActionComponent then
        roleActionComponent:OnWin()
      end
    end
    local isAuto, isEndAoto = (BattleDungeonManager.autoCtrl):RecordAndCheckAutoState()
    local StOCareerItemIdDic = {}
    for _,itemId in ipairs((ConfigData.game_config).STOCareerCostIds) do
      StOCareerItemIdDic[itemId] = true
    end
    local showRewards = {}
    local extraReward = {}
    local AddItemFunc = function(resourceDic)
      -- function num : 0_11_0_0 , upvalues : _ENV, StOCareerItemIdDic, showRewards, extraReward
      for id,count in pairs(resourceDic) do
        local dic = StOCareerItemIdDic[id] == nil and showRewards or extraReward
        local newCount = dic[id] or 0
        dic[id] = newCount + count
      end
    end

    local resMsg = ((self.bdCtrl).objectCtrl).rewardMsg
    AddItemFunc(resMsg.innerRewards)
    AddItemFunc(resMsg.firstClear)
    AddItemFunc(resMsg.overRewards)
    local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment, true)
    if (table.count)(extraReward) > 0 then
      aftertTeatmentCtrl:AddShowReward(extraReward)
    end
    do
      if isAuto then
        local dungeonStageData = BattleDungeonManager:GetCureentDungeonStageData()
        aftertTeatmentCtrl:AddDungeonAutoFightReward(showRewards, (((self.bdCtrl).objectCtrl).rewardMsg).getATH, dungeonStageData ~= nil and dungeonStageData:GetDungeonStageCfg() or nil, (BattleDungeonManager.autoCtrl):GetBattleCount())
      end
      UIManager:ShowWindowAsync(UIWindowTypeID.DungeonResult, function(window)
      -- function num : 0_11_0_1 , upvalues : _ENV, self, showRewards, resultData, mvpGrade, resMsg, isAuto
      if window == nil then
        return 
      end
      local isGuide = BattleDungeonManager:GetIsGuide()
      window:CompleteDungeon(isGuide, ((self.bdCtrl).objectCtrl).rewardMsg, showRewards, resultData, mvpGrade, (self.battleRoomData).dungeonType)
      local winEvent = BattleDungeonManager:GetBattleWinEvent()
      if (BattleDungeonManager.dungeonCtrl).enterMsgData == nil or ((BattleDungeonManager.dungeonCtrl).enterMsgData).ab == nil then
        do
          local hasSupport = winEvent == nil
          BattleDungeonManager:ClearBattleWinEvent()
          winEvent(hasSupport)
          if not self.__ExitBattleDungeon then
            self.__ExitBattleDungeon = BindCallback(self, self.ExitBattleDungeon)
            if not self.__BattleDungeonAgain then
              self.__BattleDungeonAgain = BindCallback(self, self.BattleDungeonAgain)
              if not self.__CheckCanAutoAgain then
                self.__CheckCanAutoAgain = BindCallback(self, self.CheckCanAutoAgain)
                window:SetContinueCallback(self.__ExitBattleDungeon)
                if not isGuide then
                  window:SetPlayeAgain(self.__BattleDungeonAgain, BattleDungeonManager.dungeonStageData)
                end
                if (table.count)(resMsg.extraRewards) > 0 then
                  UIManager:ShowWindowAsync(UIWindowTypeID.BattleResultExtra, function(resultExtraWindow)
        -- function num : 0_11_0_1_0 , upvalues : _ENV, resMsg
        if resultExtraWindow == nil then
          return 
        end
        if UIManager:GetWindow(UIWindowTypeID.DungeonResult) == nil then
          UIManager:DeleteWindow(UIWindowTypeID.BattleResultExtra)
          return 
        end
        resultExtraWindow:InitBattleResultExtra(resMsg.extraRewards)
      end
)
                end
                if isAuto then
                  local battleCount = (BattleDungeonManager.autoCtrl):GetBattleCount()
                  local totalCount = (BattleDungeonManager.autoCtrl):GetTotalDungeonAutoCount()
                  ;
                  (BattleDungeonManager.autoCtrl):OnEnterBattleResult(self.__BattleDungeonAgain, self.__ExitBattleDungeon, self.__CheckCanAutoAgain)
                  window:InitAutoModeShow(battleCount, totalCount)
                end
                -- DECOMPILER ERROR: 8 unprocessed JMP targets
              end
            end
          end
        end
      end
    end
)
    end
  end

  return (util.cs_generator)(battleEndCoroutine)
end

BattleDungeonBattleCtrl.OnTimelineNoticeOpenResultUI = function(self)
  -- function num : 0_12 , upvalues : _ENV
  self.__showResultUI = true
  if self.__waitSettleResult then
    ((CS.CameraController).Instance):PauseSettlementCut(true)
    self.__settleTimelinePause = true
  end
end

BattleDungeonBattleCtrl.ReqBattleFreshFormation = function(self, battleController)
  -- function num : 0_13
end

BattleDungeonBattleCtrl.DungeonChipStepLogic = function(self, chipDataGroup)
  -- function num : 0_14 , upvalues : _ENV, ChipData
  local rewardChipList = {}
  for k,v in ipairs(chipDataGroup.alg) do
    local chipData = (ChipData.NewChipForServer)(v)
    rewardChipList[k] = chipData
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.SelectChip, function(window)
    -- function num : 0_14_0 , upvalues : _ENV, rewardChipList, self
    if window == nil then
      return 
    end
    MsgCenter:Broadcast(eMsgEventId.OnSettleMentTimeLinePlayToEnd)
    window:InitSelectChip(false, rewardChipList, (self.bdCtrl).dynPlayer, BindCallback(self, self.__SelectChipComplete), BindCallback(self, self.__GiveSelectChipComplect), false, nil)
  end
)
end

BattleDungeonBattleCtrl.__SelectChipComplete = function(self, index, selectComplete)
  -- function num : 0_15
  index = index - 1
  ;
  ((self.bdCtrl).battleNetwork):CS_BATTLE_AlgSelect(index, function(dataList)
    -- function num : 0_15_0 , upvalues : self, selectComplete
    (self.bdCtrl):StartRunNextLogic()
    if selectComplete ~= nil then
      selectComplete()
    end
  end
)
end

BattleDungeonBattleCtrl.__GiveSelectChipComplect = function(self, selectComplete)
  -- function num : 0_16
  (self.epNetwork):CS_BATTLE_AlgGiveUp(function()
    -- function num : 0_16_0 , upvalues : selectComplete
    if selectComplete ~= nil then
      selectComplete()
    end
  end
)
end

BattleDungeonBattleCtrl.ReqGiveUpBattle = function(self, battleController)
  -- function num : 0_17 , upvalues : _ENV
  (battleController.fsm):ChangeState((CS.eBattleState).End)
  ;
  ((battleController.fsm).currentState):EndBattleAndClear()
  ;
  ((self.bdCtrl).battleNetwork):CS_BATTLE_Quit(function()
    -- function num : 0_17_0 , upvalues : _ENV
    BattleDungeonManager:ExitDungeon()
  end
)
end

BattleDungeonBattleCtrl.BattleDungeonAgain = function(self)
  -- function num : 0_18 , upvalues : _ENV, JumpManager
  if (PlayerDataCenter.stamina):GetCurrentStamina() < (BattleDungeonManager.dungeonStageData):GetStaminaCost() then
    JumpManager:Jump((JumpManager.eJumpTarget).BuyStamina)
    return 
  end
  if self.battleEndState ~= nil then
    (self.battleEndState):EndBattleAndClear()
  end
  if BattleDungeonManager.battleRestartEvent ~= nil then
    local formation = BattleDungeonManager:GetFormation()
    ;
    (BattleDungeonManager.battleRestartEvent)(formation)
  end
end

BattleDungeonBattleCtrl.CheckCanAutoAgain = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local dungeonStageData = BattleDungeonManager:GetCureentDungeonStageData()
  if #(PlayerDataCenter.allAthData):GetAllAthList() >= (ConfigData.game_config).athMaxNum - (ConfigData.game_config).athSpaceNotEnoughNum then
    do
      local canContinue = dungeonStageData == nil or not dungeonStageData:IsHaveATHReward()
      do return canContinue, ConfigData:GetTipContent(145) end
      do return true end
      -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
  end
end

BattleDungeonBattleCtrl.ExitBattleDungeon = function(self)
  -- function num : 0_20
  if self.battleEndState ~= nil then
    (self.battleEndState):EndBattleAndClear()
  end
  ;
  (self.bdCtrl):ExitBattleDungeon(true, true)
end

BattleDungeonBattleCtrl.OnDelete = function(self)
  -- function num : 0_21 , upvalues : _ENV, DungeonConst, DungeonBattleBaseCtrl
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

