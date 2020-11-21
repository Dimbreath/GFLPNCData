-- params : ...
-- function num : 0 , upvalues : _ENV
local UINDungeonHeroList = class("UINDungeonHeroList", UIBaseNode)
local base = UIBaseNode
local UINDungeonHeroItem = require(
                               "Game.CommonUI.DungeonState.UINDungeonHeroItem")
UINDungeonHeroList.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, UINDungeonHeroItem
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
    self.itemPool = (UIItemPool.New)(UINDungeonHeroItem, (self.ui).heroItem);
    ((self.ui).heroItem):SetActive(false)
    self.lastSelectItem = nil
    self.isHideHero = false
    self.HpChaged = false
    self.reviveCount = 0
    self.selectWithChipIdCallback =
        BindCallback(self, self.SelectHeroWithChipId)
    self.__DeselectCallback = BindCallback(self, self.DeselectHero)
    self.__SelectNextCallback = BindCallback(self, self.SelectNext)
    self.__onHeroDataChange = BindCallback(self, self.OnHeroDataChange)
    MsgCenter:AddListener(eMsgEventId.OnEpPlayerHeroDataChange,
                          self.__onHeroDataChange)
    self.__DelayRefreshHeroHp = BindCallback(self, self.DelayRefreshHeroHp)
    MsgCenter:AddListener(eMsgEventId.OnExitRoomComplete,
                          self.__DelayRefreshHeroHp)
    self.__onChipListChange = BindCallback(self, self.OnChipListUpdata)
    MsgCenter:AddListener(eMsgEventId.OnEpChipListChange,
                          self.__onChipListChange)
    self.__OnHeroCoordChanged = BindCallback(self, self.OnHeroCoordChanged)
    MsgCenter:AddListener(eMsgEventId.OnDeployCoordChanged,
                          self.__OnHeroCoordChanged)
    self.__IsRevive = BindCallback(self, self.IsRevive)
    MsgCenter:AddListener(eMsgEventId.OnEpBuffListChange, self.__IsRevive)
end

UINDungeonHeroList.InitHeroList = function(self, heroList, resloader,
                                           selectHeroCallback, buffList)
    -- function num : 0_1 , upvalues : _ENV
    self.selectHeroCallback = selectHeroCallback
    self.heroList = heroList
    self.resloader = resloader;
    (self.itemPool):HideAll()
    for _, dynHeroData in ipairs(self.heroList) do
        local heroItem = (self.itemPool):GetOne(true)
        do
            heroItem:InitHeroItem(dynHeroData, self.resloader, function()
                -- function num : 0_1_0 , upvalues : self, heroItem
                self:OnHeroClick(heroItem)
            end)
        end
    end
    self:OnHeroCoordChanged()
    self:IsRevive(buffList)
end

UINDungeonHeroList.OnHeroCoordChanged = function(self)
    -- function num : 0_2 , upvalues : _ENV
    for _, Item in ipairs((self.itemPool).listItem) do
        if not (Item.dynHeroData):IsBench() or not (self.ui).tran_sub then
            do
                (Item.transform):SetParent((self.ui).tran_main)
                -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_STMT

            end
        end
    end
end

UINDungeonHeroList.OnHeroDataChange = function(self)
    -- function num : 0_3 , upvalues : _ENV
    for _, item in ipairs((self.itemPool).listItem) do
        item:PlayHpChangeAnim()
    end
end

UINDungeonHeroList.DelayRefreshHeroHp = function(self)
    -- function num : 0_4 , upvalues : _ENV
    if self.OnRevive then
        for _, item in ipairs((self.itemPool).listItem) do
            item:PlayHpChangeAnim()
        end
        self.OnRevive = false
    end
end

UINDungeonHeroList.IsRevive = function(self, epBuffList)
    -- function num : 0_5 , upvalues : _ENV
    local count = 0
    for _, value in ipairs(epBuffList) do
        if value.dataId == 7001 then count = count + 1 end
    end
    if self.reviveCount < count then
        self.reviveCount = count
    else
        if count < self.reviveCount then
            self.reviveCount = count
            self.OnRevive = true
            for _, item in ipairs((self.itemPool).listItem) do
                item:FakeDead()
            end
        end
    end
end

UINDungeonHeroList.RefreshHeroHp = function(self)
    -- function num : 0_6 , upvalues : _ENV
    for _, item in ipairs((self.itemPool).listItem) do item:RefreshHp(true) end
end

UINDungeonHeroList.OnChipListUpdata = function(self)
    -- function num : 0_7 , upvalues : _ENV
    for _, item in ipairs((self.itemPool).listItem) do item:UpdateChipList() end
end

UINDungeonHeroList.SetDeployStation = function(self, bool)
    -- function num : 0_8
    self.isHideHero = bool
    if bool then
        self:Hide()
    else
        self:Show()
    end
end

UINDungeonHeroList.SetHpBarActive = function(self, bool)
    -- function num : 0_9 , upvalues : _ENV
    for _, item in ipairs((self.itemPool).listItem) do
        item:SetHpBarActive(bool)
    end
end

UINDungeonHeroList.OnHeroClick = function(self, heroItem)
    -- function num : 0_10 , upvalues : _ENV
    if self.lastSelectItem == heroItem then return end
    if self.lastSelectItem ~= nil then (self.lastSelectItem):SetSelect(false) end
    heroItem:SetSelect(true)
    self.lastSelectItem = heroItem;
    (self.selectHeroCallback)(heroItem)
    local win = UIManager:ShowWindow(UIWindowTypeID.DungeonInfoDetail)
    win:ShowHeroDetail(heroItem.dynHeroData, self.__DeselectCallback,
                       self.__SelectNextCallback)
end

UINDungeonHeroList.SelectNext = function(self, bool)
    -- function num : 0_11 , upvalues : _ENV
    if self.lastSelectItem == nil then
        error("switch hero error")
        return
    end
    local index = (table.indexof)((self.itemPool).listItem, self.lastSelectItem)
    local listNum = #(self.itemPool).listItem
    if bool then
        index = index + 1
        if listNum < index then index = 1 end
    else
        index = index - 1
        if index <= 0 then index = listNum end
    end
    self:OnHeroClick(((self.itemPool).listItem)[index])
end

UINDungeonHeroList.DeselectHero = function(self)
    -- function num : 0_12
    if self.lastSelectItem ~= nil then
        (self.lastSelectItem):SetSelect(false)
        self.lastSelectItem = nil
    end
    (self.selectHeroCallback)(nil)
    if self.isHideHero then self:Hide() end
end

UINDungeonHeroList.SelectHeroWithChipId =
    function(self, chipId, chipColor)
        -- function num : 0_13 , upvalues : _ENV
        if chipId == nil then
            if self.isHideHero then self:Hide() end
            for _, item in ipairs((self.itemPool).listItem) do
                item:SetChipSelect(false)
                item:SetTransparent(false)
            end
            return
        end
        if self.isHideHero then self:Show() end
        for _, item in ipairs((self.itemPool).listItem) do
            if (table.contain)(item.chipList, chipId) then
                item:SetChipSelect(true, chipColor)
                item:SetTransparent(false)
            else
                item:SetChipSelect(false)
                item:SetTransparent(true)
            end
        end
    end

UINDungeonHeroList.OnDelete = function(self)
    -- function num : 0_14 , upvalues : _ENV, base
    MsgCenter:RemoveListener(eMsgEventId.OnEpPlayerHeroDataChange,
                             self.__onHeroDataChange)
    MsgCenter:RemoveListener(eMsgEventId.OnEpChipListChange,
                             self.__onChipListChange)
    MsgCenter:RemoveListener(eMsgEventId.OnDeployCoordChanged,
                             self.__OnHeroCoordChanged)
    MsgCenter:RemoveListener(eMsgEventId.OnExitRoomComplete,
                             self.__DelayRefreshHeroHp)
    MsgCenter:RemoveListener(eMsgEventId.OnEpBuffListChange, self.__IsRevive)
    for _, item in ipairs((self.itemPool).listItem) do item:Delete() end
    (base.OnDelete)(self)
end

return UINDungeonHeroList

