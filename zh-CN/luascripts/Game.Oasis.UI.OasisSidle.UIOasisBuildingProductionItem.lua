-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasisBuildingProductionItem = class("UIOasisBuildingProductionItem",
                                            UIBaseNode)
local base = UIBaseNode
UIOasisBuildingProductionItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn, self, self.OnClick)
end

UIOasisBuildingProductionItem.UpdateInfo =
    function(self, id, rate, count, collectEvent)
        -- function num : 0_1 , upvalues : _ENV
        self.id = id
        if rate >= 1 then
            ((self.ui).img_IsMax):SetActive(true)
        else

            ((self.ui).img_IsMax):SetActive(false)
        end -- DECOMPILER ERROR at PC16: Confused about usage of register: R5 in 'UnsetPending'
        
        ((self.ui).img_Rate).fillAmount = rate;
        ((self.ui).tex_Count):SetIndex(0, tostring(count))
        self.collectEvent = collectEvent
    end

UIOasisBuildingProductionItem.OnClick = function(self)
    -- function num : 0_2
    if self.collectEvent ~= nil then (self.collectEvent)(self.id) end
end

return UIOasisBuildingProductionItem

