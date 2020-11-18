-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHomeCurrencyItem = class("UINHomeCurrencyItem", UIBaseNode)
local base = UIBaseNode
UINHomeCurrencyItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UINHomeCurrencyItem.InitCurrencyItem = function(self, itemCfg)
  -- function num : 0_1 , upvalues : _ENV
  self.itemCfg = itemCfg
  local count = PlayerDataCenter:GetItemCount(itemCfg.id)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).sprite = CRH:GetSprite(itemCfg.icon)
  if itemCfg.id >= 1003 then
    local capcity = (PlayerDataCenter.playerBonus):GetWarehouseCapcity(itemCfg.id)
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_Count).text = tostring(count) .. "/" .. tostring(capcity)
  else
    do
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.ui).tex_Count).text = tostring(count)
    end
  end
end

UINHomeCurrencyItem.UpdateCount = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local count = PlayerDataCenter:GetItemCount((self.itemCfg).id)
  if (self.itemCfg).id >= 1003 then
    local capcity = (PlayerDataCenter.playerBonus):GetWarehouseCapcity((self.itemCfg).id)
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).tex_Count).text = tostring(count) .. "/" .. tostring(capcity)
  else
    do
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((self.ui).tex_Count).text = tostring(count)
    end
  end
end

UINHomeCurrencyItem.OnDelete = function(self)
  -- function num : 0_3 , upvalues : base
  (base.OnDelete)(self)
end

return UINHomeCurrencyItem

