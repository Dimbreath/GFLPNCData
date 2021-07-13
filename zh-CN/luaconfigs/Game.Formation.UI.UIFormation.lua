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
local FmtEnum = require("Game.Formation.FmtEnum")
local cs_tweening = (CS.DG).Tweening
local SpecificHeroDataRuler = require("Game.PlayerData.Hero.SpecificHeroDataRuler")
local UINFormationChoice = require("Game.Formation.UI.UINFormationChoice")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local JumpManager = require("Game.Jump.JumpManager")
UIFormation.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINFmtHeroInfoItem, UINTroopItem, UINCommanderSkill, UINFormationChoice, cs_tweening
  self.fmtId = nil
  self._heroQuickLvUpShow = true
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
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ChipBag, self, self.OnClickChipPreview)
  -- DECOMPILER ERROR at PC71: Confused about usage of register: R1 in 'UnsetPending'

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
    self.isOpenCampInfluence = false
    self.isOpenBuffSelect = false
    self.isOpenChangeFmt = true
    self.teamCountList = {}
    for i = 2, (ConfigData.game_config).formationCount do
      ((self.ui).img_TeamCount):Instantiate()
    end
    ;
    (UIUtil.AddButtonListener)((self.ui).campList, self, self.ShowFmtCampFetter)
    self.editorNode = (UINFormationChoice.New)()
    ;
    (self.editorNode):Init(((self.ui).editorNodeFade).gameObject)
    ;
    (UIUtil.AddButtonListener)((self.ui).btn_Editor, self, self.OnClickEditor)
    local editorModelSeq = ((cs_tweening.DOTween).Sequence)()
    editorModelSeq:Append(((self.ui).tran_FHeroInfo):DOAnchorPosY((((self.ui).tran_FHeroInfo).anchoredPosition).y + 20, 0.5))
    editorModelSeq:Join(((self.ui).tran_SwitchBtn):DOAnchorPosY((((self.ui).tran_SwitchBtn).anchoredPosition).y + 100, 0.5))
    editorModelSeq:Pause()
    editorModelSeq:SetAutoKill(false)
    self.editorModelSeq = editorModelSeq
    self.notEditorSeq = self:_InitPageSeq((self.ui).notEditorNodeFade, function()
    -- function num : 0_0_0 , upvalues : self
    (((self.ui).notEditorNodeFade).gameObject):SetActive(false)
  end
)
    self.editorSeq = self:_InitPageSeq((self.ui).editorNodeFade, function()
    -- function num : 0_0_1 , upvalues : self, _ENV
    (self.editorNode):Hide()
    self:ShowFmtHeroQuickLvUp(true)
    local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
    if fmtCtrl ~= nil then
      (fmtCtrl.fmtSceneCtrl):RefreshFmtSCHeroQuickLvUp()
    end
  end
)
    self.curPageSeq = self.notEditorSeq
    ;
    (self.curPageSeq):Restart()
    self.resloader = ((CS.ResLoader).Create)()
    self.__UpdateItemForFmtInfo = BindCallback(self, self.UpdateItemForFmtInfo)
    MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__UpdateItemForFmtInfo)
    self.__UpdateHeroForFmtInfo = BindCallback(self, self.UpdateHeroForFmtInfo)
    MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__UpdateHeroForFmtInfo)
    self.__HeroCardStarUpForFmtInfo = BindCallback(self, self.HeroCardStarUpForFmtInfo)
    RedDotController:AddListener(RedDotDynPath.HeroCardStartUpPath, self.__HeroCardStarUpForFmtInfo)
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

UIFormation.OpenBuffIdSelect = function(self, isOpen)
  -- function num : 0_2 , upvalues : _ENV
  ((self.ui).obj_debuffSelect):SetActive(isOpen)
  self.isOpenBuffSelect = isOpen
  if isOpen then
    (UIUtil.AddButtonListener)((self.ui).btn_buffSelect, self, self.OnClickBuffSelect)
  end
end

UIFormation.OpenTotalPowerShow = function(self, isOpen)
  -- function num : 0_3
  ((self.ui).obj_totalPower):SetActive(isOpen)
end

UIFormation.OpenChangeFmtShow = function(self, isOpen)
  -- function num : 0_4
  self.isOpenChangeFmt = isOpen
end

UIFormation.ShowExpLaber = function(self, isOpen)
  -- function num : 0_5 , upvalues : _ENV
  if not isOpen or not {ConstGlobalItem.HeroExp, ConstGlobalItem.SKey} then
    local resIds = {ConstGlobalItem.SKey}
  end
  ;
  (UIUtil.RefreshTopResId)(resIds)
  local win = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if win ~= nil then
    local resItem = win:GetTopStatusResItem(ConstGlobalItem.HeroExp)
    if resItem ~= nil then
      resItem:SetPlayNumberTweenActive(isOpen)
    end
  end
end

UIFormation.InitUIFormation = function(self, fmtId, fmtCtrl, sectorStageId, fromModule, staminaCost)
  -- function num : 0_6 , upvalues : JumpManager, _ENV, FmtEnum
  JumpManager.couldUseItemJump = true
  self.fmtId = fmtId
  self.fmtCtrl = fmtCtrl
  self.sectorStageId = sectorStageId
  self.fromModule = fromModule
  self.isInEditor = false
  self:RefreshCommandPower()
  if (self.fmtCtrl).isOpenFmtEvaluation then
    (((self.ui).formationEvaluation).gameObject):SetActive(true)
    self:__createFmtEvaluationUI(self.sectorStageId, (self.fmtCtrl).fromModule)
  else
    ;
    (((self.ui).formationEvaluation).gameObject):SetActive(false)
  end
  ;
  ((self.ui).tex_Point):SetIndex(0, tostring(staminaCost))
  ;
  (((self.ui).btn_Recomme).gameObject):SetActive(false)
  do
    if (self.fmtCtrl).fromModule == (FmtEnum.eFmtFromModule).SectorLevel or (self.fmtCtrl).fromModule == (FmtEnum.eFmtFromModule).Infinity then
      local recommeCtrl = ControllerManager:GetController(ControllerTypeId.RecommeFormation, true)
      if recommeCtrl:IsCanReqRecomme(self.sectorStageId, false) then
        (((self.ui).btn_Recomme).gameObject):SetActive(true)
      end
    end
    if self.isOpenChangeFmt then
      (self.troopPool):HideAll()
      for i = 1, (ConfigData.game_config).formationCount do
        local troopItem = (self.troopPool):GetOne()
        troopItem:InitTroopItem(i, self.__SelectFmt)
      end
      ;
      (((self.ui).btn_ChangeTeamName).gameObject):SetActive(true)
      ;
      (((self.ui).btn_SwitchTeam).gameObject):SetActive(true)
      self:__SetSwitchButtonActive(true)
    else
      ;
      (self.troopPool):HideAll()
      ;
      (((self.ui).btn_ChangeTeamName).gameObject):SetActive(false)
      ;
      (((self.ui).btn_SwitchTeam).gameObject):SetActive(false)
      self:__SetSwitchButtonActive(false)
    end
    if self.isCSUnlock then
      self:RefreshCommanderSkill()
      self:RefreshCSLevel()
      self:RefreshCSRedDot()
    end
    if self.isOpenBuffSelect then
      local specificRuler = (self.fmtCtrl).specificHeroDataRuler
      local wcData = specificRuler:GetWCData()
      self:UpdateBuffSelect(wcData:GetLastDebuff())
    end
    do
      self:RefreshCurFmtUI()
      ;
      (((self.ui).btn_ChipBag).gameObject):SetActive((self.fmtCtrl).chipDataList ~= nil and #(self.fmtCtrl).chipDataList > 0)
      if GuideManager:TryTriggerGuide(eGuideCondition.InFormation) then
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
      end
    end
  end
end

UIFormation.__createFmtEvaluationUI = function(self, sectorStageId, fromModule)
  -- function num : 0_7 , upvalues : UINFmtEvaluation
  if self.UIFmtEvaluation == nil then
    self.UIFmtEvaluation = (UINFmtEvaluation.New)()
    ;
    (self.UIFmtEvaluation):Init((self.ui).formationEvaluation)
  end
  ;
  (self.UIFmtEvaluation):InitializeAdvantageConfig(sectorStageId, fromModule)
end

UIFormation.SelectFmt = function(self, id)
  -- function num : 0_8 , upvalues : _ENV
  if (self.editorNode).active then
    (self.editorNode):TryModifyFormation()
  end
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
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_SwitchTeamArrow).localScale = (Vector3.New)(1, -1, 1)
  self:__SetSwitchButtonActive(true)
  self:RefreshFormtionEditor()
end

UIFormation.RefreshCurFmtUI = function(self)
  -- function num : 0_9 , upvalues : _ENV
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

UIFormation.CallEvaluationAnalysisFormation = function(self, formation)
  -- function num : 0_10 , upvalues : _ENV
  if self.UIFmtEvaluation ~= nil then
    local fmtData = (PlayerDataCenter.formationDic)[formation.id]
    if fmtData ~= nil then
      (self.UIFmtEvaluation):AnalysisFormation(fmtData.data)
    end
  end
end

UIFormation.RefreshCommandPower = function(self, permillageLayer)
  -- function num : 0_11 , upvalues : _ENV
  self.stageCombat = self:__GetStageCombat(self.sectorStageId, self.fromModule, permillageLayer)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  if self.stageCombat ~= nil then
    ((self.ui).tex_Power).text = tostring((math.floor)(self.stageCombat))
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_BenchPower).text = tostring((math.floor)(self.benchCombat))
    ;
    ((self.ui).obj_Power):SetActive(true)
    local minPower = (math.floor)(self.stageCombat * 0.9)
    self.isLowPower = self.top5Total or 0 < minPower
  else
    ((self.ui).obj_Power):SetActive(false)
    self.isLowPower = nil
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIFormation.RefreshFmtInfoUI = function(self, totalFtPower, totalBenchPower, campCountDic, top5Total)
  -- function num : 0_12 , upvalues : _ENV
  self.top5Total = top5Total
  if self.stageCombat ~= nil then
    local minPower = (math.floor)(self.stageCombat * 0.9)
    self.isLowPower = top5Total < minPower
  else
    self.isLowPower = nil
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_TotalPower).text = tostring(totalFtPower)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_BenchTotalPower).text = tostring(totalBenchPower)
  self:RefreshFmtPower(totalFtPower, totalBenchPower)
  self:__SetTotalFtPowerWarnTween(totalFtPower, totalBenchPower)
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
  -- function num : 0_13 , upvalues : _ENV
  ((self.ui).switchTeamList):SetActive(true)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_SwitchTeamArrow).localScale = (Vector3.New)(1, 1, 1)
  self:__SetSwitchButtonActive(false)
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
  if fmtCtrl == nil then
    return 
  end
  for _,item in pairs((self.troopPool).listItem) do
    if not item:IsCalcutedPower() then
      local formationData = (PlayerDataCenter.formationDic)[item.id]
      if formationData ~= nil then
        local ftpower, benchPower = fmtCtrl:CalculatePower(formationData)
        item:RefreshPower(ftpower, benchPower)
      else
        do
          do
            item:RefreshPower(0, 0)
            -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC52: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

UIFormation.__OnClickCloseSwitchTeam = function(self)
  -- function num : 0_14 , upvalues : _ENV
  ((self.ui).switchTeamList):SetActive(false)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_SwitchTeamArrow).localScale = (Vector3.New)(1, -1, 1)
  self:__SetSwitchButtonActive(true)
end

UIFormation.OnClickBuffSelect = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local specificRuler = (self.fmtCtrl).specificHeroDataRuler
  if specificRuler ~= nil then
    local buffIdDic = specificRuler:GetWCDuffDic()
    do
      local wcData = specificRuler:GetWCData()
      if buffIdDic ~= nil then
        UIManager:ShowWindowAsync(UIWindowTypeID.PeriodicDebuffSelect, function(window)
    -- function num : 0_15_0 , upvalues : buffIdDic, wcData, _ENV, self
    if window ~= nil then
      window:InitDebuffSelect(buffIdDic, wcData, BindCallback(self.UpdateBuffSelect, self), ((self.fmtCtrl).virtualFormationData).buffIds, function(permillageLayer)
      -- function num : 0_15_0_0 , upvalues : self
      self:RefreshCommandPower(permillageLayer)
    end
)
    end
  end
)
      end
    end
  end
end

UIFormation.UpdateBuffSelect = function(self, buffIds)
  -- function num : 0_16
  (self.fmtCtrl):UpdateBuffSelected(buffIds)
  self:RefreshBuffState()
end

UIFormation.RefreshBuffState = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local specificRuler = (self.fmtCtrl).specificHeroDataRuler
  if specificRuler ~= nil then
    local buffIdDic = specificRuler:GetWCDuffDic()
    local wcData = specificRuler:GetWCData()
    if buffIdDic ~= nil then
      local selectedBuffIds = ((self.fmtCtrl).virtualFormationData).buffIds
      local permillageAll = 0
      for _,buffId in ipairs(selectedBuffIds) do
        permillageAll = permillageAll + buffIdDic[buffId]
      end
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).tex_Gain).text = tostring((Mathf.Floor)((permillageAll) / 10)) .. "%"
      local layer = (Mathf.Floor)((permillageAll) / 100)
      ;
      ((self.ui).tex_Layer):SetIndex(0, tostring(layer))
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((self.ui).tex_EnemyPower).text = tostring((math.floor)(wcData.baseRecommandPower * (1 + layer * wcData.weeklyRecommandPowerEffectRate)))
    end
  end
end

UIFormation.__RefreshCampBond = function(self, campCountDic)
  -- function num : 0_18 , upvalues : _ENV
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
    -- function num : 0_18_0
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
    bondItem:InitFmtCampFetterItem(v.campId, v.count, self.resloader, clickCallback)
  end
end

UIFormation.ShowFmtCampFetter = function(self, campId)
  -- function num : 0_19 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.CampBond, function(window)
    -- function num : 0_19_0 , upvalues : self, campId
    window:InitCampBond(self.campCountDic, campId)
  end
)
end

UIFormation.RefreshCommanderSkill = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local fmtData = nil
  if (self.fmtCtrl).virtualFormationData ~= nil then
    fmtData = ((self.fmtCtrl).virtualFormationData).formation
  else
    fmtData = (PlayerDataCenter.formationDic)[self.fmtId]
  end
  ;
  (self.commanderSkillPool):HideAll()
  if fmtData ~= nil and fmtData.cst ~= nil then
    local treeId = (fmtData.cst).treeId
    do
      for _,skillId in pairs(((fmtData.cst).saving).skillActive) do
        local item = (self.commanderSkillPool):GetOne()
        item:InitCommanderSkill(treeId, skillId, self.resloader)
      end
      local treeData = ((PlayerDataCenter.CommanderSkillModualData).CommanderSkillTreeDataDic)[(fmtData.cst).treeId]
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tex_ComSkillName).text = treeData:GetName()
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).img_ComSkillIcon).enabled = false
      ;
      (self.resloader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("CommanderSkillIcons"), function(spriteAtlas)
    -- function num : 0_20_0 , upvalues : self, treeData
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_ComSkillIcon).sprite = spriteAtlas:GetSprite(treeData:GetIcon())
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_ComSkillIcon).enabled = true
  end
)
    end
  end
end

UIFormation.RefreshCSLevel = function(self)
  -- function num : 0_21 , upvalues : _ENV
  local fmtData = (PlayerDataCenter.formationDic)[self.fmtId]
  if fmtData ~= nil and fmtData.cst ~= nil then
    local cst = fmtData.cst
    local treeId = (((PlayerDataCenter.formationDic)[self.fmtId]).cst).treeId
    local commandSkillTreeData = ((PlayerDataCenter.CommanderSkillModualData).CommanderSkillTreeDataDic)[treeId]
    local treeLevel = commandSkillTreeData.level
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).CS_tex_ComSkillName).text = commandSkillTreeData:GetName()
    ;
    ((self.ui).CS_text_Temp):SetIndex(0, tostring(treeLevel))
  else
    do
      ;
      ((self.ui).CS_text_Temp):SetIndex(0, "0")
    end
  end
end

UIFormation.RefreshCSRedDot = function(self)
  -- function num : 0_22 , upvalues : _ENV
  ((self.ui).CS_obj_RedDot):SetActive((PlayerDataCenter.CommanderSkillModualData):GetIsHaveCouldUpgradeCST())
end

UIFormation.UnlockCommanderSkillUI = function(self, isUnlock)
  -- function num : 0_23
  (((self.ui).btn_CommanderSkill).gameObject):SetActive(isUnlock)
end

UIFormation.EditFormationName = function(self, fmtName)
  -- function num : 0_24 , upvalues : _ENV
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
  -- function num : 0_25 , upvalues : _ENV
  local name = ((self.ui).btn_ChangeTeamName).text
  local troopItem = ((self.troopPool).listItem)[self.fmtId]
  if troopItem ~= nil then
    troopItem:RefreshTroopName(name)
  end
  local formationData = (PlayerDataCenter.formationDic)[self.fmtId]
  formationData.name = name
end

UIFormation.OnClickFmtHeroDetail = function(self)
  -- function num : 0_26
  (self.fmtCtrl):ShowFmtHeroDetail()
end

UIFormation.OnClickCommanderSkillDetail = function(self)
  -- function num : 0_27
  (self.fmtCtrl):ShowCommanderSkillDetail()
end

UIFormation.CreatFmtHeroInfo = function(self, heroData, position)
  -- function num : 0_28
  local infoItem = (self.heroInfoPool):GetOne()
  infoItem:InitFmtHeroInfo(heroData, self, (self.fmtCtrl).virtualFormationData ~= nil)
  infoItem:UpdateFmtHeroInfoPos(position)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.heroInfoDic)[heroData.dataId] = infoItem
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UIFormation.UpdateFmtHeroInfo = function(self, heroData, position, onlyPos)
  -- function num : 0_29
  local infoItem = (self.heroInfoDic)[heroData.dataId]
  if infoItem == nil then
    return 
  end
  if not onlyPos then
    infoItem:InitFmtHeroInfo(heroData, self)
  end
  infoItem:UpdateFmtHeroInfoPos(position)
end

UIFormation.ShowFmtHeroInfo = function(self, heroId, show)
  -- function num : 0_30
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
  -- function num : 0_31
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
  -- function num : 0_32 , upvalues : cs_MessageCommon, _ENV
  if self.fmtCtrl ~= nil then
    if self.isLowPower then
      (cs_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(388), function()
    -- function num : 0_32_0 , upvalues : self
    (self.fmtCtrl):FmtStartBattle()
  end
, nil)
    else
      ;
      (self.fmtCtrl):FmtStartBattle()
    end
  end
end

UIFormation.OnClickBack = function(self)
  -- function num : 0_33
  (self.fmtCtrl):ExitFormation()
end

UIFormation.OnClickToLastTeam = function(self)
  -- function num : 0_34
  self:__ChangeFormationTeam(-1)
end

UIFormation.OnClickToNextTeam = function(self)
  -- function num : 0_35
  self:__ChangeFormationTeam(1)
end

UIFormation.__ChangeFormationTeam = function(self, num)
  -- function num : 0_36 , upvalues : _ENV
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
  -- function num : 0_37
  (((self.ui).btn_LastTeam).gameObject):SetActive(active)
  ;
  (((self.ui).btn_NextTeam).gameObject):SetActive(active)
end

UIFormation.OnClickRecomme = function(self)
  -- function num : 0_38 , upvalues : _ENV
  local recommeCtr = ControllerManager:GetController(ControllerTypeId.RecommeFormation, true)
  recommeCtr:ReqRecommeFormation(self.sectorStageId, true)
end

UIFormation.__GetStageCombat = function(self, sectorStageId, fromModule, permillageLayer)
  -- function num : 0_39 , upvalues : FmtEnum, _ENV
  local stageCfg = nil
  if fromModule == (FmtEnum.eFmtFromModule).SectorLevel then
    stageCfg = (ConfigData.sector_stage)[sectorStageId]
  else
    if fromModule == (FmtEnum.eFmtFromModule).Infinity then
      local endlessLevel = ((ConfigData.endless).levelDic)[sectorStageId]
      if endlessLevel == nil then
        return 
      end
      stageCfg = ((ConfigData.endless)[endlessLevel.sectorId])[endlessLevel.index]
    else
      do
        if fromModule == (FmtEnum.eFmtFromModule).FriendshipDungeon then
          stageCfg = (ConfigData.battle_dungeon)[sectorStageId]
        else
          if fromModule == (FmtEnum.eFmtFromModule).MaterialDungeon then
            stageCfg = (ConfigData.battle_dungeon)[sectorStageId]
          else
            if fromModule == (FmtEnum.eFmtFromModule).ATHDungeon then
              stageCfg = (ConfigData.battle_dungeon)[sectorStageId]
            end
          end
        end
        if stageCfg == nil then
          return 
        end
        return stageCfg.combat, stageCfg.bench_combat
      end
    end
  end
end

UIFormation.__SetTotalFtPowerWarnTween = function(self, totalFtPower, totalBenchPower)
  -- function num : 0_40 , upvalues : cs_tweening
  local totalFtPowerWarn = false
  ;
  ((self.ui).img_LowPower):DORewind()
  ;
  ((self.ui).img_LowPower):DOKill()
  if self.stageCombat ~= nil and totalFtPower ~= nil and totalFtPower < self.stageCombat then
    ((((self.ui).img_LowPower):DOFade(0, 1.5)):SetLoops(-1, (cs_tweening.LoopType).Yoyo)):SetLink(((self.ui).img_LowPower).gameObject)
    totalFtPowerWarn = true
  end
  local totalBenchPowerWarn = false
  ;
  ((self.ui).img_LowBeachPow):DORewind()
  ;
  ((self.ui).img_LowBeachPow):DOKill()
  if self.benchCombat ~= nil and totalBenchPower ~= nil and totalBenchPower < self.benchCombat then
    ((((self.ui).img_LowBeachPow):DOFade(0, 1.5)):SetLoops(-1, (cs_tweening.LoopType).Yoyo)):SetLink(((self.ui).img_LowBeachPow).gameObject)
    totalBenchPowerWarn = true
  end
  -- DECOMPILER ERROR at PC70: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_LowPower).enabled = totalFtPowerWarn
  -- DECOMPILER ERROR at PC73: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_LowBeachPow).enabled = totalBenchPowerWarn
  self._totalFtPowerWarn = totalFtPowerWarn
  ;
  ((self.fmtCtrl).fmtSceneCtrl):RefreshFmtSCHeroQuickLvUp()
end

UIFormation.OnClickChipPreview = function(self)
  -- function num : 0_41 , upvalues : _ENV
  local chipDataList = (self.fmtCtrl).chipDataList
  if chipDataList ~= nil and #chipDataList > 0 then
    UIManager:ShowWindowAsync(UIWindowTypeID.CurrentChip, function(window)
    -- function num : 0_41_0 , upvalues : chipDataList
    window:InitCurrentChip(chipDataList)
  end
)
  end
end

UIFormation.OnClickEditor = function(self)
  -- function num : 0_42
  if (self.fmtCtrl).virtualFormationData ~= nil then
    (self.fmtCtrl):ShowQuickFormation(nil)
    return 
  end
  ;
  (self.fmtCtrl):EnterEditMode()
end

UIFormation.OnEnterEditorMode = function(self)
  -- function num : 0_43
  if (self.editorNode).active then
    return 
  end
  ;
  (self.editorNode):Show()
  ;
  (self.editorNode):InitFormationChoice(self, true)
  ;
  (self.editorModelSeq):Restart()
  self:_SwitchPageTween(self.editorSeq)
  self:ShowFmtHeroQuickLvUp(false)
end

UIFormation.OnExitEditorMode = function(self)
  -- function num : 0_44
  if not (self.editorNode).active then
    return 
  end
  ;
  (((self.ui).notEditorNodeFade).gameObject):SetActive(true)
  ;
  (self.editorModelSeq):PlayBackwards()
  self:_SwitchPageTween(self.notEditorSeq)
  self:RefreshCurFmtUI()
end

UIFormation.RefreshFormtionEditor = function(self)
  -- function num : 0_45
  if (self.editorNode).active then
    (self.editorNode):InitFormationChoice(self, false)
  end
end

UIFormation._SwitchPageTween = function(self, curPageSeq)
  -- function num : 0_46
  if self.curPageSeq == curPageSeq then
    return 
  end
  ;
  (self.curPageSeq):PlayBackwards()
  curPageSeq:Restart()
  self.curPageSeq = curPageSeq
end

UIFormation._InitPageSeq = function(self, pageFade, rewindAct)
  -- function num : 0_47 , upvalues : cs_tweening
  local pageSeq = ((cs_tweening.DOTween).Sequence)()
  pageSeq:Append((pageFade:DOFade(0, 0.5)):From())
  pageSeq:Join(((pageFade.transform):DOAnchorPosY(((pageFade.transform).anchoredPosition).y - 200, 0.5)):From())
  pageSeq:OnRewind(rewindAct)
  pageSeq:Pause()
  pageSeq:SetAutoKill(false)
  return pageSeq
end

UIFormation.ShowChangeMark = function(self, flag)
  -- function num : 0_48 , upvalues : _ENV
  for k,heroInfoItem in pairs(self.heroInfoDic) do
    heroInfoItem:SetChangeMarkState(flag)
  end
end

UIFormation.SetUIFmtHeroInfoItemLv = function(self, heroId, level)
  -- function num : 0_49
  local heroItem = (self.heroInfoDic)[heroId]
  if heroItem ~= nil then
    heroItem:SetFmtHeroInfoItemLv(level)
  end
end

UIFormation.SetUIFmtExpNum = function(self, exp)
  -- function num : 0_50 , upvalues : _ENV
  (self.resourceGroup):SetResItemNum(ConstGlobalItem.HeroExp, exp)
end

UIFormation.UpdateItemForFmtInfo = function(self)
  -- function num : 0_51 , upvalues : _ENV
  if (self.fmtCtrl).virtualFormationData ~= nil then
    return 
  end
  for _,fmtHeroInfoItem in ipairs((self.heroInfoPool).listItem) do
    fmtHeroInfoItem:RefreshLevelTip()
  end
  ;
  ((self.fmtCtrl).fmtSceneCtrl):RefreshFmtSCHeroQuickLvUp()
end

UIFormation.ShowFmtHeroQuickLvUp = function(self, show)
  -- function num : 0_52
  self._heroQuickLvUpShow = show
  ;
  ((self.fmtCtrl).fmtSceneCtrl):RefreshFmtSCHeroQuickLvUp()
end

UIFormation.GetFmtHeroQuickLvUpBtnShow = function(self, heroData)
  -- function num : 0_53
  if not self._heroQuickLvUpShow then
    return false
  end
  if (self.fmtCtrl).virtualFormationData ~= nil then
    return false
  end
  return true
end

UIFormation.IsFmtToltalPowerWarn = function(self)
  -- function num : 0_54
  return self._totalFtPowerWarn
end

UIFormation.UpdateHeroForFmtInfo = function(self, heroUpdateDic)
  -- function num : 0_55 , upvalues : _ENV
  for _,fmtHeroInfoItem in ipairs((self.heroInfoPool).listItem) do
    if fmtHeroInfoItem.heroData ~= nil and heroUpdateDic[(fmtHeroInfoItem.heroData).dataId] ~= nil then
      fmtHeroInfoItem:RefreshFmtheroInfo()
    end
  end
end

UIFormation.HeroCardStarUpForFmtInfo = function(self)
  -- function num : 0_56 , upvalues : _ENV
  if (self.fmtCtrl).virtualFormationData ~= nil then
    return 
  end
  for _,fmtHeroInfoItem in ipairs((self.heroInfoPool).listItem) do
    fmtHeroInfoItem:RefreshReddotTip()
  end
end

UIFormation.RefreshFmtPower = function(self, totalFtPower, totalBenchPower)
  -- function num : 0_57 , upvalues : _ENV
  for _,troopItem in ipairs((self.troopPool).listItem) do
    if troopItem.id == self.fmtId then
      troopItem:RefreshPower(totalFtPower, totalBenchPower)
      break
    end
  end
end

UIFormation.OnDelete = function(self)
  -- function num : 0_58 , upvalues : JumpManager, _ENV, base
  JumpManager.couldUseItemJump = false
  MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillChande, self.__RefreshCommanderSkill)
  MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillMasterLevelDiffer, self.__RefreshCSLevel)
  MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillLevelDiffer, self.__RefreshCSLevel)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__RefreshCSRedDot)
  MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillTreeDataDiffer, self.__RefreshCSRedDot)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__UpdateItemForFmtInfo)
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__UpdateHeroForFmtInfo)
  RedDotController:RemoveListener(RedDotDynPath.HeroCardStartUpPath, self.__HeroCardStarUpForFmtInfo)
  ;
  (self.troopPool):DeleteAll()
  ;
  (self.heroInfoPool):DeleteAll()
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  if self.__ftPowerWarn ~= nil then
    (self.__ftPowerWarn):Rewind()
    ;
    (self.__ftPowerWarn):Kill()
    self.__ftPowerWarn = nil
  end
  if self.editorModelSeq ~= nil then
    (self.editorModelSeq):Kill()
    self.editorModelSeq = nil
  end
  if self.notEditorSeq ~= nil then
    (self.notEditorSeq):Kill()
    self.notEditorSeq = nil
  end
  if self.editorSeq ~= nil then
    (self.editorSeq):Kill()
    self.editorSeq = nil
  end
  ;
  (self.editorNode):Delete()
  if self.resourceGroup ~= nil then
    (self.resourceGroup):Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UIFormation

