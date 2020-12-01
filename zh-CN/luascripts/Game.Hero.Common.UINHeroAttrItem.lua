-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroAttrItem = class("UINHeroAttrItem", UIBaseNode)
UINHeroAttrItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  (self.ui).tex_attrValue = self:FindComponent("Tex_AttriCount", eUnityComponentID.ExText)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).texItem_attr = self:FindComponent("Tex_AttriName", eUnityComponentID.ExText)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).imgItem_attr = self:FindComponent("Img_Icon", eUnityComponentID.Image)
end

UINHeroAttrItem.InitAttr = function(self, attrId, value)
  -- function num : 0_1 , upvalues : _ENV
  local attrCfg = (ConfigData.attribute)[attrId]
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  if (self.ui).imgItem_attr ~= nil and not IsNull(attrCfg.icon) then
    ((self.ui).imgItem_attr).sprite = CRH:GetSprite(attrCfg.icon)
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).texItem_attr).text = (LanguageUtil.GetLocaleText)(attrCfg.name)
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_attrValue).text = tostring(value)
end

return UINHeroAttrItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroAttrItem = class("UINHeroAttrItem", UIBaseNode)
UINHeroAttrItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

    (self.ui).tex_attrValue = self:FindComponent("Tex_AttriCount",
                                                 eUnityComponentID.ExText) -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'
    ;
    (self.ui).texItem_attr = self:FindComponent("Tex_AttriName",
                                                eUnityComponentID.ExText) -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'
    ;
    (self.ui).imgItem_attr = self:FindComponent("Img_Icon",
                                                eUnityComponentID.Image)
end

UINHeroAttrItem.InitAttr = function(self, attrId, value)
    -- function num : 0_1 , upvalues : _ENV
    local attrCfg = (ConfigData.attribute)[attrId]
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

    if (self.ui).imgItem_attr ~= nil and not IsNull(attrCfg.icon) then
        ((self.ui).imgItem_attr).sprite = CRH:GetSprite(attrCfg.icon)
    end -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'
    
    ((self.ui).texItem_attr).text = (LanguageUtil.GetLocaleText)(attrCfg.name) -- DECOMPILER ERROR at PC31: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).tex_attrValue).text = tostring(value)
end

return UINHeroAttrItem

