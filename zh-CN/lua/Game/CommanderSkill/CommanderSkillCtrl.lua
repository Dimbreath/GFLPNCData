local base = ControllerBase
local CommanderSkillCtrl = class("CommanderSkillCtrl", base)
local CommanderSkillTreeData = require("Game.CommanderSkill.CommanderSkillTreeData")
CommanderSkillCtrl.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill)
end

CommanderSkillCtrl.InitInitCmdSkillCtrlByIdAndList = function(self, treeId, skills, confirmFunc, winOpenAction, defaultTreeSkillsDic)
  -- function num : 0_1 , upvalues : CommanderSkillTreeData
  local fmtCSTData = (CommanderSkillTreeData.New)(treeId)
  fmtCSTData:ApplySavingData(skills)
  self:InitCmdSkillCtrl(fmtCSTData, confirmFunc, winOpenAction, defaultTreeSkillsDic)
end

CommanderSkillCtrl.InitCmdSkillCtrl = function(self, fmtCSTData, confirmFunc, winOpenAction, defaultTreeSkillsDic)
  -- function num : 0_2 , upvalues : _ENV, CommanderSkillTreeData
  self.confirmFunc = confirmFunc
  local treeDataList = {}
  local selectedTreeId = fmtCSTData.treeId
  for treeId,treeCfg in ipairs(ConfigData.commander_skill) do
    local treeData = (CommanderSkillTreeData.New)(treeId)
    if treeId == selectedTreeId then
      treeData:ApplySavingData(fmtCSTData:GetUsingCmdSkillList())
    else
      if defaultTreeSkillsDic ~= nil and defaultTreeSkillsDic[treeId] ~= nil then
        treeData:ApplySavingData(defaultTreeSkillsDic[treeId])
      end
    end
    ;
    (table.insert)(treeDataList, treeData)
  end
  self.treeDataList = treeDataList
  self.selectedTreeId = selectedTreeId
  UIManager:ShowWindowAsync(UIWindowTypeID.CSTMain, function(window)
    -- function num : 0_2_0 , upvalues : self, treeDataList, selectedTreeId, winOpenAction
    if window == nil then
      return 
    end
    window:InitCSTMain(self, treeDataList, selectedTreeId)
    local func = winOpenAction
    if func ~= nil then
      winOpenAction = nil
      func()
    end
  end
)
end

CommanderSkillCtrl.RefreshCmdSkillCtrl = function(self, fmtCSTData)
  -- function num : 0_3 , upvalues : _ENV, CommanderSkillTreeData
  local uiCstMain = UIManager:GetWindow(UIWindowTypeID.CSTMain)
  if uiCstMain == nil then
    return 
  end
  self.treeDataList = {}
  for treeId,treeCfg in ipairs(ConfigData.commander_skill) do
    local treeData = (CommanderSkillTreeData.New)(treeId)
    if treeId == fmtCSTData.treeId then
      treeData:ApplySavingData(fmtCSTData:GetUsingCmdSkillList())
    end
    ;
    (table.insert)(self.treeDataList, treeData)
  end
  self.selectedTreeId = fmtCSTData.treeId
  uiCstMain:InitCSTMain(self, self.treeDataList, self.selectedTreeId)
end

CommanderSkillCtrl.SelectCmdSkillTree = function(self, treeId)
  -- function num : 0_4
  self.selectedTreeId = treeId
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
  local saveData = (self.treeDataList)[self.selectedTreeId]
  if self.confirmFunc ~= nil then
    (self.confirmFunc)(saveData)
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

