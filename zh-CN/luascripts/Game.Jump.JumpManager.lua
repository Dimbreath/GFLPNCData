-- params : ...
-- function num : 0 , upvalues : _ENV
local JumpManager = {}
local FuncArray = {}
local funcUnLockCrtl = nil
JumpManager.eJumpTarget = {
    ShopInvest = 1,
    ShopResident = 2,
    ShopVariable = 3,
    LotteryNormal = 4,
    LotteryAdvanced = 5,
    Mail = 6,
    Hero = 7,
    Sector = 8,
    Oasis = 9,
    Factory = 10,
    DaliyTask = 11,
    WeeklyTask = 12,
    MainTask = 13,
    SideTask = 14,
    Achieve4Cultivate = 15,
    Achieve4Commander = 16,
    Achieve4Dungeon = 17,
    Achieve4System = 18,
    Achieve4Oasis = 19,
    BuyStamina = 20,
    OasisBuilding = 100,
    SectorBuilding = 101,
    fragDungeon = 102,
    resourceDungeon = 103
}
JumpManager.Init = function(self)
    -- function num : 0_0 , upvalues : _ENV, FuncArray, JumpManager
    local config = ConfigData.system_jump
    FuncArray[(JumpManager.eJumpTarget).ShopInvest] =
        BindCallback(self, self.Jump2Shop,
                     (config[(JumpManager.eJumpTarget).ShopInvest]).jump_arg)
    FuncArray[(JumpManager.eJumpTarget).ShopResident] =
        BindCallback(self, self.Jump2Shop,
                     (config[(JumpManager.eJumpTarget).ShopResident]).jump_arg)
    FuncArray[(JumpManager.eJumpTarget).ShopVariable] =
        BindCallback(self, self.Jump2Shop,
                     (config[(JumpManager.eJumpTarget).ShopVariable]).jump_arg)
    FuncArray[(JumpManager.eJumpTarget).LotteryNormal] =
        BindCallback(self, self.Jump2Lottery, true)
    FuncArray[(JumpManager.eJumpTarget).LotteryAdvanced] =
        BindCallback(self, self.Jump2Lottery, false)
    FuncArray[(JumpManager.eJumpTarget).Mail] =
        BindCallback(self, self.Jump2Mail)
    FuncArray[(JumpManager.eJumpTarget).Hero] =
        BindCallback(self, self.Jump2Hro)
    FuncArray[(JumpManager.eJumpTarget).Sector] =
        BindCallback(self, self.Jump2Sector)
    FuncArray[(JumpManager.eJumpTarget).Oasis] =
        BindCallback(self, self.Jump2Oasis)
    FuncArray[(JumpManager.eJumpTarget).Factory] =
        BindCallback(self, self.Jump2Factory)
    FuncArray[(JumpManager.eJumpTarget).DaliyTask] =
        BindCallback(self, self.Jump2Task,
                     (config[(JumpManager.eJumpTarget).DaliyTask]).jump_arg)
    FuncArray[(JumpManager.eJumpTarget).WeeklyTask] =
        BindCallback(self, self.Jump2Task,
                     (config[(JumpManager.eJumpTarget).WeeklyTask]).jump_arg)
    FuncArray[(JumpManager.eJumpTarget).MainTask] =
        BindCallback(self, self.Jump2Task,
                     (config[(JumpManager.eJumpTarget).MainTask]).jump_arg)
    FuncArray[(JumpManager.eJumpTarget).SideTask] =
        BindCallback(self, self.Jump2Task,
                     (config[(JumpManager.eJumpTarget).SideTask]).jump_arg)
    FuncArray[(JumpManager.eJumpTarget).Achieve4Cultivate] =
        BindCallback(self, self.Jump2Achievement,
                     (config[(JumpManager.eJumpTarget).Achieve4Cultivate]).jump_arg)
    FuncArray[(JumpManager.eJumpTarget).Achieve4Commander] =
        BindCallback(self, self.Jump2Achievement,
                     (config[(JumpManager.eJumpTarget).Achieve4Commander]).jump_arg)
    FuncArray[(JumpManager.eJumpTarget).Achieve4Dungeon] =
        BindCallback(self, self.Jump2Achievement,
                     (config[(JumpManager.eJumpTarget).Achieve4Dungeon]).jump_arg)
    FuncArray[(JumpManager.eJumpTarget).Achieve4System] =
        BindCallback(self, self.Jump2Achievement,
                     (config[(JumpManager.eJumpTarget).Achieve4System]).jump_arg)
    FuncArray[(JumpManager.eJumpTarget).Achieve4Oasis] =
        BindCallback(self, self.Jump2Achievement,
                     (config[(JumpManager.eJumpTarget).Achieve4Oasis]).jump_arg)
    FuncArray[(JumpManager.eJumpTarget).BuyStamina] =
        BindCallback(self, self.Jump2BuyStamina)
    FuncArray[(JumpManager.eJumpTarget).OasisBuilding] =
        BindCallback(self, self.Jump2OasisBuilding)
    FuncArray[(JumpManager.eJumpTarget).SectorBuilding] =
        BindCallback(self, self.Jump2SectorBuilding)
    FuncArray[(JumpManager.eJumpTarget).fragDungeon] =
        BindCallback(self, self.Jump2SectorFragDungeon)
    FuncArray[(JumpManager.eJumpTarget).resourceDungeon] =
        BindCallback(self, self.Jump2SectorResourceDungeon)
end

JumpManager.Jump = function(self, jumpType, jumpOverCallback, argList)
    -- function num : 0_1 , upvalues : funcUnLockCrtl, _ENV, FuncArray
    if funcUnLockCrtl == nil then
        funcUnLockCrtl = ControllerManager:GetController(
                             ControllerTypeId.FunctionUnlock, true)
    end
    local num = nil
    if type(jumpType) == "string" then
        if (string.IsNullOrEmpty)(jumpType) then return end
        num = tonumber(jumpType)
    else
        if type(jumpType) == "number" then
            num = jumpType
        else
            return
        end
    end
    if FuncArray[num] == nil then return end
    (FuncArray[num])(jumpOverCallback, argList)
end

JumpManager.Jump2Shop = function(self, shopid, jumpOverCallback)
    -- function num : 0_2 , upvalues : funcUnLockCrtl, _ENV
    local isShopUnlock = funcUnLockCrtl:ValidateUnlock(
                             proto_csmsg_SystemFunctionID.SystemFunctionID_Store)
    if not isShopUnlock then return end
    UIManager:ShowWindowAsync(UIWindowTypeID.Shop, function(win)
        -- function num : 0_2_0 , upvalues : shopid, jumpOverCallback
        if win ~= nil then
            win:InitShopTogList(shopid)
            if jumpOverCallback ~= nil then jumpOverCallback() end
        end
    end)
end

JumpManager.Jump2Lottery = function(self, isNormal, jumpOverCallback)
    -- function num : 0_3 , upvalues : funcUnLockCrtl, _ENV
    local isLotteryUnlock = funcUnLockCrtl:ValidateUnlock(
                                proto_csmsg_SystemFunctionID.SystemFunctionID_Lottery)
    if not isLotteryUnlock then return end
    UIManager:ShowWindowAsync(UIWindowTypeID.LotteryWindow, function(win)
        -- function num : 0_3_0 , upvalues : isNormal, jumpOverCallback
        if win ~= nil then
            if not isNormal then
                (((win.ui).typeFirst).onValueChanged):Invoke(true) -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'
                ;
                ((win.ui).typeFirst).isOn = true -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'
                ;
                ((win.ui).typeSecond).isOn = false
            else

                (((win.ui).typeSecond).onValueChanged):Invoke(true) -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'
                ;
                ((win.ui).typeFirst).isOn = false -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'
                ;
                ((win.ui).typeSecond).isOn = true
            end
            if jumpOverCallback ~= nil then jumpOverCallback() end
        end
    end)
end

JumpManager.Jump2Mail = function(self, jumpOverCallback)
    -- function num : 0_4 , upvalues : funcUnLockCrtl, _ENV
    local isShopUnlock = funcUnLockCrtl:ValidateUnlock(
                             proto_csmsg_SystemFunctionID.SystemFunctionID_Store)
    if not isShopUnlock then return false end
    UIManager:ShowWindowAsync(UIWindowTypeID.Mail, function(win)
        -- function num : 0_4_0 , upvalues : jumpOverCallback
        if win ~= nil and jumpOverCallback ~= nil then jumpOverCallback() end
    end)
end

JumpManager.Jump2Hro = function(self, jumpOverCallback)
    -- function num : 0_5 , upvalues : funcUnLockCrtl, _ENV
    local isHeroListUnlock = funcUnLockCrtl:ValidateUnlock(
                                 proto_csmsg_SystemFunctionID.SystemFunctionID_HeroGroup)
    if not isHeroListUnlock then return end
    local Home = UIManager:GetWindow(UIWindowTypeID.Home)
    Home:OnHeroListClicked()
    if jumpOverCallback ~= nil then jumpOverCallback() end
end

JumpManager.Jump2Sector = function(self, jumpOverCallback)
    -- function num : 0_6 , upvalues : _ENV
    local Home = UIManager:GetWindow(UIWindowTypeID.Home)
    Home:OnBtnSectorClicked()
    if jumpOverCallback ~= nil then jumpOverCallback() end
end

JumpManager.Jump2Oasis = function(self, jumpOverCallback)
    -- function num : 0_7 , upvalues : funcUnLockCrtl, _ENV
    local isOasisUnlock = funcUnLockCrtl:ValidateUnlock(
                              proto_csmsg_SystemFunctionID.SystemFunctionID_Building)
    if not isOasisUnlock then return end
    local Home = UIManager:GetWindow(UIWindowTypeID.Home)
    Home:OnBtnOasisClicked()
    if jumpOverCallback ~= nil then jumpOverCallback() end
end

JumpManager.Jump2Factory = function(self, jumpOverCallback)
    -- function num : 0_8 , upvalues : funcUnLockCrtl, _ENV
    local isFactoryUnlock = funcUnLockCrtl:ValidateUnlock(
                                proto_csmsg_SystemFunctionID.SystemFunctionID_Factory)
    if not isFactoryUnlock then return end
    UIManager:ShowWindowAsync(UIWindowTypeID.Factory, function(win)
        -- function num : 0_8_0 , upvalues : jumpOverCallback
        if win ~= nil and jumpOverCallback ~= nil then jumpOverCallback() end
    end)
end

JumpManager.Jump2Task = function(self, taskTypeID, jumpOverCallback)
    -- function num : 0_9 , upvalues : funcUnLockCrtl, _ENV
    local isTaskUIUnlock = funcUnLockCrtl:ValidateUnlock(
                               proto_csmsg_SystemFunctionID.SystemFunctionID_TaskUi)
    if not isTaskUIUnlock then return end
    local taskController = ControllerManager:GetController(
                               ControllerTypeId.Task, true)
    taskController:ShowTaskUI(taskTypeID, jumpOverCallback)
end

JumpManager.Jump2Achievement = function(self, achievementTypeID,
                                        jumpOverCallback)
    -- function num : 0_10 , upvalues : _ENV
    UIManager:ShowWindowAsync(UIWindowTypeID.Achievement, function(win)
        -- function num : 0_10_0 , upvalues : _ENV, achievementTypeID
        for key, value in pairs(win.achivTypeToggleDic) do
            if key == achievementTypeID then
                (((value.ui).toggle).onValueChanged):Invoke(true) -- DECOMPILER ERROR at PC15: Confused about usage of register: R6 in 'UnsetPending'
                ;
                ((value.ui).toggle).isOn = true
            else
                -- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'


                ((value.ui).toggle).isOn = false
            end
        end
    end)
end

JumpManager.Jump2BuyStamina = function(self, jumpOverCallback)
    -- function num : 0_11 , upvalues : _ENV
    local ShopEnum = require("Game.Shop.ShopEnum")
    local quickBuyData = (ShopEnum.eQuickBuy).stamina
    local shopId = quickBuyData.shopId
    local shelfId = quickBuyData.shelfId
    local goodData = nil
    local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
    if not ctrl.isUnlocked then
        ((CS.MessageCommon).ShowMessageTips)(
            ConfigData:GetTipContent(TipContent.notUnlockShopCantBuyStamina))
        return
    end
    ctrl:GetShopData(shopId, function(shopData)
        -- function num : 0_11_0 , upvalues : goodData, shelfId, _ENV, jumpOverCallback, quickBuyData
        goodData = (shopData.shopGoodsDic)[shelfId]
        UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
            -- function num : 0_11_0_0 , upvalues : _ENV, jumpOverCallback, goodData, quickBuyData
            if win == nil then
                error("can\'t open QuickBuy win")
                if jumpOverCallback ~= nil then
                    jumpOverCallback()
                end
                return
            end
            win:SlideIn()
            win:InitBuyTarget(goodData, nil, true, quickBuyData.resourceIds)
            if jumpOverCallback ~= nil then jumpOverCallback() end
        end)
    end)
end

JumpManager.Jump2OasisBuilding = function(self, jumpOverCallback, argList)
    -- function num : 0_12 , upvalues : funcUnLockCrtl, _ENV
    local isOasisUnlock = funcUnLockCrtl:ValidateUnlock(
                              proto_csmsg_SystemFunctionID.SystemFunctionID_Building)
    if not isOasisUnlock then return end
    local buildId = argList[1]
    local oasisController = ControllerManager:GetController(
                                ControllerTypeId.OasisController, false)
    if (oasisController.buildingItems)[buildId] == nil then return end
    local Oasis = UIManager:GetWindow(UIWindowTypeID.Oasis)
    if Oasis ~= nil then
        oasisController:BuildingUpgrade(buildId)
        return
    else
        local Home = UIManager:GetWindow(UIWindowTypeID.Home)
        if Home == nil then return end
        oasisController:InjectJumpEvent(function()
            -- function num : 0_12_0 , upvalues : oasisController, buildId
            oasisController:BuildingUpgrade(buildId, true)
        end)
        Home:OnBtnOasisClicked()
        if jumpOverCallback ~= nil then jumpOverCallback() end
    end
end

JumpManager.Jump2SectorBuilding = function(self, jumpOverCallback, argList)
    -- function num : 0_13 , upvalues : _ENV
    local sectorId = argList[1]
    if sectorId == nil then
        error("bad jump arg Jump2SectorBuilding sectorId:" .. tostring(sectorId))
        return
    end
    local Home = UIManager:GetWindow(UIWindowTypeID.Home)
    if Home == nil then return end
    Home.enterSectorJumpCallback = BindCallback(self, function()
        -- function num : 0_13_0 , upvalues : _ENV, sectorId
        local sectorController = ControllerManager:GetController(
                                     ControllerTypeId.SectorController, false)
        if sectorController == nil then
            error("can\'t get sectorController")
            return
        end
        local EnterBuilding = function()
            -- function num : 0_13_0_0 , upvalues : sectorController, sectorId, EnterBuilding
            sectorController:StartBuildFocusEnter(sectorId);
            (sectorController.homeToSectorDirector):stopped("-", EnterBuilding)
        end;
        (sectorController.homeToSectorDirector):stopped("+", EnterBuilding)
    end)
    Home:OnBtnSectorClicked()
    if jumpOverCallback ~= nil then jumpOverCallback() end
end

JumpManager.Jump2SectorFragDungeon = function(self, jumpOverCallback, argList)
    -- function num : 0_14 , upvalues : _ENV
    local heroId = argList[1]
    if heroId == nil then
        error("bad jump arg Jump2SectorFragDungeon heroId:" .. tostring(heroId))
        return
    end
    local Home = UIManager:GetWindow(UIWindowTypeID.Home)
    if Home == nil then return end
    Home.enterSectorJumpCallback = BindCallback(self, function()
        -- function num : 0_14_0 , upvalues : _ENV, heroId
        local sectorController = ControllerManager:GetController(
                                     ControllerTypeId.SectorController, false)
        if sectorController == nil then
            error("can\'t get sectorController")
            return
        end
        local EnterFragDungeon = function()
            -- function num : 0_14_0_0 , upvalues : sectorController, heroId, EnterFragDungeon
            (sectorController.uiCanvas):EnterFriendshipDungeon(heroId);
            (sectorController.homeToSectorDirector):stopped("-",
                                                            EnterFragDungeon)
        end;
        (sectorController.homeToSectorDirector):stopped("+", EnterFragDungeon)
    end)
    Home:OnBtnSectorClicked()
    if jumpOverCallback ~= nil then jumpOverCallback() end
end

JumpManager.Jump2SectorResourceDungeon =
    function(self, jumpOverCallback, argList)
        -- function num : 0_15 , upvalues : _ENV
        local typeID = argList[1]
        if typeID == nil or (ConfigData.material_dungeon)[typeID] == nil then
            error("bad jump arg Jump2SectorFragDungeon typeID:" ..
                      tostring(typeID))
            return
        end
        local Home = UIManager:GetWindow(UIWindowTypeID.Home)
        if Home == nil then return end
        Home.enterSectorJumpCallback = BindCallback(self, function()
            -- function num : 0_15_0 , upvalues : _ENV, typeID
            local sectorController = ControllerManager:GetController(
                                         ControllerTypeId.SectorController,
                                         false)
            if sectorController == nil then
                error("can\'t get sectorController")
                return
            end
            local EnterFragDungeon = function()
                -- function num : 0_15_0_0 , upvalues : sectorController, typeID, EnterFragDungeon
                (sectorController.uiCanvas):EnterMatDungeon(typeID);
                (sectorController.homeToSectorDirector):stopped("-",
                                                                EnterFragDungeon)
            end;
            (sectorController.homeToSectorDirector):stopped("+",
                                                            EnterFragDungeon)
        end)
        Home:OnBtnSectorClicked()
        if jumpOverCallback ~= nil then jumpOverCallback() end
    end

JumpManager:Init()
return JumpManager

