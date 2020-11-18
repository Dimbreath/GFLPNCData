-- params : ...
-- function num : 0 , upvalues : _ENV
local UINSettingTypeItem = class("UINSettingTypeItem", UIBaseNode)
UINSettingTypeItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  (self.ui).img_Bg = (self.transform):FindComponent("Img_Buttom", eUnityComponentID.Image)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).img_Icon = (self.transform):FindComponent("Img_Icon", eUnityComponentID.Image)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.ui).tex_Name = (self.transform):FindComponent("Tex_Name", eUnityComponentID.ExText)
end

UINSettingTypeItem.SetSettingTypeItemActive = function(self, active, bind)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  if active then
    ((self.ui).img_Bg).color = bind.color_typeBG
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).color = Color.black
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).color = bind.color_typeNameActive
  else
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_Bg).color = (Color.New)(0, 0, 0, 0)
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).color = Color.white
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).color = bind.color_typeNameDeActive
  end
end

return UINSettingTypeItem

