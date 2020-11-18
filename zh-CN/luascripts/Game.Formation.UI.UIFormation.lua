-- params : ...
-- function num : 0 , upvalues : _ENV
local UIFormation = class("UIFormation", UIBaseWindow)
local base = UIBaseWindow
local UINTroopItem = require("Game.Formation.UI.UINTroopItem")
local UINCommanderSkill = require("Game.Formation.UI.UINCommanderSkill")
local UINFmtHeroInfoItem = require("Game.Formation.UI.UINFmtHeroInfoItem")
UIFormation.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINFmtHeroInfoItem, UINTroopItem, UINCommanderSkill
  self.fmtId = nil
  ;
  (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self, self.OnClickBack)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ShowDetail, self, self.OnClickFmtHeroDetail)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CommanderSkill, self, self.OnClickCommanderSkillDetail)
  ;
  ((self.ui).fHeroInfoItem):SetActive(false)
  self.heroInfoPool = (UIItemPool.New)(UINFmtHeroInfoItem, (self.ui).fHeroInfoItem)
  self.heroInfoDic = {}
  ;
  ((self.ui).tog_TroopItem):SetActive(false)
  self.troopPool = (UIItemPool.New)(UINTroopItem, (self.ui).tog_TroopItem)
  ;
  ((self.ui).obj_skillItem):SetActive(false)
  self.commanderSkillPool = (UIItemPool.New)(UINCommanderSkill, (self.ui).obj_skillItem)
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
  end
end

UIFormation.InitUIFormation = function(self, fmtId, fmtCtrl)
  -- function num : 0_1 , upvalues : _ENV
  self.fmtId = fmtId
  self.fmtCtrl = fmtCtrl
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
  ;
  (((self.troopPool).listItem)[fmtId]):SetTroopToggleOn(true)
  if GuideManager:TryTriggerGuide(eGuideCondition.InFormation) then
  end
end

UIFormation.SelectFmt = function(self, id)
  -- function num : 0_2
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
end

UIFormation.RefreshCommanderSkill = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local fmtId = self.fmtId
  ;
  (self.commanderSkillPool):HideAll()
  if ((PlayerDataCenter.formationDic)[fmtId]).cst ~= nil then
    self.isFirstSkill = true
    local treeId = (((PlayerDataCenter.formationDic)[fmtId]).cst).treeId
    for _,skillId in pairs(((PlayerDataCenter.formationDic)[fmtId]).userSkill) do
      local item = (self.commanderSkillPool):GetOne()
      item:InitCommanderSkill(treeId, skillId, (self.fmtCtrl).resloader)
      if self.isFirstSkill then
        (((item.transform):Find("Img_Line")).gameObject):SetActive(false)
        self.isFirstSkill = false
      end
    end
  end
end

UIFormation.RefreshCSLevel = function(self)
  -- function num : 0_4 , upvalues : _ENV
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
  -- function num : 0_5
  ((self.ui).obj_commanderSkill):SetActive(isUnlock)
end

UIFormation.OnClickFmtHeroDetail = function(self)
  -- function num : 0_6
  (self.fmtCtrl):ShowFmtHeroDetail()
end

UIFormation.OnClickCommanderSkillDetail = function(self)
  -- function num : 0_7
  (self.fmtCtrl):ShowCommanderSkillDetail()
end

UIFormation.CreatFmtHeroInfo = function(self, heroData, position)
  -- function num : 0_8
  local infoItem = (self.heroInfoPool):GetOne()
  infoItem:InitFmtHeroInfo(heroData)
  infoItem:UpdateFmtHeroInfoPos(position)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.heroInfoDic)[heroData.dataId] = infoItem
end

UIFormation.UpdateFmtHeroInfoPos = function(self, heroId, position)
  -- function num : 0_9
  local infoItem = (self.heroInfoDic)[heroId]
  if infoItem == nil then
    return 
  end
  infoItem:UpdateFmtHeroInfoPos(position)
end

UIFormation.ShowFmtHeroInfo = function(self, heroId, show)
  -- function num : 0_10
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
  -- function num : 0_11
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

UIFormation.OnClickBack = function(self)
  -- function num : 0_12
  (self.fmtCtrl):ExitFormation()
end

UIFormation.OnDelete = function(self)
  -- function num : 0_13 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillChande, self.__RefreshCommanderSkill)
  MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillMasterLevelDiffer, self.__RefreshCSLevel)
  MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillLevelDiffer, self.__RefreshCSLevel)
  ;
  (base.OnDelete)(self)
end

return UIFormation

