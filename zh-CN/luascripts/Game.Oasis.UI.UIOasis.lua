-- params : ...
-- function num : 0 , upvalues : _ENV
local UIOasis = class("UIOasis", UIBaseWindow)
local base = UIBaseWindow
local cs_UIMnager = CS.UIManager
local cs_Screen = (CS.UnityEngine).Screen
local cs_ResLoader = CS.ResLoader
local cs_MessageCommon = CS.MessageCommon
local UINResourceGroup = require("Game.CommonUI.ResourceGroup.UINResourceGroup")
local UIOasisSidle = require("Game.Oasis.UI.OasisSidle.UIOasisSidle")
local UINOasisAreaLock = require("Game.Oasis.UI.Area.UINOasisAreaLock")
local resourceItems = {1003, 1004}
UIOasis.ConstructQuest = nil
UIOasis.UpdrageQueset = nil
UIOasis.ConfirmOverQuest = nil
UIOasis.AccelerateEvent = nil
UIOasis.NewBuildingEvent = nil
UIOasis.BuildingLevelUpEvent = nil
UIOasis.EditModeEvent = nil
UIOasis.BackToHome = nil
UIOasis.CollectAllRes = nil
UIOasis.CloseDetailEvent = nil
UIOasis.OnInit = function(self)
    -- function num : 0_0 , upvalues : cs_ResLoader, _ENV, UINResourceGroup, resourceItems, UINOasisAreaLock
    self.resLoader = (cs_ResLoader.Create)();
    (UIUtil.CreateTopBtnGroup)((self.ui).topButtonGroup, self, self.__backToHome);
    (UIUtil.AddButtonListener)((self.ui).btn_HideUI, self, self.DisplayScreenUI);
    (UIUtil.AddButtonListener)((self.ui).btn_CancleHideUI, self,
                               self.DisplayScreenUI)
    self.isScreenUIShow = true;
    (UIUtil.AddButtonListener)((self.ui).btn_editMode, self,
                               self.OnClickEditModeButton);
    (UIUtil.AddButtonListener)((self.ui).btn_sector, self,
                               self.OnClickSectorButton);
    (UIUtil.AddButtonListener)((self.ui).btn_StationedOV, self,
                               self.OnStationedOVClick);
    (UIUtil.AddButtonListener)((self.ui).btn_sidebar, self,
                               self.OnClickSidebarButton)
    self.onSidleHideEvent = BindCallback(self, self.OnSidleHide)
    self.resourceGroup = (UINResourceGroup.New)();
    (self.resourceGroup):Init((self.ui).obj_resourceItem);
    (self.resourceGroup):SetResourceIds(resourceItems)
    self.updateProduce = BindCallback(self, self.__updateProduce)
    MsgCenter:AddListener(eMsgEventId.BuildingProduceUpdate, self.updateProduce)
    self.isShowLower = false
    self.__updateProcessEvent = BindCallback(self, self.UpdateProcessEvent)
    MsgCenter:AddListener(eMsgEventId.UpdateBuildingProcess,
                          self.__updateProcessEvent)
    self:InitRedDotOasisEvent()
    self:OnStationedUnlock(false)
    self:OnEditeBuildingUnlock(false)
    self.onCollectResClick = BindCallback(self, self.__onCollectResClick);
    ((self.ui).obj_Lock):SetActive(false)
    self.areaLockPool = (UIItemPool.New)(UINOasisAreaLock, (self.ui).obj_Lock)
    self.areaLockItemDic = {}
end

UIOasis.Initialize = function(self, buildingUIModel, sidleLoadedCallback)
    -- function num : 0_1 , upvalues : UIOasisSidle, _ENV
    self.buildingUIModel = buildingUIModel
    if self.sidleUI == nil then
        self.sidleUI = (UIOasisSidle.New)();
        (self.sidleUI):Init((self.ui).sidleUI);
        (self.sidleUI):SetHideEvent(self.onSidleHideEvent)
    end
    (self.sidleUI):InitializeSidle(self.buildingUIModel, self.resLoader,
                                   sidleLoadedCallback) -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.sidleUI).OpenSidleEvent =
        BindCallback(self, self.OnClickSidebarButton) -- DECOMPILER ERROR at PC30: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.sidleUI).NewBuildingEvent = self.NewBuildingEvent -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.sidleUI).BuildingLevelUpEvent = self.BuildingLevelUpEvent -- DECOMPILER ERROR at PC36: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.sidleUI).ConstructEvent = self.ConstructQuest -- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.sidleUI).UpdrageEvent = self.UpdrageQueset -- DECOMPILER ERROR at PC42: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.sidleUI).ConfirmOverEvent = self.ConfirmOverQuest -- DECOMPILER ERROR at PC45: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.sidleUI).AccelerateEvent = self.AccelerateEvent -- DECOMPILER ERROR at PC48: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.sidleUI).CloseDetailEvent = self.CloseDetailEvent
    self:OnClickSidebarButton()
end

UIOasis.UpdateAllOasisAreaLock = function(self, oasisAreaList)
    -- function num : 0_2 , upvalues : _ENV
    for areaId, area in ipairs(oasisAreaList) do
        local lockItem = (self.areaLockItemDic)[areaId]
        if lockItem == nil then
            lockItem = (self.areaLockPool):GetOne() -- DECOMPILER ERROR at PC13: Confused about usage of register: R8 in 'UnsetPending'
            ;
            (self.areaLockItemDic)[areaId] = lockItem
        end
        if area.lock then
            lockItem:Show()
            lockItem:UpdateOasisAreaLockPos((area.transform).position)
        else
            lockItem:Hide()
        end
    end
end

UIOasis.__updateProduce = function(self, id, resTabSort)
    -- function num : 0_3
    self:UpdateProduceUI2D(id, resTabSort)
end

UIOasis.UpdateProduceUI2D = function(self, id, resTabSort)
    -- function num : 0_4 , upvalues : _ENV
    if not self.isShowLower then
        self.isShowLower = true
        UIManager:ShowWindowAsync(UIWindowTypeID.CommonCollectRes, function(win)
            -- function num : 0_4_0 , upvalues : self
            win:SetCommonCollectRes(self.onCollectResClick);
            (win.transform):SetParent((self.ui).Tran_CommonResNode)
            win:Hide()
            self.CollectResWin = win
        end)
    end
    if self.CollectResWin == nil then return end
    (self.CollectResWin):Show();
    (self.CollectResWin):UpdateProduction(id, resTabSort)
end

UIOasis.__onCollectResClick = function(self, buildProduction)
    -- function num : 0_5 , upvalues : _ENV
    if self.CollectAllRes ~= nil then
        local collectResCallBack = BindCallback(self,
                                                self.__onCollectResCompleted,
                                                buildProduction);
        (self.CollectAllRes)(buildProduction, collectResCallBack)
    end
end

UIOasis.__onCollectResCompleted = function(self, buildProduction)
    -- function num : 0_6 , upvalues : _ENV, cs_MessageCommon
    for id, resTable in pairs(buildProduction) do
        local resCount = #resTable
        if resTable ~= nil and resCount > 0 then
            for i = 1, resCount do
                local item = (ConfigData.item)[(resTable[i]).id]
                if item ~= nil then
                    local msg = ConfigData:GetTipContent(
                                    TipContent.Building_GainReward) ..
                                    (LanguageUtil.GetLocaleText)(item.name) ..
                                    " x " .. tostring((resTable[i]).count);
                    (cs_MessageCommon.ShowMessageTips)(msg, true)
                end
            end
        end
    end
end

UIOasis.Update = function(self, timestamp, isSecond)
    -- function num : 0_7
    if self.sidleUI ~= nil then (self.sidleUI):Update(timestamp, isSecond) end
end

UIOasis.OnClickSidebarButton = function(self)
    -- function num : 0_8
    if self.isShowLower then
        (((self.ui).btn_sidebar).gameObject):SetActive(false);
        (self.sidleUI):OnSidleShow(true)
    end
end

UIOasis.OnSidleHide = function(self)
    -- function num : 0_9
    self:__backToHome()
end

UIOasis.ShowDetail = function(self, id)
    -- function num : 0_10
    local item = ((self.sidleUI).buildingUIItems)[id]
    if item ~= nil then (self.sidleUI):__createDetailItem(item) end
end

UIOasis.UpdateSidleUI = function(self, buildingData)
    -- function num : 0_11
    (self.sidleUI):UpdateItemUI(buildingData)
end

UIOasis.ShowTween = function(self, isShow, onCompleted)
    -- function num : 0_12 , upvalues : _ENV
    if isShow then
        UIManager:PlayFov(179, 30, 0.75, 0)
        UIManager:PlayDoFade((self.ui).canvasGroup, 0, 1, 0.75, onCompleted)
    else
        UIManager:PlayDoFade((self.ui).canvasGroup, 1, 0, 0.25, onCompleted)
    end
end

UIOasis.InitRedDotOasisEvent = function(self)
    -- function num : 0_13 , upvalues : _ENV
    local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main,
                                                    RedDotStaticTypeId.Oasis)
    if node:GetRedDotCount() <= 0 then
        ((self.ui).redDotSideBar):SetActive(not ok)
        self.__oasisBuildableRedDotEvent =
            function(node)
                -- function num : 0_13_0 , upvalues : self
                ((self.ui).redDotSideBar):SetActive(node:GetRedDotCount() > 0)
                -- DECOMPILER ERROR: 1 unprocessed JMP targets
            end

        RedDotController:AddListener(RedDotDynPath.OasisBuildListPath,
                                     self.__oasisBuildableRedDotEvent)
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
    end
end

UIOasis.RemoveRedDotOasisEvent = function(self)
    -- function num : 0_14 , upvalues : _ENV
    RedDotController:RemoveListener(RedDotDynPath.OasisBuildListPath,
                                    self.__oasisBuildableRedDotEvent)
end

UIOasis.InitUnlockFunction = function(self)
    -- function num : 0_15 , upvalues : _ENV
    local funcUnLockCrtl = ControllerManager:GetController(
                               ControllerTypeId.FunctionUnlock, true)
    self.sStationedUnlock = funcUnLockCrtl:ValidateUnlock(
                                proto_csmsg_SystemFunctionID.SystemFunctionID_HeroEnter)
    self:OnStationedUnlock(self.sStationedUnlock)
end

UIOasis.OnStationedUnlock = function(self, active)
    -- function num : 0_16
    ((self.ui).stationedNode):SetActive(active)
end

UIOasis.OnEditeBuildingUnlock = function(self, active)
    -- function num : 0_17
    (((self.ui).buttonGroupCanvas).gameObject):SetActive(active)
end

UIOasis.OnStationedOVClick = function(self)
    -- function num : 0_18 , upvalues : _ENV
    UIManager:ShowWindowAsync(UIWindowTypeID.HeroEnterOverView, function(window)
        -- function num : 0_18_0 , upvalues : self
        if window == nil then return end
        window:InitHeroEnterOverView(self.resloader)
    end)
end

UIOasis.OnClickEditModeButton = function(self)
    -- function num : 0_19
    if self.EditModeEvent ~= nil then (self.EditModeEvent)() end
end

UIOasis.OnClickSectorButton = function(self)
    -- function num : 0_20 , upvalues : _ENV
    UIManager:DeleteWindow(UIWindowTypeID.Oasis)
    UIManager:DeleteWindow(UIWindowTypeID.Home);
    ((CS.GSceneManager).Instance):LoadSceneAsyncByAB((Consts.SceneName).Sector,
                                                     function()
        -- function num : 0_20_0 , upvalues : _ENV
        if ExplorationManager:HasUncompletedEp() then
            (ControllerManager:GetController(ControllerTypeId.SectorController,
                                             true)):SetFrom(
                AreaConst.Exploration)
        else

            (ControllerManager:GetController(ControllerTypeId.SectorController,
                                             true)):SetFrom(AreaConst.Oasis)
        end
    end)
end

UIOasis.ShowMask = function(self, isShow)
    -- function num : 0_21
    ((self.ui).topMsk):SetActive(isShow)
end

UIOasis.OnShow = function(self)
    -- function num : 0_22 , upvalues : base
    (base.OnShow)(self)
    self:ShowTween(true)
    if self.isShowLower and self.CollectResWin ~= nil then
        (self.CollectResWin):ShowTween()
    end
end

UIOasis.Hide = function(self)
    -- function num : 0_23 , upvalues : _ENV, base
    self:ShowTween(false, BindCallback(self, base.Hide))
end

UIOasis.UpdateProcessEvent = function(self, id, progress, remainTimeText,
                                      waitConfirmOver, second)
    -- function num : 0_24
    (self.sidleUI):UpdateProcessEvent(id, progress, remainTimeText,
                                      waitConfirmOver, second)
end

UIOasis.__backToHome = function(self)
    -- function num : 0_25
    if self.BackToHome ~= nil then
        (self.BackToHome)()
        self.BackToHome = nil
    end
    return true
end

UIOasis.DisplayScreenUI = function(self)
    -- function num : 0_26 , upvalues : _ENV
    local queueWin = UIManager:GetWindow(UIWindowTypeID.BuildingQueue)
    if self.isScreenUIShow then
        self.isScreenUIShow = false -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).uiHideCanvas).alpha = 0
        -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

        if not (self.sidleUI).openedDetail then
            ((self.ui).uiHideCanvas).blocksRaycasts = false -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'
            ;
            ((CS.OasisCameraController).Instance).AbandonScale = true
        else

            (((self.ui).btn_CancleHideUI).gameObject):SetActive(true)
        end
        if queueWin ~= nil and queueWin.active and
            not (self.sidleUI).openedDetail then queueWin:Hide() end
    else
        -- DECOMPILER ERROR at PC44: Confused about usage of register: R2 in 'UnsetPending'


        ((self.ui).uiHideCanvas).alpha = 1 -- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((self.ui).uiHideCanvas).blocksRaycasts = true
        self.isScreenUIShow = true;
        (((self.ui).btn_CancleHideUI).gameObject):SetActive(false) -- DECOMPILER ERROR at PC58: Confused about usage of register: R2 in 'UnsetPending'
        ;
        ((CS.OasisCameraController).Instance).AbandonScale = false
        if queueWin ~= nil and not queueWin.active and
            not (self.sidleUI).openedDetail then queueWin:Show() end
    end
end

UIOasis.OnDelete = function(self)
    -- function num : 0_27 , upvalues : _ENV, base
    MsgCenter:RemoveListener(eMsgEventId.BuildingProduceUpdate,
                             self.updateProduce)
    MsgCenter:RemoveListener(eMsgEventId.UpdateBuildingProcess,
                             self.__updateProcessEvent)
    self:RemoveRedDotOasisEvent();
    (NetworkManager:GetNetwork(NetworkTypeID.Building)):OnRedDotBuildingTimerUpdate()
    UIManager:DeleteWindow(UIWindowTypeID.HeroEnterOverView)
    if self.resourceGroup ~= nil then (self.resourceGroup):Delete() end
    if self.resloader ~= nil then
        (self.resloader):Put2Pool()
        self.resloader = nil
    end
    if self.sidleUI ~= nil then (self.sidleUI):Delete() end
    if self.CollectResWin ~= nil then
        (self.CollectResWin):Delete()
        self.CollectResWin = nil
    end
    (self.areaLockPool):DeleteAll()
    self:ShowMask(false);
    (base.OnDelete)(self)
end

return UIOasis

