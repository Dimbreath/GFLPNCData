local UINAthListSortKindItem = class("UINAthListSortKindItem", UIBaseNode)
local base = UIBaseNode
local AthSortEnum = require("Game.Arithmetic.AthList.Sort.AthSortEnum")
UINAthListSortKindItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Root, self, self._OnClickToggleRoot)
end

UINAthListSortKindItem.InitAthListSortKindItem = function(self, kindType, kindValue, selectFunc)
  -- function num : 0_1 , upvalues : AthSortEnum, _ENV
  self.kindType = kindType
  self.kindValue = kindValue
  self.selectFunc = selectFunc
  if kindType == (AthSortEnum.eKindType).GetOrder then
    ((self.ui).tex_KindName):SetIndex(0)
  else
    if kindType == (AthSortEnum.eKindType).Quality then
      ((self.ui).tex_KindName):SetIndex(1)
    else
      if kindType == (AthSortEnum.eKindType).Attribute then
        local attrId = ((ConfigData.game_config).athSortAttrList)[kindValue]
        local name = ConfigData:GetAttribute(attrId, 0)
        -- DECOMPILER ERROR at PC39: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (((self.ui).tex_KindName).text).text = name
      end
    end
  end
end

UINAthListSortKindItem.SetAthListSortKindItemTogOn = function(self)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tog_Root).isOn = true
end

UINAthListSortKindItem._OnClickToggleRoot = function(self, isOn)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  if isOn then
    (((self.ui).tex_KindName).text).color = Color.black
    if self.selectFunc ~= nil then
      (self.selectFunc)(self.kindType, self.kindValue, (((self.ui).tex_KindName).text).text)
    end
  else
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((self.ui).tex_KindName).text).color = Color.white
  end
end

UINAthListSortKindItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthListSortKindItem

