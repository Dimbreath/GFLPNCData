-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSInfo = class("UINCSInfo", UIBaseNode)
local base = UIBaseNode
local UINCSUpgradeNode = require("Game.CommanderSkill.UI.UINCSUpgradeNode")
local UINCSUpgradeMasterNode = require("Game.CommanderSkill.UI.UINCSUpgradeMasterNode")
UINCSInfo.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINCSUpgradeMasterNode, UINCSUpgradeNode
  self.maxLevel = #ConfigData.commander_skill_level
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_TreeLevel, self, self.OnClickAddExperience)
  self.upgradeMasterNode = (UINCSUpgradeMasterNode.New)()
  ;
  (self.upgradeMasterNode):Init((self.ui).obj_skillUpgradeNode)
  ;
  (self.upgradeMasterNode):Hide()
  self.upgradeNode = (UINCSUpgradeNode.New)()
  ;
  (self.upgradeNode):Init((self.ui).obj_skillUpgradeNode)
  ;
  (self.upgradeNode):Hide()
end

UINCSInfo.InitTreeInfo = function(self, resloader)
  -- function num : 0_1
  self.resloader = resloader
  ;
  (self.upgradeNode):InitUpgrade(resloader)
  ;
  (self.upgradeMasterNode):InitUpgrade(resloader)
end

UINCSInfo.ShowTreeInfo = function(self, treeData)
  -- function num : 0_2 , upvalues : _ENV
  self.treeData = treeData
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = treeData:GetName()
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Introduce).text = treeData:GetDescribe()
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  if treeData.level == self.maxLevel then
    ((self.ui).img_btn_TreeLevel).color = (self.ui).color_orange
    local masterLevel = (PlayerDataCenter.CommanderSkillModualData).masterLevel
    local masterExp = (PlayerDataCenter.CommanderSkillModualData).masterExp
    self:ShowLevel(masterLevel)
    local maxExp = nil
    if (ConfigData.commander_skill_master_level)[masterLevel] ~= nil then
      maxExp = ((ConfigData.commander_skill_master_level)[masterLevel]).exp
    end
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).img_Rate).fillAmount = masterExp / (maxExp or 1)
    ;
    (self.upgradeNode):Clean()
    ;
    (self.upgradeMasterNode):RefreshUpgrade(treeData.treeId, masterLevel, masterExp)
  else
    do
      -- DECOMPILER ERROR at PC60: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).img_btn_TreeLevel).color = (self.ui).color_balcak
      self:ShowLevel(treeData.level)
      do
        local maxExp = nil
        if (ConfigData.commander_skill_level)[treeData.treeId] ~= nil then
          maxExp = ((ConfigData.commander_skill_level)[treeData.level]).exp
        end
        -- DECOMPILER ERROR at PC83: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((self.ui).img_Rate).fillAmount = treeData.curExp / (maxExp or 1)
        ;
        (self.upgradeMasterNode):Clean()
        ;
        (self.upgradeNode):RefreshUpgrade(treeData)
        self:RefreshTreeInfoRedDot()
      end
    end
  end
end

UINCSInfo.RefreshTreeInfoRedDot = function(self)
  -- function num : 0_3
  ((self.ui).levelup_obj_RedDot):SetActive((self.treeData):CanThisTreeUpgrade())
end

UINCSInfo.ShowLevel = function(self, level)
  -- function num : 0_4 , upvalues : _ENV
  if level > 9 then
    (((self.ui).tex_Trim).gameObject):SetActive(false)
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_Level).text = tostring(level)
  else
    ;
    (((self.ui).tex_Trim).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_Level).text = tostring(level)
  end
end

UINCSInfo.OnClickAddExperience = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (UIUtil.SetTopStatus)(self.upgradeNode, (self.upgradeNode).Hide)
  ;
  (self.upgradeNode):Show()
end

UINCSInfo.OnDelete = function(self)
  -- function num : 0_6 , upvalues : base
  (self.upgradeNode):Delete()
  ;
  (self.upgradeMasterNode):Delete()
  ;
  (base.OnDelete)(self)
end

return UINCSInfo

