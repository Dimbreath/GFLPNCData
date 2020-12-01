-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormSortListItemFnt = class("UIDormSortListItemFnt", UIBaseNode)
local base = UIBaseNode
UIDormSortListItemFnt.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ItemDetail, self, self.OnClickIcon)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_PutinNode, self, self.OnClickInstall)
end

UIDormSortListItemFnt.InitSortListItemFnt = function(self, data, isShop, clickIconEvent, installEvent)
  -- function num : 0_1 , upvalues : _ENV
  self.data = data
  self.clickIconEvent = clickIconEvent
  self.installEvent = installEvent
  ;
  ((self.ui).priceNode):SetActive(isShop)
  ;
  ((self.ui).putinNode):SetActive(not isShop)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

  if isShop then
    ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((data.itemCfg).name)
    ;
    ((self.ui).tex_Num):SetIndex(0, tostring(data.itemNum))
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).img_Quality).color = ItemQualityColor[(data.itemCfg).quality]
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self.ui).img_ItemPic).sprite = CRH:GetSprite((data.itemCfg).icon)
    local isDiscount = data.discount ~= 100
    ;
    (((self.ui).tex_oldPrice).gameObject):SetActive(isDiscount)
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R6 in 'UnsetPending'

    if isDiscount then
      ((self.ui).tex_oldPrice).text = tostring(data.originPrice)
    end
    -- DECOMPILER ERROR at PC70: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_currPrice).text = tostring(data.discountPrice)
    -- DECOMPILER ERROR at PC77: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).img_CurrencyIcon).sprite = CRH:GetSprite(data.payItemIcon)
    ;
    ((self.ui).sellOutNode):SetActive(data.isSellOut)
    local fntCfg = (ConfigData.dorm_furniture)[(data.itemCfg).id]
    local fntType = 0
    if fntCfg ~= nil then
      fntType = fntCfg.type
    end
    ;
    ((self.ui).tex_Type):SetIndex(fntType)
  else
    -- DECOMPILER ERROR at PC105: Confused about usage of register: R5 in 'UnsetPending'

    ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)((data.fntCfg).name)
    ;
    ((self.ui).tex_Num):SetIndex(0, tostring(data.count))
    ;
    ((self.ui).tex_Type):SetIndex((data.fntCfg).type)
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UIDormSortListItemFnt.OnClickIcon = function(self)
  -- function num : 0_2
  if self.clickIconEvent ~= nil then
    (self.clickIconEvent)(self.data)
  end
end

UIDormSortListItemFnt.OnClickInstall = function(self)
  -- function num : 0_3
  if self.installEvent ~= nil then
    (self.installEvent)(self.data)
  end
end

UIDormSortListItemFnt.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UIDormSortListItemFnt

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIDormSortListItemFnt = class("UIDormSortListItemFnt", UIBaseNode)
local base = UIBaseNode
UIDormSortListItemFnt.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_ItemDetail, self, self.OnClickIcon);
    (UIUtil.AddButtonListener)((self.ui).btn_PutinNode, self,
                               self.OnClickInstall)
end

UIDormSortListItemFnt.InitSortListItemFnt =
    function(self, data, isShop, clickIconEvent, installEvent)
        -- function num : 0_1 , upvalues : _ENV
        self.data = data
        self.clickIconEvent = clickIconEvent
        self.installEvent = installEvent;
        ((self.ui).priceNode):SetActive(isShop);
        ((self.ui).putinNode):SetActive(not isShop)
        -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

        if isShop then
            ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(
                                            (data.itemCfg).name);
            ((self.ui).tex_Num):SetIndex(0, tostring(data.itemNum)) -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'
            ;
            ((self.ui).img_Quality).color =
                ItemQualityColor[(data.itemCfg).quality] -- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'
            ;
            ((self.ui).img_ItemPic).sprite = CRH:GetSprite((data.itemCfg).icon)
            local isDiscount = data.discount ~= 100;
            (((self.ui).tex_oldPrice).gameObject):SetActive(isDiscount)
            -- DECOMPILER ERROR at PC64: Confused about usage of register: R6 in 'UnsetPending'

            if isDiscount then
                ((self.ui).tex_oldPrice).text = tostring(data.originPrice)
            end -- DECOMPILER ERROR at PC70: Confused about usage of register: R6 in 'UnsetPending'
            
            ((self.ui).tex_currPrice).text = tostring(data.discountPrice) -- DECOMPILER ERROR at PC77: Confused about usage of register: R6 in 'UnsetPending'
            ;
            ((self.ui).img_CurrencyIcon).sprite =
                CRH:GetSprite(data.payItemIcon);
            ((self.ui).sellOutNode):SetActive(data.isSellOut)
            local fntCfg = (ConfigData.dorm_furniture)[(data.itemCfg).id]
            local fntType = 0
            if fntCfg ~= nil then fntType = fntCfg.type end
            ((self.ui).tex_Type):SetIndex(fntType)
        else
            -- DECOMPILER ERROR at PC105: Confused about usage of register: R5 in 'UnsetPending'

            ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(
                                            (data.fntCfg).name);
            ((self.ui).tex_Num):SetIndex(0, tostring(data.count));
            ((self.ui).tex_Type):SetIndex((data.fntCfg).type)
        end
        -- DECOMPILER ERROR: 5 unprocessed JMP targets
    end

UIDormSortListItemFnt.OnClickIcon = function(self)
    -- function num : 0_2
    if self.clickIconEvent ~= nil then (self.clickIconEvent)(self.data) end
end

UIDormSortListItemFnt.OnClickInstall = function(self)
    -- function num : 0_3
    if self.installEvent ~= nil then (self.installEvent)(self.data) end
end

UIDormSortListItemFnt.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnDelete)(self)
end

return UIDormSortListItemFnt

