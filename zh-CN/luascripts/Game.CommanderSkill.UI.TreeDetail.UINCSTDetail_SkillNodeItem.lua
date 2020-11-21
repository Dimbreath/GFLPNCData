-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSTDetail_SkillNodeItem = class("UINCSTDetail_SkillNodeItem",
                                         UIBaseNode)
local base = UIBaseNode
local CommanderSkillData = require("Game.CommanderSkill.CommanderSkillData")
UINCSTDetail_SkillNodeItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.skillData = nil;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (((self.ui).btn_skillItem).onPress):AddListener(
        BindCallback(self, self.__OnSkillLongPress));
    (((self.ui).btn_skillItem).onPressUp):AddListener(
        BindCallback(self, self.__OnSkillPressUp))
end

UINCSTDetail_SkillNodeItem.InitItem = function(self, skillData, resloader)
    -- function num : 0_1 , upvalues : _ENV, CommanderSkillData
    self.skillData = skillData -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).tex_unlockLevel).text = tostring(skillData.unlockLevel)
    resloader:LoadABAssetAsync(PathConsts:GetAtlasAssetPath(
                                   "CommanderSkillIcons"), function(spriteAtlas)
        -- function num : 0_1_0 , upvalues : self, skillData
        if spriteAtlas == nil then return end -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'
        
        ((self.ui).img_SkillIcon).sprite =
            spriteAtlas:GetSprite(skillData:GetIcon())
    end)
    if skillData.type == (CommanderSkillData.skillType).active then
        ((self.ui).type_text):SetIndex(0)
    else

        ((self.ui).type_text):SetIndex(1)
    end
    if skillData.isUnlock then
        ((self.ui).obj_img_Lock):SetActive(false) -- DECOMPILER ERROR at PC42: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).img_skillItem).color = (self.ui).color_unlocked -- DECOMPILER ERROR at PC47: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).tex_unlockLevel).color = Color.white -- DECOMPILER ERROR at PC52: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).img_SkillIcon).color = Color.white
        if skillData.isNewUnlock then
            ((self.ui).obj_img_isNew):SetActive(true)
            skillData.isNewUnlock = false
        else

            ((self.ui).obj_img_isNew):SetActive(false)
        end
    else

        ((self.ui).obj_img_Lock):SetActive(true) -- DECOMPILER ERROR at PC78: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).img_skillItem).color = (self.ui).color_locked -- DECOMPILER ERROR at PC83: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).tex_unlockLevel).color = Color.black -- DECOMPILER ERROR at PC88: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).img_SkillIcon).color = (self.ui).color_unlockedIcon;
        ((self.ui).obj_img_isNew):SetActive(false)
    end
end

UINCSTDetail_SkillNodeItem.SetFloatCallback =
    function(self, ShowSkillDescription, HideBuffDetail)
        -- function num : 0_2
        self.showDesCallback = ShowSkillDescription
        self.hideDesCallback = HideBuffDetail
    end

UINCSTDetail_SkillNodeItem.__OnSkillLongPress =
    function(self)
        -- function num : 0_3
        if self.showDesCallback ~= nil then
            (self.showDesCallback)(self, self.skillData)
        end
    end

UINCSTDetail_SkillNodeItem.__OnSkillPressUp =
    function(self)
        -- function num : 0_4
        if self.hideDesCallback ~= nil then (self.hideDesCallback)() end
    end

UINCSTDetail_SkillNodeItem.OnDelete = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnDelete)(self)
end

return UINCSTDetail_SkillNodeItem

