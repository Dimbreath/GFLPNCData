-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasisBuildingUpgradeCostItem = class("UIOasisBuildingUpgradeCostItem",
                                             UIBaseNode)
local base = UIBaseNode
local UIOasisCostMatInfo =
    require("Game.Oasis.UI.OasisSidle.UIOasisCostMatInfo")
local infoItem = require("Game.Oasis.UI.UIOasisBuildingUpgradeCostInfoItem")
local itemStateInfo = {
    normalUpgrade = 0,
    normalConstruct = 1,
    upgrading = 2,
    constructing = 3
}
local itemInfoCountMax = 2
UIOasisBuildingUpgradeCostItem.OnInit = function(self)
    -- function num : 0_0 , upvalues : itemStateInfo, _ENV, UIOasisCostMatInfo, infoItem
    self.closeEvent = nil
    self.state = itemStateInfo.normal;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).btn_DoComplete, self, self.OnClick);
    (UIUtil.AddButtonListener)((self.ui).btn_return, self, self.OnBack)
    self.matInfoPool = (UIItemPool.New)(UIOasisCostMatInfo,
                                        (self.ui).materialItem)
    self.textInfoPool = (UIItemPool.New)(infoItem, (self.ui).infoItem)
    self.itemInfoCount = 0
end

UIOasisBuildingUpgradeCostItem.ClearItemInfo =
    function(self)
        -- function num : 0_1
        if self.textInfoPool == nil then return end
        (self.textInfoPool):HideAll()
        self.itemInfoCount = 0;
        (((self.ui).btn_DoComplete).gameObject):SetActive(true);
        ((self.ui).state):SetActive(false)
    end

UIOasisBuildingUpgradeCostItem.InjectData =
    function(self, resLoader)
        -- function num : 0_2
        self.resLoader = resLoader
    end

UIOasisBuildingUpgradeCostItem.SetTitle =
    function(self, name)
        -- function num : 0_3
        -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

        ((self.ui).tex_Tile).text = name
    end

UIOasisBuildingUpgradeCostItem.SetState =
    function(self, stateIndex)
        -- function num : 0_4 , upvalues : itemStateInfo
        self.state = stateIndex;
        ((self.ui).stateInfo):SetIndex(stateIndex)
        if stateIndex == itemStateInfo.normalUpgrade then
            ((self.ui).btnText):SetIndex(1);
            ((self.ui).titleText):SetIndex(1)
        else
            if stateIndex == itemStateInfo.normalConstruct then
                ((self.ui).btnText):SetIndex(0);
                ((self.ui).titleText):SetIndex(0)
            else
                if stateIndex == itemStateInfo.upgrading then
                    ((self.ui).titleText):SetIndex(1);
                    (((self.ui).btn_DoComplete).gameObject):SetActive(false)
                else
                    if stateIndex == itemStateInfo.constructing then
                        ((self.ui).titleText):SetIndex(0);
                        (((self.ui).btn_DoComplete).gameObject):SetActive(false)
                    end
                end
            end
        end
    end

UIOasisBuildingUpgradeCostItem.UpdateWithData =
    function(self, resNeedItems, remainTime, currentLevl, nextLevel)
        -- function num : 0_5 , upvalues : _ENV
        ((self.ui).costItemList):SetActive(true);
        (self.matInfoPool):HideAll()
        if resNeedItems ~= nil then
            local index = 3
            for k, v in ipairs(resNeedItems) do
                if index > 0 and v ~= nil and v.resCount > 0 then
                    local matItem = (self.matInfoPool):GetOne()
                    matItem:UpdateUIWithName(v.resId, v.name, v.resCount,
                                             v.count)
                    index = index - 1
                end
            end
        end
        do
            -- DECOMPILER ERROR at PC36: Confused about usage of register: R5 in 'UnsetPending'


            ((self.ui).tex_UpdateTime).text = remainTime
            self:UpdateLevel(currentLevl, nextLevel)
            -- DECOMPILER ERROR at PC47: Confused about usage of register: R5 in 'UnsetPending'

            if (self.ui).progressFill ~= nil then
                ((self.ui).progressFill).fillAmount = 0
            end
        end
    end

UIOasisBuildingUpgradeCostItem.HideCostMatList =
    function(self)
        -- function num : 0_6
        ((self.ui).costItemList):SetActive(false)
    end

UIOasisBuildingUpgradeCostItem.UpdateTime =
    function(self, progress, timeText)
        -- function num : 0_7
        -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

        if (self.ui).progressFill ~= nil then
            ((self.ui).progressFill).fillAmount = progress
        end -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'
        
        ((self.ui).tex_UpdateTime).text = timeText
    end

UIOasisBuildingUpgradeCostItem.UpdateLevel =
    function(self, currentLevel, nextLevel)
        -- function num : 0_8 , upvalues : _ENV
        -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

        ((self.ui).curLvlnum1).text = tostring(currentLevel // 10) -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).curLvlnum2).text = tostring(currentLevel % 10) -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).nxtLvlnum1).text = tostring(nextLevel // 10) -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).nxtLvlnum2).text = tostring(nextLevel % 10)
    end

UIOasisBuildingUpgradeCostItem.OnBack = function(self)
    -- function num : 0_9 , upvalues : base
    if self.closeEvent ~= nil then (self.closeEvent)() end
    (base.Hide)(self)
end

UIOasisBuildingUpgradeCostItem.OnClick =
    function(self)
        -- function num : 0_10
        if self.clickEvent ~= nil then
            (self.clickEvent)()
            self:OnBack()
        end
    end

UIOasisBuildingUpgradeCostItem.SetNeedBuildingLevel =
    function(self, name, currentLevel, needLevel)
        -- function num : 0_11
        ((self.ui).state):SetActive(true);
        (((self.ui).btn_DoComplete).gameObject):SetActive(false);
        ((self.ui).stateText):SetIndex(0, name, needLevel)
    end

UIOasisBuildingUpgradeCostItem.SetBuffChange =
    function(self, buffDic, isUnbuilt)
        -- function num : 0_12 , upvalues : itemInfoCountMax
        if buffDic ~= nil then
            if self.itemInfoCount < itemInfoCountMax then
                for i = self.itemInfoCount, itemInfoCountMax do
                    if buffDic[i] ~= nil then
                        local textItem = (self.textInfoPool):GetOne()
                        if textItem ~= nil then
                            textItem:UpdateUI(nil, (buffDic[i]).currentInfo,
                                              (buffDic[i]).nextInfoValue, false,
                                              isUnbuilt)
                        end
                    end
                end
            end
            do self.itemInfoCount = itemInfoCountMax end
        end
    end

UIOasisBuildingUpgradeCostItem.OnDelete =
    function(self)
        -- function num : 0_13 , upvalues : base
        (base.OnDelete)(self)
    end

return UIOasisBuildingUpgradeCostItem

