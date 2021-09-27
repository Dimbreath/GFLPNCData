local UICSTMain = class("UICSTMain", UIBaseWindow)
local base = UIBaseWindow
local UINCSTreeTogItem = require("Game.CommanderSkill.UI.Main.UINCSTreeTogItem")
local UINCSTSkill = require("Game.CommanderSkill.UI.SkillNode.UINCSTSkill")
local UINCSTSkillDetail = require("Game.CommanderSkill.UI.SkillDetail.UINCSTSkillDetail")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
UICSTMain.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINCSTreeTogItem, UINCSTSkill, UINCSTSkillDetail, cs_ResLoader
  ((self.ui).treeItem):SetActive(false)
  self.treeItemPool = (UIItemPool.New)(UINCSTreeTogItem, (self.ui).treeItem)
  self._selectTreeFunc = BindCallback(self, self._OnSelectTree)
  self.skillNode = (UINCSTSkill.New)(self)
  ;
  (self.skillNode):Init((self.ui).skillNode)
  self.skillDetailNode = (UINCSTSkillDetail.New)()
  ;
  (self.skillDetailNode):Init((self.ui).cSTDetailNode)
  ;
  (self.skillDetailNode):Hide()
  self.resLoader = (cs_ResLoader.Create)()
  ;
  (UIUtil.SetTopStatus)(self, self._OnClickReturn, nil, nil, nil, nil, function()
    -- function num : 0_0_0 , upvalues : _ENV
    if ExplorationManager:IsInExploration() then
      (UIUtil.SetTopStatusBtnShow)(false, false)
    end
  end
)
end

UICSTMain.InitCSTMain = function(self, cmdSkillCtrl, treeDataList, selectedTreeId)
  -- function num : 0_1 , upvalues : _ENV
  self.cmdSkillCtrl = cmdSkillCtrl
  self.treeDataList = treeDataList
  ;
  (self.treeItemPool):HideAll()
  self.selectedTreeId = nil
  for k,treeData in ipairs(treeDataList) do
    local treeItem = (self.treeItemPool):GetOne()
    treeItem:InitCSTreeTogItem(treeData, self._selectTreeFunc)
    if k == selectedTreeId then
      treeItem:SetCSTreeTogItemSelect(true)
    end
  end
  self:_OnSelectTree(selectedTreeId)
end

UICSTMain.ShowCSTSkillDetail = function(self, cmdSkillData)
  -- function num : 0_2 , upvalues : _ENV
  (self.skillDetailNode):Show()
  AudioManager:PlayAudioById(1067)
  local isEquip = (self.curTreeData):GetActiveSlotCurSkill(cmdSkillData.place) == cmdSkillData.dataId
  ;
  (self.skillDetailNode):InitCSTSkillDetail(self.cmdSkillCtrl, cmdSkillData, self.resLoader, isEquip)
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

  if cmdSkillData.place == 3 then
    ((self.skillDetailNode).transform).position = ((self.ui).detailPosLeft).position
  else
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R3 in 'UnsetPending'

    ((self.skillDetailNode).transform).position = ((self.ui).detailPosRight).position
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UICSTMain.HideCSTSkillDetail = function(self)
  -- function num : 0_3 , upvalues : _ENV
  AudioManager:PlayAudioById(1068)
  ;
  (self.skillDetailNode):Hide()
end

UICSTMain._OnSelectTree = function(self, treeId)
  -- function num : 0_4 , upvalues : cs_MessageCommon, _ENV
  if self.selectedTreeId == treeId then
    return 
  end
  local treeData = (self.treeDataList)[treeId]
  if not treeData:IsCmdTreeUnlock() then
    (cs_MessageCommon.ShowMessageTips)(treeData:GetCmdSkillTreeUnlockInfo())
    return 
  end
  self.selectedTreeId = treeId
  self.curTreeData = (self.treeDataList)[treeId]
  ;
  (self.skillNode):InitUINCSTSkill(treeData, self.resLoader)
  ;
  (self.cmdSkillCtrl):SelectCmdSkillTree(treeId)
  for _,item in ipairs((self.treeItemPool).listItem) do
    item:SetCSTreeTogItemSelect((item.treeData).treeId == treeId)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UICSTMain._OnClickReturn = function(self, tohome)
  -- function num : 0_5
  (self.cmdSkillCtrl):ExitCmdSkill(tohome)
  self:Delete()
end

UICSTMain.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (self.resLoader):Put2Pool()
  self.resLoader = nil
  ;
  (self.treeItemPool):DeleteAll()
  ;
  (self.skillNode):Delete()
  ;
  (self.skillDetailNode):Delete()
  ;
  (base.OnDelete)(self)
end

return UICSTMain

