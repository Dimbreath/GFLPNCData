-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Game.Exploration.MainCtrl.EpMainCtrlBase")
local EpNormalMainCtrl = class("EpNormalMainCtrl", base)
local ExplorationMapCtrl = require("Game.Exploration.Ctrl.ExplorationMapCtrl")
local ePlayerState = base.ePlayerState
local cs_MessageCommon = CS.MessageCommon
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
EpNormalMainCtrl.ctor = function(self, mapData, dynPlayer)
  -- function num : 0_0 , upvalues : _ENV
  local saveUserData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
  local unitBlood, bossUnitBlood = saveUserData:GetUnitBlood()
  if unitBlood or 0 > 0 then
    self:SetBloodGrid(unitBlood, bossUnitBlood)
  end
end

EpNormalMainCtrl.InitEpMainSubCtrls = function(self)
  -- function num : 0_1 , upvalues : base, ExplorationMapCtrl
  (base.InitEpMainSubCtrls)(self)
  self.mapCtrl = (ExplorationMapCtrl.New)(self)
end

EpNormalMainCtrl.Start = function(self, isReconnect, isFirstEnter)
  -- function num : 0_2 , upvalues : base
  (base.Start)(self, isReconnect, isFirstEnter)
end

EpNormalMainCtrl.__EnterBattleScene = function(self, roomData, isReconnect)
  -- function num : 0_3 , upvalues : base, _ENV, ExplorationEnum
  (base.__EnterBattleScene)(self, roomData, isReconnect)
  if self.bloodGridMax == nil then
    local saveUserData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
    local unitBlood, bossUnitBlood = saveUserData:GetUnitBlood()
    if unitBlood or 0 > 0 then
      self:SetBloodGrid(unitBlood, bossUnitBlood)
    else
      self:CalculateBloodGrid()
    end
  end
  do
    ;
    (roomData.battleMap):SetBloodGridParam(self.unitBlood, self.bossUnitBlood, self.bloodGridMax, (ConfigData.game_config).bloodDensity)
    ;
    (roomData.battleMap):SetPlayerRoleBattleMaxCount((self.dynPlayer):GetEnterFiledNum())
    if roomData:IsBossRoom() or roomData:GetRoomType() == (ExplorationEnum.eRoomType).challenge then
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
    -- function num : 0_3_0 , upvalues : csbattleCtrl
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
end

EpNormalMainCtrl.UpdateNextRoomInfo = function(self, epGrid, jumpCat)
  -- function num : 0_4 , upvalues : base
  (base.UpdateNextRoomInfo)(self, epGrid, jumpCat)
  if self.bloodGridMax == nil then
    self:CalculateBloodGrid()
  end
end

EpNormalMainCtrl.OnPlayerMoveStart = function(self, roomData)
  -- function num : 0_5 , upvalues : _ENV
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
    -- function num : 0_5_0 , upvalues : self, roomData, _ENV
    self:OnPlayerMoveComplete(roomData)
    UIManager:HideWindow(UIWindowTypeID.ClickContinue)
  end
, (roomUI.transform).position)
  end
end

EpNormalMainCtrl.OnExitEpRoomBegin = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local curRoomData = self:GetCurrentRoomData(true)
  if curRoomData:IsEndColRoom() then
    return 
  end
  ;
  (UIManager:ShowWindow(UIWindowTypeID.ClickContinue)):InitContinue(nil, nil, nil, Color.clear, false)
  ;
  (self.mapCtrl):PlayerPosItemMove2NextPos(function()
    -- function num : 0_6_0 , upvalues : self, _ENV, curRoomData
    ((self.sceneCtrl).epSceneEntity):EpRoomCoverBattleMap(true, function()
      -- function num : 0_6_0_0 , upvalues : _ENV, self, curRoomData
      UIManager:HideWindow(UIWindowTypeID.ClickContinue)
      self:OnExitEpRoomEnd(curRoomData)
    end
)
  end
)
end

EpNormalMainCtrl.CalculateBloodGrid = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local roomList = {}
  local curRoom = self:GetCurrentRoomData(true)
  local nextRoomList = curRoom:GetNextRoom()
  ;
  (table.insert)(roomList, curRoom)
  ;
  (table.insertto)(roomList, nextRoomList)
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
  for _,epRoom in ipairs(roomList) do
    if epRoom ~= nil and epRoom:IsBattleRoom() then
      local monsterList = epRoom:GetMonsterList()
      for _,monster in ipairs(monsterList) do
        if monster:GetBossBloodNum() == 0 then
          local hp = monster:GetRealAttr(eHeroAttr.maxHp)
          if maxHp ~= nil or not hp then
            maxHp = (math.max)(maxHp, hp)
          end
          if minHp ~= nil or not hp then
            minHp = (math.min)(minHp, hp)
          end
        end
      end
    end
  end
  self.unitBlood = (BattleUtil.CalculateBloodGrid)(maxHp, minHp)
  local saveUserData = PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)
  saveUserData:SetUnitBlood(self.unitBlood, self.bossUnitBlood)
end

EpNormalMainCtrl.SetBloodGrid = function(self, unitBlood, bossUnitBlood)
  -- function num : 0_8 , upvalues : _ENV
  self.unitBlood = unitBlood
  self.bossUnitBlood = bossUnitBlood
  self.bloodGridMax = (ConfigData.game_config).bloodGridMax
end

EpNormalMainCtrl.GenExplorationMap = function(self)
  -- function num : 0_9
  (self.mapCtrl):GenMap(self.mapData, self:GetCurrentRoomData(true))
end

EpNormalMainCtrl.SetViewPositionOffset = function(self, offsetPosition)
  -- function num : 0_10
  local position = (self.mapCtrl):GetViewPosition() + offsetPosition
  return (self.mapCtrl):SetViewPosition(position)
end

EpNormalMainCtrl.GetRoomRoot = function(self)
  -- function num : 0_11
  return (self.mapCtrl):GetRoomRoot()
end

EpNormalMainCtrl.GetRoomUI = function(self, position, index)
  -- function num : 0_12
  return (self.mapCtrl):GetRoomUI(position, index)
end

EpNormalMainCtrl.OnDelete = function(self)
  -- function num : 0_13 , upvalues : _ENV, base
  UIManager:DeleteWindow(UIWindowTypeID.Exploration)
  ;
  (base.OnDelete)(self)
end

return EpNormalMainCtrl

