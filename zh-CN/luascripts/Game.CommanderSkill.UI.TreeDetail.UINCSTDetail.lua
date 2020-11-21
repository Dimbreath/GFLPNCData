-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSTDetail = class("UINCSTDetail", UIBaseNode)
local base = UIBaseNode
local UINCSTDetail_SkillNode = require(
                                   "Game.CommanderSkill.UI.TreeDetail.UINCSTDetail_SkillNode")
local MasterGroup = require(
                        "Game.CommanderSkill.UI.TreeDetail.UINCSTDetail_MasterGroup")
UINCSTDetail.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINCSTDetail_SkillNode, MasterGroup
    self.maxLevel = #ConfigData.commander_skill_level;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddValueChangedListener)((self.ui).tog_SkillPage, self,
                                     self.SkillPageTogChange);
    (UIUtil.AddValueChangedListener)((self.ui).tog_MasterPage, self,
                                     self.MasterPageTogChange);
    (UIUtil.AddButtonListener)((self.ui).btn_Revert, self, self.CleanMaterNode)
    self.skillNode = (UINCSTDetail_SkillNode.New)();
    (self.skillNode):Init((self.ui).obj_skillPageNode)
    self.MasterGroupPool = (UIItemPool.New)(MasterGroup,
                                            (self.ui).obj_skillGroupItem)
end

UINCSTDetail.InitTreeDetail = function(self, resloader)
    -- function num : 0_1
    self.resloader = resloader;
    (self.skillNode):InitSkillNode(resloader)
end

UINCSTDetail.ShowTreeDetail = function(self, treeData)
    -- function num : 0_2
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).tog_SkillPage).isOn = true;
    (self.skillNode):ShowSkillNode(treeData)
    self:RefreshMasterNode(treeData)
    self.isUnlockMaster = self.maxLevel <= treeData.level
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINCSTDetail.SkillPageTogChange = function(self, bool)
    -- function num : 0_3
    if bool then
        (self.skillNode):Show();
        ((self.ui).obj_SkillTogOnSelect):SetActive(true) -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).tex_SkillBtnName).color = (self.ui).color_black
    else

        (self.skillNode):Hide();
        ((self.ui).obj_SkillTogOnSelect):SetActive(false) -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).tex_SkillBtnName).color = (self.ui).color_white
    end
    ((self.ui).obj_skillList):SetActive(bool)
end

UINCSTDetail.MasterPageTogChange = function(self, bool)
    -- function num : 0_4
    if bool then
        ((self.ui).obj_masterSkillNode):SetActive(true);
        ((self.ui).obj_MasterTogOnSelect):SetActive(true) -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).tex_MasterBtnName).color = (self.ui).color_black
        if self.isUnlockMaster then
            (((self.ui).btn_Revert).gameObject):SetActive(true)
        else

            (((self.ui).btn_Revert).gameObject):SetActive(false)
        end
    else

        ((self.ui).obj_masterSkillNode):SetActive(false);
        ((self.ui).obj_MasterTogOnSelect):SetActive(false) -- DECOMPILER ERROR at PC48: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).tex_MasterBtnName).color = (self.ui).color_white;
        (((self.ui).btn_Revert).gameObject):SetActive(false)
    end
    ((self.ui).obj_skillList):SetActive(not bool)
end

UINCSTDetail.CleanMaterNode = function(self)
    -- function num : 0_5 , upvalues : _ENV
    for _, item in ipairs((self.MasterGroupPool).listItem) do
        item:CleanAllPoint()
    end
end

UINCSTDetail.RefreshMasterNode = function(self, treeData)
    -- function num : 0_6 , upvalues : _ENV
    (self.MasterGroupPool):HideAll()
    for groupIndex, skillDataList in ipairs(treeData.masterSkillList) do
        local groupItem = (self.MasterGroupPool):GetOne()
        groupItem:RefreshMasterGroup(skillDataList, groupIndex)
    end
end

UINCSTDetail.OnDelete = function(self)
    -- function num : 0_7 , upvalues : base
    (self.skillNode):Delete();
    (base.OnDelete)(self)
end

return UINCSTDetail

