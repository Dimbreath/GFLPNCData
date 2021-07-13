-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSTSkill = class("UINCSTSkill", UIBaseNode)
local base = UIBaseNode
local UINCSTSkillActiveItem = require("Game.CommanderSkill.UI.SkillNode.UINCSTSkillActiveItem")
local UINCSTSkillPassiveItem = require("Game.CommanderSkill.UI.SkillNode.UINCSTSkillPassiveItem")
local UINCSTSkillOverrideItem = require("Game.CommanderSkill.UI.SkillNode.UINCSTSkillOverrideItem")
local UINCSTSkillUltimateItem = require("Game.CommanderSkill.UI.SkillNode.UINCSTSkillUltimateItem")
UINCSTSkill.ctor = function(self, sctMain)
  -- function num : 0_0
  self.sctMain = sctMain
end

UINCSTSkill.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV, UINCSTSkillActiveItem, UINCSTSkillPassiveItem, UINCSTSkillOverrideItem, UINCSTSkillUltimateItem
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
  ;
  ((self.ui).passiveItem):SetActive(false)
  self.skillPassiveItemPool = (UIItemPool.New)(UINCSTSkillPassiveItem, (self.ui).passiveItem)
  self.overrideSkillItemList = {}
  for k,go in ipairs((self.ui).overrideSkillGoList) do
    local item = (UINCSTSkillOverrideItem.New)()
    item:Init(go)
    ;
    (table.insert)(self.overrideSkillItemList, item)
  end
  self.ultimateSkillItemList = {}
  for k,go in ipairs((self.ui).ultimateSkillGoList) do
    local item = (UINCSTSkillUltimateItem.New)()
    item:Init(go)
    ;
    (table.insert)(self.ultimateSkillItemList, item)
  end
  self._clickSkillFunc = BindCallback(self, self._OnClickSkillItem)
end

UINCSTSkill.InitUINCSTSkill = function(self, treeData, resLoader)
  -- function num : 0_2 , upvalues : _ENV
  self.treeData = treeData
  self.resLoader = resLoader
  self:_OnClickCancelSelect()
  ;
  (self.skillPassiveItemPool):HideAll()
  self.skillPassiveItemDic = {}
  for k,skillId in ipairs(treeData.passiveSkillList) do
    local skillData = (treeData.commanderSkillDataDic)[skillId]
    local skillItem = (self.skillPassiveItemPool):GetOne()
    skillItem:InitCSTSkillPassiveItem(skillData, self.resLoader, self._clickSkillFunc)
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.skillPassiveItemDic)[skillId] = skillItem
  end
  self:UpdateUINCSTSkillAll()
  self:_PlayInitAnim()
end

UINCSTSkill._PlayInitAnim = function(self)
  -- function num : 0_3 , upvalues : _ENV
  for slotId,skillItemList in pairs(self.overrideSkillItemSlotDic) do
    for k,skillItem in ipairs(skillItemList) do
      skillItem:ResetCSTSkillOverrideItemAnim()
    end
    local ultSkillItem = (self.ultSkillItemSlotDic)[slotId]
    if ultSkillItem ~= nil then
      ultSkillItem:ResetCSTSkillUltimateItemAnim()
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
    local ultSkillItem = (self.ultSkillItemSlotDic)[slotId]
    if ultSkillItem ~= nil then
      local left, right, top, bottom = nil, nil, nil, nil
      if slotId == 1 then
        if equipOvSkillIndex == 1 then
          top = true
        else
          if equipOvSkillIndex == 2 then
            bottom = true
          end
        end
      else
        if slotId == 2 then
          if equipOvSkillIndex == 1 then
            right = true
          else
            if equipOvSkillIndex == 2 then
              left = true
            end
          end
        else
          if slotId == 3 then
            if equipOvSkillIndex == 1 then
              bottom = true
            else
              if equipOvSkillIndex == 2 then
                top = true
              end
            end
          end
        end
      end
      ultSkillItem:PlayCSTSkillUltimateItemAnim(left, right, top, bottom)
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
  for k,skillItem in pairs(self.skillPassiveItemDic) do
    skillItem:RefreshCSTSkillPassiveItem()
  end
  self.overrideSkillItemDic = {}
  self.overrideSkillItemSlotDic = {}
  local index = 1
  for slotId,skillIdList in ipairs(treeData.slotSkillOverloadList) do
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R8 in 'UnsetPending'

    (self.overrideSkillItemSlotDic)[slotId] = {}
    for k = 2, 3 do
      local skillId = skillIdList[k]
      local skillData = (treeData.commanderSkillDataDic)[skillId]
      local skillItem = (self.overrideSkillItemList)[index]
      if skillData == nil or skillData:IsCmdSkillUltimate() then
        skillItem:Hide()
      else
        skillItem:Show()
        local isEquip = (treeData.slotSkillList)[skillData.place] == skillId
        skillItem:InitCSTSkillOverrideItem(skillData, self.resLoader, self._clickSkillFunc, isEquip)
        -- DECOMPILER ERROR at PC79: Confused about usage of register: R16 in 'UnsetPending'

        ;
        (self.overrideSkillItemDic)[skillId] = skillItem
        ;
        (table.insert)((self.overrideSkillItemSlotDic)[slotId], skillItem)
      end
      index = index + 1
    end
  end
  self.ultSkillItemSlotDic = {}
  self.ultSkillItemDic = {}
  for slotId,skillItem in ipairs(self.ultimateSkillItemList) do
    local skillId = (treeData.slotUltimateSkillList)[slotId]
    local skillData = (treeData.commanderSkillDataDic)[skillId]
    if skillData == nil then
      skillItem:Hide()
    else
      skillItem:Show()
      local isEquip = (treeData.slotSkillList)[skillData.place] == skillId
      skillItem:InitCSTSkillUltimateItem(skillData, self.resLoader, self._clickSkillFunc, isEquip)
      -- DECOMPILER ERROR at PC123: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (self.ultSkillItemSlotDic)[slotId] = skillItem
      -- DECOMPILER ERROR at PC125: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (self.ultSkillItemDic)[skillId] = skillItem
    end
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

UINCSTSkill.ShowCSTSkillUnlockBlueDot = function(self, skillDataList)
  -- function num : 0_9 , upvalues : _ENV
  for k,skillData in ipairs(skillDataList) do
    local skillId = skillData.dataId
    if not (self.skillActiveItemDic)[skillId] and not (self.skillPassiveItemDic)[skillId] and not (self.overrideSkillItemDic)[skillId] then
      local skillItem = (self.ultSkillItemDic)[skillId]
    end
    if skillItem == nil then
      error("skillItem is nil, skillId = " .. tostring(skillId))
    else
      skillItem:ShowCSTSkillItemBlueDot(true)
    end
  end
end

UINCSTSkill.OnDelete = function(self)
  -- function num : 0_10 , upvalues : _ENV, base
  (self.skillActiveItemPool):DeleteAll()
  ;
  (self.skillPassiveItemPool):DeleteAll()
  for k,item in ipairs(self.overrideSkillItemList) do
    item:Delete()
  end
  for k,item in ipairs(self.ultimateSkillItemList) do
    item:Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UINCSTSkill

