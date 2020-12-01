-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFormation = class("UIFormation", UIBaseWindow)
local base = UIBaseWindow
local UINTroopItem = require("Game.Formation.UI.UINTroopItem")
local UINCommanderSkill = require("Game.Formation.UI.UINCommanderSkill")
local UINFmtHeroInfoItem = require("Game.Formation.UI.UINFmtHeroInfoItem")
local UINCampBond3DItem = require("Game.Formation.UI.3DFormation.UINCampBond3DItem")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
UIFormation.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINResourceGroup, UINFmtHeroInfoItem, UINTroopItem, UINCommanderSkill
  self.fmtId = nil
  ;
  (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self, self.OnClickBack)
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
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).switchTeamList = ((((self.ui).btn_closeTeamList).transform).parent).gameObject
  ;
  (((self.ui).btn_ChangeTeamName).onEndEdit):AddListener(BindCallback(self, self.EditFormationName))
  self.resourceGroup = (UINResourceGroup.New)()
  ;
  (self.resourceGroup):Init((self.ui).gameResourceGroup)
  ;
  (self.resourceGroup):SetResourceIds({ItemIdOfKey})
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
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
  self.isCSUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill)
  self.isCSUIUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill_Ui)
  if self.isCSUnlock then
    self:UnlockCommanderSkillUI(self.isCSUIUnlock)
    self.isOpenOverClock = false
    self.isOpenCampInfluence = false
    self.teamCountList = {}
    for i = 2, (ConfigData.game_config).formationCount do
      ((self.ui).img_TeamCount):Instantiate()
    end
  end
end

UIFormation.OpenCampInfluence = function(self, isOpen)
  -- function num : 0_1 , upvalues : _ENV, UINCampBond3DItem
  self.isOpenCampInfluence = isOpen
  if isOpen then
    (((self.ui).campList).gameObject):SetActive(false)
    ;
    (UIUtil.AddButtonListener)((self.ui).campList, self, self.ShowFmtCampFetter)
    self.campBondPool = (UIItemPool.New)(UINCampBond3DItem, (self.ui).campItem)
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
  -- function num : 0_3 , upvalues : _ENV
  self.fmtId = fmtId
  self.fmtCtrl = fmtCtrl
  ;
  ((self.ui).tex_Point):SetIndex(0, tostring(staminaCost))
  ;
  (self.troopPool):HideAll()
  for i = 1, (ConfigData.game_config).formationCount do
    local troopItem = (self.troopPool):GetOne()
    troopItem:InitTroopItem(i, self.__SelectFmt)
  end
  if self.isCSUnlock then
    self:RefreshCommanderSkill()
    self:RefreshCSLevel()
  end
  self.__isInit = true
  self:RefreshCurFmtUI()
  if self.isOpenOverClock then
    (self.OverclockCtrl):SetStageId(sectorStageId, fromModule)
    ;
    (self.OverclockCtrl):CleanData()
  end
  if GuideManager:TryTriggerGuide(eGuideCondition.InFormation) then
  end
end

UIFormation.SelectFmt = function(self, id)
  -- function num : 0_4 , upvalues : _ENV
  if self.__isInit then
    self.__isInit = false
    return 
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
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).img_SwitchTeamArrow).localScale = (Vector3.New)(1, -1, 1)
  self:__SetSwitchButtonActive(true)
end

UIFormation.RefreshCurFmtUI = function(self)
  -- function num : 0_5 , upvalues : _ENV
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
end

UIFormation.RefreshFmtInfoUI = function(self, totalFtPower, campCountDic)
  -- function num : 0_6 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).tex_TotalPower).text = tostring(totalFtPower)
  if self.isOpenCampInfluence then
    self:__RefreshCampBond(campCountDic)
  end
end

UIFormation.__OnClickSwitchTeam = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((self.ui).switchTeamList):SetActive(true)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_SwitchTeamArrow).localScale = (Vector3.New)(1, 1, 1)
  self:__SetSwitchButtonActive(false)
end

UIFormation.__OnClickCloseSwitchTeam = function(self)
  -- function num : 0_8 , upvalues : _ENV
  ((self.ui).switchTeamList):SetActive(false)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_SwitchTeamArrow).localScale = (Vector3.New)(1, -1, 1)
  self:__SetSwitchButtonActive(true)
end

UIFormation.OnOverClockClick = function(self)
  -- function num : 0_9 , upvalues : _ENV
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
  -- function num : 0_10
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
  -- function num : 0_11 , upvalues : _ENV
  self.campCountDic = campCountDic
  local campCountList = {}
  for k,v in pairs(campCountDic) do
    local campCount = {campId = k, count = v}
    ;
    (table.insert)(campCountList, campCount)
  end
  ;
  (table.sort)(campCountList, function(a, b)
    -- function num : 0_11_0
    if b.count >= a.count then
      do return a.count == b.count end
      do return a.campId < b.campId end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  if self.campBondPool ~= nil then
    (self.campBondPool):HideAll()
  end
  for k,v in pairs(campCountList) do
    local bondItem = (self.campBondPool):GetOne()
    bondItem:InitCampBond3DItem(v.campId, v.count)
  end
end

UIFormation.ShowFmtCampFetter = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if self.campCountDic == nil or (table.count)(self.campCountDic) == 0 or not self.isOpenCampInfluence then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CampBond, function(window)
    -- function num : 0_12_0 , upvalues : self
    window:InitCampBond(self.campCountDic)
  end
)
end

UIFormation.RefreshCommanderSkill = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local fmtId = self.fmtId
  ;
  (self.commanderSkillPool):HideAll()
  if ((PlayerDataCenter.formationDic)[fmtId]).cst ~= nil then
    local treeId = (((PlayerDataCenter.formationDic)[fmtId]).cst).treeId
    for _,skillId in pairs(((PlayerDataCenter.formationDic)[fmtId]).userSkill) do
      local item = (self.commanderSkillPool):GetOne()
      item:InitCommanderSkill(treeId, skillId, (self.fmtCtrl).resloader)
    end
  end
end

UIFormation.RefreshCSLevel = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local cst = ((PlayerDataCenter.formationDic)[self.fmtId]).cst
  if cst ~= nil then
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

UIFormation.UnlockCommanderSkillUI = function(self, isUnlock)
  -- function num : 0_15
  (((self.ui).btn_CommanderSkill).gameObject):SetActive(isUnlock)
end

UIFormation.EditFormationName = function(self, fmtName)
  -- function num : 0_16 , upvalues : _ENV
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
  -- function num : 0_17 , upvalues : _ENV
  local name = ((self.ui).btn_ChangeTeamName).text
  local troopItem = ((self.troopPool).listItem)[self.fmtId]
  if troopItem ~= nil then
    troopItem:RefreshTroopName(name)
  end
  local formationData = (PlayerDataCenter.formationDic)[self.fmtId]
  formationData.name = name
end

UIFormation.OnClickFmtHeroDetail = function(self)
  -- function num : 0_18
  (self.fmtCtrl):ShowFmtHeroDetail()
end

UIFormation.OnClickCommanderSkillDetail = function(self)
  -- function num : 0_19
  (self.fmtCtrl):ShowCommanderSkillDetail()
end

UIFormation.CreatFmtHeroInfo = function(self, heroData, position)
  -- function num : 0_20
  local infoItem = (self.heroInfoPool):GetOne()
  infoItem:InitFmtHeroInfo(heroData)
  infoItem:UpdateFmtHeroInfoPos(position)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.heroInfoDic)[heroData.dataId] = infoItem
end

UIFormation.UpdateFmtHeroInfo = function(self, heroData, position, onlyPos)
  -- function num : 0_21
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
  -- function num : 0_22
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
  -- function num : 0_23
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
  -- function num : 0_24
  if self.fmtCtrl ~= nil then
    (self.fmtCtrl):FmtStartBattle()
  end
end

UIFormation.OnClickBack = function(self)
  -- function num : 0_25
  (self.fmtCtrl):ExitFormation()
end

UIFormation.OnClickToLastTeam = function(self)
  -- function num : 0_26
  self:__ChangeFormationTeam(-1)
end

UIFormation.OnClickToNextTeam = function(self)
  -- function num : 0_27
  self:__ChangeFormationTeam(1)
end

UIFormation.__ChangeFormationTeam = function(self, num)
  -- function num : 0_28 , upvalues : _ENV
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
  -- function num : 0_29
  (((self.ui).btn_LastTeam).gameObject):SetActive(active)
  ;
  (((self.ui).btn_NextTeam).gameObject):SetActive(active)
end

UIFormation.OnDelete = function(self)
  -- function num : 0_30 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillChande, self.__RefreshCommanderSkill)
  MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillMasterLevelDiffer, self.__RefreshCSLevel)
  MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillLevelDiffer, self.__RefreshCSLevel)
  ;
  (self.troopPool):DeleteAll()
  ;
  (self.resourceGroup):Delete()
  ;
  (base.OnDelete)(self)
end

return UIFormation

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFormation = class("UIFormation", UIBaseWindow)
local base = UIBaseWindow
local UINTroopItem = require("Game.Formation.UI.UINTroopItem")
local UINCommanderSkill = require("Game.Formation.UI.UINCommanderSkill")
local UINFmtHeroInfoItem = require("Game.Formation.UI.UINFmtHeroInfoItem")
local UINCampBond3DItem = require(
                              "Game.Formation.UI.3DFormation.UINCampBond3DItem")
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
UIFormation.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINResourceGroup, UINFmtHeroInfoItem, UINTroopItem, UINCommanderSkill
    self.fmtId = nil;
    (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self, self.OnClickBack);
    (UIUtil.AddButtonListener)((self.ui).btn_ShowTeamDetail, self,
                               self.OnClickFmtHeroDetail);
    (UIUtil.AddButtonListener)((self.ui).btn_CommanderSkill, self,
                               self.OnClickCommanderSkillDetail);
    (UIUtil.AddButtonListener)((self.ui).btn_SwitchTeam, self,
                               self.__OnClickSwitchTeam);
    (UIUtil.AddButtonListener)((self.ui).btn_closeTeamList, self,
                               self.__OnClickCloseSwitchTeam);
    (UIUtil.AddButtonListener)((self.ui).btn_Battle, self,
                               self.OnClickStartBattle);
    (UIUtil.AddButtonListener)((self.ui).btn_LastTeam, self,
                               self.OnClickToLastTeam);
    (UIUtil.AddButtonListener)((self.ui).btn_NextTeam, self,
                               self.OnClickToNextTeam) -- DECOMPILER ERROR at PC63: Confused about usage of register: R1 in 'UnsetPending'
    ;
    (self.ui).switchTeamList =
        ((((self.ui).btn_closeTeamList).transform).parent).gameObject;
    (((self.ui).btn_ChangeTeamName).onEndEdit):AddListener(
        BindCallback(self, self.EditFormationName))
    self.resourceGroup = (UINResourceGroup.New)();
    (self.resourceGroup):Init((self.ui).gameResourceGroup);
    (self.resourceGroup):SetResourceIds({ItemIdOfKey});
    ((self.ui).campItem):SetActive(false);
    ((self.ui).fHeroInfoItem):SetActive(false)
    self.heroInfoPool = (UIItemPool.New)(UINFmtHeroInfoItem,
                                         (self.ui).fHeroInfoItem)
    self.heroInfoDic = {};
    ((self.ui).switchTeamItem):SetActive(false)
    self.troopPool = (UIItemPool.New)(UINTroopItem, (self.ui).switchTeamItem);
    ((self.ui).skillItem):SetActive(false)
    self.commanderSkillPool = (UIItemPool.New)(UINCommanderSkill,
                                               (self.ui).skillItem)
    self.__SelectFmt = BindCallback(self, self.SelectFmt)
    self.heroNetwork = NetworkManager:GetNetwork(NetworkTypeID.Hero)
    self.__RefreshCommanderSkill =
        BindCallback(self, self.RefreshCommanderSkill)
    MsgCenter:AddListener(eMsgEventId.OnCommanderSkillChande,
                          self.__RefreshCommanderSkill)
    self.__RefreshCSLevel = BindCallback(self, self.RefreshCSLevel)
    MsgCenter:AddListener(eMsgEventId.OnCommanderSkillMasterLevelDiffer,
                          self.__RefreshCSLevel)
    MsgCenter:AddListener(eMsgEventId.OnCommanderSkillLevelDiffer,
                          self.__RefreshCSLevel)
    local funcUnLockCrtl = ControllerManager:GetController(
                               ControllerTypeId.FunctionUnlock, true)
    self.isCSUnlock = funcUnLockCrtl:ValidateUnlock(
                          proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill)
    self.isCSUIUnlock = funcUnLockCrtl:ValidateUnlock(
                            proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill_Ui)
    if self.isCSUnlock then
        self:UnlockCommanderSkillUI(self.isCSUIUnlock)
        self.isOpenOverClock = false
        self.isOpenCampInfluence = false
        self.teamCountList = {}
        for i = 2, (ConfigData.game_config).formationCount do
            ((self.ui).img_TeamCount):Instantiate()
        end
    end
end

UIFormation.OpenCampInfluence = function(self, isOpen)
    -- function num : 0_1 , upvalues : _ENV, UINCampBond3DItem
    self.isOpenCampInfluence = isOpen
    if isOpen then
        (((self.ui).campList).gameObject):SetActive(false);
        (UIUtil.AddButtonListener)((self.ui).campList, self,
                                   self.ShowFmtCampFetter)
        self.campBondPool = (UIItemPool.New)(UINCampBond3DItem,
                                             (self.ui).campItem)
    else

        (((self.ui).campList).gameObject):SetActive(false)
    end
end

UIFormation.OpenOverClock = function(self, isOpen)
    -- function num : 0_2 , upvalues : _ENV
    self.isOpenOverClock = isOpen
    if isOpen then
        (((self.ui).overLock).gameObject):SetActive(true);
        (UIUtil.AddButtonListener)((self.ui).overLock, self,
                                   self.OnOverClockClick)
        self.OverclockCtrl = ControllerManager:GetController(
                                 ControllerTypeId.Overclock, true);
        (self.OverclockCtrl):RefreshData(
            function()
                -- function num : 0_2_0 , upvalues : self
                self.img_OverLockCountSize =
                    ((((self.ui).img_OverLockCount).transform).sizeDelta).x
                self:RefreshOverClockUI()
            end)
    else

        (((self.ui).overLock).gameObject):SetActive(false)
    end
end

UIFormation.InitUIFormation = function(self, fmtId, fmtCtrl, sectorStageId,
                                       fromModule, staminaCost)
    -- function num : 0_3 , upvalues : _ENV
    self.fmtId = fmtId
    self.fmtCtrl = fmtCtrl;
    ((self.ui).tex_Point):SetIndex(0, tostring(staminaCost));
    (self.troopPool):HideAll()
    for i = 1, (ConfigData.game_config).formationCount do
        local troopItem = (self.troopPool):GetOne()
        troopItem:InitTroopItem(i, self.__SelectFmt)
    end
    if self.isCSUnlock then
        self:RefreshCommanderSkill()
        self:RefreshCSLevel()
    end
    self.__isInit = true
    self:RefreshCurFmtUI()
    if self.isOpenOverClock then
        (self.OverclockCtrl):SetStageId(sectorStageId, fromModule);
        (self.OverclockCtrl):CleanData()
    end
    if GuideManager:TryTriggerGuide(eGuideCondition.InFormation) then end
end

UIFormation.SelectFmt = function(self, id)
    -- function num : 0_4 , upvalues : _ENV
    if self.__isInit then
        self.__isInit = false
        return
    end
    self.fmtId = id;
    (self.fmtCtrl):RefreshFomation(id)
    if self.isCSUnlock then
        self:RefreshCommanderSkill()
        self:RefreshCSLevel()
    end
    self:RefreshCurFmtUI();
    ((self.ui).switchTeamList):SetActive(false) -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).img_SwitchTeamArrow).localScale = (Vector3.New)(1, -1, 1)
    self:__SetSwitchButtonActive(true)
end

UIFormation.RefreshCurFmtUI = function(self)
    -- function num : 0_5 , upvalues : _ENV
    local fmtData = (PlayerDataCenter.formationDic)[self.fmtId]
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

    if fmtData ~= nil and not (string.IsNullOrEmpty)(fmtData.name) then
        ((self.ui).btn_ChangeTeamName).text = fmtData.name
    else
        -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'


        ((self.ui).btn_ChangeTeamName).text =
            ((self.ui).tex_troopName):GetIndex(0, tostring(self.fmtId))
    end -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'
    
    ((self.ui).img_curTeam).anchoredPosition =
        (Vector2.New)((self.fmtId - 1) *
                          ((((self.ui).img_TeamCount).transform).sizeDelta).x, 0)
end

UIFormation.RefreshFmtInfoUI = function(self, totalFtPower, campCountDic)
    -- function num : 0_6 , upvalues : _ENV
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

    ((self.ui).tex_TotalPower).text = tostring(totalFtPower)
    if self.isOpenCampInfluence then self:__RefreshCampBond(campCountDic) end
end

UIFormation.__OnClickSwitchTeam = function(self)
    -- function num : 0_7 , upvalues : _ENV
    ((self.ui).switchTeamList):SetActive(true) -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).img_SwitchTeamArrow).localScale = (Vector3.New)(1, 1, 1)
    self:__SetSwitchButtonActive(false)
end

UIFormation.__OnClickCloseSwitchTeam = function(self)
    -- function num : 0_8 , upvalues : _ENV
    ((self.ui).switchTeamList):SetActive(false) -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).img_SwitchTeamArrow).localScale = (Vector3.New)(1, -1, 1)
    self:__SetSwitchButtonActive(true)
end

UIFormation.OnOverClockClick = function(self)
    -- function num : 0_9 , upvalues : _ENV
    if not self.isOpenOverClock then return end
    (self.OverclockCtrl):ShowOverclockUI() -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'
    ;
    (self.OverclockCtrl).selectChangEvent =
        BindCallback(self, self.RefreshOverClockUI)
end

UIFormation.RefreshOverClockUI = function(self)
    -- function num : 0_10
    if not self.isOpenOverClock then return end
    local curAssembleNum, maxAssembleNum = (self.OverclockCtrl):GetAssembleNum();
    ((self.ui).img_OverLockSelect):SetIndex(curAssembleNum > 0 and 1 or 0)
    local sizeDelta = (((self.ui).img_OverLockCount).transform).sizeDelta
    sizeDelta.x = self.img_OverLockCountSize * curAssembleNum -- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'
    ;
    (((self.ui).img_OverLockCount).transform).sizeDelta = sizeDelta
    sizeDelta = ((self.ui).overlockCountList).sizeDelta
    sizeDelta.x = self.img_OverLockCountSize * maxAssembleNum -- DECOMPILER ERROR at PC36: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).overlockCountList).sizeDelta = sizeDelta
    if (self.OverclockCtrl):GetIsHaveFree() then
        ((self.ui).obj_OverLockFree):SetActive(true)
    else

        ((self.ui).obj_OverLockFree):SetActive(false)
    end
end

UIFormation.__RefreshCampBond = function(self, campCountDic)
    -- function num : 0_11 , upvalues : _ENV
    self.campCountDic = campCountDic
    local campCountList = {}
    for k, v in pairs(campCountDic) do
        local campCount = {campId = k, count = v};
        (table.insert)(campCountList, campCount)
    end
    (table.sort)(campCountList, function(a, b)
        -- function num : 0_11_0
        if b.count >= a.count then
            do return a.count == b.count end
            do return a.campId < b.campId end
            -- DECOMPILER ERROR: 4 unprocessed JMP targets
        end
    end)
    if self.campBondPool ~= nil then (self.campBondPool):HideAll() end
    for k, v in pairs(campCountList) do
        local bondItem = (self.campBondPool):GetOne()
        bondItem:InitCampBond3DItem(v.campId, v.count)
    end
end

UIFormation.ShowFmtCampFetter = function(self)
    -- function num : 0_12 , upvalues : _ENV
    if self.campCountDic == nil or (table.count)(self.campCountDic) == 0 or
        not self.isOpenCampInfluence then return end
    UIManager:ShowWindowAsync(UIWindowTypeID.CampBond, function(window)
        -- function num : 0_12_0 , upvalues : self
        window:InitCampBond(self.campCountDic)
    end)
end

UIFormation.RefreshCommanderSkill = function(self)
    -- function num : 0_13 , upvalues : _ENV
    local fmtId = self.fmtId;
    (self.commanderSkillPool):HideAll()
    if ((PlayerDataCenter.formationDic)[fmtId]).cst ~= nil then
        local treeId = (((PlayerDataCenter.formationDic)[fmtId]).cst).treeId
        for _, skillId in pairs(
                              ((PlayerDataCenter.formationDic)[fmtId]).userSkill) do
            local item = (self.commanderSkillPool):GetOne()
            item:InitCommanderSkill(treeId, skillId, (self.fmtCtrl).resloader)
        end
    end
end

UIFormation.RefreshCSLevel = function(self)
    -- function num : 0_14 , upvalues : _ENV
    local cst = ((PlayerDataCenter.formationDic)[self.fmtId]).cst
    if cst ~= nil then
        local treeId =
            (((PlayerDataCenter.formationDic)[self.fmtId]).cst).treeId
        local treeLevel =
            (((PlayerDataCenter.CommanderSkillModualData).CommanderSkillTreeDataDic)[treeId]).level
        do
            do
                if not (PlayerDataCenter.CommanderSkillModualData).masterLevel then
                    local masterLevel = treeLevel ~=
                                            #ConfigData.commander_skill_level or
                                            0
                end
                if masterLevel > 0 then
                    ((self.ui).CS_text_Temp):SetIndex(0, tostring(masterLevel))
                else

                    ((self.ui).CS_text_Temp):SetIndex(0, tostring(treeLevel))
                end
                ((self.ui).CS_text_Temp):SetIndex(0, tostring(treeLevel));
                ((self.ui).CS_text_Temp):SetIndex(0, "0")
            end
        end
    end
end

UIFormation.UnlockCommanderSkillUI = function(self, isUnlock)
    -- function num : 0_15
    (((self.ui).btn_CommanderSkill).gameObject):SetActive(isUnlock)
end

UIFormation.EditFormationName = function(self, fmtName)
    -- function num : 0_16 , upvalues : _ENV
    if (string.IsNullOrEmpty)(fmtName) then return end
    local formationData = (PlayerDataCenter.formationDic)[self.fmtId]
    if formationData ~= nil and formationData.name == fmtName then return end
    if self.__OnEditFormationName == nil then
        self.__OnEditFormationName = BindCallback(self,
                                                  self.__OnEditFormationNameComplete)
    end
    (self.heroNetwork):CS_HERO_FormationNameFresh(self.fmtId, fmtName,
                                                  self.__OnEditFormationName)
end

UIFormation.__OnEditFormationNameComplete =
    function(self)
        -- function num : 0_17 , upvalues : _ENV
        local name = ((self.ui).btn_ChangeTeamName).text
        local troopItem = ((self.troopPool).listItem)[self.fmtId]
        if troopItem ~= nil then troopItem:RefreshTroopName(name) end
        local formationData = (PlayerDataCenter.formationDic)[self.fmtId]
        formationData.name = name
    end

UIFormation.OnClickFmtHeroDetail = function(self)
    -- function num : 0_18
    (self.fmtCtrl):ShowFmtHeroDetail()
end

UIFormation.OnClickCommanderSkillDetail =
    function(self)
        -- function num : 0_19
        (self.fmtCtrl):ShowCommanderSkillDetail()
    end

UIFormation.CreatFmtHeroInfo = function(self, heroData, position)
    -- function num : 0_20
    local infoItem = (self.heroInfoPool):GetOne()
    infoItem:InitFmtHeroInfo(heroData)
    infoItem:UpdateFmtHeroInfoPos(position) -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'
    ;
    (self.heroInfoDic)[heroData.dataId] = infoItem
end

UIFormation.UpdateFmtHeroInfo = function(self, heroData, position, onlyPos)
    -- function num : 0_21
    local infoItem = (self.heroInfoDic)[heroData.dataId]
    if infoItem == nil then return end
    if not onlyPos then infoItem:InitFmtHeroInfo(heroData) end
    infoItem:UpdateFmtHeroInfoPos(position)
end

UIFormation.ShowFmtHeroInfo = function(self, heroId, show)
    -- function num : 0_22
    local infoItem = (self.heroInfoDic)[heroId]
    if infoItem == nil then return end
    if show then
        infoItem:Show()
    else
        infoItem:Hide()
    end
end

UIFormation.ReturnFmtHeroInfo = function(self, heroId)
    -- function num : 0_23
    local infoItem = (self.heroInfoDic)[heroId]
    if infoItem == nil then return end -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'
    
    (self.heroInfoDic)[heroId] = nil;
    (self.heroInfoPool):HideOne(infoItem)
end

UIFormation.OnClickStartBattle = function(self)
    -- function num : 0_24
    if self.fmtCtrl ~= nil then (self.fmtCtrl):FmtStartBattle() end
end

UIFormation.OnClickBack = function(self)
    -- function num : 0_25
    (self.fmtCtrl):ExitFormation()
end

UIFormation.OnClickToLastTeam = function(self)
    -- function num : 0_26
    self:__ChangeFormationTeam(-1)
end

UIFormation.OnClickToNextTeam = function(self)
    -- function num : 0_27
    self:__ChangeFormationTeam(1)
end

UIFormation.__ChangeFormationTeam = function(self, num)
    -- function num : 0_28 , upvalues : _ENV
    local id = self.fmtId + num
    if (ConfigData.game_config).formationCount < id then
        id = 1
    else
        if id < 1 then id = (ConfigData.game_config).formationCount end
    end
    self:SelectFmt(id)
end

UIFormation.__SetSwitchButtonActive = function(self, active)
    -- function num : 0_29
    (((self.ui).btn_LastTeam).gameObject):SetActive(active);
    (((self.ui).btn_NextTeam).gameObject):SetActive(active)
end

UIFormation.OnDelete = function(self)
    -- function num : 0_30 , upvalues : _ENV, base
    MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillChande,
                             self.__RefreshCommanderSkill)
    MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillMasterLevelDiffer,
                             self.__RefreshCSLevel)
    MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillLevelDiffer,
                             self.__RefreshCSLevel);
    (self.troopPool):DeleteAll();
    (self.resourceGroup):Delete();
    (base.OnDelete)(self)
end

return UIFormation

