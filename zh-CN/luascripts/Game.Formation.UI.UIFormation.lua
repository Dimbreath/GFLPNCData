-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFormation = class("UIFormation", UIBaseWindow)
local base = UIBaseWindow
local UINTroopItem = require("Game.Formation.UI.UINTroopItem")
local UINCommanderSkill = require("Game.Formation.UI.UINCommanderSkill")
local UINFmtHeroInfoItem = require("Game.Formation.UI.UINFmtHeroInfoItem")
local UINFmtCampFetterItem = require("Game.Formation.UI.UINFmtCampFetterItem")
local UINFmtEvaluation = require("Game.Formation.UI.FormationEvaluation.UIFmtEvaluation")
local cs_MessageCommon = CS.MessageCommon
local eFmtFromModule = require("Game.Formation.Enum.eFmtFromModule")
local cs_tweening = (CS.DG).Tweening
UIFormation.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINFmtHeroInfoItem, UINTroopItem, UINCommanderSkill
  self.fmtId = nil
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ShowTeamDetail, self, self.OnClickFmtHeroDetail)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CommanderSkill, self, self.OnClickCommanderSkillDetail)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_SwitchTeam, self, self.__OnClickSwitchTeam)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_closeTeamList, self, self.__OnClickCloseSwitchTeam)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Battle, self, self.OnClickStartBattle)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_LastTeam, self, self.OnClickToLastTeam)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_NextTeam, self, self.OnClickToNextTeam)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Recomme, self, self.OnClickRecomme)
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).switchTeamList = ((((self.ui).btn_closeTeamList).transform).parent).gameObject
  ;
  (((self.ui).btn_ChangeTeamName).onEndEdit):AddListener(BindCallback(self, self.EditFormationName))
  ;
  (UIUtil.SetTopStatus)(self, self.OnClickBack, {ConstGlobalItem.SKey})
  ;
  ((self.ui).campItem):SetActive(false)
  ;
  ((self.ui).fHeroInfoItem):SetActive(false)
  self.heroInfoPool = (UIItemPool.New)(UINFmtHeroInfoItem, (self.ui).fHeroInfoItem)
  self.heroInfoDic = {}
  ;
  ((self.ui).switchTeamItem):SetActive(false)
  self.troopPool = (UIItemPool.New)(UINTroopItem, (self.ui).switchTeamItem)
  ;
  ((self.ui).skillItem):SetActive(false)
  self.commanderSkillPool = (UIItemPool.New)(UINCommanderSkill, (self.ui).skillItem)
  self.__SelectFmt = BindCallback(self, self.SelectFmt)
  self.heroNetwork = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  self.__RefreshCommanderSkill = BindCallback(self, self.RefreshCommanderSkill)
  MsgCenter:AddListener(eMsgEventId.OnCommanderSkillChande, self.__RefreshCommanderSkill)
  self.__RefreshCSLevel = BindCallback(self, self.RefreshCSLevel)
  MsgCenter:AddListener(eMsgEventId.OnCommanderSkillMasterLevelDiffer, self.__RefreshCSLevel)
  MsgCenter:AddListener(eMsgEventId.OnCommanderSkillLevelDiffer, self.__RefreshCSLevel)
  self.__RefreshCSRedDot = BindCallback(self, self.RefreshCSRedDot)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__RefreshCSRedDot)
  MsgCenter:AddListener(eMsgEventId.OnCommanderSkillTreeDataDiffer, self.__RefreshCSRedDot)
  self.isCSUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill)
  self.isCSUIUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill_Ui)
  if self.isCSUnlock then
    self:UnlockCommanderSkillUI(self.isCSUIUnlock)
    self.isOpenOverClock = false
    self.isOpenCampInfluence = false
    self.teamCountList = {}
    for i = 2, (ConfigData.game_config).formationCount do
      ((self.ui).img_TeamCount):Instantiate()
    end
    ;
    (UIUtil.AddButtonListener)((self.ui).campList, self, self.ShowFmtCampFetter)
  end
end

UIFormation.OpenCampInfluence = function(self, isOpen)
  -- function num : 0_1 , upvalues : _ENV, UINFmtCampFetterItem
  self.isOpenCampInfluence = isOpen
  if isOpen then
    (((self.ui).campList).gameObject):SetActive(true)
    self.campFetterPool = (UIItemPool.New)(UINFmtCampFetterItem, (self.ui).campItem)
  else
    ;
    (((self.ui).campList).gameObject):SetActive(false)
  end
end

UIFormation.OpenOverClock = function(self, isOpen)
  -- function num : 0_2 , upvalues : _ENV
  self.isOpenOverClock = isOpen
  if isOpen then
    (((self.ui).overLock).gameObject):SetActive(true)
    ;
    (UIUtil.AddButtonListener)((self.ui).overLock, self, self.OnOverClockClick)
    self.OverclockCtrl = ControllerManager:GetController(ControllerTypeId.Overclock, true)
    ;
    (self.OverclockCtrl):RefreshData(function()
    -- function num : 0_2_0 , upvalues : self
    self.img_OverLockCountSize = ((((self.ui).img_OverLockCount).transform).sizeDelta).x
    self:RefreshOverClockUI()
  end
)
  else
    ;
    (((self.ui).overLock).gameObject):SetActive(false)
  end
end

UIFormation.InitUIFormation = function(self, fmtId, fmtCtrl, sectorStageId, fromModule, staminaCost)
  -- function num : 0_3 , upvalues : _ENV, eFmtFromModule
  self.fmtId = fmtId
  self.fmtCtrl = fmtCtrl
  self.sectorStageId = sectorStageId
  self.stageCombat = self:__GetStageCombat(sectorStageId, fromModule)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R6 in 'UnsetPending'

  if self.stageCombat ~= nil then
    ((self.ui).tex_Power).text = tostring(self.stageCombat)
    ;
    ((self.ui).obj_Power):SetActive(true)
  else
    ;
    ((self.ui).obj_Power):SetActive(false)
  end
  if (self.fmtCtrl).isOpenFmtEvaluation then
    self:__createFmtEvaluationUI(self.sectorStageId, (self.fmtCtrl).fromModule)
  end
  ;
  ((self.ui).tex_Point):SetIndex(0, tostring(staminaCost))
  ;
  (((self.ui).btn_Recomme).gameObject):SetActive(false)
  if ((self.fmtCtrl).fromModule == eFmtFromModule.SectorLevel or (self.fmtCtrl).fromModule == eFmtFromModule.Infinity) and (self.fmtCtrl):IsCanReqRecomme(self.sectorStageId, false) then
    (((self.ui).btn_Recomme).gameObject):SetActive(true)
  end
  ;
  (self.troopPool):HideAll()
  for i = 1, (ConfigData.game_config).formationCount do
    local troopItem = (self.troopPool):GetOne()
    troopItem:InitTroopItem(i, self.__SelectFmt)
  end
  if self.isCSUnlock then
    self:RefreshCommanderSkill()
    self:RefreshCSLevel()
    self:RefreshCSRedDot()
  end
  self:RefreshCurFmtUI()
  if self.isOpenOverClock then
    (self.OverclockCtrl):SetStageId(sectorStageId, fromModule)
    ;
    (self.OverclockCtrl):CleanData()
  end
  if GuideManager:TryTriggerGuide(eGuideCondition.InFormation) then
  end
end

UIFormation.__createFmtEvaluationUI = function(self, sectorStageId, fromModule)
  -- function num : 0_4 , upvalues : UINFmtEvaluation
  if self.UIFmtEvaluation == nil then
    self.UIFmtEvaluation = (UINFmtEvaluation.New)()
    ;
    (self.UIFmtEvaluation):Init((self.ui).formationEvaluation)
  end
  ;
  (self.UIFmtEvaluation):InitializeAdvantageConfig(sectorStageId, fromModule)
end

UIFormation.SelectFmt = function(self, id)
  -- function num : 0_5 , upvalues : _ENV
  self.fmtId = id
  ;
  (self.fmtCtrl):RefreshFomation(id)
  if self.isCSUnlock then
    self:RefreshCommanderSkill()
    self:RefreshCSLevel()
  end
  self:RefreshCurFmtUI()
  ;
  ((self.ui).switchTeamList):SetActive(false)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_SwitchTeamArrow).localScale = (Vector3.New)(1, -1, 1)
  self:__SetSwitchButtonActive(true)
end

UIFormation.RefreshCurFmtUI = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local fmtData = (PlayerDataCenter.formationDic)[self.fmtId]
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

  if fmtData ~= nil and not (string.IsNullOrEmpty)(fmtData.name) then
    ((self.ui).btn_ChangeTeamName).text = fmtData.name
  else
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).btn_ChangeTeamName).text = ((self.ui).tex_troopName):GetIndex(0, tostring(self.fmtId))
  end
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_curTeam).anchoredPosition = (Vector2.New)((self.fmtId - 1) * ((((self.ui).img_TeamCount).transform).sizeDelta).x, 0)
  if self.UIFmtEvaluation ~= nil then
    (self.UIFmtEvaluation):AnalysisFormation(fmtData.data)
  end
end

UIFormation.CallEvaluationAnalysisFormation = function(self, fmtId)
  -- function num : 0_7 , upvalues : _ENV
  if self.UIFmtEvaluation ~= nil then
    local fmtData = (PlayerDataCenter.formationDic)[fmtId]
    if fmtData ~= nil then
      (self.UIFmtEvaluation):AnalysisFormation(fmtData.data)
    end
  end
end

UIFormation.RefreshFmtInfoUI = function(self, totalFtPower, totalBenchPower, campCountDic, top5Total)
  -- function num : 0_8 , upvalues : _ENV
  if self.stageCombat ~= nil then
    local minPower = (math.floor)(self.stageCombat * 0.9)
    self.isLowPower = top5Total < minPower
  else
    self.isLowPower = nil
  end
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_TotalPower).text = tostring(totalFtPower)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_BenchTotalPower).text = tostring(totalBenchPower)
  self:__SetTotalFtPowerWarnTween(totalFtPower)
  local isCampFetterUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_CampConnection)
  if isCampFetterUnlock then
    (((self.ui).campList).gameObject):SetActive(self.isOpenCampInfluence)
    if not isCampFetterUnlock then
      return 
    end
    if isCampFetterUnlock and self.isOpenCampInfluence and campCountDic ~= nil then
      self:__RefreshCampBond(campCountDic)
    end
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
end

UIFormation.__OnClickSwitchTeam = function(self)
  -- function num : 0_9 , upvalues : _ENV
  ((self.ui).switchTeamList):SetActive(true)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_SwitchTeamArrow).localScale = (Vector3.New)(1, 1, 1)
  self:__SetSwitchButtonActive(false)
end

UIFormation.__OnClickCloseSwitchTeam = function(self)
  -- function num : 0_10 , upvalues : _ENV
  ((self.ui).switchTeamList):SetActive(false)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_SwitchTeamArrow).localScale = (Vector3.New)(1, -1, 1)
  self:__SetSwitchButtonActive(true)
end

UIFormation.OnOverClockClick = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if not self.isOpenOverClock then
    return 
  end
  ;
  (self.OverclockCtrl):ShowOverclockUI()
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.OverclockCtrl).selectChangEvent = BindCallback(self, self.RefreshOverClockUI)
end

UIFormation.RefreshOverClockUI = function(self)
  -- function num : 0_12
  if not self.isOpenOverClock then
    return 
  end
  local curAssembleNum, maxAssembleNum = (self.OverclockCtrl):GetAssembleNum()
  ;
  ((self.ui).img_OverLockSelect):SetIndex(curAssembleNum > 0 and 1 or 0)
  local sizeDelta = (((self.ui).img_OverLockCount).transform).sizeDelta
  sizeDelta.x = self.img_OverLockCountSize * curAssembleNum
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((self.ui).img_OverLockCount).transform).sizeDelta = sizeDelta
  sizeDelta = ((self.ui).overlockCountList).sizeDelta
  sizeDelta.x = self.img_OverLockCountSize * maxAssembleNum
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).overlockCountList).sizeDelta = sizeDelta
  if (self.OverclockCtrl):GetIsHaveFree() then
    ((self.ui).obj_OverLockFree):SetActive(true)
  else
    ;
    ((self.ui).obj_OverLockFree):SetActive(false)
  end
end

UIFormation.__RefreshCampBond = function(self, campCountDic)
  -- function num : 0_13 , upvalues : _ENV
  self.campCountDic = campCountDic
  local campCountList = {}
  for campId,count in pairs(campCountDic) do
    local isHasFetterSkill = false
    for neededHeroNum,_ in pairs((ConfigData.camp_connection)[campId]) do
      if neededHeroNum <= count then
        isHasFetterSkill = true
        break
      end
    end
    do
      do
        if isHasFetterSkill then
          local campCount = {campId = campId, count = count}
          ;
          (table.insert)(campCountList, campCount)
        end
        -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  ;
  (self.campFetterPool):HideAll()
  if #campCountList < 1 then
    ((self.ui).obj_campEmpty):SetActive(true)
    return 
  else
    ;
    ((self.ui).obj_campEmpty):SetActive(false)
  end
  ;
  (table.sort)(campCountList, function(a, b)
    -- function num : 0_13_0
    if b.count >= a.count then
      do return a.count == b.count end
      do return a.campId < b.campId end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  local clickCallback = BindCallback(self, self.ShowFmtCampFetter)
  for k,v in pairs(campCountList) do
    local bondItem = (self.campFetterPool):GetOne()
    bondItem:InitFmtCampFetterItem(v.campId, v.count, (self.fmtCtrl).resloader, clickCallback)
  end
end

UIFormation.ShowFmtCampFetter = function(self, campId)
  -- function num : 0_14 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.CampBond, function(window)
    -- function num : 0_14_0 , upvalues : self, campId
    window:InitCampBond(self.campCountDic, campId)
  end
)
end

UIFormation.RefreshCommanderSkill = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local fmtId = self.fmtId
  ;
  (self.commanderSkillPool):HideAll()
  if (PlayerDataCenter.formationDic)[fmtId] ~= nil and ((PlayerDataCenter.formationDic)[fmtId]).cst ~= nil then
    local treeId = (((PlayerDataCenter.formationDic)[fmtId]).cst).treeId
    for _,skillId in pairs(((PlayerDataCenter.formationDic)[fmtId]).userSkill) do
      local item = (self.commanderSkillPool):GetOne()
      item:InitCommanderSkill(treeId, skillId, (self.fmtCtrl).resloader)
    end
  end
end

UIFormation.RefreshCSLevel = function(self)
  -- function num : 0_16 , upvalues : _ENV
  local fmtData = (PlayerDataCenter.formationDic)[self.fmtId]
  if fmtData ~= nil and fmtData.cst ~= nil then
    local cst = fmtData.cst
    local treeId = (((PlayerDataCenter.formationDic)[self.fmtId]).cst).treeId
    local treeLevel = (((PlayerDataCenter.CommanderSkillModualData).CommanderSkillTreeDataDic)[treeId]).level
    do
      do
        if not (PlayerDataCenter.CommanderSkillModualData).masterLevel then
          local masterLevel = treeLevel ~= #ConfigData.commander_skill_level or 0
        end
        if masterLevel > 0 then
          ((self.ui).CS_text_Temp):SetIndex(0, tostring(masterLevel))
        else
          ;
          ((self.ui).CS_text_Temp):SetIndex(0, tostring(treeLevel))
        end
        ;
        ((self.ui).CS_text_Temp):SetIndex(0, tostring(treeLevel))
        ;
        ((self.ui).CS_text_Temp):SetIndex(0, "0")
      end
    end
  end
end

UIFormation.RefreshCSRedDot = function(self)
  -- function num : 0_17 , upvalues : _ENV
  ((self.ui).CS_obj_RedDot):SetActive((PlayerDataCenter.CommanderSkillModualData):GetIsHaveCouldUpgradeCST())
end

UIFormation.UnlockCommanderSkillUI = function(self, isUnlock)
  -- function num : 0_18
  (((self.ui).btn_CommanderSkill).gameObject):SetActive(isUnlock)
end

UIFormation.EditFormationName = function(self, fmtName)
  -- function num : 0_19 , upvalues : _ENV
  if (string.IsNullOrEmpty)(fmtName) then
    return 
  end
  local formationData = (PlayerDataCenter.formationDic)[self.fmtId]
  if formationData ~= nil and formationData.name == fmtName then
    return 
  end
  if self.__OnEditFormationName == nil then
    self.__OnEditFormationName = BindCallback(self, self.__OnEditFormationNameComplete)
  end
  ;
  (self.heroNetwork):CS_HERO_FormationNameFresh(self.fmtId, fmtName, self.__OnEditFormationName)
end

UIFormation.__OnEditFormationNameComplete = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local name = ((self.ui).btn_ChangeTeamName).text
  local troopItem = ((self.troopPool).listItem)[self.fmtId]
  if troopItem ~= nil then
    troopItem:RefreshTroopName(name)
  end
  local formationData = (PlayerDataCenter.formationDic)[self.fmtId]
  formationData.name = name
end

UIFormation.OnClickFmtHeroDetail = function(self)
  -- function num : 0_21
  (self.fmtCtrl):ShowFmtHeroDetail()
end

UIFormation.OnClickCommanderSkillDetail = function(self)
  -- function num : 0_22
  (self.fmtCtrl):ShowCommanderSkillDetail()
end

UIFormation.CreatFmtHeroInfo = function(self, heroData, position)
  -- function num : 0_23
  local infoItem = (self.heroInfoPool):GetOne()
  infoItem:InitFmtHeroInfo(heroData)
  infoItem:UpdateFmtHeroInfoPos(position)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.heroInfoDic)[heroData.dataId] = infoItem
end

UIFormation.UpdateFmtHeroInfo = function(self, heroData, position, onlyPos)
  -- function num : 0_24
  local infoItem = (self.heroInfoDic)[heroData.dataId]
  if infoItem == nil then
    return 
  end
  if not onlyPos then
    infoItem:InitFmtHeroInfo(heroData)
  end
  infoItem:UpdateFmtHeroInfoPos(position)
end

UIFormation.ShowFmtHeroInfo = function(self, heroId, show)
  -- function num : 0_25
  local infoItem = (self.heroInfoDic)[heroId]
  if infoItem == nil then
    return 
  end
  if show then
    infoItem:Show()
  else
    infoItem:Hide()
  end
end

UIFormation.ReturnFmtHeroInfo = function(self, heroId)
  -- function num : 0_26
  local infoItem = (self.heroInfoDic)[heroId]
  if infoItem == nil then
    return 
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.heroInfoDic)[heroId] = nil
  ;
  (self.heroInfoPool):HideOne(infoItem)
end

UIFormation.OnClickStartBattle = function(self)
  -- function num : 0_27 , upvalues : cs_MessageCommon, _ENV
  if self.fmtCtrl ~= nil then
    local fmtStartBattleFunc = function()
    -- function num : 0_27_0 , upvalues : self, cs_MessageCommon, _ENV
    if self.isLowPower then
      (cs_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(388), function()
      -- function num : 0_27_0_0 , upvalues : self
      (self.fmtCtrl):FmtStartBattle()
    end
, nil)
    else
      ;
      (self.fmtCtrl):FmtStartBattle()
    end
  end

    if self.UIFmtEvaluation ~= nil and (self.UIFmtEvaluation):IsFmtDisadvantage() then
      local des = (self.UIFmtEvaluation):GetDisadvantageDescribe()
      ;
      (cs_MessageCommon.ShowMessageBox)((string.format)(ConfigData:GetTipContent(TipContent.CurFormationContainDisadvantage), des), fmtStartBattleFunc, nil)
    else
      do
        fmtStartBattleFunc()
      end
    end
  end
end

UIFormation.OnClickBack = function(self)
  -- function num : 0_28
  (self.fmtCtrl):ExitFormation()
end

UIFormation.OnClickToLastTeam = function(self)
  -- function num : 0_29
  self:__ChangeFormationTeam(-1)
end

UIFormation.OnClickToNextTeam = function(self)
  -- function num : 0_30
  self:__ChangeFormationTeam(1)
end

UIFormation.__ChangeFormationTeam = function(self, num)
  -- function num : 0_31 , upvalues : _ENV
  local id = self.fmtId + num
  if (ConfigData.game_config).formationCount < id then
    id = 1
  else
    if id < 1 then
      id = (ConfigData.game_config).formationCount
    end
  end
  self:SelectFmt(id)
end

UIFormation.__SetSwitchButtonActive = function(self, active)
  -- function num : 0_32
  (((self.ui).btn_LastTeam).gameObject):SetActive(active)
  ;
  (((self.ui).btn_NextTeam).gameObject):SetActive(active)
end

UIFormation.OnClickRecomme = function(self)
  -- function num : 0_33
  (self.fmtCtrl):ReqRecommeFormation(self.sectorStageId, true)
end

UIFormation.__GetStageCombat = function(self, sectorStageId, fromModule)
  -- function num : 0_34 , upvalues : eFmtFromModule, _ENV
  local stageCfg = nil
  if fromModule == eFmtFromModule.SectorLevel then
    stageCfg = (ConfigData.sector_stage)[sectorStageId]
  else
    if fromModule == eFmtFromModule.Infinity then
      local endlessLevel = ((ConfigData.endless).levelDic)[sectorStageId]
      if endlessLevel == nil then
        return 
      end
      stageCfg = ((ConfigData.endless)[endlessLevel.sectorId])[endlessLevel.index]
    end
  end
  do
    if stageCfg == nil then
      return 
    end
    return stageCfg.combat
  end
end

UIFormation.__SetTotalFtPowerWarnTween = function(self, totalFtPower)
  -- function num : 0_35 , upvalues : cs_tweening
  local showMinTween = false
  if self.stageCombat ~= nil and totalFtPower ~= nil and totalFtPower < self.stageCombat then
    showMinTween = true
  end
  -- DECOMPILER ERROR at PC26: Unhandled construct in 'MakeBoolean' P1

  if showMinTween and self.__ftPowerWarn == nil then
    self.__ftPowerWarn = (((self.ui).img_LowPower):DOFade(0, 1.5)):SetLoops(-1, (cs_tweening.LoopType).Yoyo)
  end
  if self.__ftPowerWarn ~= nil then
    (self.__ftPowerWarn):Rewind()
    ;
    (self.__ftPowerWarn):Kill()
    self.__ftPowerWarn = nil
  end
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_LowPower).enabled = showMinTween
end

UIFormation.OnDelete = function(self)
  -- function num : 0_36 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillChande, self.__RefreshCommanderSkill)
  MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillMasterLevelDiffer, self.__RefreshCSLevel)
  MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillLevelDiffer, self.__RefreshCSLevel)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__RefreshCSRedDot)
  MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillTreeDataDiffer, self.__RefreshCSRedDot)
  ;
  (self.troopPool):DeleteAll()
  if self.__ftPowerWarn ~= nil then
    (self.__ftPowerWarn):Rewind()
    ;
    (self.__ftPowerWarn):Kill()
    self.__ftPowerWarn = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIFormation

