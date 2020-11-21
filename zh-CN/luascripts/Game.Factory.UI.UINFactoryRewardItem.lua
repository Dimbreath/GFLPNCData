-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFactoryRewardItem = class("UINFactoryRewardItem", UIBaseNode)
UINFactoryRewardItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_reward, self,
                               self.OnRewardItemClicked)
end

UINFactoryRewardItem.InitFactoryRewardItem =
    function(self, itemCfg, count, clickAction)
        -- function num : 0_1 , upvalues : _ENV
        self.itemId = itemCfg.id
        self.itemCfg = itemCfg
        self.count = count
        self.clickAction = clickAction -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((self.ui).img_Pic).sprite = CRH:GetSprite(itemCfg.icon) -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(itemCfg.name) -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((self.ui).tex_Count).text = tostring(count) -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'
        ;
        ((self.ui).img_Quality).color = ItemQualityColor[itemCfg.quality]
    end

UINFactoryRewardItem.OnRewardItemClicked =
    function(self)
        -- function num : 0_2
        if self.clickAction ~= nil then (self.clickAction)(self) end
    end

return UINFactoryRewardItem

