local UIBattle = class("UIBattle", UIBaseWindow)
local base = UIBaseWindow
local cs_MessageCommon = CS.MessageCommon
local UINGamePlayScore = require("Game.Battle.UI.UINGamePlayScore")
local FmtEnum = require("Game.Formation.FmtEnum")
local UINBtnCommanderSkill = require("Game.Formation.UI.UINBtnCommanderSkill")
local util = require("XLua.Common.xlua_util")
local UINBattleDeployChipEft = require("Game.Battle.UI.UINBattleDeployChipEft")
local BattleUtil = require("Game.Battle.BattleUtil")
UIBattle.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINGamePlayScore, BattleUtil, UINBtnCommanderSkill, UINBattleDeployChipEft
  self.resLoader = ((CS.ResLoader).Create)()
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Pause, self, self.__OnClickPause)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SpeedUP, self, self.__OnClickSpeedUP)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_BattleStart, self, self.__OnClickBattleStart)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Back, self, self.__OnClickBreakDeploy)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Auto, self, self.__OnAutoBattleClick)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CampBondSkill, self, self.__OnClickCampFetter)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Retreat, self, self.__OnClickRetreat)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Formation, self, self.__OnClickEnterFmt)
  self.isSpeedUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_PlaySpeed)
  self.isAutoBattleUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_AutoBattle)
  self.gameplayScore = (UINGamePlayScore.New)()
  ;
  (self.gameplayScore):Init((self.ui).gamePlayScore)
  self.__haveOverclock = false
  local isInExploration = ExplorationManager:IsInExploration()
  ;
  (((self.ui).obj_currLevel).gameObject):SetActive(isInExploration)
  -- DECOMPILER ERROR at PC108: Confused about usage of register: R2 in 'UnsetPending'

  if isInExploration then
    ((self.ui).tex_Level).text = tostring(ExplorationManager:GetCurLevelIndex() + 1) .. "/" .. tostring(ExplorationManager:GetLevelCount())
    if ((ExplorationManager.epCtrl).overclockCtrl):IsLevelHasOverclock() then
      (((self.ui).btn_Overclock).gameObject):SetActive(true)
      self.__haveOverclock = true
      ;
      (UIUtil.AddButtonListener)((self.ui).btn_Overclock, self, self.OnBtnOverclockClicked)
    end
    if ExplorationManager:IsSectorNewbee() then
      self.isAutoBattleUnlock = false
    end
  end
  if (BattleUtil.IsInTDBattle)() then
    self.isAutoBattleUnlock = false
  end
  self.btnCstItem = (UINBtnCommanderSkill.New)()
  ;
  (self.btnCstItem):Init((self.ui).btn_CommanderSkill)
  self.__OnClickCstItem = BindCallback(self, self.OnClickCstItem)
  ;
  (self.btnCstItem):InitBtnCommanderSkill(self.resLoader, self.__OnClickCstItem)
  self.__OnSendCstChange = BindCallback(self, self.OnSendCstChange)
  self.deployChipEftPool = (UIItemPool.New)(UINBattleDeployChipEft, (self.ui).obj_ChipEft)
  ;
  ((self.ui).obj_ChipEft):SetActive(false)
  self.isShowingHeroInfo = false
  local isEnemyDetailUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_EnemyDetail)
  self:OnEnemyDetailUnlock(isEnemyDetailUnlock)
  self._isTempAuto = false
end

UIBattle.InitUIBattle = function(self, breakBattleFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.breakBattleFunc = breakBattleFunc
  local isUnlockBattleExit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleExit)
  if not isUnlockBattleExit then
    (((self.ui).btn_Retreat).gameObject):SetActive(false)
  end
  self.cs_battleCtrl = ((CS.BattleManager).Instance).CurBattleController
end

UIBattle.InitUIBattleDeploy = function(self, onlyDeploy, startBattleFunc, savaDeployFunc, getDeployAliveRoleCount, heroList)
  -- function num : 0_2 , upvalues : _ENV
  self.startBattleFunc = startBattleFunc
  self.savaDeployFunc = savaDeployFunc
  self.getDeployAliveRoleCount = getDeployAliveRoleCount
  self.deployCsHeroList = heroList
  ;
  (((self.ui).btn_Back).gameObject):SetActive(onlyDeploy)
  self:__SwitchUIState(false)
  if onlyDeploy then
    (((self.ui).btn_BattleStart).gameObject):SetActive(false)
  end
  ;
  (((self.ui).btn_SpeedUP).gameObject):SetActive(self.isSpeedUnlock)
  local speedIndex = 1
  if PlayerDataCenter.playerId > 0 then
    self._userDataCfg = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
    if self._userDataCfg ~= nil then
      speedIndex = (self._userDataCfg):GetBattleSpeed()
    end
  end
  self.curSpeedIndex = speedIndex
  ;
  ((self.ui).img_Speed):SetIndex(self.curSpeedIndex - 1)
  ;
  ((self.ui).tex_Speed):SetIndex(self.curSpeedIndex - 1)
  ;
  (((self.ui).tog_Auto).gameObject):SetActive(self.isAutoBattleUnlock)
  local autoBattle = self._userDataCfg and (self._userDataCfg):GetIsAutoBattle() or false
  if not autoBattle then
    if BattleDungeonManager:InBattleDungeon() then
      autoBattle = (BattleDungeonManager.autoCtrl):IsEnbaleDungeonAutoMode()
    end
    if autoBattle then
      self._isTempAuto = true
    end
  end
  -- DECOMPILER ERROR at PC96: Confused about usage of register: R8 in 'UnsetPending'

  if self.isAutoBattleUnlock and autoBattle then
    ((self.ui).tog_Auto).isOn = true
  else
    -- DECOMPILER ERROR at PC100: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((self.ui).tog_Auto).isOn = false
  end
  self._isTempAuto = nil
  self:TryShowCstChange()
  self:StartChipEft()
  self:TryRefreshAutoInfo()
end

UIBattle.InitUIBattleRunning = function(self, pauseFunc, speedUpFunc, autoBattleFunc, autoBattleUltFunc, autoBattleUltMaxEnergyFunc)
  -- function num : 0_3
  self.pauseFunc = pauseFunc
  self.speedUpFunc = speedUpFunc
  self.autoBattleFunc = autoBattleFunc
  self.autoUltFunc = autoBattleUltFunc
  self.autoUltMaxEnergy = autoBattleUltMaxEnergyFunc
  self:OnSpeedUpChange(((self.ui).speedArray)[self.curSpeedIndex])
  self:OnAutoBattleChange(((self.ui).tog_Auto).isOn)
  self:__SwitchUIState(true)
  self:CloseCstChange()
  self:EndChipEft()
  self.deployCsHeroList = nil
end

UIBattle.ChangeStartBattleBtnText = function(self, index)
  -- function num : 0_4
  ((self.ui).tex_BattleStart):SetIndex(index)
end

UIBattle.__SwitchUIState = function(self, isBattleStart)
  -- function num : 0_5 , upvalues : BattleUtil, _ENV
  (((self.ui).btn_Pause).gameObject):SetActive(isBattleStart)
  ;
  (((self.ui).btn_BattleStart).gameObject):SetActive(not isBattleStart)
  if (BattleUtil.IsInDailyDungeon)() then
    (((self.ui).btn_Formation).gameObject):SetActive(not isBattleStart)
    local stateInfoWin = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
    if stateInfoWin ~= nil then
      (stateInfoWin.chipList):ShowDungeonChipListSuitSelectBtn(not isBattleStart)
    end
  end
  do
    if self.__haveOverclock then
      (((self.ui).btn_Overclock).gameObject):SetActive(not isBattleStart)
    end
  end
end

UIBattle.HidePauseButton = function(self)
  -- function num : 0_6
  (((self.ui).btn_Pause).gameObject):SetActive(false)
end

UIBattle.SetBattleStartActive = function(self, active)
  -- function num : 0_7
  (((self.ui).btn_BattleStart).gameObject):SetActive(active)
end

UIBattle.SetBattleCanvasRaycast = function(self, active)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).canvasGroup).blocksRaycasts = active
end

UIBattle.__OnClickPause = function(self)
  -- function num : 0_9 , upvalues : _ENV
  AudioManager:PlayAudioById(1081)
  if self.pauseFunc ~= nil then
    (self.pauseFunc)(true)
  end
  local win = UIManager:GetWindow(UIWindowTypeID.BattleCrazyMode)
  if win ~= nil then
    win:OnBattlePause()
  end
end

UIBattle.__OnClickSpeedUP = function(self)
  -- function num : 0_10
  if self.isSpeedUnlock then
    self.curSpeedIndex = self.curSpeedIndex % #(self.ui).speedArray + 1
    local speed = ((self.ui).speedArray)[self.curSpeedIndex]
    if self._userDataCfg ~= nil then
      (self._userDataCfg):SetBattleSpeed(self.curSpeedIndex)
    end
    ;
    ((self.ui).img_Speed):SetIndex(self.curSpeedIndex - 1)
    ;
    ((self.ui).tex_Speed):SetIndex(self.curSpeedIndex - 1)
    self:OnSpeedUpChange(speed)
  end
end

UIBattle.OnSpeedUpChange = function(self, curSpeed)
  -- function num : 0_11
  if self.speedUpFunc ~= nil then
    (self.speedUpFunc)(curSpeed)
  end
end

UIBattle.__OnAutoBattleClick = function(self, value)
  -- function num : 0_12
  if self._userDataCfg ~= nil and not self._isTempAuto then
    (self._userDataCfg):SetIsAutoBattle(value)
  end
  ;
  ((self.ui).img_Auto):SetIndex(value and 1 or 0)
  self:OnAutoBattleChange(value)
end

UIBattle.OnAutoBattleChange = function(self, value)
  -- function num : 0_13 , upvalues : _ENV
  if self.autoBattleFunc ~= nil then
    (self.autoBattleFunc)(value)
  end
  local isAutoBattleMode = false
  if BattleDungeonManager:InBattleDungeon() then
    isAutoBattleMode = (BattleDungeonManager.autoCtrl):IsEnbaleDungeonAutoMode()
  end
  if isAutoBattleMode and self.autoUltFunc ~= nil then
    (self.autoUltFunc)(value)
    if self.autoUltMaxEnergy ~= nil then
      (self.autoUltMaxEnergy)(value)
    end
  end
end

UIBattle.OnBtnOverclockClicked = function(self)
  -- function num : 0_14 , upvalues : _ENV
  ((ExplorationManager.epCtrl).overclockCtrl):ShowEpOverclockUI(true)
end

UIBattle.SetOverclockHighlight = function(self, active)
  -- function num : 0_15
  ((self.ui).fx_Overclock):SetActive(active)
end

UIBattle.SetHasBattleActiveCampFetter = function(self, hasEpActive)
  -- function num : 0_16
  (((self.ui).btn_CampBondSkill).gameObject):SetActive(hasEpActive)
end

UIBattle.SetCampFetter = function(self, campId, heroNum, couldUse, cdStr)
  -- function num : 0_17 , upvalues : _ENV
  if couldUse then
    ((self.ui).img_btn_CampBondSkill):SetIndex(0)
    local campFetterCfg = ((ConfigData.camp_connection)[campId])[heroNum]
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).img_CampFetterIcon).sprite = (AtlasUtil.GetSpriteFromAtlas)(UIAtlasConsts.Atlas_CampFetterIcon, campFetterCfg.icon, self.resLoader)
    ;
    ((self.ui).tex_campFetterName):SetIndex(0, (LanguageUtil.GetLocaleText)(campFetterCfg.name))
    ;
    ((self.ui).tex_subText):SetIndex(0, (LanguageUtil.GetLocaleText)(((ConfigData.camp)[campId]).name))
  else
    do
      ;
      ((self.ui).img_btn_CampBondSkill):SetIndex(1)
      local campFetterCfg = ((ConfigData.camp_connection)[campId])[heroNum]
      -- DECOMPILER ERROR at PC61: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).img_CampFetterIcon).sprite = (AtlasUtil.GetSpriteFromAtlas)(UIAtlasConsts.Atlas_CampFetterIcon, campFetterCfg.icon, self.resLoader)
      ;
      ((self.ui).tex_campFetterName):SetIndex(1)
      ;
      ((self.ui).tex_subText):SetIndex(1, cdStr)
    end
  end
end

UIBattle.SetClickCampFetter = function(self, useCampFetterCallback)
  -- function num : 0_18
  self.useCampFetterCallback = useCampFetterCallback
end

UIBattle.__OnClickCampFetter = function(self)
  -- function num : 0_19
  if self.useCampFetterCallback ~= nil then
    (self.useCampFetterCallback)()
  end
end

UIBattle.__OnClickEnterFmt = function(self)
  -- function num : 0_20 , upvalues : _ENV, FmtEnum
  self:EndChipEft()
  local enterFunc = function()
    -- function num : 0_20_0 , upvalues : _ENV, self
    UIManager:HideWindow(UIWindowTypeID.Battle)
    UIManager:HideWindow(UIWindowTypeID.BattleSkillModule)
    UIManager:HideWindow(UIWindowTypeID.DungeonStateInfo)
    UIManager:HideWindow(UIWindowTypeID.EpChipSuit)
    ;
    ((self.cs_battleCtrl).fsm):ChangeState((CS.eBattleState).End)
  end

  local exitFunc = function(fmtId)
    -- function num : 0_20_1 , upvalues : _ENV, self
    local saveUserData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
    saveUserData:SetLastDailyFormationId(fmtId)
    UIManager:ShowWindowOnly(UIWindowTypeID.Battle)
    UIManager:ShowWindowOnly(UIWindowTypeID.BattleSkillModule)
    UIManager:ShowWindowOnly(UIWindowTypeID.DungeonStateInfo)
    UIManager:ShowWindowOnly(UIWindowTypeID.EpChipSuit)
    ;
    (self.cs_battleCtrl):RestartBattle()
  end

  local fmtCtrl = (ControllerManager:GetController(ControllerTypeId.Formation, true))
  -- DECOMPILER ERROR at PC10: Overwrote pending register: R4 in 'AssignReg'

  local stageId, startBattleFunc = .end, nil
  local lastFmtId = (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):GetLastDailyFormationId()
  fmtCtrl:InitFromationCtrl((FmtEnum.eFmtFromModule).DailyDungeon, stageId, enterFunc, exitFunc, startBattleFunc, nil, lastFmtId, nil, nil)
end

UIBattle.__OnClickBattleStart = function(self)
  -- function num : 0_21 , upvalues : BattleUtil, cs_MessageCommon, _ENV
  if (BattleUtil.IsInTDBattle)() then
    self:RealStartBattle()
    return 
  end
  if self.getDeployAliveRoleCount ~= nil then
    local roleNum = (self.getDeployAliveRoleCount)()
    if roleNum <= 0 then
      (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Battle_noBattleRole))
    else
      if (BattleUtil.IsInDailyDungeon)() then
        PersistentManager:SaveModelData((PersistentConfig.ePackage).UserData)
      end
      self:RealStartBattle()
    end
  end
end

UIBattle.RealStartBattle = function(self)
  -- function num : 0_22 , upvalues : _ENV
  UIManager:HideWindow(UIWindowTypeID.EpChipSuit)
  if self.startBattleFunc ~= nil then
    (self.startBattleFunc)()
    AudioManager:PlayAudioById(1000)
  end
end

UIBattle.HideRetreatAndCampBondBtn = function(self)
  -- function num : 0_23
  ((self.ui).obj_btn_CampBondSkill):SetActive(false)
  ;
  (((self.ui).btn_Retreat).gameObject):SetActive(false)
end

UIBattle.__OnClickBreakDeploy = function(self)
  -- function num : 0_24
  if self.savaDeployFunc ~= nil then
    (self.savaDeployFunc)(true)
    self:__BreakBattle()
  end
end

UIBattle.__BreakBattle = function(self)
  -- function num : 0_25
  if self.breakBattleFunc ~= nil then
    (self.breakBattleFunc)()
  end
end

UIBattle.GetBattleCstNode = function(self)
  -- function num : 0_26
  return self.btnCstItem
end

UIBattle.GetBattleCmderSkillByIndex = function(self, index)
  -- function num : 0_27
  return (self.btnCstItem):GetCmderSkillItemByIndex(index)
end

UIBattle.TryShowCstChange = function(self)
  -- function num : 0_28 , upvalues : BattleUtil, _ENV
  if not (BattleUtil.IsAllowCstChangeShowMoudle)() then
    (self.btnCstItem):Hide()
    return 
  end
  local dynPlayer = (BattleUtil.GetCurDynPlayer)()
  local skills = {}
  for i,data in ipairs(dynPlayer.playerOriginSkillList) do
    (table.insert)(skills, data.dataId)
  end
  ;
  (table.sort)(skills)
  local isFixedCst = (BattleUtil.TryGetFixedCstSkills)()
  ;
  (self.btnCstItem):Show()
  ;
  (self.btnCstItem):RefreshCstByIdAndList(dynPlayer:GetCSTId(), skills, isFixedCst)
end

UIBattle.CloseCstChange = function(self)
  -- function num : 0_29
  (self.btnCstItem):Hide()
end

UIBattle.OnClickCstItem = function(self, cstTreeData)
  -- function num : 0_30 , upvalues : BattleUtil, cs_MessageCommon, _ENV
  local isFixedCst = (BattleUtil.TryGetFixedCstSkills)()
  if isFixedCst then
    (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.CstFixed))
    return 
  end
  local dynPlayer = (BattleUtil.GetCurDynPlayer)()
  local cstCtrl = ControllerManager:GetController(ControllerTypeId.CommanderSkill, true)
  cstCtrl:InitCmdSkillCtrl(cstTreeData, self.__OnSendCstChange, nil, dynPlayer:GetCstSkillsRecord())
  UIManager:HideWindow(UIWindowTypeID.EpChipSuit)
end

UIBattle.OnSendCstChange = function(self, savingData)
  -- function num : 0_31 , upvalues : _ENV, BattleUtil
  UIManager:ShowWindowOnly(UIWindowTypeID.EpChipSuit)
  local isChange = false
  local newCstId = savingData.treeId
  local newSkills = savingData:GetUsingCmdSkillList()
  local dynPlayer = (BattleUtil.GetCurDynPlayer)()
  if dynPlayer:GetCSTId() ~= newCstId then
    isChange = true
  else
    if #newSkills ~= #dynPlayer.playerOriginSkillList then
      isChange = true
    else
      local oldSkillDis = {}
      for i,dynSkillData in ipairs(dynPlayer.playerOriginSkillList) do
        oldSkillDis[dynSkillData.dataId] = true
      end
      for i,skillId in ipairs(newSkills) do
        if oldSkillDis[skillId] == nil then
          isChange = true
          break
        end
      end
    end
  end
  do
    if not isChange then
      return 
    end
    local exploraNet = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
    exploraNet:CS_EXPLORATION_BATTLE_RefreshCommandSkillTree(newCstId, newSkills, function()
    -- function num : 0_31_0 , upvalues : _ENV, newSkills, dynPlayer, newCstId, self
    local skillDic = {}
    for i,skillId in ipairs(newSkills) do
      skillDic[skillId] = 1
    end
    dynPlayer:InitPlayerSkill(skillDic, newCstId)
    ;
    (self.btnCstItem):RefreshCstByIdAndList(newCstId, newSkills)
    dynPlayer:SetCstSkillsRecordByTreeId(newCstId, newSkills)
  end
)
  end
end

UIBattle.StartChipEft = function(self)
  -- function num : 0_32 , upvalues : BattleUtil, _ENV
  if self.deployCsHeroList == nil then
    return 
  end
  ;
  (self.deployChipEftPool):HideAll()
  local dynPlayer = (BattleUtil.GetCurDynPlayer)()
  if dynPlayer == nil then
    return 
  end
  local dungeonStateUI = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonStateUI == nil or not dungeonStateUI.active or not (dungeonStateUI.chipList).active then
    return 
  end
  for i = 1, (self.deployCsHeroList).Count do
    local csCharactor = (self.deployCsHeroList)[i - 1]
    local dynHero = csCharactor.character
    local ownedChips = dynHero:GetOwnedChips()
    if ownedChips ~= nil and (table.count)(ownedChips) ~= 0 then
      local skills = {}
      for chipData,_ in pairs(ownedChips) do
        if (chipData.chipBattleData).skillDataList ~= nil and #(chipData.chipBattleData).skillDataList > 0 then
          for _,skillData in ipairs((chipData.chipBattleData).skillDataList) do
            if skillData:GetSkillTag() == eSkillTag.passiveSkill then
              (table.insert)(skills, skillData)
            end
          end
        end
      end
      if #skills ~= 0 then
        local item = (self.deployChipEftPool):GetOne()
        local lsObject = csCharactor.lsObject
        if lsObject ~= nil and not IsNull(lsObject.transform) then
          local lineStartPos = (dungeonStateUI.chipList):GetEftLineStartPos()
          lineStartPos = (self.transform):InverseTransformPoint(lineStartPos)
          item:StartEft(skills, lineStartPos, lsObject, self.resLoader)
        end
      end
    end
  end
  if #(self.deployChipEftPool).listItem > 0 then
    (dungeonStateUI.chipList):PlayDepolyEft()
  end
end

UIBattle.EndChipEft = function(self)
  -- function num : 0_33 , upvalues : _ENV
  (self.deployChipEftPool):HideAll()
  local dungeonStateUI = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonStateUI ~= nil and dungeonStateUI.active and (dungeonStateUI.chipList).active then
    (dungeonStateUI.chipList):StopDepolyEft()
  end
end

UIBattle.__OnClickRetreat = function(self)
  -- function num : 0_34 , upvalues : _ENV
  if ExplorationManager:IsInExploration() and ((ExplorationManager.epCtrl).battleCtrl):IsBattleBeforeRunning() then
    ((ExplorationManager.epCtrl).autoCtrl):DisableEpAutoMode()
  end
  if BattleDungeonManager:InBattleDungeon() then
    local isDungeonAuto = (BattleDungeonManager.autoCtrl):IsEnbaleDungeonAutoMode()
  end
  if isDungeonAuto then
    (BattleDungeonManager.autoCtrl):AutoBreak(true)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.BattlePause, function(win)
    -- function num : 0_34_0 , upvalues : _ENV, isDungeonAuto
    if win == nil then
      return 
    end
    win:InitBattlePause(function()
      -- function num : 0_34_0_0 , upvalues : _ENV
      BattleDungeonManager:RetreatDungeon()
      AudioManager:PlayAudioById(1082)
    end
, nil, function()
      -- function num : 0_34_0_1 , upvalues : isDungeonAuto, _ENV
      if isDungeonAuto then
        (BattleDungeonManager.autoCtrl):AutoBreak(false)
      end
    end
)
    win:SetAboutBattleUIActive(false)
  end
)
end

UIBattle.ShowHeroRoleInfo = function(self, hero)
  -- function num : 0_35 , upvalues : _ENV
  self.isShowingHeroInfo = true
  ;
  (UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)):ShowHero(hero)
end

UIBattle.ShowMonsterOrNeutralRoleInfo = function(self, battleCharacterView, monsterOrNeutral)
  -- function num : 0_36 , upvalues : _ENV
  if not self.onEnemyDetailUnlock then
    return 
  end
  if self.battleCharacterViewList ~= nil then
    for _,view in ipairs(self.battleCharacterViewList) do
      view:ShowNewArrow(false)
    end
    self.battleCharacterViewList = nil
  end
  local isNew = battleCharacterView.isNew
  if isNew then
    self.battleCharacterViewList = {}
    ;
    (table.insert)(self.battleCharacterViewList, battleCharacterView)
    local enemyList = ((((ExplorationManager.epCtrl).battleCtrl).battleCtrl).EnemyTeamController).battleOriginRoleList
    for i = 0, enemyList.Count - 1 do
      local enemy = enemyList[i]
      if enemy.roleDataId == monsterOrNeutral.dataId then
        (table.insert)(self.battleCharacterViewList, enemy.battleRoleView)
      end
    end
    local neutralList = ((((ExplorationManager.epCtrl).battleCtrl).battleCtrl).NeutralTeamController).battleOriginRoleList
    for i = 0, neutralList.Count - 1 do
      local neutral = neutralList[i]
      if neutral.roleDataId == monsterOrNeutral.dataId then
        (table.insert)(self.battleCharacterViewList, neutral.battleRoleView)
      end
    end
  end
  do
    self.isShowEnemyDetail = true
    UIManager:ShowWindowAsync(UIWindowTypeID.BattleEnemyDetail, function(window)
    -- function num : 0_36_0 , upvalues : self, monsterOrNeutral, isNew
    if self.isShowEnemyDetail then
      window:InitBattleEnemyDetail(monsterOrNeutral, isNew)
    else
      window:Hide()
    end
  end
)
  end
end

UIBattle.HideHeroRoleInfo = function(self)
  -- function num : 0_37
  self.isShowingHeroInfo = false
end

UIBattle.HideMonsterOrNeutralRoleInfo = function(self)
  -- function num : 0_38 , upvalues : _ENV
  if not self.onEnemyDetailUnlock then
    return 
  end
  if self.battleCharacterViewList ~= nil then
    for _,view in ipairs(self.battleCharacterViewList) do
      view:ShowNewArrow(false)
    end
    self.battleCharacterViewList = nil
  end
  self.isShowEnemyDetail = false
  UIManager:HideWindow(UIWindowTypeID.BattleEnemyDetail)
end

UIBattle.IsRoleInfoShow = function(self)
  -- function num : 0_39
  if not self.isShowingHeroInfo then
    return self.isShowEnemyDetail
  end
end

UIBattle.SetEpChipListUIActive = function(self, active)
  -- function num : 0_40 , upvalues : _ENV
  if active then
    local win = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
    if win ~= nil then
      win:Show()
      win:SetHeroListActive(false)
      win:SetHeroListHpBar(false)
      win:SetMoneyActive(false)
      win:SetSaveMoneyActive(false)
    end
  else
    do
      local win = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
      if win ~= nil then
        win:SetHeroListActive(true)
        win:SetHeroListHpBar(true)
        win:SetMoneyActive(true)
        win:SetSaveMoneyActive(true)
        win:Hide()
      end
    end
  end
end

UIBattle.OnEnemyDetailUnlock = function(self, active)
  -- function num : 0_41
  self.onEnemyDetailUnlock = active
end

UIBattle.TryRefreshAutoInfo = function(self)
  -- function num : 0_42 , upvalues : _ENV
  if not BattleDungeonManager:InBattleDungeon() or not (BattleDungeonManager.autoCtrl):IsEnbaleDungeonAutoMode() then
    ((self.ui).battleAutoNow):SetActive(false)
    return 
  end
  local battleCount = (BattleDungeonManager.autoCtrl):GetBattleCount() + 1
  local totalCount = (BattleDungeonManager.autoCtrl):GetTotalDungeonAutoCount()
  ;
  ((self.ui).battleAutoNow):SetActive(true)
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Count_BattleAuto).text = (string.format)("%d/%d", battleCount, totalCount)
end

UIBattle.OnHide = function(self)
  -- function num : 0_43 , upvalues : base, _ENV
  (base.OnHide)(self)
  self:EndChipEft()
  local win = UIManager:GetWindow(UIWindowTypeID.BattleCrazyMode)
  if win ~= nil then
    win:Hide()
  end
end

UIBattle.OnDelete = function(self)
  -- function num : 0_44 , upvalues : _ENV, base
  UIManager:DeleteWindow(UIWindowTypeID.BattleCrazyMode)
  if self.gameplayScore ~= nil then
    (self.gameplayScore):OnDelete()
    self.gameplayScore = nil
  end
  self.deployCsHeroList = nil
  if self._userDataCfg ~= nil then
    PersistentManager:SaveModelData((PersistentConfig.ePackage).UserData)
  end
  ;
  (self.deployChipEftPool):DeleteAll()
  UIManager:DeleteWindow(UIWindowTypeID.BattleEnemyDetail)
  ;
  (base.OnDelete)(self)
end

return UIBattle

