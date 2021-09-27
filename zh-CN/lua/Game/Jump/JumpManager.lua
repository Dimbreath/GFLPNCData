local JumpManager = {}
local FuncArray = {}
local ValidateFuncArray = {}
local cs_MessageCommon = CS.MessageCommon
local HomeEnum = require("Game.Home.HomeEnum")
JumpManager.eJumpTarget = {Home = 0, ShopInvest = 1, ShopResident = 2, ShopVariable = 3, LotteryNormal = 4, LotteryAdvanced = 5, Mail = 6, Hero = 7, Sector = 8, Oasis = 9, Factory = 10, DaliyTask = 11, WeeklyTask = 12, MainTask = 13, SideTask = 14, Achieve4Cultivate = 15, Achieve4Commander = 16, Achieve4Dungeon = 17, Achieve4System = 18, Achieve4Oasis = 19, BuyStamina = 20, DailyChallenge = 21, WeeklyChallenge = 22, Dorm = 23, ShopBase = 24, Setting = 25, UserCenter = 26, UserInfoPage = 27, OasisBuilding = 100, StrategyOverview = 101, fragDungeon = 102, resourceDungeon = 103, ATHDungeon = 104, DynShop = 105, DynTask = 106, DynSectorLevel = 107, DynLottery = 108, DynActivity = 109, DynWarehouse = 110, DynCareerStO = 111}
JumpManager.Init = function(self)
  -- function num : 0_0 , upvalues : _ENV, FuncArray, JumpManager, ValidateFuncArray
  self:ClearSectorJumpId()
  self.couldUseItemJump = false
  local config = ConfigData.system_jump
  FuncArray[(JumpManager.eJumpTarget).Home] = UIUtil.ReturnHome
  FuncArray[(JumpManager.eJumpTarget).ShopInvest] = BindCallback(self, self.Jump2Shop, ((config[(JumpManager.eJumpTarget).ShopInvest]).jump_arg)[1])
  FuncArray[(JumpManager.eJumpTarget).ShopResident] = BindCallback(self, self.Jump2Shop, ((config[(JumpManager.eJumpTarget).ShopResident]).jump_arg)[1])
  FuncArray[(JumpManager.eJumpTarget).ShopVariable] = BindCallback(self, self.Jump2Shop, ((config[(JumpManager.eJumpTarget).ShopVariable]).jump_arg)[1])
  FuncArray[(JumpManager.eJumpTarget).LotteryNormal] = BindCallback(self, self.Jump2Lottery, true)
  FuncArray[(JumpManager.eJumpTarget).LotteryAdvanced] = BindCallback(self, self.Jump2Lottery, false)
  FuncArray[(JumpManager.eJumpTarget).Mail] = BindCallback(self, self.Jump2Mail)
  FuncArray[(JumpManager.eJumpTarget).Hero] = BindCallback(self, self.Jump2Hro)
  FuncArray[(JumpManager.eJumpTarget).Sector] = BindCallback(self, self.Jump2Sector)
  FuncArray[(JumpManager.eJumpTarget).Oasis] = BindCallback(self, self.Jump2Oasis)
  FuncArray[(JumpManager.eJumpTarget).Factory] = BindCallback(self, self.Jump2Factory)
  FuncArray[(JumpManager.eJumpTarget).DaliyTask] = BindCallback(self, self.Jump2Task, ((config[(JumpManager.eJumpTarget).DaliyTask]).jump_arg)[1])
  FuncArray[(JumpManager.eJumpTarget).WeeklyTask] = BindCallback(self, self.Jump2Task, ((config[(JumpManager.eJumpTarget).WeeklyTask]).jump_arg)[1])
  FuncArray[(JumpManager.eJumpTarget).MainTask] = BindCallback(self, self.Jump2Task, ((config[(JumpManager.eJumpTarget).MainTask]).jump_arg)[1])
  FuncArray[(JumpManager.eJumpTarget).SideTask] = BindCallback(self, self.Jump2Task, ((config[(JumpManager.eJumpTarget).SideTask]).jump_arg)[1])
  FuncArray[(JumpManager.eJumpTarget).Achieve4Cultivate] = BindCallback(self, self.Jump2Achievement, ((config[(JumpManager.eJumpTarget).Achieve4Cultivate]).jump_arg)[1])
  FuncArray[(JumpManager.eJumpTarget).Achieve4Commander] = BindCallback(self, self.Jump2Achievement, ((config[(JumpManager.eJumpTarget).Achieve4Commander]).jump_arg)[1])
  FuncArray[(JumpManager.eJumpTarget).Achieve4Dungeon] = BindCallback(self, self.Jump2Achievement, ((config[(JumpManager.eJumpTarget).Achieve4Dungeon]).jump_arg)[1])
  FuncArray[(JumpManager.eJumpTarget).Achieve4System] = BindCallback(self, self.Jump2Achievement, ((config[(JumpManager.eJumpTarget).Achieve4System]).jump_arg)[1])
  FuncArray[(JumpManager.eJumpTarget).Achieve4Oasis] = BindCallback(self, self.Jump2Achievement, ((config[(JumpManager.eJumpTarget).Achieve4Oasis]).jump_arg)[1])
  FuncArray[(JumpManager.eJumpTarget).BuyStamina] = BindCallback(self, self.Jump2BuyStamina)
  FuncArray[(JumpManager.eJumpTarget).DailyChallenge] = BindCallback(self, self.Jump2DailyChallenge)
  FuncArray[(JumpManager.eJumpTarget).WeeklyChallenge] = BindCallback(self, self.Jump2WeeklyChallenge)
  FuncArray[(JumpManager.eJumpTarget).Dorm] = BindCallback(self, self.Jump2Dorm)
  FuncArray[(JumpManager.eJumpTarget).ShopBase] = BindCallback(self, self.Jump2ShopBase)
  FuncArray[(JumpManager.eJumpTarget).Setting] = BindCallback(self, self.Jump2Setting)
  FuncArray[(JumpManager.eJumpTarget).UserCenter] = BindCallback(self, self.Jump2UserCenter)
  FuncArray[(JumpManager.eJumpTarget).UserInfoPage] = BindCallback(self, self.Jump2UserInfoPage)
  FuncArray[(JumpManager.eJumpTarget).OasisBuilding] = BindCallback(self, self.Jump2OasisBuilding)
  FuncArray[(JumpManager.eJumpTarget).StrategyOverview] = BindCallback(self, self.Jump2StrategyOverview)
  FuncArray[(JumpManager.eJumpTarget).fragDungeon] = BindCallback(self, self.Jump2SectorFragDungeon)
  FuncArray[(JumpManager.eJumpTarget).resourceDungeon] = BindCallback(self, self.Jump2SectorResourceDungeon)
  FuncArray[(JumpManager.eJumpTarget).ATHDungeon] = BindCallback(self, self.Jump2SectorATHDungeon)
  FuncArray[(JumpManager.eJumpTarget).DynTask] = BindCallback(self, self.Jump2DynTask)
  FuncArray[(JumpManager.eJumpTarget).DynShop] = BindCallback(self, self.Jump2DynShop)
  FuncArray[(JumpManager.eJumpTarget).DynSectorLevel] = BindCallback(self, self.Jump2DynSectorLevel)
  FuncArray[(JumpManager.eJumpTarget).DynLottery] = BindCallback(self, self.Jump2DynLottery)
  FuncArray[(JumpManager.eJumpTarget).DynActivity] = BindCallback(self, self.Jump2DynActivity)
  FuncArray[(JumpManager.eJumpTarget).DynWarehouse] = BindCallback(self, self.Jump2DynWarehouse)
  FuncArray[(JumpManager.eJumpTarget).DynCareerStO] = BindCallback(self, self.Jump2DynCareerStO)
  ValidateFuncArray[(JumpManager.eJumpTarget).Home] = function()
    -- function num : 0_0_0
    return true
  end

  ValidateFuncArray[(JumpManager.eJumpTarget).ShopInvest] = BindCallback(self, self.Jump2ShopValidate, ((config[(JumpManager.eJumpTarget).ShopInvest]).jump_arg)[1])
  ValidateFuncArray[(JumpManager.eJumpTarget).ShopResident] = BindCallback(self, self.Jump2ShopValidate, ((config[(JumpManager.eJumpTarget).ShopResident]).jump_arg)[1])
  ValidateFuncArray[(JumpManager.eJumpTarget).ShopVariable] = BindCallback(self, self.Jump2ShopValidate, ((config[(JumpManager.eJumpTarget).ShopVariable]).jump_arg)[1])
  ValidateFuncArray[(JumpManager.eJumpTarget).LotteryNormal] = BindCallback(self, self.Jump2LotteryValidate, true)
  ValidateFuncArray[(JumpManager.eJumpTarget).LotteryAdvanced] = BindCallback(self, self.Jump2LotteryValidate, false)
  ValidateFuncArray[(JumpManager.eJumpTarget).Mail] = BindCallback(self, self.Jump2MailValidate, false)
  ValidateFuncArray[(JumpManager.eJumpTarget).Hero] = BindCallback(self, self.Jump2HroValidate, false)
  ValidateFuncArray[(JumpManager.eJumpTarget).Sector] = BindCallback(self, self.Jump2SectorValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).Oasis] = BindCallback(self, self.Jump2OasisValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).Factory] = BindCallback(self, self.Jump2FactoryValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).DaliyTask] = BindCallback(self, self.Jump2TaskValidate, ((config[(JumpManager.eJumpTarget).DaliyTask]).jump_arg)[1])
  ValidateFuncArray[(JumpManager.eJumpTarget).WeeklyTask] = BindCallback(self, self.Jump2TaskValidate, ((config[(JumpManager.eJumpTarget).WeeklyTask]).jump_arg)[1])
  ValidateFuncArray[(JumpManager.eJumpTarget).MainTask] = BindCallback(self, self.Jump2TaskValidate, ((config[(JumpManager.eJumpTarget).MainTask]).jump_arg)[1])
  ValidateFuncArray[(JumpManager.eJumpTarget).SideTask] = BindCallback(self, self.Jump2TaskValidate, ((config[(JumpManager.eJumpTarget).SideTask]).jump_arg)[1])
  ValidateFuncArray[(JumpManager.eJumpTarget).Achieve4Cultivate] = BindCallback(self, self.Jump2AchievementValidate, ((config[(JumpManager.eJumpTarget).Achieve4Cultivate]).jump_arg)[1])
  ValidateFuncArray[(JumpManager.eJumpTarget).Achieve4Commander] = BindCallback(self, self.Jump2AchievementValidate, ((config[(JumpManager.eJumpTarget).Achieve4Commander]).jump_arg)[1])
  ValidateFuncArray[(JumpManager.eJumpTarget).Achieve4Dungeon] = BindCallback(self, self.Jump2AchievementValidate, ((config[(JumpManager.eJumpTarget).Achieve4Dungeon]).jump_arg)[1])
  ValidateFuncArray[(JumpManager.eJumpTarget).Achieve4System] = BindCallback(self, self.Jump2AchievementValidate, ((config[(JumpManager.eJumpTarget).Achieve4System]).jump_arg)[1])
  ValidateFuncArray[(JumpManager.eJumpTarget).Achieve4Oasis] = BindCallback(self, self.Jump2AchievementValidate, ((config[(JumpManager.eJumpTarget).Achieve4Oasis]).jump_arg)[1])
  ValidateFuncArray[(JumpManager.eJumpTarget).BuyStamina] = BindCallback(self, self.Jump2BuyStaminaValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).DailyChallenge] = BindCallback(self, self.Jump2DailyChallengeValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).WeeklyChallenge] = BindCallback(self, self.Jump2WeeklyChallengeValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).Dorm] = BindCallback(self, self.Jump2DormValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).ShopBase] = BindCallback(self, self.Jump2ShopBaseValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).Setting] = BindCallback(self, self.Jump2SettingValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).UserCenter] = BindCallback(self, self.Jump2UserCenterValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).UserInfoPage] = BindCallback(self, self.Jump2UserInfoPageValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).OasisBuilding] = BindCallback(self, self.Jump2OasisBuildingValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).StrategyOverview] = BindCallback(self, self.Jump2StrategyOverviewValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).fragDungeon] = BindCallback(self, self.Jump2SectorFragDungeonValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).resourceDungeon] = BindCallback(self, self.Jump2SectorResourceDungeonValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).ATHDungeon] = BindCallback(self, self.Jump2SectorATHDungeonValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).DynTask] = BindCallback(self, self.Jump2DynTaskValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).DynShop] = BindCallback(self, self.Jump2DynShopValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).DynSectorLevel] = BindCallback(self, self.Jump2DynSectorLevelValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).DynLottery] = BindCallback(self, self.Jump2DynLotteryValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).DynActivity] = BindCallback(self, self.Jump2DynActivityValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).DynWarehouse] = BindCallback(self, self.Jump2DynWarehouseValidate)
  ValidateFuncArray[(JumpManager.eJumpTarget).DynCareerStO] = BindCallback(self, self.Jump2DynCareerStOValidate)
end

JumpManager.Jump = function(self, jumpType, beforeJumpCallback, jumpOverCallback, argList, isCoverJump)
  -- function num : 0_1 , upvalues : JumpManager, FuncArray, _ENV
  local bool, num = self:ValidateJump(jumpType, argList)
  if bool then
    self.isJumping = true
    local newJumpOverCallback = function(...)
    -- function num : 0_1_0 , upvalues : jumpOverCallback, self
    if jumpOverCallback ~= nil then
      jumpOverCallback(...)
    end
    self.isJumping = false
  end

    do
      local RealJumpFunc = function()
    -- function num : 0_1_1 , upvalues : isCoverJump, JumpManager, jumpType, self, FuncArray, num, newJumpOverCallback, argList, _ENV
    if not isCoverJump and JumpManager:IsJumpNeedBack2Home(jumpType) then
      self:Add2OnHomeUIOpenListern(function()
      -- function num : 0_1_1_0 , upvalues : FuncArray, num, newJumpOverCallback, argList
      (FuncArray[num])(newJumpOverCallback, argList, false)
    end
)
      ;
      (UIUtil.ReturnHome)()
    else
      local jumpCorverArgs = nil
      if isCoverJump then
        for typeID,win in pairs(UIManager.windows) do
          if win.fromType == eBaseWinFromWhere.jumpCorver then
            jumpCorverArgs = win.jumpCorverArgs
            win.fromType = nil
            ;
            (UIUtil.ReturnUntil2Marker)(win:GetUIWindowTypeId(), true)
          end
        end
      end
      do
        ;
        (FuncArray[num])(newJumpOverCallback, argList, isCoverJump, jumpCorverArgs)
      end
    end
  end

      if beforeJumpCallback ~= nil then
        beforeJumpCallback(RealJumpFunc)
      else
        RealJumpFunc()
      end
    end
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

JumpManager.__ShowCanotJumpMessage = function(self, fid, lineWrap, notShowMessage)
  -- function num : 0_3 , upvalues : _ENV, cs_MessageCommon
  local des = FunctionUnlockMgr:GetFuncUnlockDecription(fid, lineWrap)
  if notShowMessage then
    return des
  end
  des = (string.format)(ConfigData:GetTipContent(TipContent.Jump_TargetFuncLocked), des)
  ;
  (cs_MessageCommon.ShowMessageTips)(des)
end

JumpManager.IsJumpNeedBack2Home = function(self, jumpType)
  -- function num : 0_4 , upvalues : JumpManager, _ENV, HomeEnum
  local notNeedBack2Home = {(JumpManager.eJumpTarget).BuyStamina, (JumpManager.eJumpTarget).Home, (JumpManager.eJumpTarget).Setting, (JumpManager.eJumpTarget).UserCenter}
  for _,sectorType in ipairs(notNeedBack2Home) do
    if jumpType == sectorType then
      return false
    end
  end
  local isInNormalHome = (ControllerManager:GetController(ControllerTypeId.HomeController)).homeState == (HomeEnum.eHomeState).Normal
  if isInNormalHome then
    return false
  end
  if jumpType == (JumpManager.eJumpTarget).DynShop and UIManager:GetWindow(UIWindowTypeID.ShopMain) ~= nil then
    return false
  end
  local sectorTypes = {(JumpManager.eJumpTarget).Sector, (JumpManager.eJumpTarget).ATHDungeon, (JumpManager.eJumpTarget).fragDungeon, (JumpManager.eJumpTarget).resourceDungeon, (JumpManager.eJumpTarget).DynSectorLevel, (JumpManager.eJumpTarget).DynCareerStO}
  for _,sectorType in ipairs(sectorTypes) do
    if jumpType == sectorType and ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil then
      return false
    end
  end
  local heroTypes = {(JumpManager.eJumpTarget).Hero}
  for _,sectorType in ipairs(heroTypes) do
    if jumpType == sectorType and UIManager:GetWindow(UIWindowTypeID.HeroList) ~= nil then
      return false
    end
  end
  local DormTypes = {(JumpManager.eJumpTarget).Dorm}
  for _,dormType in ipairs(DormTypes) do
    if jumpType == dormType and UIManager:GetWindow(UIWindowTypeID.DormMain) ~= nil then
      return false
    end
  end
  do return true end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

JumpManager.Add2OnHomeUIOpenListern = function(self, jumpfunc)
  -- function num : 0_5 , upvalues : _ENV
  self.back2HomeMsgFunc = function(isBackStackEmpty)
    -- function num : 0_5_0 , upvalues : _ENV, jumpfunc, self
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

    if not isBackStackEmpty then
      UIUtil.isRunningJump = true
    end
    if jumpfunc ~= nil then
      jumpfunc()
    end
    self.back2HomeMsgFunc = nil
  end

end

JumpManager.IsHaveBack2Home = function(self)
  -- function num : 0_6
  do return self.back2HomeMsgFunc ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

JumpManager.TryCallBack2HomeMsgFunc = function(self, isBackStackEmpty)
  -- function num : 0_7
  if self.back2HomeMsgFunc ~= nil then
    (self.back2HomeMsgFunc)(isBackStackEmpty)
    return true
  end
end

JumpManager.GetIsJumping = function(self)
  -- function num : 0_8
  return self.isJumping
end

JumpManager.GetSectorJumpId = function(self)
  -- function num : 0_9
  return self.sectorJumpId
end

JumpManager.RecordSectorJumpId = function(self, id)
  -- function num : 0_10
  self.sectorJumpId = id
end

JumpManager.ClearSectorJumpId = function(self, id)
  -- function num : 0_11
  self.sectorJumpId = nil
end

JumpManager.Jump2Shop = function(self, shopid, jumpOverCallback)
  -- function num : 0_12
  self:Jump2DynShop(jumpOverCallback, {shopid})
end

JumpManager.Jump2ShopValidate = function(self, shopid)
  -- function num : 0_13 , upvalues : _ENV
  if type(shopid) == "table" then
    return self:Jump2DynShopValidate(shopid)
  else
    return self:Jump2DynShopValidate({shopid})
  end
end

JumpManager.Jump2Lottery = function(self, isNormal, jumpOverCallback)
  -- function num : 0_14
  if isNormal then
    self:Jump2DynLottery(jumpOverCallback, {2})
  else
    self:Jump2DynLottery(jumpOverCallback, {1})
  end
end

JumpManager.Jump2LotteryValidate = function(self, isNormal)
  -- function num : 0_15
  if isNormal then
    return self:Jump2DynLotteryValidate({2})
  else
    return self:Jump2DynLotteryValidate({1})
  end
end

JumpManager.Jump2Mail = function(self, jumpOverCallback)
  -- function num : 0_16 , upvalues : _ENV
  local isMailUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Mail)
  if not isMailUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Mail, true)
    return false
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.Mail, function(win)
    -- function num : 0_16_0 , upvalues : jumpOverCallback
    if win ~= nil and jumpOverCallback ~= nil then
      jumpOverCallback()
    end
  end
)
end

JumpManager.Jump2MailValidate = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local isMailUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Mail)
  if not isMailUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Mail, true)
    return false
  end
  return true
end

JumpManager.Jump2Hro = function(self, jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  -- function num : 0_18 , upvalues : _ENV
  local hideWinList = nil
  local fromWhere = eBaseWinFromWhere.home
  local heroPotentialWin = UIManager:GetWindow(UIWindowTypeID.HeroPotential)
  if heroPotentialWin ~= nil then
    (UIUtil.ReturnUntil2Marker)(UIWindowTypeID.HeroPotential, true)
  end
  local heroStateWin = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if heroStateWin ~= nil then
    (UIUtil.ReturnUntil2Marker)(UIWindowTypeID.HeroState, true)
  end
  local heroWin = UIManager:GetWindow(UIWindowTypeID.HeroList)
  if (heroWin == nil or not heroWin.active) and isCoverJump then
    if jumpCorverArgs ~= nil then
      hideWinList = jumpCorverArgs.hideWinList
    else
      hideWinList = UIManager:HideAllWindow({[UIWindowTypeID.TopStatus] = true})
    end
    fromWhere = eBaseWinFromWhere.jumpCorver
  end
  if heroWin ~= nil then
    (UIUtil.ReturnUntil2Marker)(UIWindowTypeID.HeroList)
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return 
  end
  local jumpCorverArgs = {hideWinList = hideWinList, befroeJumpCouldUseItemJump = self:GetBefroeJumpCouldUseItemJump(jumpCorverArgs)}
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroList, function(win)
    -- function num : 0_18_0 , upvalues : _ENV, isCoverJump, jumpCorverArgs, jumpOverCallback
    if win == nil then
      return 
    end
    local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeWindow ~= nil and not isCoverJump then
      homeWindow:OpenOtherWin()
    end
    win.jumpCorverArgs = jumpCorverArgs
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
  end
, nil, fromWhere)
end

JumpManager.Jump2HroValidate = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local isHeroListUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroGroup)
  if not isHeroListUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroGroup, true)
    return false
  end
  return true
end

JumpManager.Jump2Sector = function(self, jumpOverCallback, argList)
  -- function num : 0_20 , upvalues : _ENV
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    (UIUtil.ReturnUntil2Marker)(UIWindowTypeID.Sector)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return 
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  local doNotOpenEpStages = false
  if argList ~= nil then
    doNotOpenEpStages = argList[1]
  end
  ;
  (Home.homeRightNode):OnClickEpBtn(doNotOpenEpStages)
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

JumpManager.Jump2SectorValidate = function(self, argList)
  -- function num : 0_21
  return true
end

JumpManager.Jump2Oasis = function(self, jumpOverCallback)
  -- function num : 0_22 , upvalues : _ENV
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  if Home == nil then
    return 
  end
  ;
  (Home.homeRightNode):OnClickOasisBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

JumpManager.Jump2OasisValidate = function(self)
  -- function num : 0_23 , upvalues : _ENV
  local isOasisUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Building)
  if not isOasisUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Building, true)
    return false
  end
  return true
end

JumpManager.Jump2Factory = function(self, jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  -- function num : 0_24 , upvalues : _ENV
  if not isCoverJump then
    local Home = UIManager:GetWindow(UIWindowTypeID.Home)
    ;
    (Home.homeRightNode):OnClickFactoryBtn()
  else
    do
      local formationCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
      if formationCtrl ~= nil then
        formationCtrl:Delete()
      end
      local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
      if sectorCtrl ~= nil then
        sectorCtrl:Delete()
      end
      do
        local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
        if dormCtrl ~= nil then
          dormCtrl:Delete()
        end
        ;
        (ControllerManager:GetController(ControllerTypeId.Factory, true)):OpenFactory()
        if jumpOverCallback ~= nil then
          jumpOverCallback()
        end
      end
    end
  end
end

JumpManager.Jump2FactoryValidate = function(self)
  -- function num : 0_25 , upvalues : _ENV
  local isFactoryUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Factory)
  if not isFactoryUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Factory, true)
    return false
  end
  return true
end

JumpManager.Jump2Task = function(self, taskTypeID, jumpOverCallback, isCoverJump, jumpCorverArgs)
  -- function num : 0_26
  self:Jump2DynTask(jumpOverCallback, {taskTypeID}, isCoverJump, jumpCorverArgs)
end

JumpManager.Jump2TaskValidate = function(self, taskTypeID)
  -- function num : 0_27
  return self:Jump2DynTaskValidate({taskTypeID})
end

JumpManager.Jump2Achievement = function(self, achievementTypeID, jumpOverCallback, arglist, isCoverJump, jumpCorverArgs)
  -- function num : 0_28 , upvalues : _ENV
  local fromWhere = eBaseWinFromWhere.home
  local hideWinList = nil
  if isCoverJump then
    if jumpCorverArgs ~= nil then
      hideWinList = jumpCorverArgs.hideWinList
    else
      hideWinList = UIManager:HideAllWindow({[UIWindowTypeID.TopStatus] = true})
    end
    fromWhere = eBaseWinFromWhere.jumpCorver
  end
  local jumpCorverArgs = {hideWinList = hideWinList, befroeJumpCouldUseItemJump = self:GetBefroeJumpCouldUseItemJump(jumpCorverArgs)}
  UIManager:ShowWindowAsync(UIWindowTypeID.AchievementSystem, function(win)
    -- function num : 0_28_0 , upvalues : _ENV, isCoverJump, jumpOverCallback, jumpCorverArgs
    do
      if win ~= nil then
        local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
        if homeWindow ~= nil and not isCoverJump then
          homeWindow:OpenOtherWin()
        end
        win:InitAchievement(nil, Home ~= nil)
        if jumpOverCallback ~= nil then
          jumpOverCallback()
        end
        win.jumpCorverArgs = jumpCorverArgs
      end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
, nil, fromWhere)
end

JumpManager.Jump2AchievementValidate = function(self, achievementTypeID)
  -- function num : 0_29 , upvalues : _ENV
  local isAchUIUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement)
  if not isAchUIUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Achievement, true)
    return false
  end
  return true
end

JumpManager.Jump2BuyStamina = function(self, jumpOverCallback, argList)
  -- function num : 0_30 , upvalues : _ENV
  local ShopEnum = require("Game.Shop.ShopEnum")
  local quickBuyData = (ShopEnum.eQuickBuy).stamina
  local shopId = quickBuyData.shopId
  local shelfId = quickBuyData.shelfId
  local goodData = nil
  local ctrl = (ControllerManager:GetController(ControllerTypeId.Shop, true))
  local needNum, closeCallback = nil, nil
  if argList ~= nil then
    needNum = argList[1]
    closeCallback = argList[2]
  end
  local buyKeyWin = UIManager:GetWindow(UIWindowTypeID.QuickBuyKey)
  if buyKeyWin ~= nil then
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return 
  end
  ctrl:GetShopData(shopId, function(shopData)
    -- function num : 0_30_0 , upvalues : goodData, shelfId, _ENV, jumpOverCallback, needNum, closeCallback
    goodData = (shopData.shopGoodsDic)[shelfId]
    UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuyKey, function(win)
      -- function num : 0_30_0_0 , upvalues : _ENV, jumpOverCallback, needNum, goodData, closeCallback
      if win == nil then
        error("can\'t open QuickBuy win")
        if jumpOverCallback ~= nil then
          jumpOverCallback()
        end
        return 
      end
      win:SlideIn(true)
      win:InitQuickPurchaseKey(nil, needNum, goodData, closeCallback)
      if jumpOverCallback ~= nil then
        jumpOverCallback()
      end
    end
)
  end
)
end

JumpManager.Jump2BuyStaminaValidate = function(self)
  -- function num : 0_31 , upvalues : _ENV
  local ctrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
  if not ctrl:GetIsUnlock() then
    ((CS.MessageCommon).ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.notUnlockShopCantBuyStamina))
    return false
  end
  return true
end

JumpManager.Jump2DailyChallenge = function(self, jumpOverCallback)
  -- function num : 0_32 , upvalues : _ENV
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    (UIUtil.ReturnUntil2Marker)(UIWindowTypeID.Sector)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    ;
    (sectorController.uiCanvas):OnClickDailyDungeon()
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return 
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  Home.enterSectorJumpCallback = BindCallback(self, function()
    -- function num : 0_32_0 , upvalues : _ENV, self
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can\'t get sectorController")
      return 
    end
    ;
    (sectorController.uiCanvas):OnClickDailyDungeon()
    self:ClearSectorJumpId()
  end
)
  ;
  (Home.homeRightNode):OnClickEpBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

JumpManager.Jump2DailyChallengeValidate = function(self)
  -- function num : 0_33 , upvalues : _ENV
  local isDailyChallengeUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DailyDungeon)
  if not isDailyChallengeUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge, true)
    return false
  end
  return true
end

JumpManager.Jump2WeeklyChallenge = function(self, jumpOverCallback)
  -- function num : 0_34 , upvalues : _ENV
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    (UIUtil.ReturnUntil2Marker)(UIWindowTypeID.Sector)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    ;
    (sectorController.uiCanvas):OnClickWeeklyChallenge()
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return 
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  Home.enterSectorJumpCallback = BindCallback(self, function()
    -- function num : 0_34_0 , upvalues : _ENV, self
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can\'t get sectorController")
      return 
    end
    ;
    (sectorController.uiCanvas):OnClickWeeklyChallenge()
    self:ClearSectorJumpId()
  end
)
  ;
  (Home.homeRightNode):OnClickEpBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

JumpManager.Jump2WeeklyChallengeValidate = function(self)
  -- function num : 0_35 , upvalues : _ENV
  local isWeeklyChallengeUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge)
  if not isWeeklyChallengeUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge, true)
    return false
  end
  return true
end

JumpManager.Jump2Dorm = function(self, jumpOverCallback)
  -- function num : 0_36 , upvalues : _ENV
  if (UIUtil.CheckIsHaveSpecialMarker)(UIWindowTypeID.DormMain) then
    (UIUtil.ReturnUntil2Marker)(UIWindowTypeID.DormMain)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return 
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  ;
  (Home.homeRightNode):OnClickDormBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

JumpManager.Jump2ShopBase = function(self, jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  -- function num : 0_37 , upvalues : JumpManager, _ENV
  local isShopShowBeforeUnlock = JumpManager:Jump2DynShopBeforeUnlock(argList)
  if isShopShowBeforeUnlock == false and not JumpManager:Jump2DynShopValidate(argList) then
    return 
  end
  local fromWhere = eBaseWinFromWhere.home
  local hideWinList = nil
  if isCoverJump then
    if jumpCorverArgs ~= nil then
      hideWinList = jumpCorverArgs.hideWinList
    else
      hideWinList = UIManager:HideAllWindow({[UIWindowTypeID.TopStatus] = true})
    end
    fromWhere = eBaseWinFromWhere.jumpCorver
  end
  local shopId, shopDataId, shopPageId = nil, nil, nil
  if argList ~= nil then
    shopId = argList[1]
    shopDataId = argList[2]
    shopPageId = argList[3]
  end
  local shopWin = UIManager:GetWindow(UIWindowTypeID.ShopMain)
  if shopWin ~= nil then
    (UIUtil.ReturnUntil2Marker)(UIWindowTypeID.ShopMain, false)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ShopMain, function(win)
    -- function num : 0_37_0 , upvalues : isShopShowBeforeUnlock, shopId, shopDataId, shopPageId, _ENV, isCoverJump, jumpOverCallback
    if win ~= nil then
      if isShopShowBeforeUnlock then
        if shopId == nil then
          win:InitShopMainBeforeUnlock()
        else
          win:InitShopMainBeforeUnlock(shopId, shopDataId, shopPageId)
        end
      else
        if shopId == nil then
          win:InitShopMain()
        else
          win:InitShopMain(shopId, shopDataId, shopPageId)
        end
      end
      local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
      if homeWindow ~= nil and not isCoverJump then
        homeWindow:OpenOtherWin()
      end
      if jumpOverCallback ~= nil then
        jumpOverCallback()
      end
    end
  end
, nil, fromWhere)
end

JumpManager.Jump2DormValidate = function(self)
  -- function num : 0_38 , upvalues : _ENV
  local isDormUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Dorm)
  if not isDormUnlock then
    return false
  end
  return true
end

JumpManager.Jump2ShopBaseValidate = function(self)
  -- function num : 0_39
  return true
end

JumpManager.Jump2StrategyOverview = function(self, jumpOverCallback, argList)
  -- function num : 0_40 , upvalues : _ENV
  local sectorId = argList ~= nil and argList[1] or nil
  local buildId = argList ~= nil and argList[2] or nil
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    (UIUtil.ReturnUntil2Marker)(UIWindowTypeID.Sector)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    sectorController:ShowStrategyOverview(sectorId, buildId)
  else
    local Home = UIManager:GetWindow(UIWindowTypeID.Home)
    Home.enterSectorJumpCallback = BindCallback(self, function()
    -- function num : 0_40_0 , upvalues : _ENV, sectorId, buildId
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can\'t get sectorController")
      return 
    end
    sectorController:ShowStrategyOverview(sectorId, buildId)
  end
)
    ;
    (Home.homeRightNode):OnClickEpBtn()
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

JumpManager.Jump2StrategyOverviewValidate = function(self, argList)
  -- function num : 0_41 , upvalues : _ENV, cs_MessageCommon
  local isAllow = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding)
  if not isAllow then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding, true)
  end
  do
    if argList ~= nil and #argList > 0 then
      local sectorId = argList[1]
      isAllow = (PlayerDataCenter.sectorStage):IsSectorUnlock(sectorId)
      if not isAllow then
        (cs_MessageCommon.ShowMessageTipsWithErrorSound)(ConfigData:GetTipContent(TipContent.Sector_Locked))
      end
    end
    return isAllow
  end
end

JumpManager.Jump2DynCareerStO = function(self, jumpOverCallback, argList)
  -- function num : 0_42 , upvalues : _ENV
  local buildId = argList ~= nil and argList[1] or nil
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    (UIUtil.ReturnUntil2Marker)(UIWindowTypeID.Sector)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    sectorController:ShowCareerStO(buildId)
  else
    local Home = UIManager:GetWindow(UIWindowTypeID.Home)
    Home.enterSectorJumpCallback = BindCallback(self, function()
    -- function num : 0_42_0 , upvalues : _ENV, buildId
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can\'t get sectorController")
      return 
    end
    sectorController:ShowCareerStO(buildId)
  end
)
    ;
    (Home.homeRightNode):OnClickEpBtn()
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

JumpManager.Jump2DynCareerStOValidate = function(self, argList)
  -- function num : 0_43 , upvalues : _ENV
  local isAllow = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding1)
  if not isAllow then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_SectorBuilding1, true)
  end
  return isAllow
end

JumpManager.Jump2OasisBuilding = function(self, jumpOverCallback, argList)
  -- function num : 0_44 , upvalues : _ENV
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
    -- function num : 0_44_0 , upvalues : oasisController, buildId
    oasisController.selectBuiltId = nil
    oasisController:BuildingUpgrade(buildId, true)
  end
)
    ;
    (Home.homeRightNode):OnClickOasisBtn()
    oasisController.selectBuiltId = buildId
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
  end
end

JumpManager.Jump2OasisBuildingValidate = function(self, argList)
  -- function num : 0_45 , upvalues : _ENV
  local isOasisUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Building)
  if not isOasisUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Building, true)
    return false
  end
  return true
end

JumpManager.Jump2SectorFragDungeon = function(self, jumpOverCallback, argList)
  -- function num : 0_46 , upvalues : _ENV
  local heroId = argList[1]
  self:RecordSectorJumpId(22)
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    (UIUtil.ReturnUntil2Marker)(UIWindowTypeID.Sector)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    ;
    (sectorController.uiCanvas):EnterFriendshipDungeon(heroId, true)
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return 
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  Home.enterSectorJumpCallback = BindCallback(self, function()
    -- function num : 0_46_0 , upvalues : _ENV, heroId, self
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can\'t get sectorController")
      return 
    end
    ;
    (sectorController.uiCanvas):EnterFriendshipDungeon(heroId, true)
    self:ClearSectorJumpId()
  end
)
  ;
  (Home.homeRightNode):OnClickEpBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

JumpManager.Jump2SectorFragDungeonValidate = function(self, argList, notShowMessage)
  -- function num : 0_47 , upvalues : _ENV, cs_MessageCommon
  local isFragDungeonUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship_sector_Ui)
  do
    if not isFragDungeonUnlock then
      local unlockNotice = self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship_sector_Ui, true, notShowMessage)
      return false, unlockNotice
    end
    local heroId = argList[1]
    if heroId == nil then
      return true
    end
    local heroData = (PlayerDataCenter.heroDic)[heroId]
    if heroData == nil then
      return false
    end
    local frageDungeonData = nil
    local DungeonData = require("Game.Dungeon.DungeonData")
    frageDungeonData = (DungeonData.CreateDungeonData4Frage)(nil, heroData)
    local isFrageUnlock = frageDungeonData:UnlockAndHasStageOpen()
    if not isFrageUnlock then
      local stageCfg = frageDungeonData:GetNewLockStage()
      local unlockNotice = (CheckCondition.GetUnlockInfoLua)(stageCfg.pre_condition, stageCfg.pre_para1, stageCfg.pre_para2)
      do
        do
          if not notShowMessage then
            local des = (string.format)(ConfigData:GetTipContent(TipContent.Jump_TargetFuncLocked), unlockNotice)
            ;
            (cs_MessageCommon.ShowMessageTips)(des)
          end
          do return false, unlockNotice end
          return true
        end
      end
    end
  end
end

JumpManager.Jump2SectorResourceDungeon = function(self, jumpOverCallback, argList)
  -- function num : 0_48 , upvalues : _ENV
  local typeID = argList[1]
  self:RecordSectorJumpId(11)
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    (UIUtil.ReturnUntil2Marker)(UIWindowTypeID.Sector)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    ;
    (sectorController.uiCanvas):EnterMatDungeon(typeID, true)
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return 
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  Home.enterSectorJumpCallback = BindCallback(self, function()
    -- function num : 0_48_0 , upvalues : _ENV, typeID, self
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can\'t get sectorController")
      return 
    end
    ;
    (sectorController.uiCanvas):EnterMatDungeon(typeID, true)
    self:ClearSectorJumpId()
  end
)
  ;
  (Home.homeRightNode):OnClickEpBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

JumpManager.Jump2SectorResourceDungeonValidate = function(self, argList, notShowMessage)
  -- function num : 0_49 , upvalues : _ENV
  local isMatDungeonUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_MaterialDungeon)
  do
    if not isMatDungeonUnlock then
      local unlockNotice = self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_MaterialDungeon, true, notShowMessage)
      return false, unlockNotice
    end
    local typeID = argList[1]
    if typeID == nil or (ConfigData.material_dungeon)[typeID] == nil then
      error("bad jump arg Jump2SectorFragDungeon typeID:" .. tostring(typeID))
      return false
    end
    local isSpecificDungeonUnlock = FunctionUnlockMgr:ValidateUnlock(typeID)
    do
      if not isSpecificDungeonUnlock then
        local unlockNotice = self:__ShowCanotJumpMessage(typeID, true, notShowMessage)
        return false, unlockNotice
      end
      return true
    end
  end
end

JumpManager.Jump2SectorATHDungeon = function(self, jumpOverCallback, argList)
  -- function num : 0_50 , upvalues : _ENV
  local typeID = argList[1]
  self:RecordSectorJumpId(13)
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    (UIUtil.ReturnUntil2Marker)(UIWindowTypeID.Sector)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    ;
    (sectorController.uiCanvas):EnterATHDungeon(typeID, true)
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return 
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  Home.enterSectorJumpCallback = BindCallback(self, function()
    -- function num : 0_50_0 , upvalues : _ENV, typeID, self
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can\'t get sectorController")
      return 
    end
    sectorController:OnEnterPlotOrMateralDungeon()
    ;
    (sectorController.uiCanvas):EnterATHDungeon(typeID, true)
    self:ClearSectorJumpId()
  end
)
  ;
  (Home.homeRightNode):OnClickEpBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

JumpManager.Jump2SectorATHDungeonValidate = function(self, argList, notShowMessage)
  -- function num : 0_51 , upvalues : _ENV
  local isATHDungeonUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_ATHDungeon)
  do
    if not isATHDungeonUnlock then
      local unlockNotice = self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_ATHDungeon, true, notShowMessage)
      return false, unlockNotice
    end
    local typeID = argList[1]
    if typeID == nil or (ConfigData.material_dungeon)[typeID] == nil then
      error("bad jump arg Jump2SectorATHDungeon typeID:" .. tostring(typeID))
      return false
    end
    return true
  end
end

JumpManager.Jump2DynTask = function(self, jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  -- function num : 0_52 , upvalues : _ENV
  local hideWinList = nil
  local fromWhere = eBaseWinFromWhere.home
  local taskWin = UIManager:GetWindow(UIWindowTypeID.Task)
  if (taskWin == nil or not taskWin.active) and isCoverJump then
    if jumpCorverArgs ~= nil then
      hideWinList = jumpCorverArgs.hideWinList
    else
      hideWinList = UIManager:HideAllWindow({[UIWindowTypeID.TopStatus] = true})
    end
    fromWhere = eBaseWinFromWhere.jumpCorver
  end
  local typeID = nil
  if argList ~= nil then
    typeID = argList[1]
  end
  local taskController = ControllerManager:GetController(ControllerTypeId.Task, true)
  local jumpCorverArgs = {hideWinList = hideWinList, befroeJumpCouldUseItemJump = self:GetBefroeJumpCouldUseItemJump(jumpCorverArgs)}
  taskController:ShowTaskUI(typeID, fromWhere, function()
    -- function num : 0_52_0 , upvalues : jumpOverCallback, _ENV, isCoverJump, jumpCorverArgs
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeWindow ~= nil and not isCoverJump then
      homeWindow:OpenOtherWin()
    end
    local taskWin = UIManager:GetWindow(UIWindowTypeID.Task)
    if taskWin ~= nil then
      taskWin.jumpCorverArgs = jumpCorverArgs
    end
  end
)
end

JumpManager.Jump2DynTaskValidate = function(self, argList)
  -- function num : 0_53 , upvalues : _ENV
  local isTaskUIUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TaskUi)
  if not isTaskUIUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_TaskUi, true)
    return false
  end
  local taskController = (ControllerManager:GetController(ControllerTypeId.Task, true))
  local typeID = nil
  if argList ~= nil then
    typeID = argList[1]
  end
  if typeID == nil then
    return true
  end
  local PageGroupList = taskController:GetPageGroupList()
  for _,group in pairs(PageGroupList) do
    for _,typeId in pairs(group) do
      if typeID == typeId then
        return true
      end
    end
  end
  return false
end

JumpManager.Jump2DynShop = function(self, jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  -- function num : 0_54 , upvalues : _ENV
  local fromWhere = eBaseWinFromWhere.home
  local hideWinList = nil
  if isCoverJump then
    if jumpCorverArgs ~= nil then
      hideWinList = jumpCorverArgs.hideWinList
    else
      hideWinList = UIManager:HideAllWindow({[UIWindowTypeID.TopStatus] = true})
    end
    fromWhere = eBaseWinFromWhere.jumpCorver
  end
  local shopId, shopDataId, shopPageId = nil, nil, nil
  if argList ~= nil then
    shopId = argList[1]
    shopDataId = argList[2]
    shopPageId = argList[3]
  end
  local shopWin = UIManager:GetWindow(UIWindowTypeID.ShopMain)
  if shopWin ~= nil then
    (UIUtil.ReturnUntil2Marker)(UIWindowTypeID.ShopMain, false)
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ShopMain, function(win)
    -- function num : 0_54_0 , upvalues : shopId, shopDataId, shopPageId, _ENV, isCoverJump, jumpOverCallback
    if win ~= nil then
      if shopId == nil then
        win:InitShopMain()
      else
        win:InitShopMain(shopId, shopDataId, shopPageId)
      end
      local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
      if homeWindow ~= nil and not isCoverJump then
        homeWindow:OpenOtherWin()
      end
      if jumpOverCallback ~= nil then
        jumpOverCallback()
      end
    end
  end
, nil, fromWhere)
end

JumpManager.Jump2DynShopValidate = function(self, argList, notShowMessage)
  -- function num : 0_55 , upvalues : _ENV
  local isShopUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Store)
  do
    if not isShopUnlock then
      local unlockNotice = self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Store, true, notShowMessage)
      return false, unlockNotice
    end
    local shopId = argList[1]
    if shopId == nil or (ConfigData.shop)[shopId] == nil then
      return false
    end
    local ShopController = ControllerManager:GetController(ControllerTypeId.Shop, true)
    local isUnlcok, unlockNotice = ShopController:ShopIsUnlock(shopId)
    return isUnlcok, unlockNotice
  end
end

JumpManager.Jump2DynShopBeforeUnlock = function(self, argList, notShowMessage)
  -- function num : 0_56 , upvalues : _ENV
  local shopId = argList[1]
  if shopId == nil or (ConfigData.shop)[shopId] == nil then
    return false
  end
  local ShopController = ControllerManager:GetController(ControllerTypeId.Shop, true)
  if not ShopController:ShopShowBeforeUnlock(shopId) then
    return false
  end
  local isUnlcok, unlockNotice = ShopController:ShopIsUnlock(shopId)
  local isShopUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Store)
  if isUnlcok == true and isShopUnlock == false then
    return true
  else
    return false
  end
end

JumpManager.Jump2DynSectorLevel = function(self, jumpOverCallback, argList)
  -- function num : 0_57 , upvalues : JumpManager, _ENV
  local sectorLevelId = nil
  if argList ~= nil then
    sectorLevelId = argList[1]
  end
  if sectorLevelId == nil then
    JumpManager:Jump2Sector(jumpOverCallback)
  end
  self:RecordSectorJumpId(sectorLevelId * 10)
  local isInSector = ControllerManager:GetController(ControllerTypeId.SectorController) ~= nil
  if isInSector then
    (UIUtil.ReturnUntil2Marker)(UIWindowTypeID.Sector)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    sectorController:OnSectorItemClicked(sectorLevelId)
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return 
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  Home.enterSectorJumpCallback = BindCallback(self, function()
    -- function num : 0_57_0 , upvalues : _ENV, sectorLevelId, self
    local sectorController = ControllerManager:GetController(ControllerTypeId.SectorController, false)
    if sectorController == nil then
      error("can\'t get sectorController")
      return 
    end
    sectorController:SetJumpInCallback(function()
      -- function num : 0_57_0_0 , upvalues : sectorController, sectorLevelId, self
      sectorController:OnSectorItemClicked(sectorLevelId)
      self:ClearSectorJumpId()
    end
)
  end
)
  ;
  (Home.homeRightNode):OnClickEpBtn()
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

JumpManager.Jump2DynSectorLevelValidate = function(self, argList)
  -- function num : 0_58
  if argList == nil or argList[1] == nil then
    return false
  end
  return true
end

JumpManager.Jump2DynLottery = function(self, jumpOverCallback, argList)
  -- function num : 0_59 , upvalues : _ENV
  local poolId = nil
  if argList ~= nil then
    poolId = argList[1]
  end
  local Home = UIManager:GetWindow(UIWindowTypeID.Home)
  ;
  (Home.homeRightNode):OnClickLotteryBtn(poolId)
  if jumpOverCallback ~= nil then
    jumpOverCallback()
  end
end

JumpManager.Jump2DynLotteryValidate = function(self, argList)
  -- function num : 0_60 , upvalues : _ENV
  local isLotteryUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Lottery)
  if not isLotteryUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_Lottery, true)
    return false
  end
  return true
end

JumpManager.Jump2DynActivity = function(self, jumpOverCallback, argList)
  -- function num : 0_61 , upvalues : _ENV
  local activityFrameCtrl = (ControllerManager:GetController(ControllerTypeId.ActivityFrame))
  -- DECOMPILER ERROR at PC5: Overwrote pending register: R4 in 'AssignReg'

  local activityId, category = .end, nil
  if argList ~= nil then
    activityId = argList[1]
    category = argList[2]
  end
  do
    if activityId or 0 > 0 then
      local activityFrameData = activityFrameCtrl:GetActivityFrameData(activityId)
      category = activityFrameData:GetEnterType()
    end
    if category or 0 == 0 or not activityFrameCtrl:IsHaveShowByEnterType(category) then
      category = activityFrameCtrl:GetIsHaveUnlockedActivity()
    end
    local Home = UIManager:GetWindow(UIWindowTypeID.Home)
    if Home ~= nil then
      (Home.homeLeftNode):OnClickActivity(category, activityId)
    end
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
  end
end

JumpManager.Jump2DynActivityValidate = function(self, argList)
  -- function num : 0_62 , upvalues : _ENV
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  if activityFrameCtrl == nil then
    return false
  end
  if argList[1] or argList == nil or 0 > 0 then
    local activityId = argList[1]
    local activityFrameData = activityFrameCtrl:GetActivityFrameData(activityId)
    if activityFrameData == nil or not activityFrameData:GetCouldShowActivity() then
      return false
    end
  else
    do
      do
        local couldJumpEnterType = activityFrameCtrl:GetIsHaveUnlockedActivity()
        if couldJumpEnterType == nil then
          return false
        end
        return true
      end
    end
  end
end

JumpManager.DirectShowShop = function(self, beforeJumpCallback, jumpOverCallback, shopId, unCtrlTopbtn)
  -- function num : 0_63 , upvalues : JumpManager, _ENV
  local argList = {shopId}
  local isShopShowBeforeUnlock = JumpManager:Jump2DynShopBeforeUnlock(argList)
  if isShopShowBeforeUnlock == false and not JumpManager:Jump2DynShopValidate(argList) then
    return 
  end
  if beforeJumpCallback ~= nil then
    beforeJumpCallback()
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.ShopMain, function(win)
    -- function num : 0_63_0 , upvalues : isShopShowBeforeUnlock, shopId, _ENV, unCtrlTopbtn, jumpOverCallback
    if win == nil then
      return 
    end
    if isShopShowBeforeUnlock then
      win:InitShopMainBeforeUnlock(shopId)
    else
      win:InitShopMain(shopId)
    end
    local window = UIManager:GetWindow(UIWindowTypeID.TopStatus)
    if window ~= nil and not unCtrlTopbtn then
      (window.topGroup):RefreshouldShowNaviBtn(false)
      ;
      (window.topGroup):ShowTopBtnGroupGoHomeBtn(false)
    end
    win:SetShopMainCloseFunc(function()
      -- function num : 0_63_0_0 , upvalues : _ENV, unCtrlTopbtn
      local window = UIManager:GetWindow(UIWindowTypeID.TopStatus)
      if window ~= nil and not unCtrlTopbtn then
        (window.topGroup):RefreshouldShowNaviBtn(true)
        ;
        (window.topGroup):ShowTopBtnGroupGoHomeBtn(true)
      end
    end
)
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
  end
)
end

JumpManager.Jump2DynWarehouseValidate = function(self, argList)
  -- function num : 0_64 , upvalues : _ENV
  return FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Backpack_ui)
end

JumpManager.Jump2DynWarehouse = function(self, jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  -- function num : 0_65 , upvalues : _ENV
  local hideWinList = nil
  local fromWhere = eBaseWinFromWhere.home
  local wareHouseWin = UIManager:GetWindow(UIWindowTypeID.Warehouse)
  if (wareHouseWin == nil or not wareHouseWin.active) and isCoverJump then
    if jumpCorverArgs ~= nil then
      hideWinList = jumpCorverArgs.hideWinList
    else
      hideWinList = UIManager:HideAllWindow({[UIWindowTypeID.TopStatus] = true})
    end
    fromWhere = eBaseWinFromWhere.jumpCorver
  end
  if argList ~= nil or not argList then
    local itemId = argList[1]
  end
  if argList ~= nil or not argList then
    local openType = argList[2]
  end
  local jumpCorverArgs = {hideWinList = hideWinList, befroeJumpCouldUseItemJump = self:GetBefroeJumpCouldUseItemJump(jumpCorverArgs)}
  UIManager:ShowWindowAsync(UIWindowTypeID.Warehouse, function(window)
    -- function num : 0_65_0 , upvalues : _ENV, isCoverJump, itemId, openType, jumpCorverArgs, jumpOverCallback
    local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeWindow ~= nil and not isCoverJump then
      homeWindow:OpenOtherWin()
    end
    window:InitWarehouse(itemId, openType)
    window.jumpCorverArgs = jumpCorverArgs
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
  end
, nil, fromWhere)
end

JumpManager.Jump2SettingValidate = function(self)
  -- function num : 0_66
  return true
end

JumpManager.Jump2Setting = function(self, jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  -- function num : 0_67 , upvalues : _ENV
  local oringLayoutLevel = (UIWindowGlobalConfig[UIWindowTypeID.Setting]).LayoutLevel
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (UIWindowGlobalConfig[UIWindowTypeID.Setting]).LayoutLevel = EUILayoutLevel.OverHigh
  UIManager:ShowWindowAsync(UIWindowTypeID.Setting, function(win)
    -- function num : 0_67_0 , upvalues : _ENV, oringLayoutLevel
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

    if win ~= nil then
      ((win.ui).background).enabled = false
      win:SetFromWhichUI(nil)
      local topWin = UIManager:GetWindow(UIWindowTypeID.TopStatus)
      do
        local isHaveTopStatus = (topWin ~= nil and topWin.active)
        if isHaveTopStatus then
          (UIUtil.HideTopStatus)()
        end
        win:SetUIMailHideCallback(function()
      -- function num : 0_67_0_0 , upvalues : isHaveTopStatus, _ENV
      if isHaveTopStatus then
        (UIUtil.ReShowTopStatus)()
      end
    end
)
        win:InitSettingByFrom()
        -- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (UIWindowGlobalConfig[UIWindowTypeID.Setting]).LayoutLevel = oringLayoutLevel
      end
    end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
)
end

JumpManager.Jump2UserCenterValidate = function(self)
  -- function num : 0_68
  return true
end

JumpManager.Jump2UserCenter = function(self, jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  -- function num : 0_69 , upvalues : _ENV
  if not ((CS.MicaSDKManager).Instance):IsUseSdk() then
    warn("当前未使用SDK，无法转跳到用户中心")
  end
  ;
  ((CS.MicaSDKManager).Instance):OpenUserCenter()
end

JumpManager.Jump2UserInfoPageValidate = function(self)
  -- function num : 0_70 , upvalues : _ENV
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_CommanderInformation)
  if not isUnlock then
    self:__ShowCanotJumpMessage(proto_csmsg_SystemFunctionID.SystemFunctionID_CommanderInformation, true)
  end
  return isUnlock
end

JumpManager.Jump2UserInfoPage = function(self, jumpOverCallback, argList, isCoverJump, jumpCorverArgs)
  -- function num : 0_71 , upvalues : _ENV
  local hideWinList = nil
  local fromWhere = eBaseWinFromWhere.home
  local userInfoWin = UIManager:GetWindow(UIWindowTypeID.UserInfo)
  if (userInfoWin == nil or not userInfoWin.active) and isCoverJump then
    if jumpCorverArgs ~= nil then
      hideWinList = jumpCorverArgs.hideWinList
    else
      hideWinList = UIManager:HideAllWindow({[UIWindowTypeID.TopStatus] = true})
    end
    fromWhere = eBaseWinFromWhere.jumpCorver
  end
  if userInfoWin ~= nil then
    (UIUtil.ReturnUntil2Marker)(UIWindowTypeID.UserInfo)
    if jumpOverCallback ~= nil then
      jumpOverCallback()
    end
    return 
  end
  local jumpCorverArgs = {hideWinList = hideWinList, befroeJumpCouldUseItemJump = self:GetBefroeJumpCouldUseItemJump(jumpCorverArgs)}
  UIManager:ShowWindowAsync(UIWindowTypeID.UserInfo, function(win)
    -- function num : 0_71_0 , upvalues : _ENV, isCoverJump, jumpCorverArgs, jumpOverCallback
    if win ~= nil then
      local homeWindow = UIManager:GetWindow(UIWindowTypeID.Home)
      if homeWindow ~= nil and not isCoverJump then
        homeWindow:OpenOtherWin()
      end
      win.jumpCorverArgs = jumpCorverArgs
      win:InitUserInfo()
      if jumpOverCallback ~= nil then
        jumpOverCallback()
      end
    end
  end
, nil, fromWhere)
end

JumpManager.GetBefroeJumpCouldUseItemJump = function(self, jumpCorverArgs)
  -- function num : 0_72
  if jumpCorverArgs ~= nil and jumpCorverArgs.befroeJumpCouldUseItemJump ~= nil then
    return jumpCorverArgs.befroeJumpCouldUseItemJump
  end
  return self.couldUseItemJump
end

JumpManager.CleanJumpManager = function(self)
  -- function num : 0_73
  self.couldUseItemJump = false
end

JumpManager:Init()
JumpManager.ValidateFuncArray = ValidateFuncArray
return JumpManager

