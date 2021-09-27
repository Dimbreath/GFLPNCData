RedDotStaticTypeId = {Main = "Main", MainSide = "MainSide", HeroWindow = "HeroWindow", HeroStarUp = "HeroStarUp", HeroSkillUp = "HeroSkillUp", HeroFriendship = "HeroFriendship", HeroTask = "HeroTask", HeroFriendshipSkillUp = "HeroFriendshipSkillUp", HeroInfomation = "HeroInfomation", Task = "Task", TaskPeriod = "TaskPeriod", TaskUnit = "TaskUnit", Sector = "Sector", SectorTaskBtn = "SectorTaskBtn", SectorTasks = "SectorTasks", SectorTaskAchiv = "SectorTaskAchiv", LevelDifficult = "LevelDifficult", MainAvg = "MainAvg", Lottery = "Lottery", LotteryFree = "LotteryFree", LotteryTen = "LotteryTen", ShopWindow = "ShopWindow", ShopFriendSupportBtn = "ShopFriendSupportBtn", Training = "Training", EmptyTrainingSlot = "EmptyTrainingSlot", TrainingComplete = "TrainingComplete", Oasis = "Oasis", OasisBuildResMax = "OasisBuildResMax", StrategyOverview = "StrategyOverview", SectorBuilding = "SectorBuilding", CareerBuilding = "CareerBuilding", AchivLevel = "AchivLevel", AchivLevelPage = "AchivLevelPage", AchivLevelReward = "AchivLevelReward", Mail = "Mail", Notice = "Notice", Factory = "Factory", FactoryEnerage = "FactoryEnerage", FactoryProcessLine = "FactoryProcessLine", PeriodicChallenge = "PeriodicChallenge", ActivityFrameNovice = "ActivityFrameNovice", ActivityFrameLimitTime = "ActivityFrameLimitTime", Warehouse = "Warehouse", GameNotice = "GameNotice", UserFriend = "UserFriend", UserFriendApplyPath = "UserFriendApply", WeeklyChallengeTask = "WeeklyChallengeTask", Dorm = "Dorm", DormComfort = "DormComfort", DormResOutput = "DormResOutput"}
RedDotDynPath = {HeroCardPath = "Main.Hero.HeroCard", HeroCardStartUpPath = "Main.Hero.HeroCard.StarUp", HeroCardFriendshipPath = "Main.Hero.HeroCard.HeroFriendship", HeroCardHeroTaskPath = "Main.Hero.HeroCard.HeroTask", HeroCardHeroInfomationPath = "Main.Hero.HeroCard.HeroInfomation", TaskPagePath = "Main.Task.Page", TaskPeriodPath = "Main.Task.Page.Period", TaskUnitPath = "Main.Task.Page.Unit", SectorItemPath = "Main.Sector.SectorItem", SectorItemTaskBtnPath = "Main.Sector.SectorItem.SectorTaskBtn", SectorItemTasksPath = "Main.Sector.SectorItem.SectorTaskBtn.Tasks", SectorItemTaskAchivPath = "Main.Sector.SectorItem.SectorTaskBtn.Achiv", SectorLevelDifficultPath = "Main.Sector.SectorItem.LevelDifficult", LotteryPoolPath = "Main.Lottery.LotteryPool", LotteryFreePath = "Main.Lottery.LotteryPool.LotteryFree", LotteryTenPath = "Main.Lottery.LotteryPool.LotteryTen", ShopPath = "Main.ShopWindow.Shop", ShopFriendSupportBtnPath = "Main.ShopWindow.Shop.ShopFriendSupportBtn", EmptyTrainingSlotPath = "Main.MianSide.Training.EmptyTrainingSlot", TrainingCompletePath = "Main.MainSide.Training.TrainingComplete", OasisResMaxPath = "Main.Oasis.OasisBuildResMax", StrategyOverviewPath = "Main.StrategyOverview", AchivTaskPagePath = "Main.AchivLevel.MainSide.AchivLevelPage.Page", AchivLevelReward = "Main.AchivLevel.MainSide.AchivLevelReward", PeriodicChallenge = "Main.Sector.PeriodicChallenge", ActivityFrameNovicePath = "Main.ActivityFrameNovicePath", ActivityFrameLimitTimePath = "Main.ActivityFrameLimitTimePath", WarehousePath = "Main.WarehousePath"}
local RedDotDriver = {}
RedDotController = require("Game.RedDot.RedDotController")
-- DECOMPILER ERROR at PC88: Confused about usage of register: R1 in 'UnsetPending'

RedDotController.RedDotDriver = RedDotDriver
;
(require("Game.Lottery.LotteryEnum"))
local LotteryEnum = nil
local lotteryTimerId = nil
RedDotDriver.InitLotteryRedDot = function()
  -- function num : 0_0 , upvalues : LotteryEnum, _ENV, lotteryTimerId, RedDotDriver
  local lotteryPool = (LotteryEnum.eLotteryPoolType).Main
  local lotteryCfg = (ConfigData.lottery_para)[lotteryPool]
  if lotteryCfg == nil then
    return 
  end
  RedDotController:AddRedDotNodeWithPath(RedDotDynPath.LotteryPoolPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.Lottery, lotteryPool)
  local lotteryFreeNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.LotteryFreePath, RedDotStaticTypeId.Main, RedDotStaticTypeId.Lottery, lotteryPool, RedDotStaticTypeId.LotteryFree)
  local count = 0
  do
    if lotteryCfg.cd ~= nil and lotteryCfg.cd ~= 0 then
      local lottery = (PlayerDataCenter.LotteryCfg)[lotteryPool]
      count = lottery.NextFreeTime <= PlayerDataCenter.timestamp and 1 or 0
      lotteryFreeNode:SetRedDotCount(count)
    end
    lotteryTimerId = TimerManager:StartTimer(60, RedDotDriver.UpdateLotteryFreeEvent, nil, false)
    local lotteryTenNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.LotteryOnePath, RedDotStaticTypeId.Main, RedDotStaticTypeId.Lottery, lotteryPool, RedDotStaticTypeId.LotteryTen)
    local itemCount = PlayerDataCenter:GetItemCount(lotteryCfg.costId2)
    local count = lotteryCfg.costNum2 <= itemCount and 1 or 0
    lotteryTenNode:SetRedDotCount(count)
  end
end

RedDotDriver.UpdateLotteryFreeEvent = function()
  -- function num : 0_1 , upvalues : LotteryEnum, _ENV
  local lotteryPool = (LotteryEnum.eLotteryPoolType).Main
  local lotteryCfg = (ConfigData.lottery_para)[lotteryPool]
  if lotteryCfg == nil then
    return 
  end
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Lottery, lotteryPool, RedDotStaticTypeId.LotteryFree)
  if not ok then
    return 
  end
  local count = 0
  if lotteryCfg.cd ~= nil and lotteryCfg.cd ~= 0 then
    local lottery = (PlayerDataCenter.LotteryCfg)[lotteryPool]
    count = lottery.NextFreeTime <= PlayerDataCenter.timestamp and 1 or 0
    node:SetRedDotCount(count)
  end
end

RedDotDriver.OnSyncUserData = function()
  -- function num : 0_2 , upvalues : _ENV
  local ok, heroWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow)
  if not ok then
    return 
  end
  local isStarUpUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroRank)
  local isFriendshipUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship)
  local isHeroTaskUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TrainingPlan)
  local isHeroInfomationUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroInformation)
  for heroId,heroData in pairs(PlayerDataCenter.heroDic) do
    local heroNode = heroWindowNode:AddChildWithPath(heroId, RedDotDynPath.HeroCardPath)
    do
      if isStarUpUnlock then
        local heroStarNode = heroNode:AddChildWithPath(RedDotStaticTypeId.HeroStarUp, RedDotDynPath.HeroCardStartUpPath)
        if heroData:AbleUpgradeStar() then
          heroStarNode:SetRedDotCount(1)
        else
          heroStarNode:SetRedDotCount(0)
        end
      end
      if isFriendshipUnlock then
        local friendShipNode = heroNode:AddChild(RedDotStaticTypeId.HeroFriendship)
        local upgradeFriendshipSkillNode = friendShipNode:AddChildWithPath(RedDotStaticTypeId.HeroFriendshipSkillUp, RedDotDynPath.HeroCardFriendshipPath)
        if (PlayerDataCenter.allFriendshipData):GetCouldUnlockForestLine(heroId) then
          upgradeFriendshipSkillNode:SetRedDotCount(1)
        else
          upgradeFriendshipSkillNode:SetRedDotCount(0)
        end
      end
      do
        do
          if isHeroTaskUnlock then
            local heroTaskNode = heroNode:AddChildWithPath(RedDotStaticTypeId.HeroTask, RedDotDynPath.HeroCardHeroTaskPath)
            if heroData:IsHaveCompletedHeroTask() then
              heroTaskNode:SetRedDotCount(1)
            else
              heroTaskNode:SetRedDotCount(0)
            end
          end
          do
            if isHeroInfomationUnlock then
              local heroInfoNode = heroNode:AddChildWithPath(RedDotStaticTypeId.HeroInfomation, RedDotDynPath.HeroCardHeroInfomationPath)
              if heroData:IsHaveCouldGetRewardArchive() then
                heroInfoNode:SetRedDotCount(1)
              else
                heroInfoNode:SetRedDotCount(0)
              end
            end
            -- DECOMPILER ERROR at PC123: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC123: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC123: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
    end
  end
end

RedDotDriver.OnUpdateItem = function(updateItem, resourceData)
  -- function num : 0_3 , upvalues : _ENV, RedDotDriver, LotteryEnum
  if updateItem[(ConfigData.game_config).globalExpItemId] ~= nil then
    local updateBuildingBuildable = false
    local isStarUpUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroRank)
    local isHeroSkillUpUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SkillUp)
    local isFriendshipUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship)
    for k,v in pairs(updateItem) do
      local itemCfg = (ConfigData.item)[k]
      if itemCfg ~= nil then
        if itemCfg.action_type == eItemActionType.HeroCardFrag and isStarUpUnlock then
          local heroId = (itemCfg.arg)[1]
          local heroData = (PlayerDataCenter.heroDic)[heroId]
          if heroData then
            local nodeOk, heroNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, heroId)
            if nodeOk then
              local heroStarNode = heroNode:GetChild(RedDotStaticTypeId.HeroStarUp)
              if heroStarNode ~= nil then
                if heroData:AbleUpgradeStar() then
                  heroStarNode:SetRedDotCount(1)
                else
                  heroStarNode:SetRedDotCount(0)
                end
              end
            end
          end
        end
        do
          if itemCfg.id == ConstGlobalItem.NormalGold then
            for heroId,heroData in pairs(PlayerDataCenter.heroDic) do
              local nodeOk, heroNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, heroId)
              if nodeOk then
                do
                  if isStarUpUnlock then
                    local heroStarNode = heroNode:GetChild(RedDotStaticTypeId.HeroStarUp)
                    if heroStarNode ~= nil then
                      if heroData:AbleUpgradeStar() then
                        heroStarNode:SetRedDotCount(1)
                      else
                        heroStarNode:SetRedDotCount(0)
                      end
                    end
                  end
                  if isFriendshipUnlock then
                    local friendShipNode = heroNode:GetChild(RedDotStaticTypeId.HeroFriendship)
                    local friendshipSkillNode = friendShipNode:GetChild(RedDotStaticTypeId.HeroFriendshipSkillUp)
                    if friendshipSkillNode ~= nil then
                      if (PlayerDataCenter.allFriendshipData):GetCouldUnlockForestLine(heroId) then
                        friendshipSkillNode:SetRedDotCount(1)
                      else
                        friendshipSkillNode:SetRedDotCount(0)
                      end
                    end
                  end
                  do
                    -- DECOMPILER ERROR at PC138: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC138: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC138: LeaveBlock: unexpected jumping out IF_STMT

                  end
                end
              end
            end
          else
            if (RedDotDriver.IsLottery)(itemCfg.id) then
              local lotteryPool = (LotteryEnum.eLotteryPoolType).Main
              local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Lottery, lotteryPool, RedDotStaticTypeId.LotteryTen)
              local lotteryCfg = (ConfigData.lottery_para)[lotteryPool]
              local itemCount = PlayerDataCenter:GetItemCount(lotteryCfg.costId2)
              local count = lotteryCfg.costNum2 <= itemCount and 1 or 0
              if ok then
                node:SetRedDotCount(count)
              end
            else
              do
                if (table.contain)((ConfigData.hero_skill_level).allSkillUpItemIdList, itemCfg.id) and isHeroSkillUpUnlock then
                  for _,heroData in pairs(PlayerDataCenter.heroDic) do
                    local nodeOk, heroNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, heroData.dataId)
                    if nodeOk then
                      local upgradeSkillNode = heroNode:GetChild(RedDotStaticTypeId.HeroSkillUp)
                      if upgradeSkillNode ~= nil then
                        if heroData:AbleUpgradeSkill() then
                          upgradeSkillNode:SetRedDotCount(1)
                        else
                          upgradeSkillNode:SetRedDotCount(0)
                        end
                      end
                    end
                  end
                end
                do
                  do
                    if not updateBuildingBuildable and ((ConfigData.buildingLevel).resConsumeDic)[itemCfg.id] ~= nil then
                      updateBuildingBuildable = true
                    end
                    -- DECOMPILER ERROR at PC233: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC233: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC233: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC233: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC233: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                    -- DECOMPILER ERROR at PC233: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC233: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC233: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC233: LeaveBlock: unexpected jumping out IF_STMT

                  end
                end
              end
            end
          end
        end
      end
    end
    if updateBuildingBuildable then
      (NetworkManager:GetNetwork(NetworkTypeID.Building)):UpdateRedDotBuildingBuildable()
    end
    ;
    (RedDotDriver.__UpdateWarehouseRedDot)()
  end
end

RedDotDriver.__UpdateWarehouseRedDot = function()
  -- function num : 0_4 , upvalues : _ENV
  local isUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Backpack_ui)
  if not isUnlock then
    return 
  end
  local itemDiff = NetworkManager:GetRewardShowCache()
  for itemId,diffCount in pairs(itemDiff) do
    local itemCfg = (ConfigData.item)[itemId]
    if itemCfg.warehouse_page or not ConfigData:IsManualOpenGiftItem(itemCfg) or 0 > 0 then
      local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Warehouse)
      ;
      ((node:AddChild(itemCfg.warehouse_page)):AddChild(itemCfg.id)):SetRedDotCount(1)
    end
  end
  local consume = NetworkManager:GetConsumeShowCache()
  for itemId,diffCount in pairs(consume) do
    if PlayerDataCenter:GetItemCount(itemId) == 0 then
      local itemCfg = (ConfigData.item)[itemId]
      if itemCfg.warehouse_page or not ConfigData:IsManualOpenGiftItem(itemCfg) or 0 > 0 then
        local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Warehouse, itemCfg.warehouse_page, itemCfg.id)
        if ok and node:GetRedDotCount() > 0 then
          node:SetRedDotCount(0)
        end
      end
    end
  end
end

RedDotDriver.IsLottery = function(itemId)
  -- function num : 0_5 , upvalues : _ENV, LotteryEnum
  local lotteryCfg = (ConfigData.lottery_para)[(LotteryEnum.eLotteryPoolType).Main]
  if lotteryCfg ~= nil and lotteryCfg.costId2 == itemId then
    return true
  end
  return false
end

RedDotDriver.OnUpdateHero = function(updateHero)
  -- function num : 0_6 , upvalues : _ENV
  if updateHero == nil then
    return 
  end
  local isStarUpUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroRank)
  local isFriendshipUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship)
  local isHeroTaskUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TrainingPlan)
  for heroId,v in pairs(updateHero) do
    local heroData = (PlayerDataCenter.heroDic)[heroId]
    local heroNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.HeroCardPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, heroId)
    do
      if isStarUpUnlock then
        local upgradeStarNode = heroNode:AddChildWithPath(RedDotStaticTypeId.HeroStarUp, RedDotDynPath.HeroCardStartUpPath)
        if heroData:AbleUpgradeStar() then
          upgradeStarNode:SetRedDotCount(1)
        else
          upgradeStarNode:SetRedDotCount(0)
        end
      end
      if isFriendshipUnlock then
        local friendShipNode = heroNode:AddChild(RedDotStaticTypeId.HeroFriendship)
        local upgradeFriendshipSkillNode = friendShipNode:AddChildWithPath(RedDotStaticTypeId.HeroFriendshipSkillUp, RedDotDynPath.HeroCardFriendshipPath)
        if (PlayerDataCenter.allFriendshipData):GetCouldUnlockForestLine(heroId) then
          upgradeFriendshipSkillNode:SetRedDotCount(1)
        else
          upgradeFriendshipSkillNode:SetRedDotCount(0)
        end
      end
      do
        do
          if isHeroTaskUnlock then
            local heroTaskNode = heroNode:AddChildWithPath(RedDotStaticTypeId.HeroTask, RedDotDynPath.HeroCardHeroTaskPath)
            if heroData:IsHaveCompletedHeroTask() then
              heroTaskNode:SetRedDotCount(1)
            else
              heroTaskNode:SetRedDotCount(0)
            end
          end
          -- DECOMPILER ERROR at PC99: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC99: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
end

RedDotDriver.OnExplorationEnter = function(complete)
  -- function num : 0_7 , upvalues : _ENV, lotteryTimerId
  if not complete then
    return 
  end
  TimerManager:StopTimer(lotteryTimerId)
  ;
  (ControllerManager:GetController(ControllerTypeId.Shop, true)):StopShopRedDot()
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Building)):StopBuildingRedDotTimer()
end

RedDotDriver.OnExplorationExit = function()
  -- function num : 0_8 , upvalues : lotteryTimerId, _ENV, RedDotDriver
  lotteryTimerId = TimerManager:StartTimer(60, RedDotDriver.UpdateLotteryFreeEvent, nil, false)
  ;
  (ControllerManager:GetController(ControllerTypeId.Shop, true)):StartShopAllRedDot()
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Building)):StartBuildingRedDotTimer()
end

RedDotDriver.OnFriendshipDataChange = function()
  -- function num : 0_9 , upvalues : _ENV
  local isFriendshipUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship)
  if isFriendshipUnlock then
    for heroId,heroData in pairs(PlayerDataCenter.heroDic) do
      local nodeOk, heroNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, heroId)
      if nodeOk then
        local friendShipNode = heroNode:GetChild(RedDotStaticTypeId.HeroFriendship)
        local friendshipSkillNode = friendShipNode:GetChild(RedDotStaticTypeId.HeroFriendshipSkillUp)
        if friendshipSkillNode ~= nil then
          if (PlayerDataCenter.allFriendshipData):GetCouldUnlockForestLine(heroId) then
            friendshipSkillNode:SetRedDotCount(1)
          else
            friendshipSkillNode:SetRedDotCount(0)
          end
        end
        local heroInfoNode = heroNode:GetChild(RedDotStaticTypeId.HeroInfomation)
        if heroInfoNode ~= nil then
          if heroData:IsHaveCouldGetRewardArchive() then
            heroInfoNode:SetRedDotCount(1)
          else
            heroInfoNode:SetRedDotCount(0)
          end
        end
      end
    end
  end
end

RedDotDriver.OnHeroTaskDataChange = function(heroData)
  -- function num : 0_10 , upvalues : _ENV
  local isTrainTaskUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TrainingPlan)
  if isTrainTaskUnlock then
    local ok, heroWindowNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow)
    if not ok then
      return 
    end
    local heroId = heroData.dataId
    local heroNode = heroWindowNode:AddChildWithPath(heroId, RedDotDynPath.HeroCardPath)
    local heroTaskNode = heroNode:AddChildWithPath(RedDotStaticTypeId.HeroTask, RedDotDynPath.HeroCardHeroTaskPath)
    if heroData:IsHaveCompletedHeroTask() then
      heroTaskNode:SetRedDotCount(1)
    else
      heroTaskNode:SetRedDotCount(0)
    end
  end
end

RedDotDriver.InitRedDot = function()
  -- function num : 0_11 , upvalues : _ENV, RedDotDriver
  RedDotController:InitRedDotData()
  local mainNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main)
  local heroWindowNode = mainNode:AddChild(RedDotStaticTypeId.HeroWindow)
  local taskWindowNode = mainNode:AddChild(RedDotStaticTypeId.Task)
  local sectorNode = mainNode:AddChild(RedDotStaticTypeId.Sector)
  local lotteryNode = mainNode:AddChild(RedDotStaticTypeId.Lottery)
  local shopWindowNode = mainNode:AddChildWithPath(RedDotStaticTypeId.ShopWindow, RedDotDynPath.ShopPath)
  local oasisNode = mainNode:AddChild(RedDotStaticTypeId.Oasis)
  local factoryNode = mainNode:AddChild(RedDotStaticTypeId.Factory)
  factoryNode:AddChild(RedDotStaticTypeId.FactoryEnerage)
  factoryNode:AddChild(RedDotStaticTypeId.FactoryProcessLine)
  local mainSideNode = mainNode:AddChild(RedDotStaticTypeId.MainSide)
  local achivLevelNode = mainNode:AddChild(RedDotStaticTypeId.AchivLevel)
  local trainingNode = mainSideNode:AddChild(RedDotStaticTypeId.Training)
  local mailNode = mainNode:AddChild(RedDotStaticTypeId.Mail)
  local Notice = mainSideNode:AddChild(RedDotStaticTypeId.Notice)
  local periodicChangeNode = sectorNode:AddChildWithPath(RedDotStaticTypeId.PeriodicChallenge, RedDotDynPath.PeriodicChallenge)
  local ActivityFrameNovice = mainNode:AddChildWithPath(RedDotStaticTypeId.ActivityFrameNovice, RedDotDynPath.ActivityFrameNovicePath)
  local ActivityFrameLimitTime = mainNode:AddChildWithPath(RedDotStaticTypeId.ActivityFrameLimitTime, RedDotDynPath.ActivityFrameLimitTimePath)
  local warehouse = mainNode:AddChildWithPath(RedDotStaticTypeId.Warehouse, RedDotDynPath.WarehousePath)
  local userFriend = mainNode:AddChildWithPath(RedDotStaticTypeId.UserFriend)
  local dormNode = mainNode:AddChild(RedDotStaticTypeId.Dorm)
  dormNode:AddChild(RedDotStaticTypeId.DormComfort)
  dormNode:AddChild(RedDotStaticTypeId.DormResOutput)
  MsgCenter:AddListener(eMsgEventId.SyncUserData, RedDotDriver.OnSyncUserData)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, RedDotDriver.OnUpdateItem)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, RedDotDriver.OnUpdateHero)
  MsgCenter:AddListener(eMsgEventId.OnHeroFriendshipDataChange, RedDotDriver.OnFriendshipDataChange)
  MsgCenter:AddListener(eMsgEventId.OnHeroTaskChange, RedDotDriver.OnHeroTaskDataChange)
  MsgCenter:AddListener(eMsgEventId.ExplorationEnterComplete, RedDotDriver.OnExplorationEnter)
  MsgCenter:AddListener(eMsgEventId.ExplorationExit, RedDotDriver.OnExplorationExit)
end

RedDotDriver.ClearEvent = function()
  -- function num : 0_12 , upvalues : _ENV, RedDotDriver, lotteryTimerId
  MsgCenter:RemoveListener(eMsgEventId.SyncUserData, RedDotDriver.OnSyncUserData)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, RedDotDriver.OnUpdateItem)
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, RedDotDriver.OnUpdateHero)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroFriendshipDataChange, RedDotDriver.OnFriendshipDataChange)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroTaskChange, RedDotDriver.OnHeroTaskDataChange)
  MsgCenter:RemoveListener(eMsgEventId.ExplorationEnterComplete, RedDotDriver.OnExplorationEnter)
  MsgCenter:RemoveListener(eMsgEventId.ExplorationExit, RedDotDriver.OnExplorationExit)
  TimerManager:StopTimer(lotteryTimerId)
end

RedDotDriver.ResetAllData = function()
  -- function num : 0_13 , upvalues : RedDotDriver
  (RedDotDriver.ClearEvent)()
  ;
  (RedDotDriver.InitRedDot)()
end

;
(RedDotDriver.InitRedDot)()

