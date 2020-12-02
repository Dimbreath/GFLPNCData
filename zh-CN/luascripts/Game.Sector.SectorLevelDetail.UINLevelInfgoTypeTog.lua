-- params : ...
-- function num : 0 , upvalues : _ENV
local UINLevelInfgoTypeTog = class("UINLevelInfgoTypeTog", UIBaseNode)
local base = UIBaseNode
UINLevelInfgoTypeTog.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddValueChangedListener)((self.ui).tog_Type, self, self.OnValueChage)
end

UINLevelInfgoTypeTog.InitTog = function(self, infoNodeTypeId, isLast, openNodeCallback)
  -- function num : 0_1
  self.infoNodeTypeId = infoNodeTypeId
  ;
  ((self.ui).texInfo_Name):SetIndex(infoNodeTypeId)
  ;
  ((self.ui).obj_img_Line):SetActive(not isLast)
  self.openNodeCallback = openNodeCallback
end

UINLevelInfgoTypeTog.OnValueChage = function(self, bool)
  -- function num : 0_2
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if bool then
    ((self.ui).img_tog_Type).color = (self.ui).color_white
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).color = (self.ui).color_black
    if self.openNodeCallback ~= nil then
      (self.openNodeCallback)()
    end
  else
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).img_tog_Type).color = (self.ui).color_black
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).color = (self.ui).color_white
  end
  if self.colorCallback ~= nil then
    (self.colorCallback)(((self.ui).img_tog_Type).color)
  end
end

UINLevelInfgoTypeTog.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINLevelInfgoTypeTog

