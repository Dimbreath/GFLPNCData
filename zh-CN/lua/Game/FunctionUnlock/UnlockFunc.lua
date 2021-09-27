local UnlockFunc = {}
UnlockFunc.onUnlockTaskUI = function(self)
  -- function num : 0_0 , upvalues : _ENV
  local ctrl = ControllerManager:GetController(ControllerTypeId.HomeController)
  if ctrl ~= nil then
    ctrl:OnUpdateTask()
  end
  ;
  (PlayerDataCenter.allTaskData):InitNormalTaskRedDot()
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
    (uiHome.homeRightNode):RefreshshopBtn()
  end
  ;
  (ControllerManager:GetController(ControllerTypeId.Shop, true)):SetIsUnLock(true)
end

UnlockFunc.onUnlockOasis = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local uiHome = UIManager:GetWindow(UIWindowTypeID.Home)
  if uiHome ~= nil then
    (uiHome.homeRightNode):RefreshOasisBtn()
  end
end

UnlockFunc.onUnlockSector = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local uiHome = UIManager:GetWindow(UIWindowTypeID.Home)
  if uiHome ~= nil then
    (uiHome.homeRightNode):RefreshEpBtn()
  end
end

UnlockFunc.onUnlockHeroList = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local uiHome = UIManager:GetWindow(UIWindowTypeID.Home)
  if uiHome ~= nil then
    (uiHome.homeRightNode):RefreshHeroListBtn()
  end
end

UnlockFunc.onUnlockLottery = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local uiHome = UIManager:GetWindow(UIWindowTypeID.Home)
  if uiHome ~= nil then
    (uiHome.homeRightNode):RefreshLotteryBtn()
  end
end

UnlockFunc.onUnlockFactory = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local uiHome = UIManager:GetWindow(UIWindowTypeID.Home)
  if uiHome ~= nil then
    (uiHome.homeRightNode):RefreshFactoryBtn()
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
  local uiBattle = UIManager:GetWindow(UIWindowTypeID.Battle)
  if uiBattle ~= nil then
    uiBattle:OnEnemyDetailUnlock(true)
  end
end

UnlockFunc.onUnlockDorm = function(self, self)
  -- function num : 0_12 , upvalues : _ENV
  local uiHome = UIManager:GetWindow(UIWindowTypeID.Home)
  if uiHome ~= nil then
    (uiHome.homeRightNode):RefreshDormBtn()
  end
end

UnlockFunc.onUnlockRandom = function(self, self)
  -- function num : 0_13
end

UnlockFunc.onUnlockCommanderSkill = function(self)
  -- function num : 0_14 , upvalues : _ENV
  local LocalTrySetCstForFormation = function()
    -- function num : 0_14_0 , upvalues : _ENV, LocalTrySetCstForFormation
    for formId,formation in pairs(PlayerDataCenter.formationDic) do
      if formation:IsIllegalCST(true) then
        local cmdSkillData = formation:GetFmtCSTData()
        local treeId = cmdSkillData.treeId
        local skills = cmdSkillData:GetUsingCmdSkillList()
        ;
        (NetworkManager:GetNetwork(NetworkTypeID.CommanderSkill)):CS_COMMANDSKILL_SaveFromFormation(formId, treeId, skills)
      end
    end
    local uiFormation = UIManager:GetWindow(UIWindowTypeID.Formation)
    if uiFormation ~= nil then
      uiFormation:UnlockCommanderSkillUI(FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill_Ui))
    end
    MsgCenter:RemoveListener(eMsgEventId.NetDiffSyncFinish, LocalTrySetCstForFormation)
  end

  MsgCenter:AddListener(eMsgEventId.NetDiffSyncFinish, LocalTrySetCstForFormation)
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
  (NetworkManager:GetNetwork(NetworkTypeID.Building)):InitBuildingRedDotOasis()
  local SectorController = ControllerManager:GetController(ControllerTypeId.SectorController)
  if SectorController ~= nil then
    SectorController:UnlockBuildFocusEnter(true)
  end
end

UnlockFunc.onUnlockCareerBuilding = function(self, self)
  -- function num : 0_18 , upvalues : _ENV
  (NetworkManager:GetNetwork(NetworkTypeID.Building)):InitBuildingRedDotOasis()
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

UnlockFunc.onUnlockMial = function(self)
  -- function num : 0_24 , upvalues : _ENV
  local MailController = ControllerManager:GetController(ControllerTypeId.Mail)
  if MailController ~= nil then
    MailController:RefrshMailRedDot()
  end
  local win = UIManager:GetWindow(UIWindowTypeID.Home)
  if win == nil then
    return 
  end
  ;
  (win.homeUpNdoe):RefreshMailBtn()
end

UnlockFunc.onUnlockSignIn = function(self)
  -- function num : 0_25 , upvalues : _ENV
  (ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)):AddFakeSigninActivityData()
  local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
  MsgCenter:Broadcast(eMsgEventId.ActivityShowChange, {(ActivityFrameEnum.eActiveityFakeId).dailySignIn})
end

UnlockFunc.onUnlockHeroTask = function(self)
  -- function num : 0_26 , upvalues : _ENV
  local winHreoState = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if winHreoState ~= nil then
    winHreoState:UnlockHeroTask(true)
  end
  local ok, heroWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow)
  if not ok then
    return 
  end
  for heroId,heroData in pairs(PlayerDataCenter.heroDic) do
    local heroNode = heroWindowNode:AddChildWithPath(heroId, RedDotDynPath.HeroCardPath)
    local heroTaskNode = heroNode:AddChild(RedDotStaticTypeId.HeroTask)
    if heroData:IsHaveCompletedHeroTask() then
      heroTaskNode:SetRedDotCount(1)
    else
      heroTaskNode:SetRedDotCount(0)
    end
  end
end

UnlockFunc.onUnlockHeroInfo = function(self)
  -- function num : 0_27 , upvalues : _ENV
  local winHreoState = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if winHreoState ~= nil then
    winHreoState:UnlockHeroInfo(true)
  end
  local ok, heroWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow)
  if not ok then
    return 
  end
  for heroId,heroData in pairs(PlayerDataCenter.heroDic) do
    local heroNode = heroWindowNode:AddChildWithPath(heroId, RedDotDynPath.HeroCardPath)
    local heroInfoNode = heroNode:AddChildWithPath(RedDotStaticTypeId.HeroInfomation, RedDotDynPath.HeroCardHeroInfomationPath)
    if heroData:IsHaveCouldGetRewardArchive() then
      heroInfoNode:SetRedDotCount(1)
    else
      heroInfoNode:SetRedDotCount(0)
    end
  end
end

UnlockFunc.onUnlockCDK = function(self)
  -- function num : 0_28 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.Setting)
  if win == nil or not win.active then
    return 
  end
  win:SetCDKButtomActive(true)
end

UnlockFunc.onUnlockSectorTask = function(self)
  -- function num : 0_29 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
  if win == nil or not win.active then
    return 
  end
  win:SetTaskTaskUnlock(true)
end

UnlockFunc.onUnlockNavigation = function(self)
  -- function num : 0_30 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if win == nil then
    return 
  end
  ;
  (win.topGroup):RefreshouldShowNaviBtn(true)
end

UnlockFunc.onUnlockCommanderInformation = function(self)
  -- function num : 0_31 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.Home)
  if win == nil then
    return 
  end
  ;
  (win.homeUpNdoe):RefershUserInfo()
end

UnlockFunc.onUnlockSkin = function(self)
  -- function num : 0_32 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.HeroState)
  if win ~= nil then
    win:RefreshSkinBtnState()
  end
end

UnlockFunc.onUnlockWarehouse = function(self)
  -- function num : 0_33 , upvalues : _ENV
  for id,itemData in pairs(PlayerDataCenter.itemDic) do
    local itemCfg = itemData.itemCfg
    if (itemCfg.warehouse_page or not ConfigData:IsManualOpenGiftItem(itemCfg) or 0 > 0) and itemData:GetCount() > 0 then
      local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Warehouse)
      ;
      ((node:AddChild(itemCfg.warehouse_page)):AddChild(itemCfg.id)):SetRedDotCount(1)
    end
  end
  local window = UIManager:GetWindow(UIWindowTypeID.Home)
  if window ~= nil and window.active then
    (window.homeRightNode):RefreshWarehouseBtn()
  end
end

UnlockFunc.onUnlockChangeUserInfo = function(self)
  -- function num : 0_34
end

UnlockFunc.onUnlockWorldChat = function(self)
  -- function num : 0_35 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.Home)
  if win == nil then
    return 
  end
  ;
  (win.homeLeftNode):RefreshWorldChatShow()
end

UnlockFunc.onUnlockFriend = function(self)
  -- function num : 0_36 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.Home)
  if win == nil then
    return 
  end
  ;
  (win.homeLeftNode):RefreshFriendBtn()
end

UnlockFunc.OnUnlockDailyDungeon = function(self)
  -- function num : 0_37 , upvalues : _ENV
  (NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)):CS_DUNGEON_Dync_Detail(function()
    -- function num : 0_37_0 , upvalues : _ENV
    MsgCenter:Broadcast(eMsgEventId.DailyDungeonOutOfData)
  end
)
end

UnlockFunc.OnUnlockWeeklyChallenge = function(self)
  -- function num : 0_38 , upvalues : _ENV
  (PlayerDataCenter.allTaskData):InitWeeklyChallengeTaskRedDot()
end

return UnlockFunc

