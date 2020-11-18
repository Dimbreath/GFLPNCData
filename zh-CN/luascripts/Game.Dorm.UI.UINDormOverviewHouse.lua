-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDormOverviewHouse = class("UINDormOverviewHouse", UIBaseNode)
UINDormOverviewHouse.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).dormInfoItem, self, self.OnDormInfoItemClicked)
end

UINDormOverviewHouse.InitDormHouseInfo = function(self, houseCfg, houseData, clickAction)
  -- function num : 0_1 , upvalues : _ENV
  self.houseCfg = houseCfg
  self.houseData = houseData
  self.clickAction = clickAction
  self.id = houseCfg.id
  local unlock = houseData ~= nil
  self.unlock = unlock
  ;
  ((self.ui).lock):SetActive(not unlock)
  ;
  ((self.ui).comfort):SetActive(unlock)
  if unlock then
    ((self.ui).tex_Comfort):SetIndex(0, tostring(houseData:GetComfort()))
  elseif houseCfg.unlock_logic == 1 then
    ((self.ui).tex_Condition):SetIndex(0, tostring(houseCfg.unlock_level))
    ;
    ((self.ui).priceCondition):SetActive(false)
  elseif houseCfg.unlock_logic == 2 then
    ((self.ui).tex_Condition):SetIndex(1)
    ;
    ((self.ui).priceCondition):SetActive(true)
    local itemCfg = (ConfigData.item)[houseCfg.unlock_item_id]
    -- DECOMPILER ERROR at PC74: Confused about usage of register: R6 in 'UnsetPending'

    if itemCfg ~= nil then
      ((self.ui).img_CurrencyIcon).sprite = CRH:GetSprite(itemCfg.icon)
    end
    -- DECOMPILER ERROR at PC80: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_currPrice).text = tostring(houseCfg.unlock_item_num)
  end
  self:SetSelectActive(false)
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

UINDormOverviewHouse.SetSelectActive = function(self, active)
  -- function num : 0_2
  ((self.ui).img_OnSelect):SetActive(active)
end

UINDormOverviewHouse.OnDormInfoItemClicked = function(self)
  -- function num : 0_3
  if self.clickAction ~= nil then
    (self.clickAction)(self)
  end
end

return UINDormOverviewHouse

