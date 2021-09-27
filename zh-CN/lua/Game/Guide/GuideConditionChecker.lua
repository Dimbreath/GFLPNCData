local GuideConditionChecker = {}
local CS_GSceneManager_Ins = (CS.GSceneManager).Instance
local GuideEnum = require("Game.Guide.GuideEnum")
local HomeEnum = require("Game.Home.HomeEnum")
local guideCheckFunc = {[eGuideCondition.None] = function()
  -- function num : 0_0
  return true
end
, [eGuideCondition.InHome] = function(condition_arg)
  -- function num : 0_1 , upvalues : _ENV, HomeEnum
  local homeController = ControllerManager:GetController(ControllerTypeId.HomeController, true)
  if homeController.homeState ~= (HomeEnum.eHomeState).Normal then
    return false
  end
  do
    if #condition_arg == 1 and condition_arg[1] == 1 then
      local hasHasUncompletedEp, stageId, moduleId = ExplorationManager:HasUncompletedEp()
      if not hasHasUncompletedEp then
        return false
      end
    end
    return true
  end
end
, [eGuideCondition.InExploration] = function()
  -- function num : 0_2 , upvalues : _ENV
  return ExplorationManager:IsInExplorationAndScene()
end
, [eGuideCondition.InEpRoomOutside] = function(condition_arg)
  -- function num : 0_3 , upvalues : _ENV
  local inExplorationScene = not ExplorationManager:IsInExplorationAndScene() or ((ExplorationManager.epCtrl).sceneCtrl):InBattleScene() == false
  if not inExplorationScene then
    return false
  end
  if (ExplorationManager.epCtrl).autoCtrl ~= nil and ((ExplorationManager.epCtrl).autoCtrl):IsAutoModeRunning() then
    return false
  end
  if #condition_arg == 0 then
    return true
  end
  if condition_arg[1] > 0 and condition_arg[1] ~= ExplorationManager:GetCurExplorationId() then
    return false
  end
  do
    if condition_arg[2] ~= nil and condition_arg[2] == 1 then
      local explorationWindow = UIManager:GetWindow(UIWindowTypeID.Exploration)
      if explorationWindow == nil or not explorationWindow:IsShowAutoEpBtn() then
        return false
      end
    end
    do return true end
    -- DECOMPILER ERROR: 8 unprocessed JMP targets
  end
end
, [eGuideCondition.InBattleDeploy] = function()
  -- function num : 0_4 , upvalues : _ENV
  if ExplorationManager:IsInExplorationAndScene() then
    return ((ExplorationManager.epCtrl).battleCtrl):IsBattleState(eBattleState.Deploy)
  end
end
, [eGuideCondition.InSelectChip] = function()
  -- function num : 0_5 , upvalues : _ENV
  do return UIManager:GetWindow(UIWindowTypeID.SelectChip) ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
, [eGuideCondition.InBattleScene] = function()
  -- function num : 0_6 , upvalues : _ENV
  if ExplorationManager:IsInExplorationAndScene() then
    return ((ExplorationManager.epCtrl).sceneCtrl):InBattleScene()
  end
end
, [eGuideCondition.InEpTreasureRoom] = function()
  -- function num : 0_7 , upvalues : _ENV
  do return UIManager:GetWindow(UIWindowTypeID.EpTreasureRoom) ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
, [eGuideCondition.InEpEventRoom] = function()
  -- function num : 0_8 , upvalues : _ENV
  do return UIManager:GetWindow(UIWindowTypeID.EpEventRoom) ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
, [eGuideCondition.InSectorLevel] = function(condition_arg)
  -- function num : 0_9 , upvalues : _ENV
  local sectorLevelWindow = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
  if sectorLevelWindow == nil or sectorLevelWindow.active == false then
    return false
  end
  do
    if #condition_arg == 1 then
      local arg = condition_arg[1]
      if arg == 1 then
        if ExplorationManager:HasUncompletedEp() then
          return false
        end
        if (PlayerDataCenter.sectorStage).lastSatgeData ~= nil and not ((PlayerDataCenter.sectorStage).lastSatgeData).isWin then
          return false
        end
      end
    end
    do return ControllerManager:GetController(ControllerTypeId.Avg) == nil end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
end
, [eGuideCondition.InOassisBuildingDetail] = function()
  -- function num : 0_10 , upvalues : _ENV
  local oasisWindow = UIManager:GetWindow(UIWindowTypeID.OasisMain)
  if oasisWindow == nil then
    return false
  end
  local oasisCtrl = ControllerManager:GetController(ControllerTypeId.OasisController)
  return oasisCtrl:IsOasisNormalState()
end
, [eGuideCondition.InFormation] = function(condition_arg)
  -- function num : 0_11 , upvalues : _ENV
  if not UIManager:IsMainCameraEnable() then
    return false
  end
  if UIManager:GetWindow(UIWindowTypeID.SelectSupportList) ~= nil then
    return false
  end
  local formationWindow = UIManager:GetWindow(UIWindowTypeID.Formation)
  if formationWindow == nil then
    return false
  end
  local formationCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
  if formationCtrl == nil then
    return false
  end
  if #condition_arg == 0 then
    return true
  end
  local fromModule, moduleArg = formationCtrl:GetFormatioFromModule()
  if condition_arg[1] ~= fromModule then
    return false
  end
  if #condition_arg > 1 and condition_arg[2] ~= moduleArg then
    return false
  end
  return true
end
, [eGuideCondition.InSectorSceneNormal] = function(condition_arg)
  -- function num : 0_12 , upvalues : _ENV
  local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  if sectorCtrl == nil or not sectorCtrl:IsSectorNormalState() then
    return false
  end
  if #condition_arg > 0 and condition_arg[1] == 1 then
    local dungeonDyncElem = (PlayerDataCenter.dungeonDyncData):GetDailyDungeonDyncData()
    local isNew = dungeonDyncElem.isDailyDungeonNew
    return isNew
  end
  do
    return true
  end
end
, [eGuideCondition.InMainScene] = function()
  -- function num : 0_13 , upvalues : CS_GSceneManager_Ins, _ENV
  local sceneName = CS_GSceneManager_Ins.curSceneName
  do return sceneName == (Consts.SceneName).Main end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
, [eGuideCondition.InHeroStateUI] = function()
  -- function num : 0_14 , upvalues : _ENV
  if UIManager:GetWindow(UIWindowTypeID.HeroState) == nil then
    return false
  end
  if ((CS.BattleManager).Instance).IsInBattle then
    return false
  end
  return true
end
, [eGuideCondition.InNewMonsterDetail] = function()
  -- function num : 0_15 , upvalues : _ENV
  if ExplorationManager:IsInExplorationAndScene() then
    local inBattleDeploy = ((ExplorationManager.epCtrl).battleCtrl):IsBattleState(eBattleState.Deploy)
  end
  if not inBattleDeploy then
    return false
  end
  do return ((ExplorationManager.epCtrl).battleCtrl).hasNewEnemyDetail == true end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
, [eGuideCondition.InEpBattleResult] = function()
  -- function num : 0_16 , upvalues : _ENV
  do return UIManager:GetWindow(UIWindowTypeID.BattleResult) ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
, [eGuideCondition.InLottery] = function()
  -- function num : 0_17 , upvalues : _ENV
  local lotteryCtrl = ControllerManager:GetController(ControllerTypeId.Lottery)
  do return (lotteryCtrl ~= nil and lotteryCtrl:IsLotteryNormalState()) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end
, [eGuideCondition.InATHRefactor] = function()
  -- function num : 0_18 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.AthRefactor)
  do return (window ~= nil and window.active) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end
, [eGuideCondition.AfterEpCrossRoom] = function()
  -- function num : 0_19 , upvalues : _ENV
  if not ExplorationManager:IsInExplorationAndScene() then
    return false
  end
  if ExplorationManager:GetIsInWeeklyChallenge() then
    return false
  end
  local roomData = (ExplorationManager.epCtrl):GetCurrentRoomData()
  do return (roomData ~= nil and roomData:IsCrossRoom()) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end
, [eGuideCondition.InEpRewardBagSettle] = function()
  -- function num : 0_20 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.EpRewardBag)
  do return (window ~= nil and window.active) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end
, [eGuideCondition.InHeroPotential] = function()
  -- function num : 0_21 , upvalues : _ENV
  local window = UIManager:GetWindow(UIWindowTypeID.HeroPotential)
  do return window ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
, [eGuideCondition.InEpResultFail] = function()
  -- function num : 0_22 , upvalues : _ENV
  local resultWindow = UIManager:GetWindow(UIWindowTypeID.ExplorationResult)
  if resultWindow == nil then
    return false
  end
  return resultWindow:IsEpResultType((resultWindow.EpResultType).Fail)
end
, [eGuideCondition.InEpStoreRoom] = function()
  -- function num : 0_23 , upvalues : _ENV
  local epStoreWindow = UIManager:GetWindow(UIWindowTypeID.EpStoreRoom)
  do return epStoreWindow ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
, [eGuideCondition.InFormationSpecial] = function(condition_arg)
  -- function num : 0_24 , upvalues : _ENV
  if not UIManager:IsMainCameraEnable() then
    return false
  end
  if UIManager:GetWindow(UIWindowTypeID.SelectSupportList) ~= nil then
    return false
  end
  local fmtWindow = UIManager:GetWindow(UIWindowTypeID.Formation)
  if fmtWindow == nil then
    return false
  end
  if #condition_arg > 0 and condition_arg[1] == 1 then
    local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
    if fmtCtrl == nil then
      return false
    end
    local ui3dFmt = (fmtCtrl.fmtSceneCtrl):Get3DUIFormation()
    if ui3dFmt == nil then
      return false
    end
    local platformDic = ui3dFmt:GetPlotformItemDic()
    for index,platItem in pairs(platformDic) do
      if platItem:IsAbleQuickLevelup() then
        return true
      end
    end
    return false
  end
  do
    for k,heroInfoItem in pairs(fmtWindow.heroInfoDic) do
      if heroInfoItem:FmtHeroAblePotential() then
        return true
      end
    end
    return false
  end
end
, [eGuideCondition.InLotteryFragChanged] = function()
  -- function num : 0_25 , upvalues : _ENV
  local lotteryResultWindow = UIManager:GetWindow(UIWindowTypeID.LotteryResult)
  if lotteryResultWindow == nil then
    return false
  end
  return lotteryResultWindow:IsLotteryFragChanged()
end
, [eGuideCondition.FInHome] = function()
  -- function num : 0_26 , upvalues : _ENV
  local home = UIManager:GetWindow(UIWindowTypeID.Home)
  do return home ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
, [eGuideCondition.FInSectorScene] = function()
  -- function num : 0_27 , upvalues : _ENV
  local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  do return sectorCtrl ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
, [eGuideCondition.FInSectorLevel] = function()
  -- function num : 0_28 , upvalues : _ENV
  do return UIManager:GetWindow(UIWindowTypeID.SectorLevel) ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
}
GuideConditionChecker.CheckGuideCondition = function(condition_type, condition_arg)
  -- function num : 0_29 , upvalues : guideCheckFunc
  local checkFunc = guideCheckFunc[condition_type]
  if checkFunc ~= nil then
    return checkFunc(condition_arg)
  else
    return false
  end
end

local guideTriggerCheckFunc = {[(GuideEnum.TriggerGuideCondition).FuncUnlock] = function(condition_arg)
  -- function num : 0_30 , upvalues : _ENV
  return FunctionUnlockMgr:ValidateUnlock(condition_arg)
end
, [(GuideEnum.TriggerGuideCondition).HasItem] = function(condition_arg)
  -- function num : 0_31 , upvalues : _ENV
  local result = condition_arg[2] <= PlayerDataCenter:GetItemCount(condition_arg[1])
  do return result end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
, [(GuideEnum.TriggerGuideCondition).SectorStage] = function(condition_arg)
  -- function num : 0_32 , upvalues : _ENV
  return (PlayerDataCenter.sectorStage):IsStageComplete(condition_arg)
end
, [(GuideEnum.TriggerGuideCondition).HeroLevelGreater] = function(condition_arg)
  -- function num : 0_33 , upvalues : _ENV
  local heroData = (PlayerDataCenter.heroDic)[condition_arg[1]]
  if heroData == nil then
    return false
  end
  do return condition_arg[2] <= heroData.level end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
, [(GuideEnum.TriggerGuideCondition).InExploration] = function(condition_arg)
  -- function num : 0_34 , upvalues : _ENV
  if not ExplorationManager:IsInExplorationAndScene() then
    return false
  end
  local dungeonId = condition_arg[1]
  do return ExplorationManager:GetEpDungeonId() == dungeonId end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
, [(GuideEnum.TriggerGuideCondition).BattleBenchHasRole] = function(condition_arg)
  -- function num : 0_35 , upvalues : _ENV
  if not ExplorationManager:IsInExplorationAndScene() then
    return false
  end
  local battleMgr = (CS.BattleManager).Instance
  if not battleMgr.IsInBattle then
    return 
  end
  return ((battleMgr.CurBattleController).battleFieldData):IsHasBenchRole()
end
}
GuideConditionChecker.CheckTriggerGuideCondition = function(condition_type, condition_arg)
  -- function num : 0_36 , upvalues : _ENV, guideTriggerCheckFunc
  for index,ctype in pairs(condition_type) do
    if not (guideTriggerCheckFunc[ctype])(condition_arg[index]) then
      return false
    end
  end
  return true
end

return GuideConditionChecker

