-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSTListItem = class("UINCSTListItem", UIBaseNode)
local base = UIBaseNode
UINCSTListItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.maxLevel = #ConfigData.commander_skill_level
    self.treeData = nil
    self.showDetailCallback = nil;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddValueChangedListener)((self.ui).tog_skillTreeItem, self,
                                     self.OnValueChange)
    self.__RefreshTreeActiveSkill = BindCallback(self,
                                                 self.RefreshTreeActiveSkill)
    MsgCenter:AddListener(eMsgEventId.OnCommanderSkillOverLoad,
                          self.__RefreshTreeActiveSkill)
end

UINCSTListItem.InitListItem = function(self, resloader, showDetailCallback)
    -- function num : 0_1
    self.resloader = resloader
    self.showDetailCallback = showDetailCallback
end

UINCSTListItem.RefreshListItem = function(self, treeData)
    -- function num : 0_2
    self.treeData = treeData
    self:RefreshLevel() -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).tex_Name).text = treeData:GetName() -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).tex_Intro).text = treeData:GetDescribe()
    self:RefreshTreeActiveSkill()
    if not treeData.isUnlock then treeData:TryToUnlock() end -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'
    
    ((self.ui).tog_skillTreeItem).interactable = treeData.isUnlock
    self:SetIcon()
    self:SetColor()
end

UINCSTListItem.RefreshLevel = function(self)
    -- function num : 0_3 , upvalues : _ENV
    if (self.treeData).level == self.maxLevel then
        ((self.ui).tex_Level):SetIndex(1)
    else

        ((self.ui).tex_Level):SetIndex(0, tostring((self.treeData).level))
    end
end

UINCSTListItem.OnValueChange = function(self, bool)
    -- function num : 0_4 , upvalues : _ENV
    if bool then
        ((self.ui).obj_UnSelect):SetActive(false);
        ((self.ui).obj_Select):SetActive(true);
        ((self.ui).obj_isEquip):SetActive(true)
        if self.showDetailCallback ~= nil then
            (self.showDetailCallback)(self.treeData)
        end
    else

        ((self.ui).obj_UnSelect):SetActive(true);
        ((self.ui).obj_Select):SetActive(false);
        ((self.ui).obj_isEquip):SetActive(false)
    end
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R2 in 'UnsetPending'

    if bool or not self.color then
        ((self.ui).img_SkillLineColor).color = Color.white
    end
end

UINCSTListItem.RefreshTreeActiveSkill = function(self)
    -- function num : 0_5 , upvalues : _ENV
    for index, image in ipairs((self.ui).array_skillImg) do
        do
            local skillId = ((self.treeData).slotSkillList)[index]
            local skillData = ((self.treeData).commanderSkillDataDic)[skillId]
            if skillData == nil then
                (image.gameObject):SetActive(false)
            else

                (image.gameObject):SetActive(true);
                (self.resloader):LoadABAssetAsync(
                    PathConsts:GetAtlasAssetPath("CommanderSkillIcons"),
                    function(spriteAtlas)
                        -- function num : 0_5_0 , upvalues : image, skillData
                        if spriteAtlas == nil then return end
                        image.sprite =
                            spriteAtlas:GetSprite(skillData:GetIcon())
                    end)
            end
        end
    end
end

UINCSTListItem.SetSelected = function(self)
    -- function num : 0_6
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

    ((self.ui).tog_skillTreeItem).isOn = true
end

UINCSTListItem.SetColor = function(self)
    -- function num : 0_7
    self.color = (self.treeData):GetColor() -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).img_UnSelect).color = self.color -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).img_LineColor).color = self.color -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).img_SkillLineColor).color = self.color
end

UINCSTListItem.SetIcon = function(self)
    -- function num : 0_8 , upvalues : _ENV
    (self.resloader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath(
                                          "CommanderSkillIcons"),
                                      function(spriteAtlas)
        -- function num : 0_8_0 , upvalues : self
        if spriteAtlas == nil then return end -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'
        
        ((self.ui).img_Icon).sprite = spriteAtlas:GetSprite(
                                          (self.treeData):GetIcon())
    end)
end

UINCSTListItem.OnDelete = function(self)
    -- function num : 0_9 , upvalues : _ENV, base
    MsgCenter:RemoveListener(eMsgEventId.OnCommanderSkillOverLoad,
                             self.__RefreshTreeActiveSkill);
    (base.OnDelete)(self)
end

return UINCSTListItem

