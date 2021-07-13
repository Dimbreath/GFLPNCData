-- params : ...
-- function num : 0 , upvalues : _ENV
BattleDungeonManager = {}
local BattleDungeonController = require("Game.BattleDungeon.BattleDungeonController")
-- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.__Init = function(self)
  -- function num : 0_0
  self.__inDungeon = false
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.InBattleDungeon = function(self)
  -- function num : 0_1
  return self.__inDungeon
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.RequestEnterDungeon = function(self, stageId, formationData, restartEvent, dungeonStageData, callBack)
  -- function num : 0_2 , upvalues : _ENV
  if self.__dungeonNetworkCtrl == nil then
    self.__dungeonNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)
  end
  ;
  (self.__dungeonNetworkCtrl):CS_BATTLE_DungeonEnter(stageId, formationData, function(dataList)
    -- function num : 0_2_0 , upvalues : self, restartEvent, dungeonStageData, callBack
    if dataList.Count == 0 then
      return 
    end
    local msgData = dataList[0]
    if self:InBattleDungeon() then
      self:ClearBattleDungeon()
    end
    self:SetBattleRestartDatas(restartEvent, dungeonStageData)
    self:__EnterDungeon(msgData)
    if callBack ~= nil then
      callBack()
    end
  end
)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.__EnterDungeon = function(self, dungeonData)
  -- function num : 0_3 , upvalues : _ENV, BattleDungeonController
  if self.__formationData == nil then
    error("formation Data is null,can\'t to start battle dungeon")
    return nil
  end
  local dungeonCtrl = (BattleDungeonController.New)(dungeonData, self.__formationData, self.__ATHRewardInfo, self.__hasDailyDouble)
  self.dungeonCtrl = dungeonCtrl
  self.__inDungeon = true
  UIManager:DeleteAllWindow()
  dungeonCtrl:Start()
  return dungeonCtrl
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.GetDungeonCtrl = function(self)
  -- function num : 0_4
  return self.dungeonCtrl
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.GetDungeonDynPlayer = function(self)
  -- function num : 0_5
  if self.dungeonCtrl == nil then
    return 
  end
  return (self.dungeonCtrl).dynPlayer
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.GetIsGuide = function(self)
  -- function num : 0_6
  return (self.dungeonCtrl).isGuide
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.AddDungeonLogic = function(self, logicType, msgData)
  -- function num : 0_7
  if not self:InBattleDungeon() then
    return 
  end
  ;
  (self.dungeonCtrl):AddDungeonLogic(logicType, msgData)
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.SaveFormation = function(self, formationData)
  -- function num : 0_8
  self.__formationData = formationData
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.GetFormationId = function(self)
  -- function num : 0_9
  if self.__formationData ~= nil then
    return (self.__formationData).id
  end
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.SaveBattleWinRewardInfo = function(self, ATHRewardInfo, hasDailyDouble)
  -- function num : 0_10
  self.__ATHRewardInfo = ATHRewardInfo
  self.__hasDailyDouble = hasDailyDouble or false
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.InjectBattleWinEvent = function(self, winEvent)
  -- function num : 0_11
  self.battleWinEvent = winEvent
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.GetBattleWinEvent = function(self)
  -- function num : 0_12
  return self.battleWinEvent
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.InjectBattleExitEvent = function(self, exitEvent)
  -- function num : 0_13
  self.battleExitEvent = exitEvent
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.SetBattleRestartDatas = function(self, restartEvent, dungeonStageData)
  -- function num : 0_14
  self.battleRestartEvent = restartEvent
  self.dungeonStageData = dungeonStageData
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.ClearBattleDungeon = function(self, isLogout)
  -- function num : 0_15
  self.__inDungeon = false
  self.__ATHRewardInfo = nil
  self.battleRestartEvent = nil
  self.dungeonStageData = nil
  if self.dungeonCtrl ~= nil then
    (self.dungeonCtrl):OnDelete()
    self.dungeonCtrl = nil
  end
  if isLogout then
    self.battleExitEvent = nil
  end
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.ExitDungeon = function(self, withLoginVoice)
  -- function num : 0_16 , upvalues : _ENV
  if not self:InBattleDungeon() then
    return 
  end
  AudioManager:RemoveCueSheetsWithPrefix(eAuCueSheet.Prefix_Character)
  AudioManager:RemoveCueSheetsWithPrefix(eAuCueSheet.Prefix_Monster)
  AudioManager:RemoveCueSheet(eAuCueSheet.CommonSkill)
  AudioManager:RemoveCueSheet(eAuCueSheet.Ambience)
  AudioManager:RemoveAllVoice()
  self:ClearBattleDungeon()
  UIManager:DeleteAllWindow()
  ;
  ((CS.UIManager).Instance):DeleteAllWindow()
  if self.battleExitEvent == nil then
    (UIManager:GetWindow(UIWindowTypeID.Loading)):SetLoadingTipsSystemId(2)
    ;
    ((CS.GSceneManager).Instance):LoadSceneAsyncByAB((Consts.SceneName).Main, function(ok)
    -- function num : 0_16_0 , upvalues : _ENV, withLoginVoice
    (ControllerManager:GetController(ControllerTypeId.HomeController, true)):OnEnterHome()
    UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
      -- function num : 0_16_0_0 , upvalues : _ENV, withLoginVoice
      if window == nil then
        return 
      end
      window:SetFrom2Home(AreaConst.Sector)
      if withLoginVoice then
        (window.homeController):PlayLoginHeroGreeting()
      end
    end
)
  end
)
  else
    ;
    (self.battleExitEvent)()
    self.battleExitEvent = nil
  end
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.GetLastDungeonDeploy = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local lastDeployData = nil
  local dungeonStageData = self.dungeonStageData
  if dungeonStageData ~= nil then
    local dungeonId, isFrageDungeon = (dungeonStageData.dungeonData).dungeonId, (dungeonStageData.dungeonData).isFrageDungeon
    local fileName = nil
    if isFrageDungeon then
      fileName = tostring(dungeonId) .. "_" .. tostring((dungeonStageData.dungeonData).itemId)
    else
      fileName = tostring(dungeonId)
    end
    lastDeployData = PersistentManager:LoadAndDecodeData((PersistentConfig.ePackage).DeploySaveData, fileName)
  end
  do
    self.__lastDeployData = lastDeployData
    return self.__lastDeployData
  end
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.SaveDungeonDeploy = function(self, dynPlayer)
  -- function num : 0_18 , upvalues : _ENV
  if self.__lastDeployData == nil then
    return 
  end
  local equal = true
  for _,dynHero in pairs(dynPlayer.heroList) do
    if not dynHero.onBench and ((self.__lastDeployData).hero_pos)[dynHero.dataId] ~= dynHero.coord then
      equal = false
      break
    end
  end
  do
    if equal then
      return 
    end
    local hero_pos = {}
    for _,dynHero in pairs(dynPlayer.heroList) do
      if not dynHero.onBench then
        hero_pos[dynHero.dataId] = dynHero.coord
      end
    end
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self.__lastDeployData).hero_pos = hero_pos
    PersistentManager:SaveModelData((PersistentConfig.ePackage).DeploySaveData, self.__lastDeployData)
  end
end

BattleDungeonManager:__Init()

