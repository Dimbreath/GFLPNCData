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

BattleDungeonManager.EnterDungeon = function(self, dungeonData)
  -- function num : 0_2 , upvalues : _ENV, BattleDungeonController
  if self:InBattleDungeon() then
    self:ClearBattleDungeon()
  end
  if self.__formationData == nil then
    error("formation Data is null,can\'t to start battle dungeon")
    return nil
  end
  local dungeonCtrl = (BattleDungeonController.New)(dungeonData, self.__formationData, self.__ATHRewardInfo)
  self.dungeonCtrl = dungeonCtrl
  self.__inDungeon = true
  UIManager:DeleteAllWindow()
  dungeonCtrl:Start()
  return dungeonCtrl
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.GetDungeonCtrl = function(self)
  -- function num : 0_3
  return self.dungeonCtrl
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.AddDungeonLogic = function(self, logicType, msgData)
  -- function num : 0_4
  if not self:InBattleDungeon() then
    return 
  end
  ;
  (self.dungeonCtrl):AddDungeonLogic(logicType, msgData)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.SaveFormation = function(self, formationData)
  -- function num : 0_5
  self.__formationData = formationData
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.SaveBattleWinRewardInfo = function(self, ATHRewardInfo)
  -- function num : 0_6
  self.__ATHRewardInfo = ATHRewardInfo
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.InjectBattleWinEvent = function(self, winEvent)
  -- function num : 0_7
  self.battleWinEvent = winEvent
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.GetBattleWinEvent = function(self)
  -- function num : 0_8
  return self.battleWinEvent
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.InjectBattleExitEvent = function(self, exitEvent)
  -- function num : 0_9
  self.battleExitEvent = exitEvent
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.ClearBattleDungeon = function(self)
  -- function num : 0_10
  self.__inDungeon = false
  self.__ATHRewardInfo = nil
  if self.dungeonCtrl ~= nil then
    (self.dungeonCtrl):OnDelete()
    self.dungeonCtrl = nil
  end
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.ExitDungeon = function(self)
  -- function num : 0_11 , upvalues : _ENV
  if not self:InBattleDungeon() then
    return 
  end
  ;
  (BattleUtil.ResetBattleSetting)()
  AudioManager:RemoveCueSheetsWithPrefix(eAuCueSheet.Prefix_Character)
  AudioManager:RemoveCueSheetsWithPrefix(eAuCueSheet.Prefix_Monster)
  AudioManager:RemoveCueSheet(eAuCueSheet.CommonSkill)
  AudioManager:RemoveCueSheet(eAuCueSheet.Ambience)
  self:ClearBattleDungeon()
  UIManager:DeleteAllWindow()
  ;
  ((CS.UIManager).Instance):DeleteAllWindow()
  if self.battleExitEvent == nil then
    ((CS.GSceneManager).Instance):LoadSceneAsyncByAB((Consts.SceneName).Main, function(ok)
    -- function num : 0_11_0 , upvalues : _ENV
    UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
      -- function num : 0_11_0_0 , upvalues : _ENV
      if window == nil then
        return 
      end
      window:SetFrom(AreaConst.Sector)
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

BattleDungeonManager:__Init()

-- params : ...
-- function num : 0 , upvalues : _ENV
BattleDungeonManager = {}
local BattleDungeonController = require(
                                    "Game.BattleDungeon.BattleDungeonController")
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

BattleDungeonManager.EnterDungeon = function(self, dungeonData)
    -- function num : 0_2 , upvalues : _ENV, BattleDungeonController
    if self:InBattleDungeon() then self:ClearBattleDungeon() end
    if self.__formationData == nil then
        error("formation Data is null,can\'t to start battle dungeon")
        return nil
    end
    local dungeonCtrl = (BattleDungeonController.New)(dungeonData,
                                                      self.__formationData,
                                                      self.__ATHRewardInfo)
    self.dungeonCtrl = dungeonCtrl
    self.__inDungeon = true
    UIManager:DeleteAllWindow()
    dungeonCtrl:Start()
    return dungeonCtrl
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.GetDungeonCtrl = function(self)
    -- function num : 0_3
    return self.dungeonCtrl
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.AddDungeonLogic = function(self, logicType, msgData)
    -- function num : 0_4
    if not self:InBattleDungeon() then return end
    (self.dungeonCtrl):AddDungeonLogic(logicType, msgData)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.SaveFormation = function(self, formationData)
    -- function num : 0_5
    self.__formationData = formationData
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.SaveBattleWinRewardInfo =
    function(self, ATHRewardInfo)
        -- function num : 0_6
        self.__ATHRewardInfo = ATHRewardInfo
    end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.InjectBattleWinEvent =
    function(self, winEvent)
        -- function num : 0_7
        self.battleWinEvent = winEvent
    end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.GetBattleWinEvent =
    function(self)
        -- function num : 0_8
        return self.battleWinEvent
    end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.InjectBattleExitEvent =
    function(self, exitEvent)
        -- function num : 0_9
        self.battleExitEvent = exitEvent
    end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.ClearBattleDungeon =
    function(self)
        -- function num : 0_10
        self.__inDungeon = false
        self.__ATHRewardInfo = nil
        if self.dungeonCtrl ~= nil then
            (self.dungeonCtrl):OnDelete()
            self.dungeonCtrl = nil
        end
    end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

BattleDungeonManager.ExitDungeon = function(self)
    -- function num : 0_11 , upvalues : _ENV
    if not self:InBattleDungeon() then return end
    (BattleUtil.ResetBattleSetting)()
    AudioManager:RemoveCueSheetsWithPrefix(eAuCueSheet.Prefix_Character)
    AudioManager:RemoveCueSheetsWithPrefix(eAuCueSheet.Prefix_Monster)
    AudioManager:RemoveCueSheet(eAuCueSheet.CommonSkill)
    AudioManager:RemoveCueSheet(eAuCueSheet.Ambience)
    self:ClearBattleDungeon()
    UIManager:DeleteAllWindow();
    ((CS.UIManager).Instance):DeleteAllWindow()
    if self.battleExitEvent == nil then
        ((CS.GSceneManager).Instance):LoadSceneAsyncByAB(
            (Consts.SceneName).Main, function(ok)
                -- function num : 0_11_0 , upvalues : _ENV
                UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
                    -- function num : 0_11_0_0 , upvalues : _ENV
                    if window == nil then return end
                    window:SetFrom(AreaConst.Sector)
                end)
            end)
    else

        (self.battleExitEvent)()
        self.battleExitEvent = nil
    end
end

BattleDungeonManager:__Init()

