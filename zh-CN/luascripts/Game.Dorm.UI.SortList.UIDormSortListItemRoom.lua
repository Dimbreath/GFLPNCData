-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormSortListItemRoom = class("UIDormSortListItemRoom", UIBaseNode)
local base = UIBaseNode
UIDormSortListItemRoom.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ItemDetail, self, self.OnClickIcon)
end

UIDormSortListItemRoom.InitSortListItemRoom = function(self, data, isShop, clickIconEvent)
  -- function num : 0_1 , upvalues : _ENV
  self.data = data
  self.clickIconEvent = clickIconEvent
  ;
  ((self.ui).priceNode):SetActive(isShop)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

  if isShop then
    ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((data.itemCfg).name)
    ;
    ((self.ui).tex_Num):SetIndex(0, tostring(data.itemNum))
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_Quality).color = ItemQualityColor[(data.itemCfg).quality]
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).img_ItemPic).sprite = CRH:GetSprite((data.itemCfg).icon)
    local isDiscount = data.discount ~= 100
    ;
    (((self.ui).tex_oldPrice).gameObject):SetActive(isDiscount)
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R5 in 'UnsetPending'

    if isDiscount then
      ((self.ui).tex_oldPrice).text = tostring(data.originPrice)
    end
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).tex_currPrice).text = tostring(data.discountPrice)
    -- DECOMPILER ERROR at PC71: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).img_CurrencyIcon).sprite = CRH:GetSprite(data.payItemIcon)
    ;
    ((self.ui).sellOutNode):SetActive(data.isSellOut)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UIDormSortListItemRoom.OnClickIcon = function(self)
  -- function num : 0_2
  if self.clickIconEvent ~= nil then
    (self.clickIconEvent)(self.data)
  end
end

UIDormSortListItemRoom.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UIDormSortListItemRoom

