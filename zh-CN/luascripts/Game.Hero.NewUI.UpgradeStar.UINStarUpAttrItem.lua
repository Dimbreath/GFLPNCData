-- params : ...
-- function num : 0 , upvalues : _ENV
local UINStarUpAttrItem = class("UINStarUpAttrItem", UIBaseNode)
local base = UIBaseNode
UINStarUpAttrItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINStarUpAttrItem.InitAttrItem = function(self, value, newValue, attrId)
  -- function num : 0_1 , upvalues : _ENV
  local attrCfg = (ConfigData.attribute)[attrId]
  if attrCfg == nil then
    error("can\'t read attrCfg with id=" .. attrId)
    return 
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).tex_attrName).text = (LanguageUtil.GetLocaleText)(attrCfg.name)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(attrCfg.icon)
  if attrCfg.num_type == 1 then
    if newValue ~= nil then
      ((self.ui).tex_Num):SetIndex(0, tostring(value), tostring(newValue))
    else
      ;
      ((self.ui).tex_Num):SetIndex(1, tostring(value))
    end
  else
    if attrCfg.num_type == 2 then
      if newValue ~= nil then
        ((self.ui).tex_Num):SetIndex(0, tostring(FormatNum(value / 10)) .. "%", tostring(FormatNum(newValue / 10)) .. "%")
      else
        ;
        ((self.ui).tex_Num):SetIndex(1, tostring(FormatNum(value / 10)) .. "%")
      end
    end
  end
end

UINStarUpAttrItem.OnDelete = function(self)
  -- function num : 0_2 , upvalues : base
  (base.OnDelete)(self)
end

return UINStarUpAttrItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINStarUpAttrItem = class("UINStarUpAttrItem", UIBaseNode)
local base = UIBaseNode
UINStarUpAttrItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINStarUpAttrItem.InitAttrItem = function(self, value, newValue, attrId)
    -- function num : 0_1 , upvalues : _ENV
    local attrCfg = (ConfigData.attribute)[attrId]
    if attrCfg == nil then
        error("can\'t read attrCfg with id=" .. attrId)
        return
    end -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'
    
    ((self.ui).tex_attrName).text = (LanguageUtil.GetLocaleText)(attrCfg.name) -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).img_Icon).sprite = CRH:GetSprite(attrCfg.icon)
    if attrCfg.num_type == 1 then
        if newValue ~= nil then
            ((self.ui).tex_Num):SetIndex(0, tostring(value), tostring(newValue))
        else

            ((self.ui).tex_Num):SetIndex(1, tostring(value))
        end
    else
        if attrCfg.num_type == 2 then
            if newValue ~= nil then
                ((self.ui).tex_Num):SetIndex(0,
                                             tostring(FormatNum(value / 10)) ..
                                                 "%", tostring(
                                                 FormatNum(newValue / 10)) ..
                                                 "%")
            else

                ((self.ui).tex_Num):SetIndex(1,
                                             tostring(FormatNum(value / 10)) ..
                                                 "%")
            end
        end
    end
end

UINStarUpAttrItem.OnDelete = function(self)
    -- function num : 0_2 , upvalues : base
    (base.OnDelete)(self)
end

return UINStarUpAttrItem

