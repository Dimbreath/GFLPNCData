-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSTDetail_OverloadItem = class("UINCSTDetail_OverloadItem", UIBaseNode)
local base = UIBaseNode
UINCSTDetail_OverloadItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddValueChangedListener)((self.ui).tog_skillDetailItem, self,
                                     self.OnTogChange)
end

UINCSTDetail_OverloadItem.InitOverladItem =
    function(self, skillData, resloader, treeData)
        -- function num : 0_1 , upvalues : _ENV
        self.treeData = treeData
        self.skillData = skillData
        local mp = skillData.mpCost
        resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath(
                                       "CommanderSkillIcons"),
                                   function(spriteAtlas)
            -- function num : 0_1_0 , upvalues : self, skillData
            if spriteAtlas == nil then return end -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'
            
            ((self.ui).img_Icon).sprite =
                spriteAtlas:GetSprite(skillData:GetIcon())
        end) -- DECOMPILER ERROR at PC14: Confused about usage of register: R5 in 'UnsetPending'
        ;
        ((self.ui).tex_SkillName).text = skillData:GetName() -- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'
        ;
        ((self.ui).tex_Content).text = skillData:GetDescribe();
        ((self.ui).tex_Consume):SetIndex(0, tostring(mp))
        self:SetIsUnlock(skillData.isUnlock, skillData.unlockLevel)
    end

UINCSTDetail_OverloadItem.SetIsUnlock = function(self, bool, unlockLevel)
    -- function num : 0_2 , upvalues : _ENV
    ((self.ui).obj_lock):SetActive(not bool) -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).tog_skillDetailItem).interactable = bool
    if not bool then
        ((self.ui).tex_Condition):SetIndex(0, tostring(unlockLevel))
    end
end

UINCSTDetail_OverloadItem.SetSelected = function(self, bool)
    -- function num : 0_3
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).tog_skillDetailItem).isOn = bool
end

UINCSTDetail_OverloadItem.OnTogChange = function(self, bool)
    -- function num : 0_4
    if bool then
        ((self.ui).obj_imgSelect):SetActive(true);
        (self.treeData):SetSlotSkillList((self.skillData).place,
                                         (self.skillData).dataId)
    else

        ((self.ui).obj_imgSelect):SetActive(false)
    end
end

UINCSTDetail_OverloadItem.OnDelete = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnDelete)(self)
end

return UINCSTDetail_OverloadItem

