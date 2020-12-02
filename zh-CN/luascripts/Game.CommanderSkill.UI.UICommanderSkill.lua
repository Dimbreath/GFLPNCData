-- params : ...
-- function num : 0 , upvalues : _ENV
local UICommanderSkill = class("UICommanderSkill", UIBaseWindow)
local base = UIBaseWindow
local CS_ResLoader = CS.ResLoader
local CommanderSkillTreeData = require("Game.CommanderSkill.CommanderSkillTreeData")
local FormationData = require("Game.PlayerData.FormationData")
local UINCSTList = require("Game.CommanderSkill.UI.UINCSTList")
local UINCSTDetail = require("Game.CommanderSkill.UI.TreeDetail.UINCSTDetail")
local UINCSInfo = require("Game.CommanderSkill.UI.UINCSInfo")
UICommanderSkill.OnInit = function(self)
  -- function num : 0_0 , upvalues : CS_ResLoader, _ENV, UINCSTList, UINCSTDetail, UINCSInfo
  self.resloader = (CS_ResLoader.Create)()
  self.proficiencyLevel = 0
  self.treeDataList = {}
  self.selectedTreeId = nil
  self.selectedTreeData = nil
  self.formId = nil
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill)
  ;
  (UIUtil.CreateTopBtnGroup)((self.ui).obj_topButtonGroup, self, self.OnClickBack)
  self.treeList = (UINCSTList.New)()
  ;
  (self.treeList):Init((self.ui).obj_treeList)
  self.treeDetail = (UINCSTDetail.New)()
  ;
  (self.treeDetail):Init((self.ui).obj_treeDetail)
  ;
  (self.treeDetail):InitTreeDetail(self.resloader)
  self.treeInfo = (UINCSInfo.New)()
  ;
  (self.treeInfo):Init((self.ui).obj_treeInfo)
  ;
  (self.treeInfo):InitTreeInfo(self.resloader)
  self.__ShowTree = BindCallback(self, self.ShowTree)
  self.__OnTreeDataChnage = BindCallback(self, self.OnTreeDataChnage)
  MsgCenter:AddListener(eMsgEventId.OnCommanderSkillTreeDataDiffer, self.__OnTreeDataChnage)
  self.__OnMasterLevelChange = BindCallback(self, self.OnMasterLevelChange)
  MsgCenter:AddListener(eMsgEventId.OnCommanderSkillMasterLevelDiffer, self.__OnMasterLevelChange)
  self.__RefreshRedDot = BindCallback(self, self.RefreshRedDot)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__RefreshRedDot)
end

UICommanderSkill.InitCommanderSkillWin = function(self, formId)
  -- function num : 0_1 , upvalues : _ENV, FormationData
  self.formId = formId
  local fmtCSTData = ((PlayerDataCenter.formationDic)[formId]).cst
  if fmtCSTData == nil then
    (FormationData.CreateDefultCST)(formId)
  end
  local selectedTreeId = fmtCSTData.treeId
  local selectedTreeData = nil
  for treeId,treeData in pairs((PlayerDataCenter.CommanderSkillModualData).CommanderSkillTreeDataDic) do
    if treeId == selectedTreeId then
      selectedTreeData = treeData
      treeData:ApplySavingData(fmtCSTData.saving)
    end
    ;
    (table.insert)(self.treeDataList, treeData)
  end
  ;
  (self.treeList):InitTreeList(self.treeDataList, self.__ShowTree, self.resloader)
  ;
  (self.treeList):SelectTree(selectedTreeData)
end

UICommanderSkill.ShowTree = function(self, treeData)
  -- function num : 0_2
  (self.treeDetail):ShowTreeDetail(treeData)
  ;
  (self.treeInfo):ShowTreeInfo(treeData)
  self.selectedTreeId = treeData.treeId
  self.selectedTreeData = treeData
end

UICommanderSkill.OnTreeDataChnage = function(self, treeId)
  -- function num : 0_3 , upvalues : _ENV
  if treeId == self.selectedTreeId then
    self:ShowTree(((PlayerDataCenter.CommanderSkillModualData).CommanderSkillTreeDataDic)[treeId])
    local treeItem = (self.treeList):__GetTreeItemByData(self.selectedTreeData)
    if treeItem ~= nil then
      treeItem:RefreshLevel()
    end
    self:RefreshRedDot()
  end
end

UICommanderSkill.OnMasterLevelChange = function(self)
  -- function num : 0_4
  (self.treeInfo):ShowTreeInfo(self.selectedTreeData)
  ;
  (self.treeDetail):RefreshMasterNode(self.selectedTreeData)
end

UICommanderSkill.RefreshRedDot = function(self)
  -- function num : 0_5
  (self.treeList):RefreshTreeRedDot()
  ;
  (self.treeInfo):RefreshTreeInfoRedDot()
end

UICommanderSkill.FormSelectSkillTree = function(self, saveData)
  -- function num : 0_6
  if self.networkCtrl ~= nil then
    (self.networkCtrl):CS_COMMANDSKILL_SaveFromFormation(self.formId, self.selectedTreeId, saveData)
  end
end

UICommanderSkill.OnClickBack = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if ((self.treeInfo).upgradeNode).active then
    ((self.treeInfo).upgradeNode):Hide()
    return false
  else
    if ((self.treeInfo).upgradeMasterNode).active then
      ((self.treeInfo).upgradeMasterNode):Hide()
      return false
    end
  end
  local saveData = (PlayerDataCenter.CommanderSkillModualData):CreateSavingData(self.selectedTreeId)
  local fmtCSTData = ((PlayerDataCenter.formationDic)[self.formId]).cst
  local changed = false
  if fmtCSTData.treeId == self.selectedTreeId then
    for index,skillId in pairs((fmtCSTData.saving).skillActive) do
      if (saveData.skillActive)[index] ~= skillId then
        changed = true
      end
    end
    for index,skillId in pairs(saveData.skillActive) do
      if ((fmtCSTData.saving).skillActive)[index] == nil or ((fmtCSTData.saving).skillActive)[index] ~= skillId then
        changed = true
      end
    end
    for id,data in pairs((fmtCSTData.saving).skillProficient) do
      if (saveData.skillProficient)[id] == nil or ((saveData.skillProficient)[id]).level ~= data.level then
        changed = true
      end
    end
    for id,data in pairs(saveData.skillProficient) do
      if ((fmtCSTData.saving).skillProficient)[id] == nil or (((fmtCSTData.saving).skillProficient)[id]).level ~= data.level then
        changed = true
      end
    end
  else
    do
      changed = true
      if changed == true and self.formId ~= nil then
        self:FormSelectSkillTree(saveData)
      end
      self:Delete()
    end
  end
end

UICommanderSkill.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  (self.treeList):Delete()
  ;
  (self.treeDetail):Delete()
  ;
  (self.treeInfo):Delete()
  ;
  (self.resloader):Put2Pool()
  self.resloader = nil
  MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillTreeDataDiffer, self.__OnTreeDataChnage)
  MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillMasterLevelDiffer, self.__OnMasterLevelChange)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__RefreshRedDot)
  ;
  (base.OnDelete)(self)
end

return UICommanderSkill

