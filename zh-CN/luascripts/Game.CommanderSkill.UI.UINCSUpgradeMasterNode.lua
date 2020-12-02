-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSUpgradeNode = require("Game.CommanderSkill.UI.UINCSUpgradeNode")
local UINCSUpgradeMasterNode = class("UINCSUpgradeMasterNode", UINCSUpgradeNode)
local base = UINCSUpgradeNode
UINCSUpgradeMasterNode.OnInit = function(self)
  -- function num : 0_0 , upvalues : base
  (base.OnInit)(self)
end

UINCSUpgradeMasterNode.InitUpgrade = function(self, resloader)
  -- function num : 0_1 , upvalues : _ENV
  self.resloader = resloader
  self.levelCfg = ConfigData.commander_skill_master_level
  self.maxLevel = #self.levelCfg
end

UINCSUpgradeMasterNode.RefreshUpgrade = function(self, treeId, masterLevel, masterExp)
  -- function num : 0_2
  self.selectedTreeId = treeId
  self.curLevel = masterLevel or 1
  if self.curLevel == 0 then
    self.curLevel = 1
  end
  self.curExp = masterExp
  ;
  ((self.ui).obj_skillNode):SetActive(false)
  self.needFresh = true
  self:UpdateGrowupItem()
  self:CalAndRefreshExpBar()
end

UINCSUpgradeMasterNode.UpdateLevel = function(self, level)
  -- function num : 0_3
  if not self.needFresh then
    return 
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  if self.curLevel < level then
    ((self.ui).tex_Level).color = (self.ui).color_orange
  else
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_Level).color = (self.ui).color_black
  end
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).tex_Level).text = level
  ;
  ((self.ui).obj_tex_Trim):SetActive(level <= 9)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINCSUpgradeMasterNode.OnDelete = function(self)
  -- function num : 0_4 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__UpdateGrowupItem)
  ;
  (base.OnDelete)(self)
end

return UINCSUpgradeMasterNode

