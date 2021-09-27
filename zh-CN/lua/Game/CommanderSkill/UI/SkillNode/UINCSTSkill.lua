local UINCSTSkill = class("UINCSTSkill", UIBaseNode)
local base = UIBaseNode
local UINCSTSkillActiveItem = require("Game.CommanderSkill.UI.SkillNode.UINCSTSkillActiveItem")
local UINCSTSkillOverrideItem = require("Game.CommanderSkill.UI.SkillNode.UINCSTSkillOverrideItem")
UINCSTSkill.ctor = function(self, sctMain)
  -- function num : 0_0
  self.sctMain = sctMain
end

UINCSTSkill.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINCSTSkillActiveItem, UINCSTSkillOverrideItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_CancelSelect, self, self._OnClickCancelSelect)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).btn_CancelSelect).enabled = false
  ;
  ((self.ui).skillRootItem):SetActive(false)
  self.skillActiveItemPool = (UIItemPool.New)(UINCSTSkillActiveItem, (self.ui).skillRootItem)
  self.skillActiveItemList = {}
  self.skillActiveItemDic = {}
  for i = 1, 3 do
    local skillItem = (self.skillActiveItemPool):GetOne()
    ;
    (table.insert)(self.skillActiveItemList, skillItem)
  end
  self.overrideSkillItemList = {}
  for k,go in ipairs((self.ui).overrideSkillGoList) do
    local item = (UINCSTSkillOverrideItem.New)()
    item:Init(go)
    ;
    (table.insert)(self.overrideSkillItemList, item)
  end
  self._clickSkillFunc = BindCallback(self, self._OnClickSkillItem)
end

UINCSTSkill.InitUINCSTSkill = function(self, treeData, resLoader)
  -- function num : 0_2
  self.treeData = treeData
  self.resLoader = resLoader
  self:_OnClickCancelSelect()
  self:UpdateUINCSTSkillAll()
  self:_PlayInitAnim()
end

UINCSTSkill._PlayInitAnim = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for slotId,skillItemList in pairs(self.overrideSkillItemSlotDic) do
    for k,skillItem in ipairs(skillItemList) do
      skillItem:ResetCSTSkillOverrideItemAnim()
    end
    self:PlayCSTSkillSlotAnim(slotId)
  end
end

UINCSTSkill.PlayCSTSkillSlotAnim = function(self, slotId)
  -- function num : 0_4 , upvalues : _ENV
  local skillItemList = (self.overrideSkillItemSlotDic)[slotId]
  local isMiddle = true
  for k,skillItem in ipairs(skillItemList) do
    if skillItem.isEquip then
      isMiddle = false
      break
    end
  end
  do
    local equipOvSkillIndex = nil
    for k,skillItem in ipairs(skillItemList) do
      skillItem:PlayCSTSkillOverrideItemAnim(isMiddle)
      if skillItem.isEquip then
        equipOvSkillIndex = k
      end
    end
  end
end

UINCSTSkill._OnClickSkillItem = function(self, cmdSkillData, skillItem)
  -- function num : 0_5
  if self.lastSelectSkillItem == skillItem then
    return 
  end
  if self.lastSelectSkillItem ~= nil then
    (self.lastSelectSkillItem):SetCSTSkillItemSelect(false)
  end
  skillItem:SetCSTSkillItemSelect(true)
  self.lastSelectSkillItem = skillItem
  ;
  (self.sctMain):ShowCSTSkillDetail(cmdSkillData)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).btn_CancelSelect).enabled = true
end

UINCSTSkill._OnClickCancelSelect = function(self)
  -- function num : 0_6
  if self.lastSelectSkillItem == nil then
    return 
  end
  ;
  (self.lastSelectSkillItem):SetCSTSkillItemSelect(false)
  self.lastSelectSkillItem = nil
  ;
  (self.sctMain):HideCSTSkillDetail()
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).btn_CancelSelect).enabled = false
end

UINCSTSkill.CSTSkillCancelSelect = function(self)
  -- function num : 0_7
  self:_OnClickCancelSelect()
end

UINCSTSkill.UpdateUINCSTSkillAll = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local treeData = self.treeData
  for slot,skillItem in ipairs(self.skillActiveItemList) do
    local skillId = (treeData.slotSkillList)[slot]
    if skillId == 0 or skillId == nil then
      skillId = ((treeData.slotSkillOverloadList)[slot])[1]
    end
    local skillData = (treeData.commanderSkillDataDic)[skillId]
    skillItem:InitCSTSkillActiveItem(skillData, self.resLoader, self._clickSkillFunc)
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self.skillActiveItemDic)[skillId] = skillItem
  end
  self.overrideSkillItemDic = {}
  self.overrideSkillItemSlotDic = {}
  local index = 1
  for slotId,skillIdList in ipairs(treeData.slotSkillOverloadList) do
    local installedSkillId = (treeData.slotSkillList)[slotId]
    local installedIsDefault = nil
    if installedSkillId == nil or installedSkillId == 0 then
      installedIsDefault = nil
    else
      local installedSkillData = (treeData.commanderSkillDataDic)[installedSkillId]
      installedIsDefault = installedSkillData:CmdSkillIsSlotDefault()
    end
    do
      do
        -- DECOMPILER ERROR at PC50: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (self.overrideSkillItemSlotDic)[slotId] = {}
        for k = 2, 3 do
          local skillId = skillIdList[k]
          local skillData = (treeData.commanderSkillDataDic)[skillId]
          local skillItem = (self.overrideSkillItemList)[index]
          skillItem:Show()
          local isEquip = (treeData.slotSkillList)[skillData.place] == skillId
          skillItem:InitCSTSkillOverrideItem(skillData, self.resLoader, self._clickSkillFunc, isEquip)
          -- DECOMPILER ERROR at PC76: Confused about usage of register: R18 in 'UnsetPending'

          ;
          (self.overrideSkillItemDic)[skillId] = skillItem
          ;
          (table.insert)((self.overrideSkillItemSlotDic)[slotId], skillItem)
          if installedIsDefault then
            do
              skillItem:ShowRedDotCSTSkillItem(skillData:IsCmdSkillUnlock())
              index = index + 1
              -- DECOMPILER ERROR at PC90: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC90: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
        -- DECOMPILER ERROR at PC91: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UINCSTSkill.OnDelete = function(self)
  -- function num : 0_9 , upvalues : _ENV, base
  (self.skillActiveItemPool):DeleteAll()
  for k,item in ipairs(self.overrideSkillItemList) do
    item:Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UINCSTSkill

