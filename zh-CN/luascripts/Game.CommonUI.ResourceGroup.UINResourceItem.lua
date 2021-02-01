-- params : ...
-- function num : 0 , upvalues : _ENV
local UINResourceItem = class("UINResourceItem", UIBaseNode)
local base = UIBaseNode
local JumpManager = require("Game.Jump.JumpManager")
local smallResSize = (Vector2.New)(150, 40)
UINResourceItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Add, self, self.OnClickAdd)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_resourceItem, self, self.OnClickItem)
  self.shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  self.passiveRefresh = true
  self.__defaultSize = (self.transform).sizeDelta
end

UINResourceItem.InitCurrencyItem = function(self, itemCfg)
  -- function num : 0_1 , upvalues : _ENV, smallResSize
  self.itemCfg = itemCfg
  local isKey = ConstGlobalItem.SKey == (self.itemCfg).id
  ;
  (((self.ui).img_Icon).gameObject):SetActive(not isKey)
  ;
  (((self.ui).obj_key_Icon).gameObject):SetActive(isKey)
  if isKey then
    local quickPurchaseWin = UIManager:GetWindow(UIWindowTypeID.QuickBuy)
    if (quickPurchaseWin == nil or quickPurchaseWin.active == false) and (self.shopCtrl):GetIsUnlock() then
      (((self.ui).btn_Add).gameObject):SetActive(true)
    end
  else
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R3 in 'UnsetPending'

    ((self.ui).img_Icon).sprite = CRH:GetSprite(itemCfg.small_icon)
    ;
    (((self.ui).btn_Add).gameObject):SetActive(false)
  end
  -- DECOMPILER ERROR at PC66: Confused about usage of register: R3 in 'UnsetPending'

  if itemCfg.small_icon_type then
    ((self.ui).img_Icon).color = ItemQualityColor[itemCfg.quality]
    -- DECOMPILER ERROR at PC69: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.transform).sizeDelta = smallResSize
  else
    -- DECOMPILER ERROR at PC75: Confused about usage of register: R3 in 'UnsetPending'

    ((self.ui).img_Icon).color = Color.white
    -- DECOMPILER ERROR at PC78: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.transform).sizeDelta = self.__defaultSize
  end
  self:UpdateCount()
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

UINResourceItem.SetPassiveRefresh = function(self, active)
  -- function num : 0_2
  self.passiveRefresh = active
end

UINResourceItem.UpdateCount = function(self, setCount)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  if setCount ~= nil then
    ((self.ui).tex_Count).text = tostring(setCount)
    return 
  end
  if not self.passiveRefresh then
    return 
  end
  if ConstGlobalItem.SKey == (self.itemCfg).id then
    if self._UpdateCount == nil then
      self._UpdateCount = BindCallback(self, self.UpdateCount)
      MsgCenter:AddListener(eMsgEventId.StaminaUpdate, self._UpdateCount)
    end
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.ui).tex_Count).text = tostring((PlayerDataCenter.stamina):GetCurrentStamina()) .. "/" .. tostring((PlayerDataCenter.stamina):GetStaminaCeiling())
    return 
  end
  local count = PlayerDataCenter:GetItemCount((self.itemCfg).id)
  if (self.itemCfg).id >= 1003 then
    local capcity = (PlayerDataCenter.playerBonus):GetWarehouseCapcity((self.itemCfg).id)
    -- DECOMPILER ERROR at PC75: Confused about usage of register: R4 in 'UnsetPending'

    if capcity == nil or capcity == 0 then
      ((self.ui).tex_Count).text = tostring(count)
    else
      -- DECOMPILER ERROR at PC87: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((self.ui).tex_Count).text = tostring(count) .. "/" .. tostring(capcity)
    end
  else
    do
      -- DECOMPILER ERROR at PC94: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.ui).tex_Count).text = tostring(count)
    end
  end
end

UINResourceItem.OnClickAdd = function(self)
  -- function num : 0_4 , upvalues : _ENV, JumpManager
  if self.__ClickAddCallback ~= nil then
    (self.__ClickAddCallback)()
    return 
  end
  if ConstGlobalItem.SKey == (self.itemCfg).id then
    JumpManager:Jump((JumpManager.eJumpTarget).BuyStamina)
    return 
  end
end

UINResourceItem.SetAddBtn = function(self, bool, addBtnCallback)
  -- function num : 0_5
  (((self.ui).btn_Add).gameObject):SetActive(bool)
  if bool then
    self.__ClickAddCallback = addBtnCallback
  else
    self.__ClickAddCallback = nil
  end
end

UINResourceItem.OnClickItem = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local window = UIManager:ShowWindow(UIWindowTypeID.GlobalItemDetail)
  if self.parentWindowType ~= nil then
    window:ParentWindowType(self.parentWindowType)
  end
  window:InitCommonItemDetail(self.itemCfg)
end

UINResourceItem.OnHide = function(self)
  -- function num : 0_7
  self.passiveRefresh = true
end

UINResourceItem.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  if self._UpdateCount ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.StaminaUpdate, self._UpdateCount)
  end
  ;
  (base.OnDelete)(self)
end

return UINResourceItem

