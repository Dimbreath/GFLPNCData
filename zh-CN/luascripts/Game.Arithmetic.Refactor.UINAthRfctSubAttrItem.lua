-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthRfctSubAttrItem = class("UINAthRfctSubAttrItem", UIBaseNode)
local base = UIBaseNode
UINAthRfctSubAttrItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Lock, self, self._OnClickLock)
end

UINAthRfctSubAttrItem.InitAthDetailAttr = function(self, index, attrId, attrValue, color, lock, lockFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.index = index
  self.lockFunc = lockFunc
  local name, valueStr, icon = ConfigData:GetAttribute(attrId, attrValue)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R10 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(icon)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R10 in 'UnsetPending'

  ;
  ((self.ui).tex_AttriNum).text = "+" .. valueStr
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R10 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).text = name
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R10 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).color = color
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R10 in 'UnsetPending'

  ;
  ((self.ui).tex_AttriNum).color = color
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R10 in 'UnsetPending'

  ;
  ((self.ui).tex_Name).color = color
  self:SetAthRfctSubAttrLock(lock)
end

UINAthRfctSubAttrItem.SetAthRfctSubAttrLock = function(self, lock)
  -- function num : 0_2
  ;
  ((self.ui).img_Lock):SetIndex(lock and 0 or 1)
end

UINAthRfctSubAttrItem._OnClickLock = function(self)
  -- function num : 0_3
  if self.lockFunc ~= nil then
    (self.lockFunc)(self.index)
  end
end

UINAthRfctSubAttrItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthRfctSubAttrItem

