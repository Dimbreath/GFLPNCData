-- params : ...
-- function num : 0 , upvalues : _ENV
local JumpManager = {}
local FuncArray = {}
local ValidateFuncArray = {}
local cs_MessageCommon = CS.MessageCommon
JumpManager.eJumpTarget = {ShopInvest = 1, ShopResident = 2, ShopVariable = 3, LotteryNormal = 4, LotteryAdvanced = 5, Mail = 6, Hero = 7, Sector = 8, Oasis = 9, Factory = 10, DaliyTask = 11, WeeklyTask = 12, MainTask = 13, SideTask = 14, Achieve4Cultivate = 15, Achieve4Commander = 16, Achieve4Dungeon = 17, Achieve4System = 18, Achieve4Oasis = 19, BuyStamina = 20, OasisBuilding = 100, SectorBuilding = 101, fragDungeon = 102, resourceDungeon = 103, ATHDungeon = 104}
JumpManager.Init = function(self)
  -- function num : 0_0 , upvalues : _ENV, FuncArray, JumpManager, ValidateFuncArray
  self:ClearSectorJumpId()
  self.couldUseItemJump = false
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
  ValidateFuncArray[(JumpManager.eJumpTarget).ShopInvest] = BindCallback(self, self.Jump2ShopValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).ShopResident] = ValidateFuncArray[(JumpManager.eJumpTarget).ShopInvest]
  ValidateFuncArray[(JumpManager.eJumpTarget).ShopVariable] = ValidateFuncArray[(JumpManager.eJumpTarget).ShopInvest]
  ValidateFuncArray[(JumpManager.eJumpTarget).LotteryNormal] = BindCallback(self, self.Jump2LotteryValidate, true)
  ValidateFuncArray[(JumpManager.eJumpTarget).LotteryAdvanced] = BindCallback(self, self.Jump2LotteryValidate, false)
  ValidateFuncArray[(JumpManager.eJumpTarget).Mail] = BindCallback(self, self.Jump2MailValidate, false)
  ValidateFuncArray[(JumpManager.eJumpTarget).Hero] = BindCallback(self, self.Jump2HroValidate, false)
  ValidateFuncArray[(JumpManager.eJumpTarget).Sector] = BindCallback(self, self.Jump2SectorValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).Oasis] = BindCallback(self, self.Jump2OasisValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).Factory] = BindCallback(self, self.Jump2FactoryValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).DaliyTask] = BindCallback(self, self.Jump2TaskValidate, (config[(JumpManager.eJumpTarget).DaliyTask]).jump_arg)
  ValidateFuncArray[(JumpManager.eJumpTarget).WeeklyTask] = BindCallback(self, self.Jump2TaskValidate, (config[(JumpManager.eJumpTarget).WeeklyTask]).jump_arg)
  ValidateFuncArray[(JumpManager.eJumpTarget).MainTask] = BindCallback(self, self.Jump2TaskValidate, (config[(JumpManager.eJumpTarget).MainTask]).jump_arg)
  ValidateFuncArray[(JumpManager.eJumpTarget).SideTask] = BindCallback(self, self.Jump2TaskValidate, (config[(JumpManager.eJumpTarget).SideTask]).jump_arg)
  ValidateFuncArray[(JumpManager.eJumpTarget).Achieve4Cultivate] = BindCallback(self, self.Jump2AchievementValidate, (config[(JumpManager.eJumpTarget).Achieve4Cultivate]).jump_arg)
  ValidateFuncArray[(JumpManager.eJumpTarget).Achieve4Commander] = BindCallback(self, self.Jump2AchievementValidate, (config[(JumpManager.eJumpTarget).Achieve4Commander]).jump_arg)
  ValidateFuncArray[(JumpManager.eJumpTarget).Achieve4Dungeon] = BindCallback(self, self.Jump2AchievementValidate, (config[(JumpManager.eJumpTarget).Achieve4Dungeon]).jump_arg)
  ValidateFuncArray[(JumpManager.eJumpTarget).Achieve4System] = BindCallback(self, self.Jump2AchievementValidate, (config[(JumpManager.eJumpTarget).Achieve4System]).jump_arg)
  ValidateFuncArray[(JumpManager.eJumpTarget).Achieve4Oasis] = BindCallback(self, self.Jump2AchievementValidate, (config[(JumpManager.eJumpTarget).Achieve4Oasis]).jump_arg)
  ValidateFuncArray[(JumpManager.eJumpTarget).BuyStamina] = BindCallback(self, self.Jump2BuyStaminaValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).OasisBuilding] = BindCallback(self, self.Jump2OasisBuildingValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).SectorBuilding] = BindCallback(self, self.Jump2SectorBuildingValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).fragDungeon] = BindCallback(self, self.Jump2SectorFragDungeonValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).resourceDungeon] = BindCallback(self, self.Jump2SectorResourceDungeonValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).ATHDungeon] = BindCallback(self, self.Jump2SectorATHDungeonValidate)
end

JumpManager.Jump = function(self, jumpType, beforeJumpCallback, jumpOverCallback, argList)
  -- function num : 0_1 , upvalues : FuncArray
  local bool, num = self:ValidateJump(jumpType, argList)
  if bool then
    if beforeJumpCallback ~= nil then
      beforeJumpCallback()
    end
    ;
    (FuncArray[num])(jumpOverCallback, argList)
  end
end

JumpManager.ValidateJump = function(self, jumpType, argList)
  -- function num : 0_2 , upvalues : _ENV, FuncArray, ValidateFuncArray
  local num = nil
  if type(jumpType) == "string" then
    if (string.IsNullOrEmpty)(jumpType) then
      return false
    end
    num = tonumber(jumpType)
  else
    if type(jumpType) == "number" then
      num = jumpType
    else
      return false
    end
  end
  if FuncArray[num] == nil then
    return false
  end
  return (ValidateFuncArray[num])(argList), num
end

JumpManager.ShowCanotJumpMessage = function(self, fid, lineWrap)
  -- function num : 0_3 , upvalues : _ENV, cs_MessageCommon
  local des = FunctionUnlockMgr:GetFuncUnlockDecription(fid, lineWrap)
  des = (string.format)(ConfigData:GetTipContent(TipContent.Jump_TargetFuncLocked), des)
  ;
  (cs_MessageCommon.ShowMessageTips)(des)
end

JumpManager.GetSectorJumpId = function(self)
  -- function num : 0_4
  return self.sectorJumpId
end

JumpManager.RecordSectorJumpId = function(self, id)
  -- function num : 0_5
  self.sectorJumpId = id
end

JumpManager.ClearSectorJumpId = function(self, id)
  -- function num : 0_6
  self.sectorJumpId = nil
end

JumpManager.Jump2Shop = function(self, shopid, jumpOverCallback)
  -- function num : 0_7 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.Shop, function(win)
    -- function num : 0_7_0 , upvalues : shopid, jumpOverCallback
    if win ~= nil then
      win:InitShopTogList(shopid)
      if jumpOverCallback ~= nil then
        jumpOverCallback()
      end
    end
  end
)
end

JumpManager.Jump2ShopValidate = function(self, shopid)
  -- function num : 0_8 , upvalues : _ENV
  local isShopUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Store)
  if not isShopUnlock then
    self:ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Store, true)
    return false
  end
  return true
end

JumpManager.Jump2Lottery = function(self, isNormal, jumpOverCallback)
  -- function num : 0_9 , upvalues : _ENV
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  ;
  (Home.rightList):OnClickLotteryBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

JumpManager.Jump2LotteryValidate = function(self, isNormal)
  -- function num : 0_10 , upvalues : _ENV
  local isLotteryUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Lottery)
  if not isLotteryUnlock then
    self:ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Lottery, true)
    return false
  end
  return true
end

JumpManager.Jump2Mail = function(self, jumpOverCallback)
  -- function num : 0_11 , upvalues : _ENV
  local isMailUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Mail)
  if not isMailUnlock then
    self:ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Mail, true)
    return false
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Mail, function(win)
    -- function num : 0_11_0 , upvalues : jumpOverCallback
    if win ~= nil and jumpOverCallback ~= nil then
      jumpOverCallback()
    end
  end
)
end

JumpManager.Jump2MailValidate = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local isMailUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Mail)
  if not isMailUnlock then
    self:ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Mail, true)
    return false
  end
  return true
end

JumpManager.Jump2Hro = function(self, jumpOverCallback)
  -- function num : 0_13 , upvalues : _ENV
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  ;
  (Home.rightList):OnClickHeroListBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

JumpManager.Jump2HroValidate = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local isHeroListUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroGroup)
  if not isHeroListUnlock then
    self:ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroGroup, true)
    return false
  end
  return true
end

JumpManager.Jump2Sector = function(self, jumpOverCallback, argList)
  -- function num : 0_15 , upvalues : _ENV
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

JumpManager.Jump2SectorValidate = function(self, argList)
  -- function num : 0_16
  return true
end

JumpManager.Jump2Oasis = function(self, jumpOverCallback)
  -- function num : 0_17 , upvalues : _ENV
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  ;
  (Home.rightList):OnClickOasisBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

JumpManager.Jump2OasisValidate = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local isOasisUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Building)
  if not isOasisUnlock then
    self:ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Building, true)
    return false
  end
  return true
end

JumpManager.Jump2Factory = function(self, jumpOverCallback)
  -- function num : 0_19 , upvalues : _ENV
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  ;
  (Home.rightList):OnClickFactoryBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

JumpManager.Jump2FactoryValidate = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local isFactoryUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Factory)
  if not isFactoryUnlock then
    return false
  end
  return true
end

JumpManager.Jump2Task = function(self, taskTypeID, jumpOverCallback)
  -- function num : 0_21 , upvalues : _ENV
  local taskController = ControllerManager:GetController(ControllerTypeId.Task, true)
  taskController:ShowTaskUI(taskTypeID, jumpOverCallback)
end

JumpManager.Jump2TaskValidate = function(self, taskTypeID)
  -- function num : 0_22 , upvalues : _ENV
  local isTaskUIUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TaskUi)
  if not isTaskUIUnlock then
    self:ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_TaskUi, true)
    return false
  end
  return true
end

JumpManager.Jump2Achievement = function(self, achievementTypeID, jumpOverCallback)
  -- function num : 0_23 , upvalues : _ENV
  UIManager:ShowWindowAsync(UIWindowTypeID.AchievementSystem, function(win)
    -- function num : 0_23_0
    if win ~= nil then
      win:InitAchievement(nil, false)
    end
  end
)
end

JumpManager.Jump2AchievementValidate = function(self, achievementTypeID)
  -- function num : 0_24 , upvalues : _ENV
  local isAchUIUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement)
  if not isAchUIUnlock then
    self:ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement, true)
    return false
  end
  return true
end

JumpManager.Jump2BuyStamina = function(self, jumpOverCallback)
  -- function num : 0_25 , upvalues : _ENV
  local ShopEnum = require("Game.Shop.ShopEnum")
  local quickBuyData = (ShopEnum.eQuickBuy).stamina
  local shopId = quickBuyData.shopId
  local shelfId = quickBuyData.shelfId
  local goodData = nil
  local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  ctrl:GetShopData(shopId, function(shopData)
    -- function num : 0_25_0 , upvalues : goodData, shelfId, _ENV, jumpOverCallback, quickBuyData
    goodData = (shopData.shopGoodsDic)[shelfId]
    UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(win)
      -- function num : 0_25_0_0 , upvalues : _ENV, jumpOverCallback, goodData, quickBuyData
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

JumpManager.Jump2BuyStaminaValidate = function(self)
  -- function num : 0_26 , upvalues : _ENV
  local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  if not ctrl:GetIsUnlock() then
    ((CS.MessageCommon).ShowMessageTips)(ConfigData:GetTipContent(TipContent.notUnlockShopCantBuyStamina))
    return false
  end
  return true
end

JumpManager.Jump2OasisBuilding = function(self, jumpOverCallback, argList)
  -- function num : 0_27 , upvalues : _ENV
  local buildId = argList[1]
  local oasisController = ControllerManager:GetController(ControllerTypeId.OasisController, true)
  if (oasisController.buildingItems)[buildId] == nil then
    self:Jump2Oasis(jumpOverCallback)
    return 
  end
  local Oasis = UIManager:GetWindow(UIWindowTypeID.OasisMain)
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
    -- function num : 0_27_0 , upvalues : oasisController, buildId
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

JumpManager.Jump2OasisBuildingValidate = function(self, argList)
  -- function num : 0_28 , upvalues : _ENV
  local isOasisUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Building)
  if not isOasisUnlock then
    self:ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Building, true)
    return false
  end
  return true
end

JumpManager.Jump2SectorBuilding = function(self, jumpOverCallback, argList)
  -- function num : 0_29 , upvalues : _ENV
  local sectorId = argList[1]
  self:RecordSectorJumpId(sectorId * 10)
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  if Home.sideWin ~= nil then
    (Home.sideWin):Delete()
    Home.sideWin = nil
  end
  Home.enterSectorJumpCallback = BindCallback(self, function()
    -- function num : 0_29_0 , upvalues : _ENV, sectorId, self
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can\'t get sectorController")
      return 
    end
    local EnterBuilding = function()
      -- function num : 0_29_0_0 , upvalues : sectorController, sectorId, EnterBuilding, self
      sectorController:StartBuildFocusEnter(sectorId)
      ;
      (sectorController.homeToSectorDirector):stopped("-", EnterBuilding)
      self:ClearSectorJumpId()
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

JumpManager.Jump2SectorBuildingValidate = function(self, argList)
  -- function num : 0_30 , upvalues : _ENV
  local sectorId = argList[1]
  if sectorId == nil then
    error("bad jump arg Jump2SectorBuilding sectorId:" .. tostring(sectorId))
    return 
  end
  local isSectorBuildingUIUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding)
  if not isSectorBuildingUIUnlock then
    self:ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding, true)
    return false
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  if Home == nil then
    return false
  end
  return true
end

JumpManager.Jump2SectorFragDungeon = function(self, jumpOverCallback, argList)
  -- function num : 0_31 , upvalues : _ENV
  local heroId = argList[1]
  self:RecordSectorJumpId(22)
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  Home.enterSectorJumpCallback = BindCallback(self, function()
    -- function num : 0_31_0 , upvalues : _ENV, heroId, self
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can\'t get sectorController")
      return 
    end
    local EnterFragDungeon = function()
      -- function num : 0_31_0_0 , upvalues : sectorController, heroId, EnterFragDungeon, self
      (sectorController.uiCanvas):EnterFriendshipDungeon(heroId, true)
      ;
      (sectorController.homeToSectorDirector):stopped("-", EnterFragDungeon)
      self:ClearSectorJumpId()
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

JumpManager.Jump2SectorFragDungeonValidate = function(self, argList)
  -- function num : 0_32 , upvalues : _ENV
  local isFragDungeonUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship_sector_Ui)
  if not isFragDungeonUnlock then
    self:ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship_sector_Ui, true)
    return false
  end
  local heroId = argList[1]
  if heroId == nil then
    error("bad jump arg Jump2SectorFragDungeon heroId:" .. tostring(heroId))
    return false
  end
  if (PlayerDataCenter.heroDic)[heroId] == nil then
    warn("尝试跳转至未拥有的hero的碎片副本 heroId=" .. tostring(heroId))
    return false
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  if Home == nil then
    return false
  end
  return true
end

JumpManager.Jump2SectorResourceDungeon = function(self, jumpOverCallback, argList)
  -- function num : 0_33 , upvalues : _ENV
  self:RecordSectorJumpId(11)
  local typeID = argList[1]
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  Home.enterSectorJumpCallback = BindCallback(self, function()
    -- function num : 0_33_0 , upvalues : _ENV, typeID, self
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can\'t get sectorController")
      return 
    end
    local EnterFragDungeon = function()
      -- function num : 0_33_0_0 , upvalues : sectorController, typeID, EnterFragDungeon, self
      (sectorController.uiCanvas):EnterMatDungeon(typeID, true)
      ;
      (sectorController.homeToSectorDirector):stopped("-", EnterFragDungeon)
      self:ClearSectorJumpId()
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

JumpManager.Jump2SectorResourceDungeonValidate = function(self, argList)
  -- function num : 0_34 , upvalues : _ENV
  local isMatDungeonUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_MaterialDungeon)
  if not isMatDungeonUnlock then
    self:ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_MaterialDungeon, true)
    return 
  end
  local typeID = argList[1]
  if typeID == nil or (ConfigData.material_dungeon)[typeID] == nil then
    error("bad jump arg Jump2SectorFragDungeon typeID:" .. tostring(typeID))
    return 
  end
  local isSpecificDungeonUnlock = FunctionUnlockMgr:ValidateUnlock(typeID)
  if not isSpecificDungeonUnlock then
    self:ShowCanotJumpMessage(typeID, true)
    return 
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  if Home == nil then
    return 
  end
  return true
end

JumpManager.Jump2SectorATHDungeon = function(self, jumpOverCallback, argList)
  -- function num : 0_35 , upvalues : _ENV
  self:RecordSectorJumpId(13)
  local typeID = argList[1]
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  Home.enterSectorJumpCallback = BindCallback(self, function()
    -- function num : 0_35_0 , upvalues : _ENV, typeID, self
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can\'t get sectorController")
      return 
    end
    local EnterATHDungeon = function()
      -- function num : 0_35_0_0 , upvalues : sectorController, typeID, EnterATHDungeon, self
      (sectorController.uiCanvas):EnterATHDungeon(typeID, true)
      ;
      (sectorController.homeToSectorDirector):stopped("-", EnterATHDungeon)
      self:ClearSectorJumpId()
    end

    sectorController:OnEnterPlotOrMateralDungeon()
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

JumpManager.Jump2SectorATHDungeonValidate = function(self, argList)
  -- function num : 0_36 , upvalues : _ENV
  local isATHDungeonUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_EquipDungeon)
  if not isATHDungeonUnlock then
    self:ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_EquipDungeon, true)
    return 
  end
  local typeID = argList[1]
  if typeID == nil or (ConfigData.material_dungeon)[typeID] == nil then
    error("bad jump arg Jump2SectorATHDungeon typeID:" .. tostring(typeID))
    return 
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  if Home == nil then
    return 
  end
  return true
end

JumpManager.CleanJumpManager = function(self)
  -- function num : 0_37
  self.couldUseItemJump = false
end

JumpManager:Init()
return JumpManager

