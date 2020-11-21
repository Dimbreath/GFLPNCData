-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFactoryLineEntity = class("UINFactoryLineEntity", UIBaseNode)
local UINFactoryLineEntityMat = require(
                                    "Game.Factory.UI.UINFactoryLineEntityMat")
UINFactoryLineEntity.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINFactoryLineEntityMat
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    ((self.ui).materialItem):SetActive(false)
    self.matItemPool = (UIItemPool.New)(UINFactoryLineEntityMat,
                                        (self.ui).materialItem)
    self.lineMatItems = {}
end

UINFactoryLineEntity.InitFactoryLineEntity =
    function(self, lineData, factoryLine, allResource, count)
        -- function num : 0_1 , upvalues : _ENV
        self.lineData = lineData
        self.uid = lineData.uid
        if lineData.isSetCycle == true then
            (((self.ui).tex_cycle).gameObject):SetActive(true);
            ((self.ui).tex_cycle):SetIndex(0, tostring(
                                               lineData.presetCycle -
                                                   lineData.curCycle),
                                           tostring(lineData.presetCycle))
        else

            (((self.ui).tex_cycle).gameObject):SetActive(false)
        end -- DECOMPILER ERROR at PC39: Confused about usage of register: R5 in 'UnsetPending'
        
        ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(
                                        (factoryLine.cfg).name) -- DECOMPILER ERROR at PC47: Confused about usage of register: R5 in 'UnsetPending'
        ;
        ((self.ui).img_Pic).sprite = CRH:GetSprite((factoryLine.itemCfg).icon);
        ((self.ui).tex_Count):SetIndex(0, tostring(count)) -- DECOMPILER ERROR at PC59: Confused about usage of register: R5 in 'UnsetPending'
        ;
        ((self.ui).img_Fill).fillAmount = lineData.cycleRate;
        ((self.ui).tex_sdate):SetIndex(lineData.state) -- DECOMPILER ERROR at PC71: Confused about usage of register: R5 in 'UnsetPending'
        ;
        ((self.ui).img_Quality).color =
            ItemQualityColor[(factoryLine.itemCfg).quality];
        (self.matItemPool):HideAll()
        local lastItem = nil
        for k, consumeId in ipairs((factoryLine.cfg).consumeIds) do
            local itemCfg = (ConfigData.item)[consumeId]
            if itemCfg ~= nil then
                local lineMatItem = (self.matItemPool):GetOne()
                lineMatItem:InitLineEntityResItem(itemCfg,
                                                  allResource[consumeId] or 0)
                lineMatItem:SetSignActive(true)
                lastItem = lineMatItem
            end
        end
        if lastItem ~= nil then lastItem:SetSignActive(false) end
    end

UINFactoryLineEntity.RefreshFactoryLine =
    function(self)
        -- function num : 0_2
        -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

        ((self.ui).img_Fill).fillAmount = (self.lineData).cycleRate
    end

return UINFactoryLineEntity

