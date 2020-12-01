-- params : ...
-- function num : 0 , upvalues : _ENV
local UICurrencyItem = class("UICurrencyItem", UIBaseNode)
local base = UIBaseNode
UICurrencyItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UICurrencyItem.Initialize = function(self, itemCfg, count)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ((self.ui).texName).text = (LanguageUtil.GetLocaleText)(itemCfg.name)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).icon).sprite = CRH:GetSprite(itemCfg.icon)
  self:UpdateCount(count)
  ;
  ((self.ui).ceillingCount):SetActive(false)
  self.showCeilCount = false
end

UICurrencyItem.UpdateCount = function(self, count)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).texCount).text = tonumber(count)
end

UICurrencyItem.UpdateCeilCount = function(self, count)
  -- function num : 0_3 , upvalues : _ENV
  if not self.showCeilCount then
    self.showCeilCount = true
    ;
    ((self.ui).ceillingCount):SetActive(true)
  end
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).ceilcount).text = tonumber(count)
end

UICurrencyItem.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)()
end

return UICurrencyItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UICurrencyItem = class("UICurrencyItem", UIBaseNode)
local base = UIBaseNode
UICurrencyItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
end

UICurrencyItem.Initialize = function(self, itemCfg, count)
    -- function num : 0_1 , upvalues : _ENV
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

    ((self.ui).texName).text = (LanguageUtil.GetLocaleText)(itemCfg.name) -- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).icon).sprite = CRH:GetSprite(itemCfg.icon)
    self:UpdateCount(count);
    ((self.ui).ceillingCount):SetActive(false)
    self.showCeilCount = false
end

UICurrencyItem.UpdateCount = function(self, count)
    -- function num : 0_2 , upvalues : _ENV
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).texCount).text = tonumber(count)
end

UICurrencyItem.UpdateCeilCount = function(self, count)
    -- function num : 0_3 , upvalues : _ENV
    if not self.showCeilCount then
        self.showCeilCount = true;
        ((self.ui).ceillingCount):SetActive(true)
    end -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'
    
    ((self.ui).ceilcount).text = tonumber(count)
end

UICurrencyItem.OnDelete = function(self)
    -- function num : 0_4 , upvalues : base
    (base.OnDelete)()
end

return UICurrencyItem

