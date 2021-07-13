-- params : ...
-- function num : 0 , upvalues : _ENV
local base = ControllerBase
local CommanderSkillCtrl = class("CommanderSkillCtrl", base)
CommanderSkillCtrl.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill)
end

CommanderSkillCtrl.InitCmdSkillCtrl = function(self, fmtCSTData, confirmFunc, winOpenAction)
  -- function num : 0_1 , upvalues : _ENV
  self.confirmFunc = confirmFunc
  local treeDataList = {}
  local selectedTreeId = fmtCSTData.treeId
  local selectedTreeData = nil
  for treeId,treeData in pairs((PlayerDataCenter.CommanderSkillModualData).CommanderSkillTreeDataDic) do
    if treeId == selectedTreeId then
      selectedTreeData = treeData
      treeData:ApplySavingData(fmtCSTData.saving)
    end
    ;
    (table.insert)(treeDataList, treeData)
  end
  self.treeDataList = treeDataList
  self.selectedTreeId = selectedTreeId
  UIManager:ShowWindowAsync(UIWindowTypeID.CSTMain, function(window)
    -- function num : 0_1_0 , upvalues : _ENV, self, treeDataList, selectedTreeId, winOpenAction
    if window == nil then
      return 
    end
    AudioManager:PlayAudioById(1088)
    window:InitCSTMain(self, treeDataList, selectedTreeId)
    local func = winOpenAction
    if func ~= nil then
      winOpenAction = nil
      func()
    end
  end
)
end

CommanderSkillCtrl.SelectCmdSkillTree = function(self, treeId)
  -- function num : 0_2
  self.selectedTreeId = treeId
end

CommanderSkillCtrl.ReqCmdSkillUp = function(self, treeId, itemDic, cstDataDiff)
  -- function num : 0_3 , upvalues : _ENV
  self._onTreeUpFunc = BindCallback(self, self._OnCmdSkillUp, cstDataDiff)
  ;
  (self.networkCtrl):CS_COMMANDSKILL_Upgrade(treeId, itemDic, self._onTreeUpFunc)
end

CommanderSkillCtrl._OnCmdSkillUp = function(self, cstDataDiff)
  -- function num : 0_4 , upvalues : _ENV
  local cmdSkillWindow = UIManager:GetWindow(UIWindowTypeID.CSTMain)
  if cmdSkillWindow == nil then
    return 
  end
  ;
  (cmdSkillWindow.lvUpNode):OnCSTLevelUpComplete(cstDataDiff)
  ;
  (cmdSkillWindow.skillNode):UpdateUINCSTSkillAll()
  cmdSkillWindow:RefreshCSTLevel()
  ;
  (cmdSkillWindow.skillDetailNode):RefreshCSTSkillDetail()
end

CommanderSkillCtrl.ChangeCSTSlotSkill = function(self, slotId, skillId)
  -- function num : 0_5
  local treeData = (self.treeDataList)[self.selectedTreeId]
  treeData:SetSlotSkillList(slotId, skillId)
  self:_OnChangeCSTSlotSkill(slotId)
end

CommanderSkillCtrl._OnChangeCSTSlotSkill = function(self, slotId)
  -- function num : 0_6 , upvalues : _ENV
  local cmdSkillWindow = UIManager:GetWindow(UIWindowTypeID.CSTMain)
  if cmdSkillWindow == nil then
    return 
  end
  ;
  (cmdSkillWindow.skillNode):CSTSkillCancelSelect()
  ;
  (cmdSkillWindow.skillNode):UpdateUINCSTSkillAll()
  ;
  (cmdSkillWindow.skillNode):PlayCSTSkillSlotAnim(slotId)
end

CommanderSkillCtrl.ExitCmdSkill = function(self, tohome)
  -- function num : 0_7 , upvalues : _ENV
  local saveData = (PlayerDataCenter.CommanderSkillModualData):CreateSavingData(self.selectedTreeId)
  if self.confirmFunc ~= nil then
    (self.confirmFunc)(self.selectedTreeId, saveData)
  end
  self:Delete()
  if not tohome then
    GuideManager:TryTriggerGuide(eGuideCondition.InFormation)
    GuideManager:TryTriggerGuide(eGuideCondition.InFormationSpecial)
  end
end

CommanderSkillCtrl.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnDelete)(self)
end

return CommanderSkillCtrl

