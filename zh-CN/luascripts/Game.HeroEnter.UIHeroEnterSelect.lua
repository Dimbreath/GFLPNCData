-- params : ...
-- function num : 0 , upvalues : _ENV
local UIHeroEnterSelect = class("UIHeroEnterSelect", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local UINHeroSortList = require("Game.Hero.SortList.UINHeroSortList")
local UINHeroEnterSlotItem = require("Game.HeroEnter.UINHeroEnterSlotItem")
local UINHeroEnterBuildingBuffInfo = require(
                                         "Game.HeroEnter.UINHeroEnterBuildingBuffInfo")
local UINHeroEnterLifeSkillInfo = require(
                                      "Game.HeroEnter.UINHeroEnterLifeSkillInfo")
local HeroEnterDataUtil = require("Game.HeroEnter.HeroEnterDataUtil")
UIHeroEnterSelect.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV, cs_ResLoader, UINHeroEnterSlotItem, UINHeroEnterBuildingBuffInfo, UINHeroEnterLifeSkillInfo
    self.enterNetwork = NetworkManager:GetNetwork(NetworkTypeID.HeroEnter)
    self.enterLimt = nil
    self.buildingID = nil
    self.enterSlotList = {}
    self.enterModifyId = nil
    self.heroSortListSelectedId = nil
    self.SelectedSlotIndex = nil
    self.bulidingLevel = nil
    self.validCampIds = {}
    self.enteredHeroList = {}
    self.buildingBuffList = {}
    self.heroLifeSkillDic = {};
    (UIUtil.AddButtonListener)((self.ui).btn_close, self, self.CloseClicked);
    (UIUtil.AddButtonListener)((self.ui).btn_Cancle, self, self.Uninstall);
    (UIUtil.AddButtonListener)((self.ui).btn_Confirm, self, self.ConfirmClicked)
    self.resloader = (cs_ResLoader.Create)()
    self.selectHeroFunc = BindCallback(self, self.__SelectHeroFunc)
    self.fliterHeroFunc = BindCallback(self, self.__FliterHeroFunc)
    self.HeroEnterSlotPool = (UIItemPool.New)(UINHeroEnterSlotItem,
                                              (self.ui).obj_heroStationedItem);
    ((self.ui).obj_heroStationedItem):SetActive(false)
    self.buildingBuffPool = (UIItemPool.New)(UINHeroEnterBuildingBuffInfo,
                                             (self.ui).obj_buildingBuffInfo);
    ((self.ui).obj_buildingBuffInfo):SetActive(false)
    self.heroLifeSkillPool = (UIItemPool.New)(UINHeroEnterLifeSkillInfo,
                                              (self.ui).obj_EffectDetail);
    ((self.ui).obj_EffectDetail):SetActive(false)
    self.__RefreshEnteredHeroFunc = BindCallback(self,
                                                 self.RefreshEnteredHeroFunc)
    MsgCenter:AddListener(eMsgEventId.OnHeroEnterDataUpdate,
                          self.__RefreshEnteredHeroFunc)
end

UIHeroEnterSelect.InitHeroEnterSelect = function(self, enterLimt, buildingID,
                                                 enterSlotList, enterModifyId)
    -- function num : 0_1 , upvalues : UINHeroSortList
    self.enterLimt = enterLimt
    self.buildingID = buildingID
    self.enterSlotList = enterSlotList
    self.enterModifyId = enterModifyId
    self:ShowBuildingInfo()
    self:CreateBuffItems(buildingID)
    self.panelSortList = (UINHeroSortList.New)();
    (self.panelSortList):Init((self.ui).obj_heroSortListNode);
    (self.panelSortList):InitHeroSortList(self.resloader, self.selectHeroFunc,
                                          self.fliterHeroFunc, nil, true);
    (self.panelSortList):RefreshHeroList()
    self:RefreshEnteredHeroFunc()
    self:RefreshSlot()
end

UIHeroEnterSelect.RefreshEnteredHeroFunc =
    function(self)
        -- function num : 0_2 , upvalues : _ENV
        self.enteredHeroList = {}
        local allEnterData = PlayerDataCenter.allEnterData
        for bID, v in pairs(allEnterData) do
            for hID, _ in pairs(v.data) do
                (table.insert)(self.enteredHeroList, hID)
            end
        end
        (self.panelSortList):SetEnteredHero(self.enteredHeroList)
    end

UIHeroEnterSelect.__SelectHeroFunc = function(self, heroData)
    -- function num : 0_3 , upvalues : HeroEnterDataUtil
    local selectedHeroId = ((self.enterSlotList)[self.enterModifyId]).heroID
    if heroData == nil then
        self.heroSortListSelectedId = nil
        self:ShowBuff(HeroEnterDataUtil:CalRateById(selectedHeroId))
    else
        self.heroSortListSelectedId = (heroData.heroCfg).id
        if ((self.enterSlotList)[self.enterModifyId]).heroID ~=
            self.heroSortListSelectedId then
            self:ShowBuff(HeroEnterDataUtil:CalRateById(selectedHeroId),
                          HeroEnterDataUtil:CalRateById(
                              self.heroSortListSelectedId))
        else
            self:ShowBuff(HeroEnterDataUtil:CalRateById(selectedHeroId))
        end
    end
    self:RefreshLifeSkill()
end

UIHeroEnterSelect.__FliterHeroFunc = function(self, dataId, heroData)
    -- function num : 0_4 , upvalues : _ENV
    for _, value in pairs(self.validCampIds) do
        if (heroData.heroCfg).camp == value then return true end
    end
    return false
end

UIHeroEnterSelect.SelectHeroInSortedList =
    function(self, heroID)
        -- function num : 0_5 , upvalues : _ENV
        self.heroSortListSelectedId = heroID;
        (self.panelSortList):__OnHeroItemClicked(
            (PlayerDataCenter.heroDic)[heroID])
    end

UIHeroEnterSelect.ShowBuildingInfo = function(self)
    -- function num : 0_6 , upvalues : _ENV
    if self.buildingID == nil then
        error("没有要入住的建筑物的ID!")
        return
    end -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'
    
    ((self.ui).tex_BuildName).text = (LanguageUtil.GetLocaleText)(
                                         ((ConfigData.building)[self.buildingID]).name)
    for k, v in pairs((PlayerDataCenter.AllBuildingData).built) do
        if v.id == self.buildingID then
            self.bulidingLevel = v.level
            break
        end
    end
    do
        self.validCampIds = ((ConfigData.building)[self.buildingID]).camp_limit
        local limtText = ""
        for index, value in ipairs(self.validCampIds) do
            limtText = limtText ..
                           (LanguageUtil.GetLocaleText)(
                               ((ConfigData.camp)[value]).name)
        end
        ((self.ui).tex_Condition):SetIndex(0, limtText)
    end
end

UIHeroEnterSelect.CreateBuffItems = function(self, buildingID)
    -- function num : 0_7 , upvalues : _ENV
    local buildingData =
        ((PlayerDataCenter.AllBuildingData).oasisBuilt)[buildingID]
    if buildingData == nil then
        error("无建筑数据" .. buildingID)
        return
    end
    local level = buildingData.level
    local levelBuffCfg = ((ConfigData.buildingLevel)[buildingID])[level]
    for i = 1, #levelBuffCfg.buff_logic do
        local buffItem = (self.buildingBuffPool):GetOne(true)
        buffItem:InitBuff(levelBuffCfg, i);
        (table.insert)(self.buildingBuffList, buffItem)
    end
end

UIHeroEnterSelect.RefreshSlot = function(self)
    -- function num : 0_8 , upvalues : UINHeroEnterSlotItem, _ENV
    UINHeroEnterSlotItem:cleanStaticAllSlots();
    (self.HeroEnterSlotPool):HideAll()
    if self.enterSlotList == nil or #self.enterSlotList == 0 then
        error("槽的显示有问题")
        return
    end
    for index, data in ipairs(self.enterSlotList) do
        do
            local slot = (self.HeroEnterSlotPool):GetOne(true)
            slot:InitHeroEnterSlot(self.resloader, data.isUnlock, data.heroID,
                                   true)
            slot:SetSlotClickEvent(function(isUnlock, heroID)
                -- function num : 0_8_0 , upvalues : self, index
                if isUnlock then
                    self.SelectedSlotIndex = index
                    self:SelectHeroInSortedList(heroID)
                end
            end)
            if index == self.enterModifyId then slot:OnSlotClick() end
        end
    end
end

UIHeroEnterSelect.ConfirmClicked = function(self)
    -- function num : 0_9 , upvalues : _ENV
    if (table.contain)(self.enteredHeroList, self.heroSortListSelectedId) then
        if self.heroSortListSelectedId ==
            ((self.enterSlotList)[self.SelectedSlotIndex]).heroID then
            return
        end
        ((CS.MessageCommon).ShowMessageBox)(
            ConfigData:GetTipContent(
                TipContent.heroEnter_HasEnteredOtherBuilding), function()
                -- function num : 0_9_0 , upvalues : self
                (self.enterNetwork):CS_STATION_Uninstall(
                    self.heroSortListSelectedId)
                self:InstallHero()
            end, function()
                -- function num : 0_9_1
                return
            end)
    else
        self:InstallHero()
    end
end

UIHeroEnterSelect.InstallHero = function(self)
    -- function num : 0_10
    if self.heroSortListSelectedId == nil then return end
    if ((self.enterSlotList)[self.SelectedSlotIndex]).heroID ~= nil then
        (self.enterNetwork):CS_STATION_Uninstall(
            ((self.enterSlotList)[self.SelectedSlotIndex]).heroID, function()
                -- function num : 0_10_0 , upvalues : self
                (self.enterNetwork):CS_STATION_Install(
                    self.heroSortListSelectedId, self.buildingID, function()
                        -- function num : 0_10_0_0 , upvalues : self
                        -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

                        ((self.enterSlotList)[self.SelectedSlotIndex]).heroID =
                            self.heroSortListSelectedId
                        self.enterModifyId = self.SelectedSlotIndex
                        self:RefreshSlot()
                    end)
            end)
    else

        (self.enterNetwork):CS_STATION_Install(self.heroSortListSelectedId,
                                               self.buildingID, function()
            -- function num : 0_10_1 , upvalues : self
            -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

            ((self.enterSlotList)[self.SelectedSlotIndex]).heroID =
                self.heroSortListSelectedId
            self.enterModifyId = self.SelectedSlotIndex
            self:RefreshSlot()
        end)
    end
end

UIHeroEnterSelect.Uninstall = function(self)
    -- function num : 0_11
    if ((self.enterSlotList)[self.SelectedSlotIndex]).heroID ~= nil then
        (self.enterNetwork):CS_STATION_Uninstall(
            ((self.enterSlotList)[self.SelectedSlotIndex]).heroID, function()
                -- function num : 0_11_0 , upvalues : self
                -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

                ((self.enterSlotList)[self.SelectedSlotIndex]).heroID = nil
                self.enterModifyId = self.SelectedSlotIndex
                self:RefreshSlot()
            end)
    end
end

UIHeroEnterSelect.ShowBuff = function(self, heroScoreRate, newHroScoreRate)
    -- function num : 0_12 , upvalues : _ENV
    for _, buffItem in pairs(self.buildingBuffList) do
        buffItem:SetValue(heroScoreRate, newHroScoreRate)
    end
end

UIHeroEnterSelect.RefreshLifeSkill = function(self)
    -- function num : 0_13 , upvalues : _ENV
    for slotIndex, slotInfo in pairs(self.enterSlotList) do
        local heroData = (PlayerDataCenter.heroDic)[slotInfo.heroID]
        do
            local lifeSkillData = {}
            local isHeroHaveLifeSkill = function(skillDic, isNew)
                -- function num : 0_13_0 , upvalues : _ENV, lifeSkillData
                for key, skilldata in pairs(skillDic) do
                    if skilldata.type == eHeroSkillType.LifeSkill then
                        if isNew then
                            lifeSkillData.new = skilldata
                        else
                            lifeSkillData.old = skilldata
                        end
                        return true
                    end
                end
                return false
            end;
            (self.heroLifeSkillPool):HideAll()
            if self.SelectedSlotIndex == slotIndex and
                self.heroSortListSelectedId ~= slotInfo.heroID then
                local selectHeroData =
                    (PlayerDataCenter.heroDic)[self.heroSortListSelectedId]
                if selectHeroData then
                    local temp = isHeroHaveLifeSkill(selectHeroData.skillDic,
                                                     true)
                end
                if (heroData and isHeroHaveLifeSkill(heroData.skillDic)) or temp then
                    local item = (self.heroLifeSkillPool):GetOne(true)
                    item:InitLifeSkill(lifeSkillData.old, lifeSkillData.new,
                                       self.resloader)
                end
            else
                do
                    if heroData and isHeroHaveLifeSkill(heroData.skillDic) then
                        local item = (self.heroLifeSkillPool):GetOne(true)
                        item:InitLifeSkill(lifeSkillData.old, nil,
                                           self.resloader)
                    end
                end
            end
            do
                -- DECOMPILER ERROR at PC66: LeaveBlock: unexpected jumping out DO_STMT

            end
        end
    end
end

UIHeroEnterSelect.CloseClicked = function(self)
    -- function num : 0_14 , upvalues : UINHeroEnterSlotItem, _ENV
    UINHeroEnterSlotItem:cleanStaticAllSlots();
    (self.panelSortList):OnDelete()
    UIManager:DeleteWindow(UIWindowTypeID.HeroEnter)
    MsgCenter:RemoveListener(eMsgEventId.OnHeroEnterDataUpdate,
                             self.__RefreshEnteredHeroFunc)
end

UIHeroEnterSelect.OnDelete = function(self)
    -- function num : 0_15 , upvalues : base
    (base.OnDelete)(self)
end

return UIHeroEnterSelect

