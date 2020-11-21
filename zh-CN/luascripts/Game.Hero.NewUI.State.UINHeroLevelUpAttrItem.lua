-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroLevelUpAttrItem = class("UINHeroLevelUpAttrItem", UIBaseNode)
local base = UIBaseNode
UINHeroLevelUpAttrItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINHeroLevelUpAttrItem.InitAttrItem = function(self, attrId)
    -- function num : 0_1 , upvalues : _ENV
    self.attrId = attrId;
    ((self.ui).img_Icon):SetIndex(attrId) -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).tex_attrName).text = (LanguageUtil.GetLocaleText)(
                                        ((ConfigData.attribute)[attrId]).name)
end

UINHeroLevelUpAttrItem.SetValue = function(self, lastValue, newValue)
    -- function num : 0_2 , upvalues : _ENV
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

    ((self.ui).tex_Num).text = tostring(lastValue)
    if newValue == nil then
        (((self.ui).tex_Add).gameObject):SetActive(false)
    else
        if newValue - lastValue < 1 then
            (((self.ui).tex_Add).gameObject):SetActive(false)
        else

            (((self.ui).tex_Add).gameObject):SetActive(true);
            ((self.ui).tex_Add):SetIndex(0, tostring(newValue - lastValue))
        end
    end
end

UINHeroLevelUpAttrItem.OnDelete = function(self)
    -- function num : 0_3 , upvalues : base
    (base.OnDelete)(self)
end

return UINHeroLevelUpAttrItem

