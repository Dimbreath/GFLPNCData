-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthAttrItem = class("UINAthAttrItem", UIBaseNode)
local base = UIBaseNode
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")
UINAthAttrItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINAthAttrItem.InitAthAttrItem = function(self, attrId, count, efficiency)
  -- function num : 0_1 , upvalues : _ENV
  local name = ConfigData:GetAttribute(attrId)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (((self.ui).tex_AttriName).text).text = name
  local _, value1 = ConfigData:GetAttribute(attrId, count)
  if efficiency == nil then
    ((self.ui).tex_AttriCount):SetIndex(0, value1)
  else
    local effValue = count * (efficiency / 1000)
    effValue = (math.floor)(effValue)
    local _, value2 = ConfigData:GetAttribute(attrId, effValue)
    ;
    ((self.ui).tex_AttriCount):SetIndex(1, value1, value2)
  end
end

UINAthAttrItem.SetAttrColor = function(self, quality)
  -- function num : 0_2 , upvalues : ArthmeticEnum
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).affix_image).color = (ArthmeticEnum.AthQualityColor)[quality]
end

UINAthAttrItem.SetAttrPara = function(self, affix_para, affix_quality)
  -- function num : 0_3
  self.affix_para = affix_para
  self.quality = affix_quality
end

UINAthAttrItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthAttrItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthAttrItem = class("UINAthAttrItem", UIBaseNode)
local base = UIBaseNode
local ArthmeticEnum = require("Game.Arithmetic.ArthmeticEnum")
UINAthAttrItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINAthAttrItem.InitAthAttrItem = function(self, attrId, count, efficiency)
    -- function num : 0_1 , upvalues : _ENV
    local name = ConfigData:GetAttribute(attrId) -- DECOMPILER ERROR at PC7: Confused about usage of register: R5 in 'UnsetPending'
    ;
    (((self.ui).tex_AttriName).text).text = name
    local _, value1 = ConfigData:GetAttribute(attrId, count)
    if efficiency == nil then
        ((self.ui).tex_AttriCount):SetIndex(0, value1)
    else
        local effValue = count * (efficiency / 1000)
        effValue = (math.floor)(effValue)
        local _, value2 = ConfigData:GetAttribute(attrId, effValue);
        ((self.ui).tex_AttriCount):SetIndex(1, value1, value2)
    end
end

UINAthAttrItem.SetAttrColor = function(self, quality)
    -- function num : 0_2 , upvalues : ArthmeticEnum
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).affix_image).color = (ArthmeticEnum.AthQualityColor)[quality]
end

UINAthAttrItem.SetAttrPara = function(self, affix_para, affix_quality)
    -- function num : 0_3
    self.affix_para = affix_para
    self.quality = affix_quality
end

UINAthAttrItem.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnDelete)(self)
end

return UINAthAttrItem

