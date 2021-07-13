-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthDetailAttr = class("UINAthDetailAttr", UIBaseNode)
local base = UIBaseNode
UINAthDetailAttr.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.__showAttrPopDetail = BindCallback(self, self.__showAttrWin)
  ;
  (((self.ui).button).onPressDown):AddListener(self.__showAttrPopDetail)
  self.__hideAttrPopDetail = BindCallback(self, self.__hideAttrWin)
  ;
  (((self.ui).button).onPressUp):AddListener(self.__hideAttrPopDetail)
end

UINAthDetailAttr.InjectPressPopFunc = function(self, pressDownFunc, pressUpFunc)
  -- function num : 0_1
  self.__pressDownFunc = pressDownFunc
  self.__pressUpFunc = pressUpFunc
end

UINAthDetailAttr.__showAttrWin = function(self)
  -- function num : 0_2
  if self.__pressDownFunc ~= nil then
    (self.__pressDownFunc)(self.attrId, self.iconSprite, self.transform)
  end
end

UINAthDetailAttr.__hideAttrWin = function(self)
  -- function num : 0_3
  if self.__pressUpFunc ~= nil then
    (self.__pressUpFunc)()
  end
end

UINAthDetailAttr.InitAthDetailAttr = function(self, attrId, attrValue, color)
  -- function num : 0_4 , upvalues : _ENV
  self.attrId = attrId
  local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
  self.iconSprite = CRH:GetSprite(icon)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = self.iconSprite
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_AttriNum).text = "+" .. valueStr
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = name
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).color = color
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_AttriNum).color = color
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R7 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).color = color
end

UINAthDetailAttr.OnDelete = function(self)
  -- function num : 0_5 , upvalues : base
  if self.__showAttrPopDetail ~= nil then
    (((self.ui).button).onPressDown):RemoveListener(self.__showAttrPopDetail)
  end
  if self.__hideAttrPopDetail ~= nil then
    (((self.ui).button).onPressUp):RemoveListener(self.__hideAttrPopDetail)
  end
  ;
  (base.OnDelete)(self)
end

return UINAthDetailAttr

