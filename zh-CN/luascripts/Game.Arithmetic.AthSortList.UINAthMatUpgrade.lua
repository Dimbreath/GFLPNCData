-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthMatUpgrade = class("UINAthMatUpgrade", UIBaseNode)
local base = UIBaseNode
local UINHeroLevelUpItem = require(
                               "Game.Hero.NewUI.UpgradeLevel.UINHeroLevelUpItem")
local CS_LayoutRebuilder = ((CS.UnityEngine).UI).LayoutRebuilder
UINAthMatUpgrade.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINHeroLevelUpItem
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.lvUpMatItemDic = {}
    self.growupItemList = {};
    ((self.ui).upgradeItem):SetActive(false)
    self.lvUpMatPool = (UIItemPool.New)(UINHeroLevelUpItem,
                                        (self.ui).upgradeItem)
    self.__onItemChange = BindCallback(self, self.OnItemChange)
    MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__onItemChange)
end

UINAthMatUpgrade.InitAthMatUp = function(self, curLevel, curExp, addExpFunc)
    -- function num : 0_1
    self.curLevel = curLevel
    self.curExp = curExp
    self.addExpFunc = addExpFunc
    self:RefreshAllAthMatItem()
end

UINAthMatUpgrade.SetRefreshAthSlotAddExpFunc =
    function(self, refreshAthSlotAddExpFunc)
        -- function num : 0_2
        self.refreshAthSlotAddExpFunc = refreshAthSlotAddExpFunc
    end

UINAthMatUpgrade.RefreshAllAthMatItem = function(self)
    -- function num : 0_3 , upvalues : _ENV, CS_LayoutRebuilder
    (self.lvUpMatPool):HideAll()
    for _, id in ipairs(
                     ((ConfigData.item).growUpIds)[eItemActionType.AthAreaExp]) do
        if (PlayerDataCenter.itemDic)[id] ~= nil then
            local itemData = (PlayerDataCenter.itemDic)[id]
            do
                local item = (self.lvUpMatPool):GetOne(true) -- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'
                ;
                (item.gameObject).name = tostring(id)
                item:InitExpItem(itemData, function(num)
                    -- function num : 0_3_0 , upvalues : self, itemData
                    -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

                    (self.lvUpMatItemDic)[itemData] = num
                    self:GenAthMatExpAdd()
                end);
                (table.insert)(self.growupItemList, item)
            end
        else
            do
                do
                    local item = (self.lvUpMatPool):GetOne(true)
                    item:InitEmptyExpItem(id)
                    -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC47: LeaveBlock: unexpected jumping out IF_STMT

                end
            end
        end
    end
    (CS_LayoutRebuilder.ForceRebuildLayoutImmediate)(self.transform)
end

UINAthMatUpgrade.CleanAllAthUpMat = function(self)
    -- function num : 0_4 , upvalues : _ENV
    for _, item in ipairs(self.growupItemList) do item:CleanAll() end
    for itemData, _ in pairs(self.lvUpMatItemDic) do
        -- DECOMPILER ERROR at PC13: Confused about usage of register: R6 in 'UnsetPending'

        (self.lvUpMatItemDic)[itemData] = 0
    end
end

UINAthMatUpgrade.SetAthAddExpLimt = function(self, maxAddExp, addExp)
    -- function num : 0_5 , upvalues : _ENV
    for _, item in ipairs(self.growupItemList) do
        item:SetAddExpLimt(maxAddExp, addExp)
    end
end

UINAthMatUpgrade.GenAthMatExpAdd = function(self)
    -- function num : 0_6 , upvalues : _ENV
    local addExp = 0
    for itemData, num in pairs(self.lvUpMatItemDic) do
        addExp = addExp + itemData:GetActionArg(1) * num
    end
    if self.addExpFunc ~= nil then (self.addExpFunc)(addExp) end
end

UINAthMatUpgrade.GetAthMatExpAddItemDic =
    function(self)
        -- function num : 0_7 , upvalues : _ENV
        local itemDic = {}
        for itemData, num in pairs(self.lvUpMatItemDic) do
            itemDic[itemData.dataId] = num
        end
        return itemDic
    end

UINAthMatUpgrade.GetAthMatItemList = function(self)
    -- function num : 0_8
    return self.growupItemList
end

UINAthMatUpgrade.OnItemChange = function(self, itemUpdate)
    -- function num : 0_9 , upvalues : _ENV
    for k, v in ipairs((self.lvUpMatPool).listItem) do
        if itemUpdate[v:GetHeroLvUpItemId()] == false then
            self:RefreshAllAthMatItem()
            if self.refreshAthSlotAddExpFunc ~= nil then
                (self.refreshAthSlotAddExpFunc)()
            end
            break
        end
    end
end

UINAthMatUpgrade.OnDelete = function(self)
    -- function num : 0_10 , upvalues : _ENV, base
    (self.lvUpMatPool):DeleteAll()
    MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__onItemChange);
    (base.OnDelete)(self)
end

return UINAthMatUpgrade

