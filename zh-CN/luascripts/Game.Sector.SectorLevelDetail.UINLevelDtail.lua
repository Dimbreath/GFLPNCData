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
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local eFmtFromModule = require("Game.Formation.Enum.eFmtFromModule")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local eDetailType = SectorLevelDetailEnum.eDetailType
local eInfoNodeType = SectorLevelDetailEnum.eInfoNodeType
local eTogType = SectorLevelDetailEnum.eTogType
UINLevelDtail.OnInit = function(self)
  -- function num : 0_0 , upvalues : eDetailType, _ENV, UINResourceGroup, UINLevelInfgoTypeTog, UINLevelNormalNode, UINLevelChipNode, UINLevelEnemyNode, eInfoNodeType, cs_UIMnager, cs_Screen
  self.detailType = eDetailType.None
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Battle, self, self.OnClickBattle)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GiveUP, self, self.OnCliCkGiveUpLastEp)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ViewAvg, self, self.OnCliCkViewAvg)
  self.resourceGroup = (UINResourceGroup.New)()
  ;
  (self.resourceGroup):Init((self.ui).gameResourceGroup)
  ;
  (self.resourceGroup):SetResourceIds({ItemIdOfKey})
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
  self:GenTypeTogs()
  self.__onHasUncompletedEp = BindCallback(self, self.UpdateUncompletedEp)
  ;
  (((self.ui).moveTween).onComplete):AddListener(BindCallback(self, self.__OnMoveTweenComplete))
  ;
  (((self.ui).moveTween).onRewind):AddListener(BindCallback(self, self.__OnMoveTweenRewind))
  local position = Vector2.zero
  position.x = ((((self.ui).moveTween).transform).sizeDelta).x + (cs_UIMnager.Instance).CurNotchValue / 100 * cs_Screen.width
  -- DECOMPILER ERROR at PC122: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.ui).moveTween).transform).anchoredPosition = position
  self.__isShow = false
end

UINLevelDtail.InitLevelDetailNode = function(self, sectorStageCfg)
  -- function num : 0_1 , upvalues : eDetailType, _ENV, eInfoNodeType
  self.detailType = eDetailType.Stage
  self.stageCfg = sectorStageCfg
  ;
  ((self.ui).tex_Point):SetIndex(0, tostring((self.stageCfg).cost_strength_num))
  ;
  (((self.ui).btn_Battle).gameObject):SetActive(true)
  ;
  (((self.ui).btn_ViewAvg).gameObject):SetActive(false)
  ;
  ((self.ui).obj_togGroup):SetActive(true)
  self:PlayMoveTween(true)
  self:UpdateUncompletedEp()
  self:SelectDefaultTog(eInfoNodeType.LevelNormalInfo)
end

UINLevelDtail.InitAvgDetail = function(self, avgCfg, playAvgCompleteFunc)
  -- function num : 0_2 , upvalues : eDetailType, eInfoNodeType
  self.detailType = eDetailType.Avg
  self.avgCfg = avgCfg
  self.playAvgCompleteFunc = playAvgCompleteFunc
  ;
  (((self.ui).btn_Battle).gameObject):SetActive(false)
  ;
  (((self.ui).btn_GiveUP).gameObject):SetActive(false)
  ;
  (((self.ui).btn_ViewAvg).gameObject):SetActive(true)
  ;
  ((self.ui).obj_togGroup):SetActive(false)
  self:PlayMoveTween(true)
  self:ShowNode(eInfoNodeType.LevelNormalInfo)
end

UINLevelDtail.InitInfinityLevelDetailNode = function(self, levelData)
  -- function num : 0_3 , upvalues : eDetailType, _ENV, eInfoNodeType
  self.detailType = eDetailType.Infinity
  self.levelData = levelData
  if (self.levelData).isComplete then
    ((self.ui).tex_Point):SetIndex(0, tostring(((levelData.cfg).cost_strength_itemNums)[1]))
  else
    ;
    ((self.ui).tex_Point):SetIndex(0, "0")
  end
  ;
  (((self.ui).btn_Battle).gameObject):SetActive(true)
  ;
  (((self.ui).btn_ViewAvg).gameObject):SetActive(false)
  ;
  ((self.ui).obj_togGroup):SetActive(true)
  self:PlayMoveTween(true)
  self:UpdateUncompletedEp()
  self:SelectDefaultTog(eInfoNodeType.LevelNormalInfo)
end

UINLevelDtail.GenTypeTogs = function(self)
  -- function num : 0_4 , upvalues : _ENV, eTogType
  (self.typeTogPool):HideAll()
  for index,infoNodeTypeId in ipairs(eTogType) do
    do
      local togItem = (self.typeTogPool):GetOne()
      local isLast = index == #eTogType
      togItem:InitTog(infoNodeTypeId, isLast, function()
    -- function num : 0_4_0 , upvalues : self, infoNodeTypeId, isLast
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
  -- function num : 0_5 , upvalues : _ENV
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
  -- function num : 0_6 , upvalues : _ENV
  for typeId,NodeItem in pairs(self.NodeDic) do
    if infoNodeTypeId == typeId then
      NodeItem:Show()
      NodeItem:InitInfoNode(self)
    else
      NodeItem:Hide()
    end
  end
end

UINLevelDtail.UpdateUncompletedEp = function(self)
  -- function num : 0_7 , upvalues : eDetailType, _ENV
  if self.detailType ~= eDetailType.Stage and self.detailType ~= eDetailType.Infinity then
    return 
  end
  self.__lastEpStateCfg = ExplorationManager:TryGetUncompletedEpSectorStateCfg()
  self:RefreshBattleButton()
end

UINLevelDtail.RefreshBattleButton = function(self)
  -- function num : 0_8 , upvalues : eDetailType, _ENV
  if self.__lastEpStateCfg == nil then
    (((self.ui).btn_GiveUP).gameObject):SetActive(false)
    ;
    ((self.ui).obj_point):SetActive(true)
    if self.detailType == eDetailType.Infinity then
      local infinittLevelId = ((self.levelData).cfg).id
      if ((PlayerDataCenter.infinityData).completed)[infinittLevelId] or ((PlayerDataCenter.infinityData).processingUpdate)[infinittLevelId] ~= nil then
        ((self.ui).tex_Battle):SetIndex(2)
      else
        ;
        ((self.ui).tex_Battle):SetIndex(0)
      end
    else
      do
        ;
        ((self.ui).tex_Battle):SetIndex(0)
        local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock)
        local isUnlockBattleExit = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_BattleExit)
        ;
        (((self.ui).btn_GiveUP).gameObject):SetActive(isUnlockBattleExit)
        ;
        ((self.ui).obj_point):SetActive(false)
        ;
        ((self.ui).tex_Battle):SetIndex(1)
      end
    end
  end
end

UINLevelDtail.OnClickBattle = function(self)
  -- function num : 0_9 , upvalues : _ENV, eDetailType, cs_MessageCommon, eFmtFromModule
  if self.__lastEpStateCfg ~= nil then
    ExplorationManager:ContinueLastExploration()
    return 
  end
  if self.detailType == eDetailType.Stage and (PlayerDataCenter.stamina).value < (self.stageCfg).cost_strength_num then
    (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Sector_LackOfStamina))
    return 
  else
    if self.detailType == eDetailType.Infinity and ((PlayerDataCenter.infinityData).completed)[((self.levelData).cfg).id] and (PlayerDataCenter.stamina).value < (((self.levelData).cfg).cost_strength_itemNums)[1] then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Sector_LackOfStamina))
      return 
    end
  end
  local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation, true)
  local enterFunc = function()
    -- function num : 0_9_0 , upvalues : _ENV
    UIManager:HideWindow(UIWindowTypeID.Sector)
    UIManager:HideWindow(UIWindowTypeID.SectorLevel)
    UIManager:HideWindow(UIWindowTypeID.SectorLevelDetail)
  end

  local exitFunc = function()
    -- function num : 0_9_1 , upvalues : _ENV
    UIManager:ShowWindow(UIWindowTypeID.Sector, true)
    UIManager:ShowWindow(UIWindowTypeID.SectorLevel, true)
    UIManager:ShowWindow(UIWindowTypeID.SectorLevelDetail, true)
  end

  local startBattleFunc = function(curSelectFormationId, callBack)
    -- function num : 0_9_2 , upvalues : self, eDetailType, _ENV
    if self.detailType == eDetailType.Stage then
      ExplorationManager:ReqEnterExploration((self.stageCfg).id, curSelectFormationId, proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration, callBack)
    else
      if self.detailType == eDetailType.Infinity then
        ExplorationManager:ReqEnterExploration(((self.levelData).cfg).id, curSelectFormationId, proto_csmsg_SystemFunctionID.SystemFunctionID_Endless, callBack)
      end
    end
  end

  if self.detailType == eDetailType.Stage then
    fmtCtrl:InitFromationCtrl(eFmtFromModule.SectorLevel, (self.stageCfg).id, enterFunc, exitFunc, startBattleFunc)
  else
    if self.detailType == eDetailType.Infinity then
      fmtCtrl:InitFromationCtrl(eFmtFromModule.Infinity, ((self.levelData).cfg).id, enterFunc, exitFunc, startBattleFunc)
    end
  end
end

UINLevelDtail.OnCliCkGiveUpLastEp = function(self)
  -- function num : 0_10 , upvalues : _ENV, cs_MessageCommon
  (ExplorationManager:GetLastEpReturnStamina())
  local returnStamina = nil
  local msg = nil
  if returnStamina == 0 then
    msg = ConfigData:GetTipContent(TipContent.LevelDetail_GiveupEp)
  else
    msg = (string.format)(ConfigData:GetTipContent(TipContent.LevelDetail_GiveupEpWithStaminaReturn), returnStamina)
  end
  ;
  (cs_MessageCommon.ShowMessageBox)(msg, function()
    -- function num : 0_10_0 , upvalues : _ENV
    ExplorationManager:GiveUpLastExploration()
  end
, nil)
end

UINLevelDtail.OnCliCkViewAvg = function(self)
  -- function num : 0_11 , upvalues : _ENV, eInfoNodeType
  (ControllerManager:GetController(ControllerTypeId.Avg, true)):StartAvg((self.avgCfg).script_id, (self.avgCfg).id, function()
    -- function num : 0_11_0 , upvalues : self, eInfoNodeType
    (self.playAvgCompleteFunc)()
    self:ShowNode(eInfoNodeType.LevelNormalInfo)
  end
)
end

UINLevelDtail.GetNLevelDetailWidthAndDuration = function(self)
  -- function num : 0_12
  return ((self.transform).sizeDelta).x, ((self.ui).moveTween).duration
end

UINLevelDtail.PlayMoveTween = function(self, isShow)
  -- function num : 0_13 , upvalues : _ENV
  if isShow then
    if self.__isShow then
      return 
    end
    self.__isShow = true
    ;
    ((self.ui).moveTween):DOPlayForward()
  else
    ;
    ((self.ui).moveTween):DOPlayBackwards()
  end
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
end

UINLevelDtail.__OnMoveTweenComplete = function(self)
  -- function num : 0_14 , upvalues : _ENV
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
end

UINLevelDtail.__OnMoveTweenRewind = function(self)
  -- function num : 0_15 , upvalues : _ENV
  UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  UIManager:HideWindow(UIWindowTypeID.SectorLevelDetail)
  self.__isShow = false
end

UINLevelDtail.OnShow = function(self)
  -- function num : 0_16 , upvalues : base, _ENV
  (base.OnShow)(self)
  if self.__addListener then
    return 
  end
  MsgCenter:AddListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  self.__addListener = true
end

UINLevelDtail.OnHide = function(self)
  -- function num : 0_17 , upvalues : _ENV
  if not self.__addListener then
    return 
  end
  MsgCenter:RemoveListener(eMsgEventId.OnHasUncompletedEp, self.__onHasUncompletedEp)
  self.__addListener = false
end

UINLevelDtail.OnDelete = function(self)
  -- function num : 0_18 , upvalues : _ENV, base
  (self.resourceGroup):Delete()
  for _,NodeItem in pairs(self.NodeDic) do
    NodeItem:Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UINLevelDtail

