-- params : ...
-- function num : 0 , upvalues : _ENV
local UITopStatus = class("UITopStatus", UIBaseWindow)
local base = UIBaseWindow
local UICurrencyItem = require("Game.TopStatus.UICurrencyItem")
local CurrencyId = {1001, 1002, 1003, 1004}
UITopStatus.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.__returnCallback = {}
  self.btnHomeClicked = nil
  self:ShowButtons(false)
  self:ShowReturnButton(false)
  self:ShowHomeButton(false)
  self:InitCurrency()
  self:InitStamima()
  ;
  (UIUtil.AddButtonListener)((self.ui).btnHome, self, self.OnBtnHomeClicked)
  ;
  (UIUtil.AddButtonListener)((self.ui).btnReturn, self, self.OnBtnReturnClicked)
  self.__secondTimer = (TimerManager:GetTimer(1, (BindCallback(self, self.UpdateSecond)), nil, false)):Start()
end

UITopStatus.InitCurrency = function(self)
  -- function num : 0_1 , upvalues : _ENV, CurrencyId, UICurrencyItem
  ((self.ui).currencyPrefab):SetActive(false)
  self.currencyItems = {}
  local parent = (((self.ui).currencyPrefab).transform).parent
  for _,v in pairs(CurrencyId) do
    local go = ((self.ui).currencyPrefab):Instantiate(parent)
    go:SetActive(true)
    local itemCfg = (ConfigData.item)[v]
    if itemCfg == nil then
      error("item Cfg is null :" .. tostring(v))
      return 
    end
    local count = PlayerDataCenter:GetItemCount(v)
    local item = (UICurrencyItem.New)()
    item:Init(go)
    item:Initialize(itemCfg, count)
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (self.currencyItems)[v] = item
  end
  self:OnWarehouseUpdateEvent()
  self.__onUpdateItemEvent = BindCallback(self, self.OnItemUpdateEvent)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
  self.__onUpdateWarehouseEvent = BindCallback(self, self.OnWarehouseUpdateEvent)
  MsgCenter:AddListener(eMsgEventId.UpdateWarehouse, self.__onUpdateWarehouseEvent)
end

UITopStatus.InitStamima = function(self)
  -- function num : 0_2 , upvalues : _ENV
  ((self.ui).stamina):SetAsLastSibling()
  self:UpdateStaminaUI()
  self.__onUpdateStaminaUI = BindCallback(self, self.UpdateStaminaUI)
  MsgCenter:AddListener(eMsgEventId.StaminaUpdate, self.__onUpdateStaminaUI)
end

UITopStatus.UpdateSecond = function(self)
  -- function num : 0_3
  self:UpdateStaminaUI()
end

UITopStatus.UpdateStaminaUI = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local ceiling = (PlayerDataCenter.stamina):GetStaminaCeiling()
  local stamina, remainSecond = (PlayerDataCenter.stamina):GetCurrentStamina()
  ;
  ((self.ui).staminaCount):SetIndex(0, tostring(stamina), tostring(ceiling))
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

  if ceiling > stamina or not "" then
    ((self.ui).staminaTimer).text = TimestampToTime(remainSecond)
  end
end

UITopStatus.SetHomeEvent = function(self, callback)
  -- function num : 0_5
  self.btnHomeClicked = callback
  self:ShowButtons(true)
  self:ShowHomeButton(true)
end

UITopStatus.AddReturnEvent = function(self, callback)
  -- function num : 0_6 , upvalues : _ENV
  if type(callback) == "function" then
    (table.insert)(self.__returnCallback, callback)
    self:ShowReturnButton(true)
    self:ShowButtons(true)
  else
    error("AddReturnEvent : callback is not function")
  end
end

UITopStatus.ClearReturnEvents = function(self)
  -- function num : 0_7
  self.__returnCallback = {}
  self:ShowReturnButton(false)
end

UITopStatus.ShowButtons = function(self, show)
  -- function num : 0_8
  ((self.ui).buttons):SetActive(show)
end

UITopStatus.ShowReturnButton = function(self, show)
  -- function num : 0_9
  (((self.ui).btnReturn).gameObject):SetActive(show)
end

UITopStatus.ShowHomeButton = function(self, show)
  -- function num : 0_10
  (((self.ui).btnHome).gameObject):SetActive(show)
end

UITopStatus.OnBtnHomeClicked = function(self)
  -- function num : 0_11
  if self.btnHomeClicked ~= nil then
    (self.btnHomeClicked)()
    self.btnHomeClicked = nil
    self:ShowButtons(false)
  end
  self:ClearReturnEvents()
  self:ShowButtons(false)
  self:ShowHomeButton(false)
end

UITopStatus.OnBtnReturnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if #self.__returnCallback > 0 then
    local callback = (table.remove)(self.__returnCallback)
    callback()
    if #self.__returnCallback == 0 then
      self:ShowReturnButton(false)
      if self.btnHomeClicked == nil then
        self:ShowButtons(false)
      end
    end
  else
    do
      error("No return callback")
    end
  end
end

UITopStatus.OnItemUpdateEvent = function(self, itemDic)
  -- function num : 0_13 , upvalues : _ENV, CurrencyId
  for _,v in ipairs(CurrencyId) do
    if itemDic[v] ~= nil then
      local count = PlayerDataCenter:GetItemCount(v)
      ;
      ((self.currencyItems)[v]):UpdateCount(count)
    end
  end
end

UITopStatus.OnWarehouseUpdateEvent = function(self)
  -- function num : 0_14 , upvalues : _ENV, CurrencyId
  for k,v in ipairs(CurrencyId) do
    if v >= 1003 then
      local count = (PlayerDataCenter.playerBonus):GetWarehouseCapcity(v)
      ;
      ((self.currencyItems)[v]):UpdateCeilCount(count)
    end
  end
end

UITopStatus.OnDelete = function(self)
  -- function num : 0_15 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onUpdateItemEvent)
  MsgCenter:RemoveListener(eMsgEventId.UpdateWarehouse, self.__onUpdateWarehouseEvent)
  MsgCenter:RemoveListener(eMsgEventId.StaminaUpdate, self.__onUpdateStaminaUI)
  if self.__secondTimer ~= nil then
    (self.__secondTimer):Stop()
    self.__secondTimer = nil
  end
  ;
  (base.OnDelete)(self)
end

return UITopStatus

