-- params : ...
-- function num : 0 , upvalues : _ENV
local UINResourceItem = class("UINResourceItem", UIBaseNode)
local base = UIBaseNode
local JumpManager = require("Game.Jump.JumpManager")
UINResourceItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Add, self, self.OnClickAdd)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_resourceItem, self, self.OnClickItem)
  self.shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
end

UINResourceItem.InitCurrencyItem = function(self, itemCfg)
  -- function num : 0_1 , upvalues : _ENV
  self.itemCfg = itemCfg
  if ItemIdOfKey == (self.itemCfg).id then
    (((self.ui).img_Icon).gameObject):SetActive(false)
    ;
    (((self.ui).obj_key_Icon).gameObject):SetActive(true)
    local quickPurchaseWin = UIManager:GetWindow(UIWindowTypeID.QuickBuy)
    if (quickPurchaseWin == nil or quickPurchaseWin.active == false) and (self.shopCtrl).isUnlocked then
      (((self.ui).btn_Add).gameObject):SetActive(true)
    end
  else
    do
      -- DECOMPILER ERROR at PC45: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).img_Icon).sprite = CRH:GetSprite(itemCfg.small_icon)
      ;
      (((self.ui).btn_Add).gameObject):SetActive(false)
      self:UpdateCount()
    end
  end
end

UINResourceItem.UpdateCount = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if ItemIdOfKey == (self.itemCfg).id then
    if self._UpdateCount == nil then
      self._UpdateCount = BindCallback(self, self.UpdateCount)
      MsgCenter:AddListener(eMsgEventId.StaminaUpdate, self._UpdateCount)
    end
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).tex_Count).text = tostring((PlayerDataCenter.stamina):GetCurrentStamina()) .. "/" .. tostring((PlayerDataCenter.stamina):GetStaminaCeiling())
    return 
  end
  local count = PlayerDataCenter:GetItemCount((self.itemCfg).id)
  if (self.itemCfg).id >= 1003 then
    local capcity = (PlayerDataCenter.playerBonus):GetWarehouseCapcity((self.itemCfg).id)
    -- DECOMPILER ERROR at PC61: Confused about usage of register: R3 in 'UnsetPending'

    if capcity == nil or capcity == 0 then
      ((self.ui).tex_Count).text = tostring(count)
    else
      -- DECOMPILER ERROR at PC73: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.ui).tex_Count).text = tostring(count) .. "/" .. tostring(capcity)
    end
  else
    do
      -- DECOMPILER ERROR at PC80: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).tex_Count).text = tostring(count)
    end
  end
end

UINResourceItem.OnClickAdd = function(self)
  -- function num : 0_3 , upvalues : _ENV, JumpManager
  if ItemIdOfKey == (self.itemCfg).id then
    JumpManager:Jump((JumpManager.eJumpTarget).BuyStamina)
    return 
  end
end

UINResourceItem.OnClickItem = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local window = UIManager:ShowWindow(UIWindowTypeID.GlobalItemDetail)
  if self.parentWindowType ~= nil then
    window:ParentWindowType(self.parentWindowType)
  end
  window:InitCommonItemDetail(self.itemCfg)
end

UINResourceItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : _ENV, base
  if self._UpdateCount ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.StaminaUpdate, self._UpdateCount)
  end
  ;
  (base.OnDelete)(self)
end

return UINResourceItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UINResourceItem = class("UINResourceItem", UIBaseNode)
local base = UIBaseNode
local JumpManager = require("Game.Jump.JumpManager")
UINResourceItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Add, self, self.OnClickAdd);
    (UIUtil.AddButtonListener)((self.ui).btn_resourceItem, self,
                               self.OnClickItem)
    self.shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
end

UINResourceItem.InitCurrencyItem = function(self, itemCfg)
    -- function num : 0_1 , upvalues : _ENV
    self.itemCfg = itemCfg
    if ItemIdOfKey == (self.itemCfg).id then
        (((self.ui).img_Icon).gameObject):SetActive(false);
        (((self.ui).obj_key_Icon).gameObject):SetActive(true)
        local quickPurchaseWin = UIManager:GetWindow(UIWindowTypeID.QuickBuy)
        if (quickPurchaseWin == nil or quickPurchaseWin.active == false) and
            (self.shopCtrl).isUnlocked then
            (((self.ui).btn_Add).gameObject):SetActive(true)
        end
    else
        do
            -- DECOMPILER ERROR at PC45: Confused about usage of register: R2 in 'UnsetPending'


            ((self.ui).img_Icon).sprite = CRH:GetSprite(itemCfg.small_icon);
            (((self.ui).btn_Add).gameObject):SetActive(false)
            self:UpdateCount()
        end
    end
end

UINResourceItem.UpdateCount = function(self)
    -- function num : 0_2 , upvalues : _ENV
    if ItemIdOfKey == (self.itemCfg).id then
        if self._UpdateCount == nil then
            self._UpdateCount = BindCallback(self, self.UpdateCount)
            MsgCenter:AddListener(eMsgEventId.StaminaUpdate, self._UpdateCount)
        end -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'
        
        ((self.ui).tex_Count).text = tostring(
                                         (PlayerDataCenter.stamina):GetCurrentStamina()) ..
                                         "/" ..
                                         tostring(
                                             (PlayerDataCenter.stamina):GetStaminaCeiling())
        return
    end
    local count = PlayerDataCenter:GetItemCount((self.itemCfg).id)
    if (self.itemCfg).id >= 1003 then
        local capcity = (PlayerDataCenter.playerBonus):GetWarehouseCapcity(
                            (self.itemCfg).id)
        -- DECOMPILER ERROR at PC61: Confused about usage of register: R3 in 'UnsetPending'

        if capcity == nil or capcity == 0 then
            ((self.ui).tex_Count).text = tostring(count)
        else
            -- DECOMPILER ERROR at PC73: Confused about usage of register: R3 in 'UnsetPending'


            ((self.ui).tex_Count).text =
                tostring(count) .. "/" .. tostring(capcity)
        end
    else
        do
            -- DECOMPILER ERROR at PC80: Confused about usage of register: R2 in 'UnsetPending'


            ((self.ui).tex_Count).text = tostring(count)
        end
    end
end

UINResourceItem.OnClickAdd = function(self)
    -- function num : 0_3 , upvalues : _ENV, JumpManager
    if ItemIdOfKey == (self.itemCfg).id then
        JumpManager:Jump((JumpManager.eJumpTarget).BuyStamina)
        return
    end
end

UINResourceItem.OnClickItem = function(self)
    -- function num : 0_4 , upvalues : _ENV
    local window = UIManager:ShowWindow(UIWindowTypeID.GlobalItemDetail)
    if self.parentWindowType ~= nil then
        window:ParentWindowType(self.parentWindowType)
    end
    window:InitCommonItemDetail(self.itemCfg)
end

UINResourceItem.OnDelete = function(self)
    -- function num : 0_5 , upvalues : _ENV, base
    if self._UpdateCount ~= nil then
        MsgCenter:RemoveListener(eMsgEventId.StaminaUpdate, self._UpdateCount)
    end
    (base.OnDelete)(self)
end

return UINResourceItem

