local UINDmRoomFntListItem = class("UINDmRoomFntListItem", UIBaseNode)
local base = UIBaseNode
UINDmRoomFntListItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self._OnClickRoot)
end

UINDmRoomFntListItem.InitDmRoomFntListItem = function(self, fntWarehouseData, clickFunc)
  -- function num : 0_1 , upvalues : _ENV
  self.fntWarehouseData = fntWarehouseData
  self.clickFunc = clickFunc
  ;
  ((self.ui).comfortLv):SetActive(not fntWarehouseData.isDefaultDmFnt)
  ;
  ((self.ui).num):SetActive(not fntWarehouseData.isDefaultDmFnt)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

  if fntWarehouseData.isDefaultDmFnt then
    ((self.ui).tex_Name).text = fntWarehouseData.name
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = CRH:GetSprite(fntWarehouseData.icon)
  else
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Comfort).text = tostring((fntWarehouseData.fntCfg).comfort)
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((fntWarehouseData.itemCfg).name)
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = CRH:GetSprite((fntWarehouseData.itemCfg).icon)
  end
  self:UpdDmRoomFntListItem()
end

UINDmRoomFntListItem.UpdDmRoomFntListItem = function(self)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  if (self.fntWarehouseData).isDefaultDmFnt then
    ((self.ui).buttom).color = Color.white
    return 
  end
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).tex_Num).text = tostring((self.fntWarehouseData).count)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  if (self.fntWarehouseData).count <= 0 or not Color.white then
    ((self.ui).buttom).color = Color.gray
  end
end

UINDmRoomFntListItem._OnClickRoot = function(self)
  -- function num : 0_3
  if self.clickFunc ~= nil then
    (self.clickFunc)(self.fntWarehouseData, self)
  end
end

UINDmRoomFntListItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINDmRoomFntListItem

