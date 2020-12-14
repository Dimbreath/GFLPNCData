-- params : ...
-- function num : 0 , upvalues : _ENV
RedDotStaticTypeId = {Main = "Main", MainSide = "MainSide", HeroWindow = "HeroWindow", HeroStarUp = "HeroStarUp", HeroSkillUp = "HeroSkillUp", HeroFriendship = "HeroFriendship", HeroFriendshipSkillUp = "HeroFriendshipSkillUp", Task = "Task", TaskPeriod = "TaskPeriod", TaskUnit = "TaskUnit", Sector = "Sector", SectorTaskBtn = "SectorTaskBtn", SectorTasks = "SectorTasks", SectorTaskAchiv = "SectorTaskAchiv", LevelDifficult = "LevelDifficult", MainAvg = "MainAvg", Lottery = "Lottery", LotteryFree = "LotteryFree", LotteryTen = "LotteryTen", ShopWindow = "ShopWindow", Training = "Training", EmptyTrainingSlot = "EmptyTrainingSlot", TrainingComplete = "TrainingComplete", Oasis = "Oasis", OasisBuildList = "OasisBuildList", OasisBuildQueue = "OasisBuildQueue", SectorBuildQueue = "SectorBuildQueue", SectorBuilding = "SectorBuilding", SectorBuildingRes = "SectorBuildingRes", SectorBuildingResItem = "SectorBuildingResItem", AchivLevel = "AchivLevel", AchivLevelPage = "AchivLevelPage", AchivLevelReward = "AchivLevelReward", Mail = "Mail", Notice = "Notice", Factory = "Factory"}
RedDotDynPath = {HeroCardPath = "Main.Hero.HeroCard", HeroCardStartUpPath = "Main.Hero.HeroCard.StarUp", HeroCardFriendshipPath = "Main.Hero.HeroCard.HeroFriendship", TaskPagePath = "Main.Task.Page", TaskPeriodPath = "Main.Task.Page.Period", TaskUnitPath = "Main.Task.Page.Unit", SectorItemPath = "Main.Sector.SectorItem", SectorItemTaskBtnPath = "Main.Sector.SectorItem.SectorTaskBtn", SectorItemTasksPath = "Main.Sector.SectorItem.SectorTaskBtn.Tasks", SectorItemTaskAchivPath = "Main.Sector.SectorItem.SectorTaskBtn.Achiv", SectorLevelDifficultPath = "Main.Sector.SectorItem.LevelDifficult", LotteryPoolPath = "Main.Lottery.LotteryPool", LotteryFreePath = "Main.Lottery.LotteryPool.LotteryFree", LotteryTenPath = "Main.Lottery.LotteryPool.LotteryTen", ShopPath = "Main.ShopWindow.Shop", EmptyTrainingSlotPath = "Main.MianSide.Training.EmptyTrainingSlot", TrainingCompletePath = "Main.MainSide.Training.TrainingComplete", OasisBuildListPath = "Main.Oasis.OasisBuildList", OasisBuildQueuePath = "Main.Oasis.OasisBuildQueue", SectorBuildingPath = "Main.Sector.SectorBuilding.SectorId", SectorBuildingResItemPath = "Main.Sector.SectorBuildingRes.SectorBuildingResItem", SectorBuildQueuePath = "Main.Sector.SectorBuildQueue", AchivTaskPagePath = "Main.AchivLevel.MainSide.AchivLevelPage.Page", AchivLevelReward = "Main.AchivLevel.MainSide.AchivLevelReward", FactoryLine = "Main.Factory.FactoryLine"}
local RedDotDriver = {}
RedDotController = require("Game.RedDot.RedDotController")
-- DECOMPILER ERROR at PC71: Confused about usage of register: R1 in 'UnsetPending'

RedDotController.RedDotDriver = RedDotDriver
;
(require("Game.Lottery.LotteryEnum"))
local LotteryEnum = nil
local lotteryTimer = nil
RedDotDriver.InitLotteryRedDot = function()
  -- function num : 0_0 , upvalues : LotteryEnum, _ENV, lotteryTimer, RedDotDriver
  local lotteryPool = (LotteryEnum.eLotteryPoolType).Main
  local lotteryCfg = (ConfigData.gashapon_para)[lotteryPool]
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
    lotteryTimer = (TimerManager:GetTimer(60, RedDotDriver.UpdateLotteryFreeEvent, nil, false)):Start()
    local lotteryTenNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.LotteryOnePath, RedDotStaticTypeId.Main, RedDotStaticTypeId.Lottery, lotteryPool, RedDotStaticTypeId.LotteryTen)
    local itemCount = PlayerDataCenter:GetItemCount(lotteryCfg.costId2)
    local count = lotteryCfg.costNum2 <= itemCount and 1 or 0
    lotteryTenNode:SetRedDotCount(count)
  end
end

RedDotDriver.UpdateLotteryFreeEvent = function()
  -- function num : 0_1 , upvalues : LotteryEnum, _ENV
  local lotteryPool = (LotteryEnum.eLotteryPoolType).Main
  local lotteryCfg = (ConfigData.gashapon_para)[lotteryPool]
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
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock)
  local isStarUpUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroRank)
  local isFriendshipUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship)
  for heroId,heroData in pairs(PlayerDataCenter.heroDic) do
    local heroNode = heroWindowNode:AddChildWithPath(heroId, RedDotDynPath.HeroCardPath)
    do
      if isStarUpUnlock then
        local heroStarNode = heroNode:AddChildWithPath(RedDotStaticTypeId.HeroStarUp, RedDotDynPath.HeroCardStartUpPath)
        if heroData:AbleUpgrade2FullStar() then
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
        -- DECOMPILER ERROR at PC78: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

RedDotDriver.OnUpdateItem = function(updateItem)
  -- function num : 0_3 , upvalues : _ENV, RedDotDriver, LotteryEnum
  if updateItem[(ConfigData.game_config).globalExpItemId] ~= nil then
    (NetworkManager:GetNetwork(NetworkTypeID.Training)):UpdateRedDotEmptySlot()
  end
  local updateBuildingBuildable = false
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock)
  local isStarUpUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroRank)
  local isHeroSkillUpUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SkillUp)
  local isFriendshipUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship)
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
              if heroData:AbleUpgrade2FullStar() then
                heroStarNode:SetRedDotCount(1)
              else
                heroStarNode:SetRedDotCount(0)
              end
            end
          end
        end
      end
      do
        if itemCfg.id == ItemIdOfG then
          for heroId,heroData in pairs(PlayerDataCenter.heroDic) do
            local nodeOk, heroNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, heroId)
            if nodeOk then
              do
                if isStarUpUnlock then
                  local heroStarNode = heroNode:GetChild(RedDotStaticTypeId.HeroStarUp)
                  if heroStarNode ~= nil then
                    if heroData:AbleUpgrade2FullStar() then
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
                  -- DECOMPILER ERROR at PC146: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC146: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC146: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        else
          if (RedDotDriver.IsLottery)(itemCfg.id) then
            local lotteryPool = (LotteryEnum.eLotteryPoolType).Main
            local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Lottery, lotteryPool, RedDotStaticTypeId.LotteryTen)
            local lotteryCfg = (ConfigData.gashapon_para)[lotteryPool]
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
                  -- DECOMPILER ERROR at PC241: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC241: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC241: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC241: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC241: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC241: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC241: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC241: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC241: LeaveBlock: unexpected jumping out IF_STMT

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
end

RedDotDriver.IsLottery = function(itemId)
  -- function num : 0_4 , upvalues : _ENV, LotteryEnum
  local lotteryCfg = (ConfigData.gashapon_para)[(LotteryEnum.eLotteryPoolType).Main]
  if lotteryCfg ~= nil and lotteryCfg.costId2 == itemId then
    return true
  end
  return false
end

RedDotDriver.OnUpdateHero = function(updateHero)
  -- function num : 0_5 , upvalues : _ENV
  if updateHero == nil then
    return 
  end
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock)
  local isStarUpUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_HeroRank)
  local isFriendshipUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship)
  for heroId,v in pairs(updateHero) do
    local heroData = (PlayerDataCenter.heroDic)[heroId]
    local heroNode = RedDotController:AddRedDotNodeWithPath(RedDotDynPath.HeroCardPath, RedDotStaticTypeId.Main, RedDotStaticTypeId.HeroWindow, heroId)
    do
      if v and isStarUpUnlock then
        local upgradeStarNode = heroNode:AddChildWithPath(RedDotStaticTypeId.HeroStarUp, RedDotDynPath.HeroCardStartUpPath)
        if heroData:AbleUpgrade2FullStar() then
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
        -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

RedDotDriver.OnExplorationEnter = function(complete)
  -- function num : 0_6 , upvalues : lotteryTimer, _ENV
  if not complete then
    return 
  end
  if lotteryTimer ~= nil then
    lotteryTimer:Stop()
    lotteryTimer = nil
  end
  ;
  (ControllerManager:GetController(ControllerTypeId.Shop, true)):StopShopRedDot()
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Training)):StopTrainingRedDotTimer()
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Building)):StopBuildingRedDotTimer()
end

RedDotDriver.OnExplorationExit = function()
  -- function num : 0_7 , upvalues : lotteryTimer, _ENV, RedDotDriver
  lotteryTimer = (TimerManager:GetTimer(60, RedDotDriver.UpdateLotteryFreeEvent, nil, false)):Start()
  ;
  (ControllerManager:GetController(ControllerTypeId.Shop, true)):StartShopAllRedDot()
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Training)):StartTrainingRedDotTimer()
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Building)):StartBuildingRedDotTimer()
end

RedDotDriver.OnFriendshipDataChange = function()
  -- function num : 0_8 , upvalues : _ENV
  local funcUnLockCrtl = ControllerManager:GetController(ControllerTypeId.FunctionUnlock)
  local isFriendshipUnlock = funcUnLockCrtl:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_friendship)
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
      end
    end
  end
end

RedDotDriver.InitRedDot = function()
  -- function num : 0_9 , upvalues : _ENV, RedDotDriver
  RedDotController:InitRedDotData()
  local mainNode = RedDotController:AddRedDotNode(RedDotStaticTypeId.Main)
  local heroWindowNode = mainNode:AddChild(RedDotStaticTypeId.HeroWindow)
  local taskWindowNode = mainNode:AddChild(RedDotStaticTypeId.Task)
  local sectorNode = mainNode:AddChild(RedDotStaticTypeId.Sector)
  local lotteryNode = mainNode:AddChild(RedDotStaticTypeId.Lottery)
  local shopWindowNode = mainNode:AddChild(RedDotStaticTypeId.ShopWindow)
  local oasisNode = mainNode:AddChild(RedDotStaticTypeId.Oasis)
  local factoryNode = mainNode:AddChild(RedDotStaticTypeId.Factory)
  local mainSideNode = mainNode:AddChild(RedDotStaticTypeId.MainSide)
  local achivLevelNode = mainSideNode:AddChild(RedDotStaticTypeId.AchivLevel)
  local trainingNode = mainSideNode:AddChild(RedDotStaticTypeId.Training)
  local mailNode = mainSideNode:AddChild(RedDotStaticTypeId.Mail)
  local Notice = mainSideNode:AddChild(RedDotStaticTypeId.Notice)
  MsgCenter:AddListener(eMsgEventId.SyncUserData, RedDotDriver.OnSyncUserData)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, RedDotDriver.OnUpdateItem)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, RedDotDriver.OnUpdateHero)
  MsgCenter:AddListener(eMsgEventId.OnHeroFriendshipDataChange, RedDotDriver.OnFriendshipDataChange)
  MsgCenter:AddListener(eMsgEventId.ExplorationEnterComplete, RedDotDriver.OnExplorationEnter)
  MsgCenter:AddListener(eMsgEventId.ExplorationExit, RedDotDriver.OnExplorationExit)
end

RedDotDriver.ClearEvent = function()
  -- function num : 0_10 , upvalues : _ENV, RedDotDriver, lotteryTimer
  MsgCenter:RemoveListener(eMsgEventId.SyncUserData, RedDotDriver.OnSyncUserData)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, RedDotDriver.OnUpdateItem)
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, RedDotDriver.OnUpdateHero)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroFriendshipDataChange, RedDotDriver.OnFriendshipDataChange)
  MsgCenter:RemoveListener(eMsgEventId.ExplorationEnterComplete, RedDotDriver.OnExplorationEnter)
  MsgCenter:RemoveListener(eMsgEventId.ExplorationExit, RedDotDriver.OnExplorationExit)
  if lotteryTimer ~= nil then
    lotteryTimer:Stop()
    lotteryTimer = nil
  end
end

RedDotDriver.ResetAllData = function()
  -- function num : 0_11 , upvalues : RedDotDriver
  (RedDotDriver.ClearEvent)()
  ;
  (RedDotDriver.InitRedDot)()
end

;
(RedDotDriver.InitRedDot)()

