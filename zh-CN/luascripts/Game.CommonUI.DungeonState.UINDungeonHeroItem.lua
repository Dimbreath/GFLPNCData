-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDungeonHeroItem = class("UINDungeonHeroItem", UIBaseNode)
local base = UIBaseNode
local UINHeroHeadItem = require("Game.CommonUI.Hero.UINHeroHeadItem")
local heroHpPercent = 10000
UINDungeonHeroItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINHeroHeadItem, heroHpPercent
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.headItem = (UINHeroHeadItem.New)();
    (self.headItem):Init((self.ui).obj_heroHeadItem)
    self.chipList = {}
    self.targetHpPercent = heroHpPercent
    self.__OnHpTweenComplete = BindCallback(self, self.OnHpTweenComplete)
end

UINDungeonHeroItem.InitHeroItem = function(self, dynHeroData, resloader,
                                           clickCallback)
    -- function num : 0_1
    self.dynHeroData = dynHeroData
    local heroData = dynHeroData.heroData;
    (self.headItem):InitHeroHeadItem(heroData, resloader, clickCallback)
    self:RefreshHp(true)
    self:UpdateChipList()
end

UINDungeonHeroItem.RefreshHp = function(self, setMin)
    -- function num : 0_2 , upvalues : heroHpPercent
    local amount = (self.dynHeroData).hpPer / heroHpPercent -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).img_hP).fillAmount = amount
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

    if setMin then ((self.ui).img_hPMin).fillAmount = amount end
    if amount <= 0.3 then
        ((self.ui).obj_img_Wound):SetActive(true)
    else

        ((self.ui).obj_img_Wound):SetActive(false)
    end
end

UINDungeonHeroItem.PlayHpChangeAnim = function(self)
    -- function num : 0_3 , upvalues : heroHpPercent, _ENV
    local amount = (self.dynHeroData).hpPer / heroHpPercent
    if amount < ((self.ui).img_hP).fillAmount then
        self:KillHpChangeTween() -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).img_hP).fillAmount = amount
        local duration = (math.abs)(((self.ui).img_hPMin).fillAmount - amount) *
                             5
        self.HpTween =
            (((self.ui).img_hPMin):DOFillAmount(amount, duration)):OnComplete(
                self.__OnHpTweenComplete)
    else
        do
            if ((self.ui).img_hP).fillAmount < amount then
                self:KillHpChangeTween() -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'
                ;
                ((self.ui).img_hPMin).fillAmount = amount
                local duration = (math.abs)(
                                     ((self.ui).img_hP).fillAmount - amount) * 5
                self.HpTween =
                    (((self.ui).img_hP):DOFillAmount(amount, duration)):OnComplete(
                        self.__OnHpTweenComplete)
            end
            do
                if amount <= 0.3 then
                    ((self.ui).obj_img_Wound):SetActive(true)
                else

                    ((self.ui).obj_img_Wound):SetActive(false)
                end
            end
        end
    end
end

UINDungeonHeroItem.FakeDead = function(self)
    -- function num : 0_4
    local amount = 0 -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).img_hP).fillAmount = amount -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).img_hPMin).fillAmount = amount;
    ((self.ui).obj_img_Wound):SetActive(true)
end

UINDungeonHeroItem.OnHpTweenComplete = function(self)
    -- function num : 0_5
    self.HpTween = nil -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).img_hPMin).fillAmount = ((self.ui).img_hP).fillAmount
end

UINDungeonHeroItem.KillHpChangeTween = function(self)
    -- function num : 0_6
    if self.HpTween ~= nil then
        (self.HpTween):Kill()
        self.HpTween = nil
    end
end

UINDungeonHeroItem.SetHpBarActive = function(self, bool)
    -- function num : 0_7
    ((self.ui).obj_hpBar):SetActive(bool)
end

UINDungeonHeroItem.SetChipSelect = function(self, bool, chipColor)
    -- function num : 0_8
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

    if bool then
        ((self.ui).img_Adapter).color = chipColor;
        (((self.ui).img_Adapter).gameObject):SetActive(true)
    else

        (((self.ui).img_Adapter).gameObject):SetActive(false)
    end
end

UINDungeonHeroItem.SetSelect = function(self, bool)
    -- function num : 0_9
    if bool then
        ((self.ui).DoTween_heroItem):DOPlayForward();
        ((self.ui).obj_onSelect):SetActive(true)
    else

        ((self.ui).DoTween_heroItem):DOPlayBackwards();
        ((self.ui).obj_onSelect):SetActive(false)
    end
end

UINDungeonHeroItem.UpdateChipList = function(self)
    -- function num : 0_10 , upvalues : _ENV
    local chips = (self.dynHeroData):GetOwnedChips()
    for key, _ in pairs(chips) do (table.insert)(self.chipList, key.dataId) end
end

UINDungeonHeroItem.SetTransparent = function(self, bool)
    -- function num : 0_11
    (self.headItem):TransparentHeroHeadItem(bool)
end

UINDungeonHeroItem.OnDelete = function(self)
    -- function num : 0_12 , upvalues : base
    self:KillHpChangeTween();
    (base.OnDelete)(self)
end

return UINDungeonHeroItem

