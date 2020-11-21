-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDungeonInfoHeroDetailAttr = class("UINDungeonInfoHeroDetailAttr",
                                           UIBaseNode)
local base = UIBaseNode
UINDungeonInfoHeroDetailAttr.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINDungeonInfoHeroDetailAttr.InitAttr = function(self, attrId, attrVal,
                                                 attrOriginVal)
    -- function num : 0_1 , upvalues : _ENV
    local attrCfg = (ConfigData.attribute)[attrId]
    if attrCfg == nil then
        error("can\'t read attrCfg with ID:" .. attrId)
        return
    end -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'
    
    ((self.ui).tex_attrName).text = (LanguageUtil.GetLocaleText)(attrCfg.name) -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).img_Icon).sprite = CRH:GetSprite(attrCfg.icon)
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R5 in 'UnsetPending'

    if attrCfg.num_type == 2 then
        ((self.ui).tex_Num).text = tostring(attrVal / 10) .. "%"
    else
        -- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'


        ((self.ui).tex_Num).text = tostring(attrVal)
    end
    (((self.ui).tex_Add).gameObject):SetActive(false)
    if attrVal == attrOriginVal then
        (((self.ui).tex_Add).gameObject):SetActive(false)
    else
        if attrCfg.num_type == 2 then
            ((self.ui).tex_Add):SetIndex(1, tostring(
                                             (attrVal - attrOriginVal) / 10) ..
                                             "%")
        else

            ((self.ui).tex_Add):SetIndex(1, tostring(attrVal - attrOriginVal))
        end
        (((self.ui).tex_Add).gameObject):SetActive(true)
    end
end

UINDungeonInfoHeroDetailAttr.OnDelete = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnDelete)(self)
end

return UINDungeonInfoHeroDetailAttr

