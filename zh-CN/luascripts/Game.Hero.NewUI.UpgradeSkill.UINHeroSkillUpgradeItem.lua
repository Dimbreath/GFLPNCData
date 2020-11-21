-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroSkillUpgradeItem = class("UINHeroSkillUpgradeItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")
local HeroSkillUpgradeEnum = require(
                                 "Game.Hero.NewUI.UpgradeSkill.HeroSkillUpgradeEnum")
UINHeroSkillUpgradeItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINBaseSkillItem
    self.isInited = false
    self.couldUpgrade = false;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.skillItem = (UINBaseSkillItem.New)();
    (self.skillItem):Init((self.ui).obj_uINSkillItem)
    self.StarList = {};
    (table.insert)(self.StarList, (self.ui).img_star);
    (UIUtil.AddButtonListener)((self.ui).btn_CanLevelUp, self, self.OnClilck);
    (UIUtil.AddButtonListener)((self.ui).btn_skillUpgradeItem, self,
                               self.OnClilck)
end

UINHeroSkillUpgradeItem.InitSkillItem = function(self, skillData, resloader,
                                                 type, OpenInfoNodeCallback)
    -- function num : 0_1
    self.isInited = true
    self.couldUpgrade = false
    self.skillData = skillData
    self.resloader = resloader
    self.type = type
    self.OpenInfoNodeCallback = OpenInfoNodeCallback
    if skillData == nil then
        ((self.ui).obj_base):SetActive(false);
        ((self.ui).obj_notGet):SetActive(true)
        return
    else

        ((self.ui).obj_base):SetActive(true);
        ((self.ui).obj_notGet):SetActive(false)
    end
    if skillData:GetIsUnlock() then
        ((self.ui).obj_lock):SetActive(false)
        self:UpgradeUnlockSillInfo()
    else

        ((self.ui).obj_lock):SetActive(true)
        self:UpgradeLockedSillInfo()
    end
end

UINHeroSkillUpgradeItem.UpgradeUnlockSillInfo =
    function(self)
        -- function num : 0_2 , upvalues : _ENV, HeroSkillUpgradeEnum
        -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

        ((self.ui).tex_Name).color = (self.ui).color_normal -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'
        ;
        ((self.ui).tex_Descr).color = (self.ui).color_normal -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'
        ;
        ((self.ui).tex_Name).text = (self.skillData):GetName()
        -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

        if (self.skillData).level <= 0 then
            ((self.ui).tex_Descr).text =
                (self.skillData):GetColorLevelDescribe(1, "ff8400")
        else
            -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'


            ((self.ui).tex_Descr).text =
                (self.skillData):GetColorLevelDescribe((self.skillData).level,
                                                       "ff8400")
        end
        local isFullLevel = (self.skillData):IsFullLevel()
        if isFullLevel then
            ((self.ui).tex_Lv):SetIndex(1)
        else

            ((self.ui).tex_Lv):SetIndex(0, tostring((self.skillData).level))
        end
        (self.skillItem):InitBaseSkillItem(self.skillData, self.resloader)
        -- DECOMPILER ERROR at PC76: Confused about usage of register: R2 in 'UnsetPending'

        if self.type == nil or self.type ==
            (HeroSkillUpgradeEnum.SkillType).undefined then
            ((self.ui).img_type).color = ((self.ui).color_typeArry)[4];
            ((self.ui).tex_Type):SetIndex(4);
            ((self.ui).tex_Tppe_En):SetIndex(4)
        else
            -- DECOMPILER ERROR at PC95: Confused about usage of register: R2 in 'UnsetPending'


            ((self.ui).img_type).color =
                ((self.ui).color_typeArry)[self.type + 1];
            ((self.ui).tex_Type):SetIndex(self.type);
            ((self.ui).tex_Tppe_En):SetIndex(self.type)
        end
        if not isFullLevel and (self.skillData):GetIsUnlock() then
            self.couldUpgrade = true;
            (((self.ui).btn_CanLevelUp).gameObject):SetActive(true)
        else
            self.couldUpgrade = false;
            (((self.ui).btn_CanLevelUp).gameObject):SetActive(false)
        end
        if (self.skillData):CanUpgrade() then
            ((self.ui).obj_blueDot):SetActive(true)
        else

            ((self.ui).obj_blueDot):SetActive(false)
        end
    end

UINHeroSkillUpgradeItem.UpgradeLockedSillInfo =
    function(self)
        -- function num : 0_3
        self:UpgradeUnlockSillInfo() -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'
        ;
        ((self.ui).tex_Name).color = (self.ui).color_locked -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'
        ;
        ((self.ui).tex_Descr).color = (self.ui).color_locked
        local rare, star = (self.skillData):GetOpenStar()
        self:InitStarList(star)
    end

UINHeroSkillUpgradeItem.InitStarList = function(self, starNum)
    -- function num : 0_4 , upvalues : _ENV
    for _, starGo in ipairs(self.StarList) do
        (starGo.gameObject):SetActive(false)
    end
    local count = (math.ceil)(starNum / 2)
    local isHalf = starNum % 2 == 1
    for i = 1, count do
        if (self.StarList)[i] ~= nil then
            (((self.StarList)[i]).gameObject):SetActive(true);
            ((self.StarList)[i]):SetIndex(0)
        else
            local imgItemInfo =
                (((self.ui).img_star):Instantiate()):GetComponent(
                    typeof(CS.UiImageItemInfo));
            (table.insert)(self.StarList, imgItemInfo);
            (imgItemInfo.gameObject):SetActive(true)
        end
    end
    if isHalf then ((self.StarList)[count]):SetIndex(1) end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

UINHeroSkillUpgradeItem.OnClilck = function(self)
    -- function num : 0_5 , upvalues : cs_MessageCommon, _ENV
    if self.skillData == nil then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.hero_Skill_notOpenYet))
        return
    end
    if (self.skillData):IsFullLevel() then return end
    if not (self.skillData):GetIsUnlock() then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.hero_Skill_unLockWhernReachStar))
        return
    end
    if self.OpenInfoNodeCallback ~= nil then
        (self.OpenInfoNodeCallback)(self.skillData)
    end
end

UINHeroSkillUpgradeItem.OnDelete = function(self)
    -- function num : 0_6 , upvalues : base
    (base.OnDelete)(self)
end

return UINHeroSkillUpgradeItem

