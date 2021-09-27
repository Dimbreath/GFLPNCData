local base = require("Game.Exploration.MainCtrl.EpMainCtrlBase")
local EpNormalMainCtrl = class("EpNormalMainCtrl", base)
local ExplorationPlayerCtrl = require("Game.Exploration.Ctrl.ExplorationPlayerCtrl")
local ExplorationMapCtrl = require("Game.Exploration.Ctrl.ExplorationMapCtrl")
local ExplorationBattleCtrl = require("Game.Exploration.Ctrl.ExplorationBattleCtrl")
local ExplorationSceneCtrl = require("Game.Exploration.Ctrl.ExplorationSceneCtrl")
local ePlayerState = base.ePlayerState
local cs_MessageCommon = CS.MessageCommon
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
EpNormalMainCtrl.ctor = function(self, mapData, dynPlayer)
  -- function num : 0_0
end

EpNormalMainCtrl.InitEpMainSubCtrls = function(self)
  -- function num : 0_1 , upvalues : base, ExplorationPlayerCtrl, ExplorationMapCtrl, ExplorationBattleCtrl, ExplorationSceneCtrl
  (base.InitEpMainSubCtrls)(self)
  self.playerCtrl = (ExplorationPlayerCtrl.New)(self)
  self.mapCtrl = (ExplorationMapCtrl.New)(self)
  self.battleCtrl = (ExplorationBattleCtrl.New)(self)
  self.sceneCtrl = (ExplorationSceneCtrl.New)(self)
end

EpNormalMainCtrl.Start = function(self, isReconnect, isFirstEnter)
  -- function num : 0_2 , upvalues : base
  (base.Start)(self, isReconnect, isFirstEnter)
end

EpNormalMainCtrl.__EnterExplorationScene = function(self, state)
  -- function num : 0_3 , upvalues : _ENV, base
  AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, (eAuSelct.Sector).name, (eAuSelct.Sector).roomSelect)
  ;
  (base.__EnterExplorationScene)(self, state)
end

EpNormalMainCtrl.__OnEnterEpSceneComplete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.__TryShowOperationBeforeEpSceneComplete)(self)
end

EpNormalMainCtrl.__EnterBattleScene = function(self, roomData, isReconnect)
  -- function num : 0_5 , upvalues : base, ExplorationEnum, _ENV
  (base.__EnterBattleScene)(self, roomData, isReconnect)
  if (roomData:IsBossRoom() or roomData:GetRoomType() == (ExplorationEnum.eRoomType).challenge) and not ExplorationManager:IsSectorNewbee() then
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, (eAuSelct.Sector).name, (eAuSelct.Sector).bossCombat)
  else
    AudioManager:SetSourceSelectorLabel(eAudioSourceType.BgmSource, (eAuSelct.Sector).name, (eAuSelct.Sector).normalCombat)
  end
  local window = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if window ~= nil then
    window:Hide(true)
  end
  window = UIManager:GetWindow(UIWindowTypeID.Exploration)
  if window ~= nil then
    window:Hide(true)
  end
  local csbattleCtrl = (self.battleCtrl):StartNewEpBattle(roomData, self.dynPlayer)
  local epToBattleAction = function()
    -- function num : 0_5_0 , upvalues : csbattleCtrl
    csbattleCtrl:StartEnterDeployState()
  end

  if roomData:IsDeployRoom() or isReconnect then
    (self.sceneCtrl):ExplorationToBattleSceneInReconnected(epToBattleAction)
  else
    local epDetail = (self.dynPlayer):GetOperatorDetail()
    if epDetail.state ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Over or not #epDetail.path - 1 then
      local index = #epDetail.path
    end
    local lastRoomCoord = (epDetail.path)[index]
    local lastRoomPos = ((self.mapCtrl):GetRoomEntity(lastRoomCoord)):GetRoomEntityLocalPos(0)
    local curRoomPos = ((self.mapCtrl):GetRoomEntity(roomData.position)):GetRoomEntityLocalPos(0)
    local isUp = lastRoomPos.y < curRoomPos.y
    local dir = -1
    if isUp then
      dir = 1
    end
    if roomData:IsBossRoom() then
      dir = 0
    end
    local roomPos = (self.mapCtrl):GetRoomEntityPos(roomData)
    local mapRoot = self:GetRoomRoot()
    ;
    (self.sceneCtrl):ExplorationToBattleSceneNormal(dir, mapRoot, roomPos, epToBattleAction)
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

EpNormalMainCtrl.UpdateNextRoomInfo = function(self, epGrid, jumpCat)
  -- function num : 0_6 , upvalues : base
  (base.UpdateNextRoomInfo)(self, epGrid, jumpCat)
end

EpNormalMainCtrl.CheckAfterOutSide = function(self)
  -- function num : 0_7 , upvalues : base, _ENV
  (base.CheckAfterOutSide)(self)
  if not self._outsideTheRoomFunc then
    self._outsideTheRoomFunc = function()
    -- function num : 0_7_0 , upvalues : self, _ENV
    self:CheckBossRoom()
    GuideManager:TryTriggerGuide(eGuideCondition.InEpRoomOutside)
  end

    if not (self.residentStoreCtrl):CheckEpResidentStore(self._outsideTheRoomFunc) then
      (self._outsideTheRoomFunc)()
    end
  end
end

EpNormalMainCtrl.OnPlayerMoveStart = function(self, roomData)
  -- function num : 0_8 , upvalues : _ENV
  AudioManager:PlayAudioById(1002)
  if roomData:IsBattleRoom() then
    (self.mapCtrl):PlayerPosItemMove2NextPos()
    self:OnPlayerMoveComplete(roomData)
  else
    ;
    (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
    local roomUI = self:GetRoomUI(roomData.position)
    ;
    (self.mapCtrl):PlayerPosItemMove2NextPos()
    ;
    ((self.sceneCtrl).epSceneEntity):EpRoomCoverBattleMap(true, function()
    -- function num : 0_8_0 , upvalues : self, roomData, _ENV
    self:OnPlayerMoveComplete(roomData)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  end
, (roomUI.transform).position)
  end
end

EpNormalMainCtrl.OnExitEpRoomBegin = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local curRoomData = self:GetCurrentRoomData(true)
  if curRoomData:IsEndColRoom() then
    return 
  end
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
  ;
  (self.mapCtrl):PlayerPosItemMove2NextPos(function()
    -- function num : 0_9_0 , upvalues : self, _ENV, curRoomData
    ((self.sceneCtrl).epSceneEntity):EpRoomCoverBattleMap(true, function()
      -- function num : 0_9_0_0 , upvalues : _ENV, self, curRoomData
      UIManager:HideWindow(UIWindowTypeID.ClickContinue)
      self:OnExitEpRoomEnd(curRoomData)
    end
)
  end
)
end

EpNormalMainCtrl.GenExplorationMap = function(self)
  -- function num : 0_10
  (self.mapCtrl):GenMap(self.mapData, self:GetCurrentRoomData(true))
end

EpNormalMainCtrl.SetViewPositionOffset = function(self, offsetPosition)
  -- function num : 0_11
  local position = (self.mapCtrl):GetViewPosition() + offsetPosition
  return (self.mapCtrl):SetViewPosition(position)
end

EpNormalMainCtrl.GetRoomRoot = function(self)
  -- function num : 0_12
  return (self.mapCtrl):GetRoomRoot()
end

EpNormalMainCtrl.GetRoomUI = function(self, position, index)
  -- function num : 0_13
  return (self.mapCtrl):GetRoomUI(position, index)
end

EpNormalMainCtrl.OnDelete = function(self)
  -- function num : 0_14 , upvalues : _ENV, base
  UIManager:DeleteWindow(UIWindowTypeID.Exploration)
  UIManager:DeleteWindow(UIWindowTypeID.EpChipSuit)
  ;
  (base.OnDelete)(self)
end

return EpNormalMainCtrl

