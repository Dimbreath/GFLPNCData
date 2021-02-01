-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLevelDtail = class("UINLevelDtail", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local cs_UIMnager = CS.UIManager
local cs_Screen = (CS.UnityEngine).Screen
local UINLevelInfgoTypeTog = require("Game.Sector.SectorLevelDetail.UINLevelInfgoTypeTog")
local UINLevelNormalNode = require("Game.Sector.SectorLevelDetail.Nodes.UINLevelNormalNode")
local UINLevelChipNode = require("Game.Sector.SectorLevelDetail.Nodes.UINLevelChipNode")
local UINLevelEnemyNode = require("Game.Sector.SectorLevelDetail.Nodes.UINLevelEnemyNode")
local ChipData = require("Game.PlayerData.Item.ChipData")
local eFmtFromModule = require("Game.Formation.Enum.eFmtFromModule")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local eDetailType = SectorLevelDetailEnum.eDetailType
local eInfoNodeType = SectorLevelDetailEnum.eInfoNodeType
local eTogType = SectorLevelDetailEnum.eTogType
local SpecificHeroDataRuler = require("Game.PlayerData.Hero.SpecificHeroDataRuler")
local JumpManager = require("Game.Jump.JumpManager")
UINLevelDtail.OnInit = function(self)
  -- function num : 0_0 , upvalues : eDetailType, _ENV, UINLevelInfgoTypeTog, UINLevelNormalNode, UINLevelChipNode, UINLevelEnemyNode, eInfoNodeType, cs_UIMnager, cs_Screen
  self.detailType = eDetailType.None
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Battle, self, self.OnClickBattle)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GiveUP, self, self.OnCliCkGiveUpLastEp)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ViewAvg, self, self.OnCliCkViewAvg)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Blitz, self, self.OnBtnBlitz)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Recomme, self, self.OnClickRecomme)
  self.typeTogPool = (UIItemPool.New)(UINLevelInfgoTypeTog, (self.ui).obj_tog_Type)
  ;
  ((self.ui).obj_tog_Type):SetActive(false)
  local NormalInfoNode = (UINLevelNormalNode.New)()
  NormalInfoNode:Init((self.ui).obj_normalNode)
  local ChipInfoNode = (UINLevelChipNode.New)()
  ChipInfoNode:Init((self.ui).obj_chipNode)
  local EnemyInfoNode = (UINLevelEnemyNode.New)()
  EnemyInfoNode:Init((self.ui).obj_enemyNode)
  self.NodeDic = {[eInfoNodeType.LevelNormalInfo] = NormalInfoNode, [eInfoNodeType.LevelChips] = ChipInfoNode, [eInfoNodeType.LevelEnemies] = EnemyInfoNode}
  self.SelectedNode = nil
  self:GenTypeTogs()
  self.__onHasUncompletedEp = BindCallback(self, self.UpdateUncompletedEp)
  ;
  (((self.ui).moveTween).onComplete):AddListener(BindCallback(self, self.__OnMoveTweenComplete))
  ;
  (((self.ui).moveTween).onRewind):AddListener(BindCallback(self, self.__OnMoveTweenRewind))
  local position = Vector2.zero
  position.x = ((((self.ui).moveTween).transform).sizeDelta).x + (cs_UIMnager.Instance).CurNotchValue / 100 * cs_Screen.width
  -- DECOMPILER ERROR at PC123: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.ui).moveTween).transform).anchoredPosition = position
  self.__isShow = false
  self.__OnChipSetUpdate = BindCallback(self, self.OnChipSetUpdate)
end

UINLevelDtail.InitLevelDtail = function(self, resloader)
  -- function num : 0_1
  self.__resloader = resloader
end

UINLevelDtail.InitLevelDetailNode = function(self, sectorStageCfg, sectorId)
  -- function num : 0_2 , upvalues : eDetailType, _ENV, eInfoNodeType
  self.detailType = eDetailType.Stage
  self.stageCfg = sectorStageCfg
  self.sectorId = sectorId
  ;
  ((self.ui).tex_Point):SetIndex(0, tostring((self.stageCfg).cost_strength_num))
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Power).text = tostring((self.stageCfg).combat)
  ;
  (((self.ui).btn_Blitz).gameObject):SetActive(false)
  ;
  (((self.ui).btn_Battle).gameObject):SetActive(true)
  ;
  (((self.ui).btn_ViewAvg).gameObject):SetActive(false)
  ;
  ((self.ui).obj_togGroup):SetActive(true)
  ;
  ((self.ui).obj_Power):SetActive(true)
  self:PlayMoveTween(true)
  self:UpdateUncompletedEp()
  self:SelectDefaultTog(eInfoNodeType.LevelNormalInfo)
  self:InitChipDataQualityDic(self.detailType)
  self:SendChipSet()
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  ;
  (((self.ui).btn_Recomme).gameObject):SetActive(fmtCtrl:IsCanReqRecomme((self.stageCfg).id, false))
end

UINLevelDtail.InitAvgDetail = function(self, avgCfg, playAvgCompleteFunc, sectorId)
  -- function num : 0_3 , upvalues : eDetailType, eInfoNodeType
  self.detailType = eDetailType.Avg
  self.avgCfg = avgCfg
  self.sectorId = sectorId
  self.playAvgCompleteFunc = playAvgCompleteFunc
  ;
  (((self.ui).btn_Blitz).gameObject):SetActive(false)
  ;
  (((self.ui).btn_Battle).gameObject):SetActive(false)
  ;
  (((self.ui).btn_GiveUP).gameObject):SetActive(false)
  ;
  (((self.ui).btn_ViewAvg).gameObject):SetActive(true)
  ;
  ((self.ui).obj_togGroup):SetActive(false)
  ;
  ((self.ui).obj_Power):SetActive(false)
  self:PlayMoveTween(true)
  self:ShowNode(eInfoNodeType.LevelNormalInfo)
  ;
  (((self.ui).btn_Recomme).gameObject):SetActive(false)
end

UINLevelDtail.InitInfinityLevelDetailNode = function(self, levelData, sectorId)
  -- function num : 0_4 , upvalues : eDetailType, _ENV, eInfoNodeType
  self.detailType = eDetailType.Infinity
  self.levelData = levelData
  self.sectorId = sectorId
  if (self.levelData).isComplete then
    ((self.ui).tex_Point):SetIndex(0, tostring(((levelData.cfg).cost_strength_itemNums)[1]))
  else
    ;
    ((self.ui).tex_Point):SetIndex(0, "0")
  end
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_Power).text = tostring((levelData.cfg).combat)
  ;
  (((self.ui).btn_Blitz).gameObject):SetActive(false)
  ;
  (((self.ui).btn_Battle).gameObject):SetActive(true)
  ;
  (((self.ui).btn_ViewAvg).gameObject):SetActive(false)
  ;
  ((self.ui).obj_togGroup):SetActive(true)
  ;
  ((self.ui).obj_Power):SetActive(true)
  self:PlayMoveTween(true)
  self:UpdateUncompletedEp()
  self:SelectDefaultTog(eInfoNodeType.LevelNormalInfo)
  self:InitChipDataQualityDic(self.detailType)
  self:SendChipSet()
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  ;
  (((self.ui).btn_Recomme).gameObject):SetActive(fmtCtrl:IsCanReqRecomme(((self.levelData).cfg).id, false))
end

UINLevelDtail.InitPeriodicChallengeDetailNode = function(self, challengeId, eChallengeType)
  -- function num : 0_5 , upvalues : eDetailType, eInfoNodeType
  self.detailType = eDetailType.PeriodicChallenge
  self.sectorId = challengeId
  self.challengeId = challengeId
  self.eChallengeType = eChallengeType
  self:PlayMoveTween(true)
  self:UpdateUncompletedEp()
  self:SelectDefaultTog(eInfoNodeType.LevelNormalInfo)
  self:InitChipDataQualityDic(self.detailType)
  self:SendChipSet()
  ;
  ((self.ui).tex_Point):SetIndex(0, "0")
  ;
  ((self.ui).obj_RecommendPower):SetActive(false)
  ;
  (((self.ui).btn_Recomme).gameObject):SetActive(false)
end

UINLevelDtail.GenTypeTogs = function(self)
  -- function num : 0_6 , upvalues : _ENV, eTogType
  (self.typeTogPool):HideAll()
  for index,infoNodeTypeId in ipairs(eTogType) do
    do
      local togItem = (self.typeTogPool):GetOne()
      local isLast = index == #eTogType
      togItem:InitTog(infoNodeTypeId, isLast, function()
    -- function num : 0_6_0 , upvalues : self, infoNodeTypeId, isLast
    self:ShowNode(infoNodeTypeId)
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

    if isLast then
      ((self.ui).img_lastTog).color = (self.ui).color_white
    else
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

      ;
      ((self.ui).img_lastTog).color = (self.ui).color_black
    end
  end
)
    end
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINLevelDtail.SelectDefaultTog = function(self, infoNodeTypeId)
  -- function num : 0_7 , upvalues : _ENV
  for _,item in ipairs((self.typeTogPool).listItem) do
    if item.infoNodeTypeId == infoNodeTypeId then
      if ((item.ui).tog_Type).isOn then
        self:ShowNode(infoNodeTypeId)
        break
      end
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R7 in 'UnsetPending'

      ;
      ((item.ui).tog_Type).isOn = true
      break
    end
  end
end

UINLevelDtail.ShowNode = function(self, infoNodeTypeId)
  -- function num : 0_8 , upvalues : _ENV
  for typeId,NodeItem in pairs(self.NodeDic) do
    if infoNodeTypeId == typeId then
      NodeItem:Show()
      NodeItem:InitInfoNode(self, self.chipDataQualityDic, self.__resloader)
      self.SelectedNode = NodeItem
    else
      NodeItem:Hide()
    end
  end
end

UINLevelDtail.InitChipDataQualityDic = function(self, detailType)
  -- function num : 0_9 , upvalues : eDetailType, _ENV, ChipData
  local chip_dic = {}
  if detailType == eDetailType.Stage then
    local stageCfg = self.stageCfg
    for k,v in pairs(stageCfg.function_extra) do
      chip_dic[v] = true
    end
    local chip_pool_dic = {}
    for _,epId in pairs(stageCfg.exploration_list) do
      local epCfg = (ConfigData.exploration)[epId]
      if epCfg ~= nil then
        for _,poolId in pairs(epCfg.chip_pool) do
          chip_pool_dic[poolId] = true
          local funcPoolCfg = (ConfigData.ep_function_pool)[poolId]
          if funcPoolCfg ~= nil then
            for _,chipId in pairs(funcPoolCfg.function_pool) do
              chip_dic[chipId] = true
            end
          end
        end
      end
    end
  else
    do
      if detailType == eDetailType.Infinity then
        local infinityCfg = (self.levelData).cfg
        for k,v in pairs(infinityCfg.chip) do
          chip_dic[v] = true
        end
      else
        do
          if detailType == eDetailType.PeriodicChallenge then
            local chipList = (PlayerDataCenter.periodicChallengeData):GetDailyChallengeChipList(self.eChallengeType)
            if chipList ~= nil then
              for index,value in ipairs(chipList) do
                chip_dic[value] = true
              end
            end
          end
          do
            self.chipDataQualityDic = {}
            local chipData = nil
            for itemId,_ in pairs(chip_dic) do
              chipData = (ChipData.New)(R10_PC83)
              chipData.isLock = true
              -- DECOMPILER ERROR at PC92: Overwrote pending register: R10 in 'AssignReg'

              -- DECOMPILER ERROR at PC94: Confused about usage of register: R9 in 'UnsetPending'

              if (self.chipDataQualityDic)[R10_PC83] == nil then
                (self.chipDataQualityDic)[R10_PC83] = {}
                -- DECOMPILER ERROR at PC97: Overwrote pending register: R10 in 'AssignReg'

                -- DECOMPILER ERROR at PC99: Overwrote pending register: R10 in 'AssignReg'

                ;
                (table.insert)(R10_PC83, chipData)
              else
                -- DECOMPILER ERROR at PC105: Overwrote pending register: R10 in 'AssignReg'

                -- DECOMPILER ERROR at PC107: Overwrote pending register: R10 in 'AssignReg'

                ;
                (table.insert)(R10_PC83, chipData)
              end
            end
          end
        end
      end
    end
  end
end

UINLevelDtail.OnChipSetUpdate = function(self, chipSetTab)
  -- function num : 0_10 , upvalues : _ENV
  for _,list in pairs(self.chipDataQualityDic) do
    for index,chipData in ipairs(list) do
      if chipSetTab[chipData.dataId] ~= nil then
        chipData.isLock = false
      end
    end
  end
end

UINLevelDtail.SendChipSet = function(self)
  -- function num : 0_11 , upvalues : _ENV
  self.networkContrl = NetworkManager:GetNetwork(NetworkTypeID.Sector)
  ;
  (self.networkContrl):SendChipSet()
end

UINLevelDtail.UpdateUncompletedEp = function(self)
  -- function num : 0_12 , upvalues : eDetailType, _ENV
  if self.detailType ~= eDetailType.Stage and self.detailType ~= eDetailType.Infinity and self.detailType ~= eDetailType.PeriodicChallenge then
    return 
  end
  self.__lastEpStateCfg = ExplorationManager:TryGetUncompletedEpSectorStateCfg()
  self:RefreshBattleButton()
end

UINLevelDtail.RefreshBattleButton = function(self)
  -- function num : 0_13 , upvalues : eDetailType, _ENV
  if self.__lastEpStateCfg == nil then
    (((self.ui).btn_GiveUP).gameObject):SetActive(false)
    ;
    ((self.ui).obj_point):SetActive(true)
    if self.detailType == eDetailType.Infinity then
      local infinittLevelId = ((self.levelData).cfg).id
      if ((PlayerDataCenter.infinityData).completed)[infinittLevelId] then
        ((self.ui).tex_Battle):SetIndex(2)
        if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_EndlessAuto) then
          (((self.ui).btn_Blitz).gameObject):SetActive(true)
        end
      else
        if ((PlayerDataCenter.infinityData).processingUpdate)[infinittLevelId] ~= nil then
          ((self.ui).tex_Battle):SetIndex(2)
        else
          ;
          ((self.ui).tex_Battle):SetIndex(0)
        end
      end
    else
      do
        ;
        ((self.ui).tex_Battle):SetIndex(0)
        local isUnlockBattleExit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleExit)
        local _, _, _, canFloorOver = ExplorationManager:HasUncompletedEp()
        if isUnlockBattleExit then
          (((self.ui).btn_GiveUP).gameObject):SetActive(not canFloorOver)
          ;
          ((self.ui).obj_point):SetActive(false)
          ;
          ((self.ui).tex_Battle):SetIndex(1)
        end
      end
    end
  end
end

UINLevelDtail.OnClickBattle = function(self)
  -- function num : 0_14 , upvalues : _ENV, eDetailType
  if self.__lastEpStateCfg ~= nil then
    ExplorationManager:ContinueLastExploration()
    return 
  end
  if self.detailType == eDetailType.Stage then
    local isComplete = (PlayerDataCenter.sectorStage):IsStageComplete((self.stageCfg).id)
    if isComplete then
      local dontShowEpRepeat = (PlayerDataCenter.cacheSaveData).dontShowEpRepeat
      if not dontShowEpRepeat then
        local msgWindow = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
        msgWindow:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(370), function()
    -- function num : 0_14_0 , upvalues : self
    self:__EnterBattleFormation()
  end
)
        msgWindow:ShowDontRemindTog(function(isOn)
    -- function num : 0_14_1 , upvalues : _ENV
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

    (PlayerDataCenter.cacheSaveData).dontShowEpRepeat = isOn
  end
)
        return 
      end
    end
  else
    do
      if self.detailType == eDetailType.Infinity then
        if self.levelData then
          local isComplete = ((PlayerDataCenter.infinityData).completed)[((self.levelData).cfg).id]
        end
        if isComplete then
          local dontShowEndlessRepeat = (PlayerDataCenter.cacheSaveData).dontShowEndlessRepeat
          if not dontShowEndlessRepeat then
            local msgWindow = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
            msgWindow:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(372), function()
    -- function num : 0_14_2 , upvalues : self
    self:__EnterBattleFormation()
  end
)
            msgWindow:ShowDontRemindTog(function(isOn)
    -- function num : 0_14_3 , upvalues : _ENV
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

    (PlayerDataCenter.cacheSaveData).dontShowEndlessRepeat = isOn
  end
, false)
            return 
          end
        end
      end
      do
        self:__EnterBattleFormation()
      end
    end
  end
end

UINLevelDtail.__EnterBattleFormation = function(self)
  -- function num : 0_15 , upvalues : _ENV, eDetailType, JumpManager, eFmtFromModule, cs_MessageCommon, SpecificHeroDataRuler
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local enterFunc = function()
    -- function num : 0_15_0 , upvalues : _ENV
    UIManager:HideWindow(UIWindowTypeID.Sector)
    UIManager:HideWindow(UIWindowTypeID.SectorLevel)
    UIManager:HideWindow(UIWindowTypeID.SectorLevelDetail)
    UIManager:HideWindow(UIWindowTypeID.DailyChallenge)
  end

  local exitFunc = function()
    -- function num : 0_15_1 , upvalues : _ENV
    UIManager:ShowWindowOnly(UIWindowTypeID.Sector)
    UIManager:ShowWindowOnly(UIWindowTypeID.SectorLevel)
    UIManager:ShowWindowOnly(UIWindowTypeID.SectorLevelDetail)
    UIManager:ShowWindowOnly(UIWindowTypeID.DailyChallenge)
  end

  local startBattleFunc = function(curSelectFormationId, callBack)
    -- function num : 0_15_2 , upvalues : self, eDetailType, _ENV, JumpManager
    if self.detailType == eDetailType.Stage and (PlayerDataCenter.stamina):GetCurrentStamina() < (self.stageCfg).cost_strength_num then
      JumpManager:Jump((JumpManager.eJumpTarget).BuyStamina)
      return 
    else
      if self.detailType == eDetailType.Infinity and ((PlayerDataCenter.infinityData).completed)[((self.levelData).cfg).id] and (PlayerDataCenter.stamina):GetCurrentStamina() < (((self.levelData).cfg).cost_strength_itemNums)[1] then
        JumpManager:Jump((JumpManager.eJumpTarget).BuyStamina)
        return 
      else
      end
    end
    -- DECOMPILER ERROR at PC65: Unhandled construct in 'MakeBoolean' P1

    if self.detailType ~= eDetailType.PeriodicChallenge or self.detailType == eDetailType.Stage then
      ExplorationManager:ReqEnterExploration((self.stageCfg).id, curSelectFormationId, proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration, callBack)
    else
      if self.detailType == eDetailType.Infinity then
        ExplorationManager:ReqEnterExploration(((self.levelData).cfg).id, curSelectFormationId, proto_csmsg_SystemFunctionID.SystemFunctionID_Endless, callBack)
      else
        if self.detailType == eDetailType.PeriodicChallenge then
          ExplorationManager:ReqEnterChallengeExploration(curSelectFormationId)
        end
      end
    end
    local saveUserData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
    saveUserData:SetLastFormationId(self.sectorId, curSelectFormationId)
  end

  local lastFmtId = (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):GetLastFormationId(self.sectorId)
  if self.detailType == eDetailType.Stage then
    local startFunc = function()
    -- function num : 0_15_3 , upvalues : fmtCtrl, eFmtFromModule, self, enterFunc, exitFunc, startBattleFunc, lastFmtId
    fmtCtrl:InitFromationCtrl(eFmtFromModule.SectorLevel, (self.stageCfg).id, enterFunc, exitFunc, startBattleFunc, (self.stageCfg).cost_strength_num, lastFmtId)
  end

    if (ConfigData.game_config).athMaxNum - (ConfigData.game_config).athSpaceNotEnoughNum <= #(PlayerDataCenter.allAthData):GetAllAthList() then
      (cs_MessageCommon.ShowMessageBox)(ConfigData:GetTipContent(145), startFunc, nil)
    else
      startFunc()
    end
  else
    do
      do
        if not (self.levelData).isComplete or not (((self.levelData).cfg).cost_strength_itemNums)[1] then
          local staminaCost = self.detailType ~= eDetailType.Infinity or 0
        end
        fmtCtrl:InitFromationCtrl(eFmtFromModule.Infinity, ((self.levelData).cfg).id, enterFunc, exitFunc, startBattleFunc, staminaCost, lastFmtId)
        if self.detailType == eDetailType.PeriodicChallenge then
          local challengeCfg = (ConfigData.daily_challenge)[self.challengeId]
          if challengeCfg == nil then
            error("challengeCfg is nil,pls check")
          end
          local specificHeroDataRuler = (SpecificHeroDataRuler.ctorWithChallengeCfg)(challengeCfg)
          fmtCtrl:InitFromationCtrl(eFmtFromModule.PeriodicChallenge, "not configed", enterFunc, exitFunc, startBattleFunc, 0, lastFmtId, specificHeroDataRuler)
        end
      end
    end
  end
end

UINLevelDtail.OnCliCkGiveUpLastEp = function(self)
  -- function num : 0_16 , upvalues : _ENV, cs_MessageCommon
  (ExplorationManager:GetLastEpReturnStamina())
  local returnStamina = nil
  local msg = nil
  if returnStamina == 0 then
    msg = ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpo)
  else
    msg = (string.format)(ConfigData:GetTipContent(TipContent.exploration_Player_ExitExpoWithStaminaBack), tostring(returnStamina))
  end
  ;
  (cs_MessageCommon.ShowMessageBox)(msg, function()
    -- function num : 0_16_0 , upvalues : _ENV
    ExplorationManager:GiveUpLastExploration()
  end
, nil)
end

UINLevelDtail.OnCliCkViewAvg = function(self)
  -- function num : 0_17 , upvalues : _ENV, eInfoNodeType
  (ControllerManager:GetController(ControllerTypeId.Avg, true)):StartAvg((self.avgCfg).script_id, (self.avgCfg).id, function()
    -- function num : 0_17_0 , upvalues : self, eInfoNodeType
    (self.playAvgCompleteFunc)()
    self:ShowNode(eInfoNodeType.LevelNormalInfo)
  end
)
end

UINLevelDtail.OnBtnBlitz = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local costId1 = (((self.levelData).cfg).cost_strength_itemIds)[1]
  local costNum1 = (((self.levelData).cfg).cost_strength_itemNums)[1]
  local costId2, costNum2 = nil, nil
  local extraCondition = true
  if ((self.levelData).cfg).blitz_cost_id ~= nil then
    costId2 = ((self.levelData).cfg).blitz_cost_id
    costNum2 = ((self.levelData).cfg).blitz_cost_num
    extraCondition = costNum2 <= PlayerDataCenter:GetItemCount(costId2)
  end
  if costNum1 <= (PlayerDataCenter.stamina):GetCurrentStamina() and extraCondition then
    local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    if costId2 ~= nil then
      local msg = (string.format)(ConfigData:GetTipContent(290), ConfigData:GetItemName(costId1) .. "," .. ConfigData:GetItemName(costId2))
      window:ShowItemCost2(msg, costId1, costNum1, costId2, costNum2, function()
    -- function num : 0_18_0 , upvalues : _ENV, self
    (NetworkManager:GetNetwork(NetworkTypeID.Object)):CS_BLITZ_Blitz(((self.levelData).cfg).id)
  end
)
    else
      local msg = (string.format)(ConfigData:GetTipContent(290), ConfigData:GetItemName(costId1))
      window:ShowItemCost(msg, costId1, costNum1, function()
    -- function num : 0_18_1 , upvalues : _ENV, self
    (NetworkManager:GetNetwork(NetworkTypeID.Object)):CS_BLITZ_Blitz(((self.levelData).cfg).id)
  end
)
    end
  else
    local msg = (string.format)(ConfigData:GetTipContent(252))
    local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    if costId2 ~= nil then
      window:ShowItemCost2Confirm(msg, costId1, costNum1, costId2, costNum2)
    else
      window:ShowItemCostConfirm(msg, costId1, costNum1)
    end
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

UINLevelDtail.OnClickRecomme = function(self)
  -- function num : 0_19 , upvalues : _ENV, eDetailType
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  if self.detailType == eDetailType.Stage then
    fmtCtrl:ReqRecommeFormation((self.stageCfg).id, false)
  else
    fmtCtrl:ReqRecommeFormation(((self.levelData).cfg).id, false)
  end
end

UINLevelDtail.GetNLevelDetailWidthAndDuration = function(self)
  -- function num : 0_20
  return ((self.transform).sizeDelta).x, ((self.ui).moveTween).duration
end

UINLevelDtail.PlayMoveTween = function(self, isShow)
  -- function num : 0_21 , upvalues : eDetailType, _ENV
  if isShow then
    if self.__isShow then
      return 
    end
    self.__isShow = true
    ;
    ((self.ui).moveTween):DOPlayForward()
    if self.detailType == eDetailType.Stage then
      AudioManager:PlayAudioById(1033)
    else
      if self.detailType == eDetailType.Avg then
        AudioManager:PlayAudioById(1035)
      end
    end
  else
    ;
    ((self.ui).moveTween):DOPlayBackwards()
    if self.detailType == eDetailType.Stage then
      AudioManager:PlayAudioById(1034)
    else
      if self.detailType == eDetailType.Avg then
        AudioManager:PlayAudioById(1036)
      end
    end
  end
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
end

UINLevelDtail.__OnMoveTweenComplete = function(self)
  -- function num : 0_22 , upvalues : _ENV
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  if (self.SelectedNode).ForceRefresh ~= nil then
    (self.SelectedNode):ForceRefresh()
  end
end

UINLevelDtail.__OnMoveTweenRewind = function(self)
  -- function num : 0_23 , upvalues : _ENV
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  UIManager:HideWindow(UIWindowTypeID.SectorLevelDetail)
  self.__isShow = false
end

UINLevelDtail.OnShow = function(self)
  -- function num : 0_24 , upvalues : base, _ENV
  (base.OnShow)(self)
  if self.__addListener then
    return 
  end
  MsgCenter:AddListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  MsgCenter:AddListener(eMsgEventId.SectorChipSet, self.__OnChipSetUpdate)
  self.__addListener = true
end

UINLevelDtail.OnHide = function(self)
  -- function num : 0_25 , upvalues : _ENV
  if not self.__addListener then
    return 
  end
  MsgCenter:RemoveListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  MsgCenter:RemoveListener(eMsgEventId.SectorChipSet, self.__OnChipSetUpdate)
  self.__addListener = false
end

UINLevelDtail.OnDelete = function(self)
  -- function num : 0_26 , upvalues : _ENV, base
  for _,NodeItem in pairs(self.NodeDic) do
    NodeItem:Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UINLevelDtail

