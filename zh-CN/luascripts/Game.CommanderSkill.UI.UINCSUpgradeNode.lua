-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSUpgradeNode = class("UINCSUpgradeNode", UIBaseNode)
local base = UIBaseNode
local UINCSUpgradeItem = require("Game.CommanderSkill.UI.UINCSUpgradeItem")
local UINCSUpgradeSkillList = require("Game.CommanderSkill.UI.UINCSUpgradeSkillList")
local CommanderSkillData = require("Game.CommanderSkill.CommanderSkillData")
UINCSUpgradeNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINCSUpgradeSkillList, UINCSUpgradeItem
  self.selectedTreeId = nil
  self.curLevel = 1
  self.newLevel = 1
  self.maxLevel = 15
  self.curExp = 0
  self.addExp = 0
  self.levelCfg = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_close, self, self.Hide)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.OnClickConfirm)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Clear, self, self.OnClickClear)
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill)
  self.unlockableList = (UINCSUpgradeSkillList.New)()
  ;
  (self.unlockableList):Init((self.ui).obj_skillList)
  self.expItemPool = (UIItemPool.New)(UINCSUpgradeItem, (self.ui).obj_materialItem)
  self.expItemList = {}
  self.expItemNums = {}
  self.__OnItemChange = BindCallback(self, self.OnItemChange)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemChange)
  self.__ConfirmCallBack = BindCallback(self, self.ConfirmCallBack)
end

UINCSUpgradeNode.InitUpgrade = function(self, resloader)
  -- function num : 0_1 , upvalues : _ENV
  self.resloader = resloader
  self.levelCfg = ConfigData.commander_skill_level
  self.maxLevel = #self.levelCfg
  ;
  (self.unlockableList):InitList(resloader)
end

UINCSUpgradeNode.RefreshUpgrade = function(self, treeData)
  -- function num : 0_2
  self.selectedTreeId = treeData.treeId
  self.treeData = treeData
  self.curLevel = treeData.level
  self.curExp = treeData.curExp
  ;
  ((self.ui).obj_skillNode):SetActive(true)
  self.needFresh = true
  self:OnItemChange()
end

UINCSUpgradeNode.OnItemChange = function(self)
  -- function num : 0_3
  self:UpdateGrowupItem()
  self:CalAndRefreshExpBar()
end

UINCSUpgradeNode.UpdateLevel = function(self, level)
  -- function num : 0_4
  if not self.needFresh then
    return 
  end
  self.newLevel = level
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

  if self.curLevel < level then
    ((self.ui).tex_Level).color = (self.ui).color_orange
  else
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_Level).color = (self.ui).color_black
  end
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Level).text = level
  ;
  ((self.ui).obj_tex_Trim):SetActive(level <= 9)
  self:RefreshUnlockSkill(level)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINCSUpgradeNode.RefreshConfirmBtn = function(self)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).img_Confirm).color = (self.ui).color_gray
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).img_Clear).color = (self.ui).color_gray
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).btn_Confirm).interactable = false
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).btn_Clear).interactable = false
  if (table.count)(self.expItemNums) ~= 0 then
    for itemId,num in pairs(self.expItemNums) do
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R6 in 'UnsetPending'

      if num > 0 then
        ((self.ui).img_Confirm).color = (self.ui).color_orange
        -- DECOMPILER ERROR at PC37: Confused about usage of register: R6 in 'UnsetPending'

        ;
        ((self.ui).img_Clear).color = (self.ui).color_black
        -- DECOMPILER ERROR at PC40: Confused about usage of register: R6 in 'UnsetPending'

        ;
        ((self.ui).btn_Confirm).interactable = true
        -- DECOMPILER ERROR at PC43: Confused about usage of register: R6 in 'UnsetPending'

        ;
        ((self.ui).btn_Clear).interactable = true
      end
    end
  end
end

UINCSUpgradeNode.CalAndRefreshExpBar = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if not self.needFresh then
    return 
  end
  self:RefreshConfirmBtn()
  local level = self.curLevel or 1
  local curExp = self.curExp or 0
  local addExp = self:_CalAddExp() or 0
  local requireExp = ((self.levelCfg)[level]).exp
  local maxAddExp = -curExp
  for i = level, self.maxLevel - 1 do
    maxAddExp = maxAddExp + ((self.levelCfg)[i]).exp
  end
  self:SetAddExpLimt(maxAddExp, addExp)
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R6 in 'UnsetPending'

  if maxAddExp == 0 then
    ((self.ui).img_Process).fillAmount = 0
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).img_RateProcess).fillAmount = 0
    ;
    ((self.ui).tex_Exp):SetIndex(1)
    ;
    (((self.ui).tex_RateExp).gameObject):SetActive(false)
    self:UpdateLevel(level)
    return 
  else
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R6 in 'UnsetPending'

    if maxAddExp <= addExp then
      ((self.ui).img_Process).fillAmount = 0
      -- DECOMPILER ERROR at PC68: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((self.ui).img_RateProcess).fillAmount = 1
      ;
      ((self.ui).tex_Exp):SetIndex(1)
      ;
      ((self.ui).tex_RateExp):SetIndex(0, tostring(addExp))
      self:UpdateLevel(self.maxLevel)
      return 
    end
  end
  ;
  ((self.ui).tex_Exp):SetIndex(0, tostring(curExp), tostring(requireExp))
  ;
  ((self.ui).tex_RateExp):SetIndex(0, tostring(addExp))
  -- DECOMPILER ERROR at PC111: Confused about usage of register: R6 in 'UnsetPending'

  if curExp + addExp < requireExp then
    ((self.ui).img_Process).fillAmount = curExp / requireExp
    -- DECOMPILER ERROR at PC116: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).img_RateProcess).fillAmount = (curExp + addExp) / requireExp
    ;
    ((self.ui).tex_Exp):SetIndex(0, tostring(curExp + addExp), tostring(requireExp))
    self:UpdateLevel(level)
  else
    local remainEXP = curExp + addExp - requireExp
    if self.maxLevel >= level + 1 then
      level = level + 1
      requireExp = ((self.levelCfg)[level]).exp
      while 1 do
        if requireExp <= remainEXP then
          remainEXP = remainEXP - requireExp
          if self.maxLevel >= level + 1 then
            level = level + 1
            requireExp = ((self.levelCfg)[level]).exp
            -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC153: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    -- DECOMPILER ERROR at PC156: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).img_Process).fillAmount = 0
    -- DECOMPILER ERROR at PC160: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self.ui).img_RateProcess).fillAmount = (remainEXP) / requireExp
    ;
    ((self.ui).tex_Exp):SetIndex(0, tostring(remainEXP), tostring(requireExp))
    self:UpdateLevel(level)
  end
end

UINCSUpgradeNode._CalAddExp = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local totalExp = 0
  for itemData,num in pairs(self.expItemNums) do
    totalExp = totalExp + itemData:GetActionArg(1) * num
  end
  return totalExp
end

UINCSUpgradeNode.SetAddExpLimt = function(self, maxAddExp, addExp)
  -- function num : 0_8 , upvalues : _ENV
  for _,item in ipairs(self.expItemList) do
    item:SetAddExpLimt(maxAddExp, addExp)
  end
end

UINCSUpgradeNode.UpdateGrowupItem = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self.needFresh then
    (self.expItemPool):HideAll()
    for _,id in ipairs(((ConfigData.item).growUpIds)[eItemActionType.CommanderSkillExp]) do
      if (PlayerDataCenter.itemDic)[id] ~= nil then
        local itemData = (PlayerDataCenter.itemDic)[id]
        do
          local item = (self.expItemPool):GetOne(true)
          item:InitExpItem(itemData, function(num)
    -- function num : 0_9_0 , upvalues : self, itemData
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

    (self.expItemNums)[itemData] = num
    self:CalAndRefreshExpBar()
  end
)
          ;
          (table.insert)(self.expItemList, item)
        end
      else
        do
          do
            local item = (self.expItemPool):GetOne(true)
            item:InitEmptyExpItem(id)
            -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

UINCSUpgradeNode.OnClickClear = function(self)
  -- function num : 0_10 , upvalues : _ENV
  for _,item in ipairs(self.expItemList) do
    item:CleanAll()
  end
  for itemData,_ in pairs(self.expItemNums) do
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R6 in 'UnsetPending'

    (self.expItemNums)[itemData] = 0
  end
end

UINCSUpgradeNode.OnClickConfirm = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if (table.count)(self.expItemNums) == 0 then
    return 
  end
  local itemTab = {}
  for itemData,num in pairs(self.expItemNums) do
    itemTab[itemData.dataId] = num
  end
  if self.networkCtrl ~= nil then
    (self.networkCtrl):CS_COMMANDSKILL_Upgrade(self.selectedTreeId, itemTab, self.__ConfirmCallBack)
  end
end

UINCSUpgradeNode.ConfirmCallBack = function(self)
  -- function num : 0_12
  self:PopUnlockSkillMessageTip()
  self:OnClickClear()
end

UINCSUpgradeNode.RefreshUnlockSkill = function(self, level)
  -- function num : 0_13
  if self.curLevel < level then
    local LevelSkillData = self:LevelSkillData(self.curLevel, level)
    ;
    (self.unlockableList):RefreshList(LevelSkillData)
  else
    do
      local LevelSkillData = self:LevelSkillData(self.curLevel, self.curLevel + 1)
      ;
      (self.unlockableList):RefreshList(LevelSkillData)
    end
  end
end

UINCSUpgradeNode.LevelSkillData = function(self, startLevel, endLevel)
  -- function num : 0_14 , upvalues : _ENV, CommanderSkillData
  local skillDatas = {}
  for i = startLevel + 1, endLevel do
    if (ConfigData.commander_skill_unlock)[self.selectedTreeId] ~= nil and ((ConfigData.commander_skill_unlock)[self.selectedTreeId])[i] ~= nil then
      for skillId,_ in pairs(((ConfigData.commander_skill_unlock)[self.selectedTreeId])[i]) do
        local skillData = ((self.treeData).commanderSkillDataDic)[skillId]
        if skillData.type ~= (CommanderSkillData.skillType).master then
          (table.insert)(skillDatas, ((self.treeData).commanderSkillDataDic)[skillId])
        end
      end
    end
  end
  return skillDatas
end

UINCSUpgradeNode.PopUnlockSkillMessageTip = function(self)
  -- function num : 0_15 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageSide, function(window)
    -- function num : 0_15_0 , upvalues : self, _ENV
    if window == nil then
      return 
    end
    if self.newLevel == self.curLevel then
      return 
    end
    local LevelSkillData = self:LevelSkillData(self.curLevel, self.newLevel)
    if #LevelSkillData == 0 then
      return 
    end
    for _,data in pairs(LevelSkillData) do
      data.isNewUnlock = true
      local msg = ConfigData:GetTipContent(TipContent.CST_unlockTip)
      msg = (string.format)(msg, (data.battleSkillCfg).Name)
      window:ShowTips(msg)
    end
  end
)
end

UINCSUpgradeNode.Clean = function(self)
  -- function num : 0_16
  self:OnClickClear()
  ;
  (self.expItemPool):HideAll()
  self.expItemList = {}
  self.needFresh = false
end

UINCSUpgradeNode.OnHide = function(self)
  -- function num : 0_17
  self:OnClickClear()
end

UINCSUpgradeNode.OnDelete = function(self)
  -- function num : 0_18 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemChange)
  ;
  (self.expItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UINCSUpgradeNode

