local base = ExplorationCtrlBase
local ExplorationSupportRoomCtrl = class("ExplorationSupportRoomCtrl", base)
local DynHero = require("Game.Exploration.Data.DynHero")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
ExplorationSupportRoomCtrl.ctor = function(self, epCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.eventNetWork = NetworkManager:GetNetwork(NetworkTypeID.EventRoom)
end

ExplorationSupportRoomCtrl.EnterSupportRoom = function(self, heroStcList)
  -- function num : 0_1 , upvalues : _ENV
  local supportHeroList = {}
  local dynPlayer = (self.epCtrl).dynPlayer
  for k,stc in ipairs(heroStcList) do
    local dynHeroData = dynPlayer:CreateSupportDynHero(stc)
    if dynHeroData ~= nil then
      (table.insert)(supportHeroList, dynHeroData)
    end
  end
  dynPlayer:ExecuteAllChip2NewHeroList(supportHeroList)
  UIManager:ShowWindowAsync(UIWindowTypeID.EpSupportRoom, function(window)
    -- function num : 0_1_0 , upvalues : dynPlayer, supportHeroList, self
    if window == nil then
      return 
    end
    window:InitEpSurpportRoom(dynPlayer, supportHeroList, self)
  end
)
end

ExplorationSupportRoomCtrl.ReqChangeSupportHero = function(self, quitHeroUidList, enterIdList)
  -- function num : 0_2 , upvalues : _ENV
  local roomData = (self.epCtrl):GetCurrentRoomData()
  if not self._OnReqChangeHeroFunc then
    self._OnReqChangeHeroFunc = BindCallback(self, self._OnReqChangeSupportHero)
    ;
    (self.eventNetWork):CS_EXPLORATION_EVENT_Assist(roomData.position, quitHeroUidList, enterIdList, self._OnReqChangeHeroFunc)
  end
end

ExplorationSupportRoomCtrl._OnReqChangeSupportHero = function(self, objList)
  -- function num : 0_3 , upvalues : _ENV, ExplorationEnum
  if objList.Count == 0 then
    error("objList.Count == 0")
    return 
  end
  UIManager:DeleteWindow(UIWindowTypeID.EpSupportRoom)
  local msg = objList[0]
  if msg.roleSync == nil then
    return 
  end
  self:ChangeEpHero(msg.roleSync)
  MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, (ExplorationEnum.eExitRoomCompleteType).SupportRoom)
end

ChangeDynPlayerHero = function(dynPlayer, enter, quit, battlRoleType)
  -- function num : 0_4 , upvalues : _ENV, DynHero
  local newHeroList = {}
  local heroUidDic = {}
  local mirrorHeroDic = {}
  local addHeroList = {}
  local removeHeroList = {}
  local heroNum = 0
  for k,dynHero in ipairs(dynPlayer.heroList) do
    local mirrorHero = (dynPlayer.mirrorHeroList)[k]
    if quit[dynHero.uid] ~= nil then
      (table.insert)(removeHeroList, dynHero)
    else
      ;
      (table.insert)(newHeroList, dynHero)
      mirrorHeroDic[mirrorHero.uid] = mirrorHero
      if not dynHero:IsBench() then
        heroNum = heroNum + 1
      end
    end
  end
  for k,role in pairs(enter) do
    local dynHero = dynPlayer:CreateDynHero((role.data).stc, (role.data).dyc, role.roleType)
    dynHero:SetDynHeroFmtIdx(((role.data).dyc).formationIdx)
    dynHero.onBench = (ConfigData.game_config).max_stage_hero <= heroNum
    if not dynHero:IsBench() then
      heroNum = heroNum + 1
    end
    ;
    (table.insert)(newHeroList, dynHero)
    ;
    (table.insert)(addHeroList, dynHero)
    local stc = (role.data).stc
    local mirrorHero = (DynHero.New)(dynHero.heroData, dynHero.uid, battlRoleType)
    mirrorHero:UpdateBaseHeroData(stc.attr, stc.skillGroup, stc.athSkillGroup)
    mirrorHeroDic[mirrorHero.uid] = mirrorHero
  end
  ;
  (table.sort)(newHeroList, function(a, b)
    -- function num : 0_4_0
    do return a:GetDynHeroFmtIdx() < b:GetDynHeroFmtIdx() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local newMirrorHeroList = {}
  for k,dynHero in ipairs(newHeroList) do
    newMirrorHeroList[k] = mirrorHeroDic[dynHero.uid]
    heroUidDic[dynHero.uid] = dynHero
  end
  dynPlayer:SetPlayerNewHeroList(newHeroList, newMirrorHeroList, heroUidDic, mirrorHeroDic, enter)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

ExplorationSupportRoomCtrl.ChangeEpHero = function(self, roleSync)
  -- function num : 0_5 , upvalues : _ENV
  local dynPlayer = (self.epCtrl).dynPlayer
  local addHeroList, newHeroList, removeHeroList = dynPlayer:ChangeDynPlayerHeroList(roleSync.enter, roleSync.quit, roleSync.change, proto_object_EplBattleRoleType.BattleRoleAssist)
  ExplorationManager:TryUpdataEpMvpHeros(newHeroList, removeHeroList)
  local epWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if epWindow ~= nil then
    epWindow:ReInitDungeonHeroList(dynPlayer)
  end
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
  ;
  ((self.epCtrl).sceneCtrl):RefreshEpSceneHeroPos(newHeroList)
  ;
  ((self.epCtrl).sceneCtrl):ChangeEpHeroModel(removeHeroList, addHeroList, function()
    -- function num : 0_5_0 , upvalues : _ENV
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  end
)
end

ExplorationSupportRoomCtrl.OnDelete = function(self)
  -- function num : 0_6
end

return ExplorationSupportRoomCtrl

