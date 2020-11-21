-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSUpgradeSkillList = class("UINCSUpgradeSkillList", UIBaseNode)
local base = UIBaseNode
local UINCSUpgradeSkillItem = require(
                                  "Game.CommanderSkill.UI.UINCSUpgradeSkillItem")
UINCSUpgradeSkillList.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.itemDic = {};
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui) -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).loopList_skillList).onInstantiateItem =
        BindCallback(self, self.__OnNewItem) -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).loopList_skillList).onChangeItem =
        BindCallback(self, self.__OnChangeItem)
end

UINCSUpgradeSkillList.InitList = function(self, resloader)
    -- function num : 0_1
    self.resloader = resloader
end

UINCSUpgradeSkillList.RefreshList = function(self, dataList)
    -- function num : 0_2
    self.dataList = dataList -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).loopList_skillList).totalCount = #dataList;
    ((self.ui).loopList_skillList):RefillCells()
end

UINCSUpgradeSkillList.__OnNewItem = function(self, go)
    -- function num : 0_3 , upvalues : UINCSUpgradeSkillItem
    local skillItem = (UINCSUpgradeSkillItem.New)()
    skillItem:Init(go)
    skillItem:InitSkillItem(self.resloader) -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.itemDic)[go] = skillItem
end

UINCSUpgradeSkillList.__OnChangeItem = function(self, go, index)
    -- function num : 0_4 , upvalues : _ENV
    local skillItem = (self.itemDic)[go]
    if skillItem == nil then
        error("Can\'t find treeItem by gameObject")
        return
    end
    local skillData = (self.dataList)[index + 1]
    if skillData == nil then
        error("Can\'t find treeData by index, index = " .. tonumber(index))
    end
    skillItem:RefreshIcon(skillData)
end

UINCSUpgradeSkillList.OnDelete = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnDelete)(self)
end

return UINCSUpgradeSkillList

