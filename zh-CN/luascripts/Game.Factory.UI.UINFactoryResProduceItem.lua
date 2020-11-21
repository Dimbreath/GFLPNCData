-- params : ...
-- function num : 0 , upvalues : _ENV
local UINFactoryResProduceItem = class("UINFactoryResProduceItem", UIBaseNode)
UINFactoryResProduceItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_resItem, self,
                               self.OnBtnSelectClicked)
end

UINFactoryResProduceItem.InitResProduce =
    function(self, itemCfg, stockNum, output, clickedAction)
        -- function num : 0_1 , upvalues : _ENV
        self.itemCfg = itemCfg
        self.id = itemCfg.id
        self.stockNum = stockNum
        self.output = output
        self.clickAction = clickedAction -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'
        ;
        ((self.ui).tex_Name).text = (LanguageUtil.GetLocaleText)(itemCfg.name) -- DECOMPILER ERROR at PC19: Confused about usage of register: R5 in 'UnsetPending'
        ;
        ((self.ui).img_Pic).sprite = CRH:GetSprite(itemCfg.icon) -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'
        ;
        ((self.ui).img_Quality).color = ItemQualityColor[itemCfg.quality]
        self:RefreshProduceState()
    end

UINFactoryResProduceItem.RefreshProduceState =
    function(self)
        -- function num : 0_2 , upvalues : _ENV
        local isInt = (math.floor)(self.output) == self.output
        if not isInt or not tostring(self.output) then
            local outputStr = (string.format)("%.2f", self.output)
        end
        -- DECOMPILER ERROR at PC35: Confused about usage of register: R3 in 'UnsetPending'

        if self.output < 0 then
            if (math.abs)(self.output) <= self.stockNum then
                ((self.ui).img_Color).color = (self.ui).col_Running;
                ((self.ui).tex_Inventory):SetIndex(1, tostring(self.stockNum));
                ((self.ui).tex_Yield):SetIndex(1, outputStr)
            else
                -- DECOMPILER ERROR at PC55: Confused about usage of register: R3 in 'UnsetPending'

                ((self.ui).img_Color).color = (self.ui).col_Stopped;
                ((self.ui).tex_Inventory):SetIndex(0, tostring(self.stockNum));
                ((self.ui).tex_Yield):SetIndex(0, outputStr)
            end
        else
            -- DECOMPILER ERROR at PC75: Confused about usage of register: R3 in 'UnsetPending'

            ((self.ui).img_Color).color = (self.ui).col_Running;
            ((self.ui).tex_Inventory):SetIndex(0, tostring(self.stockNum));
            ((self.ui).tex_Yield):SetIndex(0, outputStr)
        end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
    end

UINFactoryResProduceItem.RefreshResNum =
    function(self, stockNum, output)
        -- function num : 0_3
        self.stockNum = stockNum
        self.output = output
        self:RefreshProduceState()
    end

UINFactoryResProduceItem.RefreshStockNum =
    function(self, stockNum)
        -- function num : 0_4
        self.stockNum = stockNum
        self:RefreshProduceState()
    end

UINFactoryResProduceItem.OnBtnSelectClicked =
    function(self)
        -- function num : 0_5
        if self.clickAction ~= nil then (self.clickAction)(self) end
    end

UINFactoryResProduceItem.SetProduceSelect =
    function(self, active)
        -- function num : 0_6
        ((self.ui).img_Selected):SetActive(active)
    end

return UINFactoryResProduceItem

