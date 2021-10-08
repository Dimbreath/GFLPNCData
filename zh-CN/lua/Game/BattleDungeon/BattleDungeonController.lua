local BattleDungeonController = class("BattleDungeonController")
local Messenger = require("Framework.Common.Messenger")
local BattleDungeonSceneCtrl = require("Game.BattleDungeon.Ctrl.BattleDungeonSceneCtrl")
local BattleDungeonBattleCtrl = require("Game.BattleDungeon.Ctrl.BattleDungeonBattleCtrl")
local BattleDungeonObjectCtrl = require("Game.BattleDungeon.Ctrl.BattleDungeonObjectCtrl")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
BattleDungeonController.ctor = function(self, dungeonData, enterMsgData, formationData)
  -- function num : 0_0 , upvalues : Messenger, _ENV, BattleDungeonBattleCtrl, BattleDungeonObjectCtrl, BattleDungeonSceneCtrl
  self.ctrls = {}
  self.isGuide = false
  self.__dungeonLogicMessage = (Messenger.New)()
  self.__cacheDungeonLogic = {}
  if dungeonData.dungeonId == (GuideManager.firstBattleGuideCtrl).guideDungeonId then
    self.battleGuideType = (GuideManager.firstBattleGuideCtrl).battleGuideType
    local BattleDungeonGuideBatteCtrl = require("Game.BattleDungeon.Guide.BattleDungeonGuideBatteCtrl")
    self.battleCtrl = (BattleDungeonGuideBatteCtrl.New)(self, self.battleGuideType)
    local BattleDungeonGuideObjectCtrl = require("Game.BattleDungeon.Guide.BattleDungeonGuideObjectCtrl")
    self.objectCtrl = (BattleDungeonGuideObjectCtrl.New)(self, self.battleGuideType)
    self.isGuide = true
  else
    do
      self.battleCtrl = (BattleDungeonBattleCtrl.New)(self)
      self.objectCtrl = (BattleDungeonObjectCtrl.New)(self)
      self.sceneCtrl = (BattleDungeonSceneCtrl.New)(self)
      self.battleNetwork = NetworkManager:GetNetwork(NetworkTypeID.BattleDungeon)
      self:__InitDungeonCtrl(dungeonData, enterMsgData, formationData)
    end
  end
end

BattleDungeonController.__InitDungeonCtrl = function(self, dungeonData, enterMsgData, formationData)
  -- function num : 0_1 , upvalues : _ENV
  self.dungeonData = dungeonData
  self.enterMsgData = enterMsgData
  self.dungeonId = dungeonData.dungeonId
  self.dungeonCfg = (ConfigData.battle_dungeon)[self.dungeonId]
  if self.dungeonCfg == nil then
    error("battle dungeon cfg is null,id:" .. tostring(self.dungeonId))
  end
  local lastDeployData = BattleDungeonManager:GetLastDungeonDeploy()
  if enterMsgData ~= nil then
    for index,battleRole in pairs(dungeonData.role) do
      if (battleRole.stc).dataId == enterMsgData.astHeroId then
        battleRole.roleType = proto_object_EplBattleRoleType.BattleRoleFriendAssist
        break
      end
    end
  end
  do
    if (self.dungeonCfg).dungeon_type == proto_csmsg_DungeonType.DungeonType_TD then
      local TowerDefenceDynPlayer = require("Game.BattleDungeon.Data.TdDungeonDynPlayer")
      self.dynPlayer = (TowerDefenceDynPlayer.CreateTdDungeonPlayer)(dungeonData.role, dungeonData.player, self.dungeonCfg, lastDeployData, dungeonData.treeId)
    else
      do
        do
          local DungeonDynPlayer = require("Game.BattleDungeon.Data.DungeonDynPlayer")
          self.dynPlayer = (DungeonDynPlayer.CreateDungeonPlayer)(dungeonData.role, dungeonData.player, self.dungeonCfg, lastDeployData, dungeonData.treeId)
          ;
          (self.dynPlayer):InitDynPlayerChip(dungeonData.algData)
          if self.dungeonId == (GuideManager.firstBattleGuideCtrl).guideDungeonId then
            (self.dynPlayer):InitPlayerSkillCustom(formationData.userSkill, (formationData.cst).treeId)
          end
          if dungeonData.player ~= nil then
            (self.dynPlayer):InitDynPlayerAttr((dungeonData.player).stc)
          end
        end
      end
    end
  end
end

BattleDungeonController.Start = function(self)
  -- function num : 0_2 , upvalues : _ENV
  AudioManager:PlayAudioById(3101)
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, (eAuSelct.Sector).name, (eAuSelct.Sector).normalCombat)
  self._waitFirstLoadScene = true
  ;
  (self.sceneCtrl):EnterDungeonScene((self.dungeonData).wave, function()
    -- function num : 0_2_0 , upvalues : self, _ENV
    if self._afterEnterSceneExit then
      BattleDungeonManager:RetreatDungeonNoReq()
      return 
    end
    local epWindow = UIManager:ShowWindow(UIWindowTypeID.DungeonStateInfo)
    epWindow:InitHeroAndChip(self.dynPlayer)
    local unlockChipSuit = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_TagSuit)
    do
      if unlockChipSuit then
        local epSuitWindow = UIManager:ShowWindow(UIWindowTypeID.EpChipSuit)
        epSuitWindow:InitEpChipSuit(self.dynPlayer)
        epSuitWindow:RefreshChipSuitSimpleUI()
        self.__onChipSuitUpdate = BindCallback(self, self._RefreshChipSuitItemPreview)
        MsgCenter:AddListener(eMsgEventId.OnEpChipSuitUpdate, self.__onChipSuitUpdate)
      end
      self:StartRunNextLogic()
      self._waitFirstLoadScene = false
    end
  end
)
end

BattleDungeonController.DungeonIsInWaitFirstLoadScene = function(self)
  -- function num : 0_3
  return self._waitFirstLoadScene
end

BattleDungeonController.SetDungeonAfterEnterSceneExit = function(self)
  -- function num : 0_4
  self._afterEnterSceneExit = true
end

BattleDungeonController.ExitBattleDungeon = function(self, battleWin, notNeedWinEvent)
  -- function num : 0_5 , upvalues : _ENV
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local param1 = battleWin and 2 or 3
  avgPlayCtrl:TryPlayTaskAvg(param1, function()
    -- function num : 0_5_0 , upvalues : self, _ENV, battleWin
    if self.battleGuideType ~= 1 then
      BattleDungeonManager:ExitDungeon(battleWin, true)
    end
  end
)
  if battleWin and not notNeedWinEvent then
    local winEvent = BattleDungeonManager:GetBattleWinEvent()
    if winEvent ~= nil then
      BattleDungeonManager:ClearBattleWinEvent()
      winEvent()
    end
  end
end

BattleDungeonController.StartRunNextLogic = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if self:__TryRunTopLogic() then
    return 
  end
  self.__runLogicTimerId = TimerManager:StartTimer(1, self.__TryRunTopLogic, self, false, true)
end

BattleDungeonController.__TryRunTopLogic = function(self)
  -- function num : 0_7 , upvalues : _ENV
  if #self.__cacheDungeonLogic > 0 then
    TimerManager:StopTimer(self.__runLogicTimerId)
    local logicData = (table.remove)(self.__cacheDungeonLogic, 1)
    ;
    (self.__dungeonLogicMessage):Broadcast(logicData.logicType, logicData.logicContent)
    return true
  end
  do
    return false
  end
end

BattleDungeonController.AddDungeonLogic = function(self, logicType, msgData)
  -- function num : 0_8 , upvalues : _ENV
  local logicCacheData = {logicType = logicType, logicContent = msgData}
  ;
  (table.insert)(self.__cacheDungeonLogic, logicCacheData)
end

BattleDungeonController.RegisterDungeonLogic = function(self, logicId, action)
  -- function num : 0_9
  (self.__dungeonLogicMessage):AddListener(logicId, action)
end

BattleDungeonController.UnRegisterDungeonLogic = function(self, logicId, action)
  -- function num : 0_10
  (self.__dungeonLogicMessage):RemoveListener(logicId, action)
end

BattleDungeonController.CalculateBloodGrid = function(self, monsterList)
  -- function num : 0_11 , upvalues : _ENV
  local heroDic = (self.dynPlayer).heroDic
  local maxHp, minHp = nil, nil
  for id,dyHero in pairs(heroDic) do
    local hp = dyHero:GetRealAttr(eHeroAttr.maxHp)
    if maxHp ~= nil or not hp then
      maxHp = (math.max)(maxHp, hp)
    end
    if minHp ~= nil or not hp then
      minHp = (math.min)(minHp, hp)
    end
  end
  for id,monsterRole in ipairs(monsterList) do
    local hp = monsterRole:GetRealAttr(eHeroAttr.maxHp)
    if maxHp ~= nil or not hp then
      maxHp = (math.max)(maxHp, hp)
    end
    if minHp ~= nil or not hp then
      minHp = (math.min)(minHp, hp)
    end
  end
  self.unitBlood = (BattleUtil.CalculateBloodGrid)(maxHp, minHp)
end

BattleDungeonController._RefreshChipSuitItemPreview = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local win = UIManager:GetWindow(UIWindowTypeID.EpChipSuit)
  win:RefreshChipSuitSimpleUI()
end

BattleDungeonController.OnDelete = function(self)
  -- function num : 0_13 , upvalues : _ENV
  TimerManager:StopTimer(self.__runLogicTimerId)
  if self.__onChipSuitUpdate ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.OnEpChipSuitUpdate, self.__onChipSuitUpdate)
    self.__onChipSuitUpdate = nil
  end
  for k,v in pairs(self.ctrls) do
    v:OnDelete()
  end
  self.ctrls = nil
end

return BattleDungeonController

