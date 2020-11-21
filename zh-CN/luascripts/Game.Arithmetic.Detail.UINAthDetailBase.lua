-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthDetailBase = class("UINAthDetailBase", UIBaseNode)
local base = UIBaseNode
local UINAthAttrItem = require("Game.Arithmetic.Common.UINAthAttrItem")
local cs_MessageCommon = CS.MessageCommon
local StrengthenQuality = 5
UINAthDetailBase.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINAthAttrItem
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_Close, self, self.OnClickClose);
    (UIUtil.AddButtonListener)((self.ui).btn_Strengthen, self,
                               self.OnClickStrengthen);
    (UIUtil.AddButtonListener)((self.ui).btn_Lock, self, self.OnClickLock);
    (((self.ui).mainAttriItem).gameObject):SetActive(false);
    (((self.ui).subAttriItem).gameObject):SetActive(false)
    self.mainAttrPool =
        (UIItemPool.New)(UINAthAttrItem, (self.ui).mainAttriItem)
    self.subAttrPool = (UIItemPool.New)(UINAthAttrItem, (self.ui).subAttriItem)
end

UINAthDetailBase.InitAthDetailNode = function(self, athData, efficiency)
    -- function num : 0_1 , upvalues : _ENV, StrengthenQuality
    self.athData = athData
    self.efficiency = efficiency -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'
    ;
    ((self.ui).img_BgColor).color = athData:GetColor();
    ((self.ui).tex_ATHName):SetIndex(0, athData:GetName(),
                                     tostring(athData.area_type));
    ((self.ui).tex_ATHSpace):SetIndex(0, tostring(athData.size))
    self:RefreshAthLock();
    (self.mainAttrPool):HideAll()
    for k, v in ipairs(athData.attrList) do
        local attrItem = (self.mainAttrPool):GetOne()
        attrItem:InitAthAttrItem(v.id, v.value, efficiency)
    end
    (self.subAttrPool):HideAll()
    for k, v in ipairs(athData.affixList) do
        local attrItem = (self.subAttrPool):GetOne()
        local cfg = (ConfigData.ath_affix_pool)[v.id]
        if cfg == nil then
            error("Cant\'t find ath_affix_pool, id = " .. tostring(v.id))
        else
            attrItem:InitAthAttrItem(cfg.affix_para, v.value)
            attrItem:SetAttrColor(v.quality)
        end
    end
    local strengthenEnable = StrengthenQuality <= athData.quality -- DECOMPILER ERROR at PC85: Confused about usage of register: R4 in 'UnsetPending'
    ;
    ((self.ui).btn_Strengthen).interactable = strengthenEnable
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINAthDetailBase.OnClickStrengthen = function(self)
    -- function num : 0_2 , upvalues : StrengthenQuality, cs_MessageCommon, _ENV
    local strengthenEnable = StrengthenQuality == (self.athData).quality
    if not strengthenEnable then
        (cs_MessageCommon.ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.arithmetic_Strengthlimt))
        return
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.AthStrengthen, function(window)
        -- function num : 0_2_0 , upvalues : self
        if window == nil then return end
        window:InitAthStrengthen(self.athData)
    end)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINAthDetailBase.RefreshAthLock = function(self)
    -- function num : 0_3

    ((self.ui).img_Lock):SetIndex((self.athData).lockUnlock and 1 or 0)
end

UINAthDetailBase.SetCloseEvent = function(self, closeEvent)
    -- function num : 0_4
    self.closeEvent = closeEvent
end

UINAthDetailBase.OnClickClose = function(self)
    -- function num : 0_5
    self:Hide()
    if self.closeEvent ~= nil then (self.closeEvent)() end
end

UINAthDetailBase.SetLockEvent = function(self, lockEvent)
    -- function num : 0_6
    self.lockEvent = lockEvent
end

UINAthDetailBase.OnClickLock = function(self)
    -- function num : 0_7
    if self.lockEvent ~= nil then (self.lockEvent)((self.athData).uid) end
end

UINAthDetailBase.OnDelete = function(self)
    -- function num : 0_8 , upvalues : base
    (base.OnDelete)(self)
end

return UINAthDetailBase

