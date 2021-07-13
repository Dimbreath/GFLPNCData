-- params : ...
-- function num : 0 , upvalues : _ENV
local UICSTMain = class("UICSTMain", UIBaseWindow)
local base = UIBaseWindow
local UINCSTreeTogItem = require("Game.CommanderSkill.UI.Main.UINCSTreeTogItem")
local UINCSTSkill = require("Game.CommanderSkill.UI.SkillNode.UINCSTSkill")
local UINCSTLevelUp = require("Game.CommanderSkill.UI.LevelUpNode.UINCSTLevelUp")
local UINCSTSkillDetail = require("Game.CommanderSkill.UI.SkillDetail.UINCSTSkillDetail")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
UICSTMain.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINCSTreeTogItem, UINCSTSkill, UINCSTLevelUp, UINCSTSkillDetail, cs_ResLoader
  ((self.ui).treeItem):SetActive(false)
  self.treeItemPool = (UIItemPool.New)(UINCSTreeTogItem, (self.ui).treeItem)
  self._selectTreeFunc = BindCallback(self, self._OnSelectTree)
  self.skillNode = (UINCSTSkill.New)(self)
  ;
  (self.skillNode):Init((self.ui).skillNode)
  self.lvUpNode = (UINCSTLevelUp.New)(self)
  ;
  (self.lvUpNode):Init((self.ui).cSTLevelUpNode)
  ;
  (self.lvUpNode):Hide()
  self.skillDetailNode = (UINCSTSkillDetail.New)()
  ;
  (self.skillDetailNode):Init((self.ui).cSTDetailNode)
  ;
  (self.skillDetailNode):Hide()
  self.resLoader = (cs_ResLoader.Create)()
  ;
  (UIUtil.SetTopStatus)(self, self._OnClickReturn)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_TreeLevel, self, self._OnClickLevel)
  self.__OnItemChange = BindCallback(self, self._OnItemChange)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemChange)
end

UICSTMain.InitCSTMain = function(self, cmdSkillCtrl, treeDataList, selectedTreeId)
  -- function num : 0_1 , upvalues : _ENV
  self.cmdSkillCtrl = cmdSkillCtrl
  self.treeDataList = treeDataList
  for k,treeData in ipairs(treeDataList) do
    local treeItem = (self.treeItemPool):GetOne()
    treeItem:InitCSTreeTogItem(treeData, self._selectTreeFunc)
    if k == selectedTreeId then
      treeItem:SetCSTreeTogItemSelect(true)
    end
  end
  self:_OnSelectTree(selectedTreeId)
end

UICSTMain.RefreshCSTLevel = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local level = (self.curTreeData).level
  if level > 9 then
    ((self.ui).tex_TreeLevel):SetIndex(1, tostring(level))
  else
    ;
    ((self.ui).tex_TreeLevel):SetIndex(0, tostring(level))
  end
  local cmdSkillLevelCfg = (ConfigData.commander_skill_level)[level]
  local curExp = (self.curTreeData).curExp
  local maxExp = cmdSkillLevelCfg.exp
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

  if maxExp == 0 then
    ((self.ui).img_ExpBar).fillAmount = 1
  else
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).img_ExpBar).fillAmount = curExp / maxExp
  end
  if #ConfigData.commander_skill_level <= level then
    ((self.ui).tex_TreeExp):SetIndex(1)
  else
    ;
    ((self.ui).tex_TreeExp):SetIndex(0, tostring(curExp), tostring(maxExp))
  end
  self:_RefreshBlueDot()
end

UICSTMain.ShowCSTSkillDetail = function(self, cmdSkillData)
  -- function num : 0_3 , upvalues : _ENV
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
  -- function num : 0_4 , upvalues : _ENV
  AudioManager:PlayAudioById(1068)
  ;
  (self.skillDetailNode):Hide()
end

UICSTMain._OnItemChange = function(self)
  -- function num : 0_5
  self:_RefreshBlueDot()
end

UICSTMain._RefreshBlueDot = function(self)
  -- function num : 0_6 , upvalues : _ENV
  ((self.ui).obj_RedDot):SetActive((self.curTreeData):CanThisTreeUpgrade())
  for k,treeItem in ipairs((self.treeItemPool).listItem) do
    treeItem:RefreshCSTreeTogItemBlueDot()
  end
end

UICSTMain._OnSelectTree = function(self, treeId)
  -- function num : 0_7 , upvalues : cs_MessageCommon
  if self.selectedTreeId == treeId then
    return 
  end
  self.selectedTreeId = treeId
  self.curTreeData = (self.treeDataList)[treeId]
  local treeData = (self.treeDataList)[treeId]
  if not treeData.isUnlock and not treeData:TryToUnlock() then
    (cs_MessageCommon.ShowMessageTips)(treeData:GetCmdSkillTreeUnlockInfo())
    return 
  end
  ;
  (self.skillNode):InitUINCSTSkill(treeData, self.resLoader)
  self:RefreshCSTLevel()
  ;
  (self.cmdSkillCtrl):SelectCmdSkillTree(treeId)
  self:_RefreshBlueDot()
end

UICSTMain._OnClickLevel = function(self)
  -- function num : 0_8
  (self.lvUpNode):Show()
  ;
  (self.lvUpNode):InitCSTLevelUp(self.cmdSkillCtrl, self.curTreeData, self.resLoader)
end

UICSTMain._OnClickReturn = function(self, tohome)
  -- function num : 0_9
  (self.cmdSkillCtrl):ExitCmdSkill(tohome)
  self:Delete()
end

UICSTMain.OnDelete = function(self)
  -- function num : 0_10 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemChange)
  ;
  (self.resLoader):Put2Pool()
  self.resLoader = nil
  ;
  (self.treeItemPool):DeleteAll()
  ;
  (self.skillNode):Delete()
  ;
  (self.lvUpNode):Delete()
  ;
  (self.skillDetailNode):Delete()
  ;
  (base.OnDelete)(self)
end

return UICSTMain

