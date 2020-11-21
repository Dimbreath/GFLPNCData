-- params : ...
-- function num : 0 , upvalues : _ENV
local UINTroopItem = class("UINTroopItem", UIBaseNode)
local base = UIBaseNode
UINTroopItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddValueChangedListener)((self.ui).tog_root, self,
                                     self.OnClickSeleteTroop)
end

UINTroopItem.InitTroopItem = function(self, fmtId, selectEvent)
    -- function num : 0_1
    self.id = fmtId
    self.selectEvent = selectEvent
    self:SetTroopToggleOn(false)
    self:RefreshTroopName()
end

UINTroopItem.RefreshTroopName = function(self)
    -- function num : 0_2 , upvalues : _ENV
    ((self.ui).tex_troopName):SetIndex(0, tostring(self.id))
end

UINTroopItem.OnClickSeleteTroop = function(self, isOn)
    -- function num : 0_3
    if not isOn then return end
    if self.selectEvent ~= nil then (self.selectEvent)(self.id) end
end

UINTroopItem.SetTroopToggleOn = function(self, isOn)
    -- function num : 0_4
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

    ((self.ui).tog_root).isOn = isOn
end

UINTroopItem.OnDelete = function(self)
    -- function num : 0_5 , upvalues : base
    (base.OnDelete)(self)
end

return UINTroopItem

