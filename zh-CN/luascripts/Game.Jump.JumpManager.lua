-- params : ...
-- function num : 0 , upvalues : _ENV
local JumpManager = {}
local FuncArray = {}
local funcUnLockCrtl = nil
JumpManager.eJumpTarget = {ShopInvest = 1, ShopResident = 2, ShopVariable = 3, LotteryNormal = 4, LotteryAdvanced = 5, Mail = 6, Hero = 7, Sector = 8, Oasis = 9, Factory = 10, DaliyTask = 11, WeeklyTask = 12, MainTask = 13, SideTask = 14, Achieve4Cultivate = 15, Achieve4Commander = 16, Achieve4Dungeon = 17, Achieve4System = 18, Achieve4Oasis = 19, BuyStamina = 20, OasisBuilding = 100, SectorBuilding = 101, fragDungeon = 102, resourceDungeon = 103, ATHDungeon = 104}
JumpManager.Init = function(self)
  -- function num : 0_0 , upvalues : _ENV, FuncArray, JumpManager
  local config = ConfigData.system_jump
  FuncArray[(JumpManager.eJumpTarget).ShopInvest] = BindCallback(self, self.Jump2Shop, (config[(JumpManager.eJumpTarget).ShopInvest]).jump_arg)
  FuncArray[(JumpManager.eJumpTarget).ShopResident] = BindCallback(self, self.Jump2Shop, (config[(JumpManager.eJumpTarget).ShopResident]).jump_arg)
  FuncArray[(JumpManager.eJumpTarget).ShopVariable] = BindCallback(self, self.Jump2Shop, (config[(JumpManager.eJumpTarget).ShopVariable]).jump_arg)
  FuncArray[(JumpManager.eJumpTarget).LotteryNormal] = BindCallback(self, self.Jump2Lottery, true)
  FuncArray[(JumpManager.eJumpTarget).LotteryAdvanced] = BindCallback(self, self.Jump2Lottery, false)
  FuncArray[(JumpManager.eJumpTarget).Mail] = BindCallback(self, self.Jump2Mail)
  FuncArray[(JumpManager.eJumpTarget).Hero] = BindCallback(self, self.Jump2Hro)
  FuncArray[(JumpManager.eJumpTarget).Sector] = BindCallback(self, self.Jump2Sector)
  FuncArray[(JumpManager.eJumpTarget).Oasis] = BindCallback(self, self.Jump2Oasis)
  FuncArray[(JumpManager.eJumpTarget).Factory] = BindCallback(self, self.Jump2Factory)
  FuncArray[(JumpManager.eJumpTarget).DaliyTask] = BindCallback(self, self.Jump2Task, (config[(JumpManager.eJumpTarget).DaliyTask]).jump_arg)
  FuncArray[(JumpManager.eJumpTarget).WeeklyTask] = BindCallback(self, self.Jump2Task, (config[(JumpManager.eJumpTarget).WeeklyTask]).jump_arg)
  FuncArray[(JumpManager.eJumpTarget).MainTask] = BindCallback(self, self.Jump2Task, (config[(JumpManager.eJumpTarget).MainTask]).jump_arg)
  FuncArray[(JumpManager.eJumpTarget).SideTask] = BindCallback(self, self.Jump2Task, (config[(JumpManager.eJumpTarget).SideTask]).jump_arg)
  FuncArray[(JumpManager.eJumpTarget).Achieve4Cultivate] = BindCallback(self, self.Jump2Achievement, (config[(JumpManager.eJumpTarget).Achieve4Cultivate]).jump_arg)
  FuncArray[(JumpManager.eJumpTarget).Achieve4Commander] = BindCallback(self, self.Jump2Achievement, (config[(JumpManager.eJumpTarget).Achieve4Commander]).jump_arg)
  FuncArray[(JumpManager.eJumpTarget).Achieve4Dungeon] = BindCallback(self, self.Jump2Achievement, (config[(JumpManager.eJumpTarget).Achieve4Dungeon]).jump_arg)
  FuncArray[(JumpManager.eJumpTarget).Achieve4System] = BindCallback(self, self.Jump2Achievement, (config[(JumpManager.eJumpTarget).Achieve4System]).jump_arg)
  FuncArray[(JumpManager.eJumpTarget).Achieve4Oasis] = BindCallback(self, self.Jump2Achievement, (config[(JumpManager.eJumpTarget).Achieve4Oasis]).jump_arg)
  FuncArray[(JumpManager.eJumpTarget).BuyStamina] = BindCallback(self, self.Jump2BuyStamina)
  FuncArray[(JumpManager.eJumpTarget).OasisBuilding] = BindCallback(self, self.Jump2OasisBuilding)
  FuncArray[(JumpManager.eJumpTarget).SectorBuilding] = BindCallback(self, self.Jump2SectorBuilding)
  FuncArray[(JumpManager.eJumpTarget).fragDungeon] = BindCallback(self, self.Jump2SectorFragDungeon)
  FuncArray[(JumpManager.eJumpTarget).resourceDungeon] = BindCallback(self, self.Jump2SectorResourceDungeon)
  FuncArray[(JumpManager.eJumpTarget).ATHDungeon] = BindCallback(self, self.Jump2SectorATHDungeon)
end

JumpManager.Jump = function(self, jumpType, jumpOverCallback, argList)
  -- function num : 0_1 , upvalues : funcUnLockCrtl, _ENV, FuncArray
  if funcUnLockCrtl == nil then
    funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock, true)
  end
  local num = nil
  if type(jumpType) == "string" then
    if (string.IsNullOrEmpty)(jumpType) then
      return 
    end
    num = tonumber(jumpType)
  else
    if type(jumpType) == "number" then
      num = jumpType
    else
      return 
    end
  end
  if FuncArray[num] == nil then
    return 
  end
  ;
  (FuncArray[num])(jumpOverCallback, argList)
end

JumpManager.Jump2Shop = function(self, shopid, jumpOverCallback)
  -- function num : 0_2 , upvalues : funcUnLockCrtl, _ENV
  local isShopUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Store)
  if not isShopUnlock then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Shop, function(win)
    -- function num : 0_2_0 , upvalues : shopid, jumpOverCallback
    if win ~= nil then
      win:InitShopTogList(shopid)
      if jumpOverCallback ~= nil then
        jumpOverCallback()
      end
    end
  end
)
end

JumpManager.Jump2Lottery = function(self, isNormal, jumpOverCallback)
  -- function num : 0_3 , upvalues : funcUnLockCrtl, _ENV
  local isLotteryUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Lottery)
  if not isLotteryUnlock then
    return 
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  ;
  (Home.rightList):OnClickLotteryBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

JumpManager.Jump2Mail = function(self, jumpOverCallback)
  -- function num : 0_4 , upvalues : funcUnLockCrtl, _ENV
  local isMailUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Mail)
  if not isMailUnlock then
    return false
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Mail, function(win)
    -- function num : 0_4_0 , upvalues : jumpOverCallback
    if win ~= nil and jumpOverCallback ~= nil then
      jumpOverCallback()
    end
  end
)
end

JumpManager.Jump2Hro = function(self, jumpOverCallback)
  -- function num : 0_5 , upvalues : funcUnLockCrtl, _ENV
  local isHeroListUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroGroup)
  if not isHeroListUnlock then
    return 
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  ;
  (Home.rightList):OnClickHeroListBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

JumpManager.Jump2Sector = function(self, jumpOverCallback, argList)
  -- function num : 0_6 , upvalues : _ENV
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  local doNotOpenEpStages = false
  if argList ~= nil then
    doNotOpenEpStages = argList[1]
  end
  ;
  (Home.rightList):OnClickEpBtn(doNotOpenEpStages)
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

JumpManager.Jump2Oasis = function(self, jumpOverCallback)
  -- function num : 0_7 , upvalues : funcUnLockCrtl, _ENV
  local isOasisUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Building)
  if not isOasisUnlock then
    return 
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  ;
  (Home.rightList):OnClickOasisBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

JumpManager.Jump2Factory = function(self, jumpOverCallback)
  -- function num : 0_8 , upvalues : funcUnLockCrtl, _ENV
  local isFactoryUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Factory)
  if not isFactoryUnlock then
    return 
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Factory, function(win)
    -- function num : 0_8_0 , upvalues : jumpOverCallback
    if win ~= nil and jumpOverCallback ~= nil then
      jumpOverCallback()
    end
  end
)
end

JumpManager.Jump2Task = function(self, taskTypeID, jumpOverCallback)
  -- function num : 0_9 , upvalues : funcUnLockCrtl, _ENV
  local isTaskUIUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TaskUi)
  if not isTaskUIUnlock then
    return 
  end
  local taskController = ControllerManager:GetController(ControllerTypeId.Task, true)
  taskController:ShowTaskUI(taskTypeID, jumpOverCallback)
end

JumpManager.Jump2Achievement = function(self, achievementTypeID, jumpOverCallback)
  -- function num : 0_10 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.AchievementSystem, function(win)
    -- function num : 0_10_0
    if win ~= nil then
      win:InitAchievement(nil, false)
    end
  end
)
end

JumpManager.Jump2BuyStamina = function(self, jumpOverCallback)
  -- function num : 0_11 , upvalues : _ENV
  local ShopEnum = require("Game.Shop.ShopEnum")
  local quickBuyData = (ShopEnum.eQuickBuy).stamina
  local shopId = quickBuyData.shopId
  local shelfId = quickBuyData.shelfId
  local goodData = nil
  local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  if not ctrl:GetIsUnlock() then
    ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(TipContent.notUnlockShopCantBuyStamina))
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
      win:OnClickAdd()
      if jumpOverCallback ~= nil then
        jumpOverCallback()
      end
    end
)
  end
)
end

JumpManager.Jump2OasisBuilding = function(self, jumpOverCallback, argList)
  -- function num : 0_12 , upvalues : funcUnLockCrtl, _ENV
  local isOasisUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Building)
  if not isOasisUnlock then
    return 
  end
  local buildId = argList[1]
  local oasisController = ControllerManager:GetController(ControllerTypeId.OasisController, true)
  if (oasisController.buildingItems)[buildId] == nil then
    self:Jump2Oasis(jumpOverCallback)
    return 
  end
  local Oasis = UIManager:GetWindow(UIWindowTypeID.Oasis)
  if Oasis ~= nil then
    oasisController:BuildingUpgrade(buildId)
    return 
  else
    local Home = UIManager:GetWindow(UIWindowTypeID.Home)
    if Home == nil then
      return 
    end
    if Home.sideWin ~= nil then
      (Home.sideWin):Delete()
      Home.sideWin = nil
    end
    oasisController:InjectJumpEvent(function()
    -- function num : 0_12_0 , upvalues : oasisController, buildId
    oasisController.selectBuiltId = nil
    oasisController:BuildingUpgrade(buildId, true)
  end
)
    ;
    (Home.rightList):OnClickOasisBtn()
    oasisController.selectBuiltId = buildId
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
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
  if Home == nil then
    return 
  end
  if Home.sideWin ~= nil then
    (Home.sideWin):Delete()
    Home.sideWin = nil
  end
  Home.enterSectorJumpCallback = BindCallback(self, function()
    -- function num : 0_13_0 , upvalues : _ENV, sectorId
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can\'t get sectorController")
      return 
    end
    local EnterBuilding = function()
      -- function num : 0_13_0_0 , upvalues : sectorController, sectorId, EnterBuilding
      sectorController:StartBuildFocusEnter(sectorId)
      ;
      (sectorController.homeToSectorDirector):stopped("-", EnterBuilding)
    end

    ;
    (sectorController.homeToSectorDirector):stopped("+", EnterBuilding)
  end
)
  ;
  (Home.rightList):OnClickEpBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

JumpManager.Jump2SectorFragDungeon = function(self, jumpOverCallback, argList)
  -- function num : 0_14 , upvalues : _ENV
  local heroId = argList[1]
  if heroId == nil then
    error("bad jump arg Jump2SectorFragDungeon heroId:" .. tostring(heroId))
    return 
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  if Home == nil then
    return 
  end
  Home.enterSectorJumpCallback = BindCallback(self, function()
    -- function num : 0_14_0 , upvalues : _ENV, heroId
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can\'t get sectorController")
      return 
    end
    local EnterFragDungeon = function()
      -- function num : 0_14_0_0 , upvalues : sectorController, heroId, EnterFragDungeon
      (sectorController.uiCanvas):EnterFriendshipDungeon(heroId)
      ;
      (sectorController.homeToSectorDirector):stopped("-", EnterFragDungeon)
    end

    ;
    (sectorController.homeToSectorDirector):stopped("+", EnterFragDungeon)
  end
)
  ;
  (Home.rightList):OnClickEpBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

JumpManager.Jump2SectorResourceDungeon = function(self, jumpOverCallback, argList)
  -- function num : 0_15 , upvalues : _ENV
  local typeID = argList[1]
  if typeID == nil or (ConfigData.material_dungeon)[typeID] == nil then
    error("bad jump arg Jump2SectorFragDungeon typeID:" .. tostring(typeID))
    return 
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  if Home == nil then
    return 
  end
  Home.enterSectorJumpCallback = BindCallback(self, function()
    -- function num : 0_15_0 , upvalues : _ENV, typeID
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can\'t get sectorController")
      return 
    end
    local EnterFragDungeon = function()
      -- function num : 0_15_0_0 , upvalues : sectorController, typeID, EnterFragDungeon
      (sectorController.uiCanvas):EnterMatDungeon(typeID)
      ;
      (sectorController.homeToSectorDirector):stopped("-", EnterFragDungeon)
    end

    ;
    (sectorController.homeToSectorDirector):stopped("+", EnterFragDungeon)
  end
)
  ;
  (Home.rightList):OnClickEpBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

JumpManager.Jump2SectorATHDungeon = function(self, jumpOverCallback, argList)
  -- function num : 0_16 , upvalues : _ENV
  local typeID = argList[1]
  if typeID == nil or (ConfigData.material_dungeon)[typeID] == nil then
    error("bad jump arg Jump2SectorATHDungeon typeID:" .. tostring(typeID))
    return 
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  if Home == nil then
    return 
  end
  Home.enterSectorJumpCallback = BindCallback(self, function()
    -- function num : 0_16_0 , upvalues : _ENV, typeID
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can\'t get sectorController")
      return 
    end
    local EnterATHDungeon = function()
      -- function num : 0_16_0_0 , upvalues : sectorController, typeID, EnterATHDungeon
      (sectorController.uiCanvas):EnterATHDungeon(typeID)
      ;
      (sectorController.homeToSectorDirector):stopped("-", EnterATHDungeon)
    end

    ;
    (sectorController.homeToSectorDirector):stopped("+", EnterATHDungeon)
  end
)
  ;
  (Home.rightList):OnClickEpBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

JumpManager:Init()
return JumpManager

