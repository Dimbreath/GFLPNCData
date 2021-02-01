-- params : ...
-- function num : 0 , upvalues : _ENV
local UnlockFunc = {}
UnlockFunc.onUnlockTaskUI = function(self)
  -- function num : 0_0 , upvalues : _ENV
  local ctrl = ControllerManager:GetController(ControllerTypeId.HomeController)
  if ctrl ~= nil then
    ctrl:OnUpdateTask()
  end
end

UnlockFunc.onUnlockDailyAndWeeklyTaskUI = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (PlayerDataCenter.allTaskData):InitNormalTaskRedDot()
  local ctrl = ControllerManager:GetController(ControllerTypeId.Task)
  if ctrl ~= nil then
    ctrl:SetDailyAndWeeklyLock()
  end
end

UnlockFunc.onUnlockShop = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local uiHome = UIManager:GetWindow(UIWindowTypeID.Home)
  if uiHome ~= nil then
    (uiHome.rightList):RefreshFrgShopBtn()
    ;
    (uiHome.rightList):RefreshShopBtn()
  end
  ;
  (ControllerManager:GetController(ControllerTypeId.Shop, true)):SetIsUnLock(true)
end

UnlockFunc.onUnlockOasis = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local uiHome = UIManager:GetWindow(UIWindowTypeID.Home)
  if uiHome ~= nil then
    (uiHome.rightList):RefreshOasisBtn()
  end
end

UnlockFunc.onUnlockSector = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local uiHome = UIManager:GetWindow(UIWindowTypeID.Home)
  if uiHome ~= nil then
    (uiHome.rightList):RefreshEpBtn()
  end
end

UnlockFunc.onUnlockHeroList = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local uiHome = UIManager:GetWindow(UIWindowTypeID.Home)
  if uiHome ~= nil then
    (uiHome.rightList):RefreshHeroListBtn()
  end
end

UnlockFunc.onUnlockLottery = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local uiHome = UIManager:GetWindow(UIWindowTypeID.Home)
  if uiHome ~= nil then
    (uiHome.rightList):RefreshLotteryBtn()
  end
end

UnlockFunc.onUnlockFactory = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local uiHome = UIManager:GetWindow(UIWindowTypeID.Home)
  if uiHome ~= nil then
    (uiHome.rightList):RefreshFactoryBtn()
  end
end

UnlockFunc.onUnlockTraining = function(self)
  -- function num : 0_8
end

UnlockFunc.onUnlockSocial = function(self)
  -- function num : 0_9
end

UnlockFunc.onUnlockHeroEnter = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local uiTraining = UIManager:GetWindow(UIWindowTypeID.Training)
  if uiTraining ~= nil then
    uiTraining:OnStaffInfoUnlock(true)
  end
end

UnlockFunc.onUnlockEnemyDetail = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local uiBattleDeploy = UIManager:GetWindow(UIWindowTypeID.BattleDeploy)
  if uiBattleDeploy ~= nil then
    uiBattleDeploy:OnEnemyDetailUnlock(true)
  end
end

UnlockFunc.onUnlockDorm = function(self, self)
  -- function num : 0_12 , upvalues : _ENV
  local uiHome = UIManager:GetWindow(UIWindowTypeID.Home)
  if uiHome ~= nil then
    (uiHome.rightList):RefreshDormBtn()
  end
end

UnlockFunc.onUnlockRandom = function(self, self)
  -- function num : 0_13
end

UnlockFunc.onUnlockCommanderSkill = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local uiFormation = UIManager:GetWindow(UIWindowTypeID.Formation)
  if uiFormation ~= nil then
    uiFormation:UnlockCommanderSkillUI(FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill_Ui))
  end
end

UnlockFunc.onUnlockCommanderSkillUI = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local uiFormation = UIManager:GetWindow(UIWindowTypeID.Formation)
  if uiFormation ~= nil then
    uiFormation:UnlockCommanderSkillUI(FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill))
  end
end

UnlockFunc.onUnlockStarUp = function(self, self)
  -- function num : 0_16 , upvalues : _ENV
  local winHreoState = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if winHreoState ~= nil then
    winHreoState:UnlockStarup(true)
  end
  local ok, heroWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow)
  if not ok then
    return 
  end
  for heroId,heroData in pairs(PlayerDataCenter.heroDic) do
    local heroNode = heroWindowNode:AddChildWithPath(heroId, RedDotDynPath.HeroCardPath)
    local heroStarNode = heroNode:AddChildWithPath(RedDotStaticTypeId.HeroStarUp, RedDotDynPath.HeroCardStartUpPath)
    if heroData:AbleUpgradeStar() then
      heroStarNode:SetRedDotCount(1)
    else
      heroStarNode:SetRedDotCount(0)
    end
  end
end

UnlockFunc.onUnlockSectorBuilding = function(self, self)
  -- function num : 0_17 , upvalues : _ENV
  local SectorController = ControllerManager:GetController(ControllerTypeId.SectorController)
  if SectorController ~= nil then
    SectorController:UnlockBuildFocusEnter(true)
  end
end

UnlockFunc.onUnlockChangeName = function(self, self)
  -- function num : 0_18 , upvalues : _ENV
  local uiHome = UIManager:GetWindow(UIWindowTypeID.Home)
  if uiHome ~= nil then
    uiHome:OnUserNamelock(true)
  end
end

UnlockFunc.onUnlockEndlss = function(self)
  -- function num : 0_19
end

UnlockFunc.onUnlockEpHard = function(self)
  -- function num : 0_20
end

UnlockFunc.onUnlockAchievement = function(self)
  -- function num : 0_21 , upvalues : _ENV
  local HomeSide = UIManager:GetWindow(UIWindowTypeID.HomeSide)
  if HomeSide ~= nil then
    HomeSide:RefreshAchievementBtn()
  end
  local userInfo = UIManager:GetWindow(UIWindowTypeID.UserInfo)
  if userInfo ~= nil then
    userInfo:RefreshAchievementInfo()
  end
end

UnlockFunc.onUnlockPeriodicChanllenge = function(self)
  -- function num : 0_22 , upvalues : _ENV
  (NetworkManager:GetNetwork(NetworkTypeID.Sector)):CS_DAILYCHALLENGE_Detail()
end

UnlockFunc.onUnlockFriendShip = function(self)
  -- function num : 0_23 , upvalues : _ENV
  local winHreoState = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if winHreoState ~= nil then
    winHreoState:UnlockFriendship(true)
  end
  local plotDungeon = UIManager:GetWindow(UIWindowTypeID.FriendShipPlotDungeon)
  if plotDungeon ~= nil then
    plotDungeon:__loadFriendShip()
  end
  local ok, heroWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow)
  if not ok then
    return 
  end
  for heroId,heroData in pairs(PlayerDataCenter.heroDic) do
    local heroNode = heroWindowNode:AddChildWithPath(heroId, RedDotDynPath.HeroCardPath)
    local friendShipNode = heroNode:AddChild(RedDotStaticTypeId.HeroFriendship)
    local upgradeFriendshipSkillNode = friendShipNode:AddChildWithPath(RedDotStaticTypeId.HeroFriendshipSkillUp, RedDotDynPath.HeroCardFriendshipPath)
    if (PlayerDataCenter.allFriendshipData):GetCouldUnlockForestLine(heroId) then
      upgradeFriendshipSkillNode:SetRedDotCount(1)
    else
      upgradeFriendshipSkillNode:SetRedDotCount(0)
    end
  end
end

return UnlockFunc

