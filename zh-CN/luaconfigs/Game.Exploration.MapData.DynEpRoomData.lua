-- params : ...
-- function num : 0 , upvalues : _ENV
local BaseBattleRoom = require("Game.Common.Data.BaseBattleRoom")
local DynEpRoomData = class("DynEpRoomData", BaseBattleRoom)
local CS_BattleUtility = CS.BattleUtility
local ChipData = require("Game.PlayerData.Item.ChipData")
local ItemData = require("Game.PlayerData.Item.ItemData")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
DynEpRoomData.ctor = function(self, x, y, type, position, hidden, cross, mode)
  -- function num : 0_0
  self.x = x
  self.y = y
  self.type = type
  self.mode = mode
  if not position then
    self.position = y << 16 | x
    self.hidden = hidden
    self.visible = not hidden
    self.isCrossRoom = cross or false
    self.monsterList = {}
    self.neutralList = {}
  end
end

DynEpRoomData.SetMapData = function(self, map, epOp)
  -- function num : 0_1 , upvalues : ExplorationEnum
  self.mapData = map
  if epOp and self.position == epOp.curPostion then
    self.jumpCat = epOp.jumpCat
  end
  if (self:IsBattleRoom() or self.type == (ExplorationEnum.eRoomType).deploy) and self.battleMap == nil then
    self:GenerateBattleMap()
  end
end

DynEpRoomData.SetEpRoomEpOpStateChanged = function(self, EpOp)
  -- function num : 0_2 , upvalues : ExplorationEnum
  if not EpOp or EpOp.curPostion ~= self.position then
    return 
  end
  if EpOp.jumpCat and EpOp.jumpCat > 0 then
    self.jumpCat = EpOp.jumpCat
    if (self:IsBattleRoom() or self.type == (ExplorationEnum.eRoomType).deploy) and self.battleMap == nil then
      self:GenerateBattleMap()
    end
  end
end

DynEpRoomData.GenerateBattleMap = function(self)
  -- function num : 0_3 , upvalues : CS_BattleUtility, ExplorationEnum
  local size_row, size_col, deploy_rows = (self.mapData):GetBattleFieldSize()
  self.battleMap = (CS_BattleUtility.GenBattleMap)(size_row, size_col, deploy_rows)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.battleMap).IsDeployRoom = self.type == (ExplorationEnum.eRoomType).deploy
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynEpRoomData.GetSceneId = function(self)
  -- function num : 0_4
  return ((self.mapData).sceneCfg).id
end

DynEpRoomData.IsMaxWidthCol = function(self)
  -- function num : 0_5
  return ((self.mapData):GetMapColType(self.x)).isMaxWidthCol
end

DynEpRoomData.IsEndColRoom = function(self)
  -- function num : 0_6
  do return self.x == (self.mapData).maxMapColNumber end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynEpRoomData.InitBattleData = function(self, monsterGroup)
  -- function num : 0_7 , upvalues : _ENV, ChipData
  self.battleId = monsterGroup.battleId
  self.dungeonType = monsterGroup.dungeonType
  self.crazyTime = monsterGroup.crazyTime
  if self.battleMap == nil then
    self:GenerateBattleMap()
  end
  self:__InitMonsterOrNeutralData(monsterGroup.roleGroup)
  self:__InitBattleGrid(monsterGroup.grids)
  self.chipPreview = monsterGroup.algShow
  self.rewardChipList = {}
  if monsterGroup.alg ~= nil then
    for k,v in ipairs(monsterGroup.alg) do
      local chipData = (ChipData.NewChipForServer)(v)
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self.rewardChipList)[k] = chipData
    end
  end
  do
    self.monsterChipList = {}
    if monsterGroup.monsterAlg ~= nil then
      for k,v in ipairs(monsterGroup.monsterAlg) do
        local chipData = (ChipData.NewChipForServer)(v)
        -- DECOMPILER ERROR at PC48: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (self.monsterChipList)[k] = chipData
      end
    end
    do
      self.refreshAlgCntAfterBattle = monsterGroup.refreshAlgCnt
    end
  end
end

DynEpRoomData.InitRoomRewardGroup = function(self, rewards)
  -- function num : 0_8 , upvalues : _ENV, ItemData
  self.rewardList = {}
  if rewards ~= nil then
    for k1,elem in ipairs(rewards.data) do
      for i = 1, elem.stacking do
        local itemData = (ItemData.New)(elem.id, elem.num)
        local pos = (math.random)(1, #self.rewardList + 1)
        ;
        (table.insert)(self.rewardList, pos, itemData)
      end
    end
    self.rewardExtraDic = rewards.extra
  end
end

DynEpRoomData.InitTreasureRoomData = function(self, treasureGroup)
  -- function num : 0_9 , upvalues : _ENV, ChipData, ChipEnum
  if treasureGroup == nil then
    error("DynEpRoomData:InitTreasureRoomData error:treasureGroup is nil")
    return 
  end
  self.treasureData = {}
  local boxId = nil
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.treasureData).boxId = treasureGroup.boxId
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.treasureData).logic = treasureGroup.logic
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.treasureData).freshCnt = treasureGroup.freshCnt
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.treasureData).chipDatas = {}
  if treasureGroup.data ~= nil then
    for k,v in pairs(treasureGroup.data) do
      local Data = {}
      Data.data = (ChipData.NewChipForServer)(v.id)
      local state = nil
      if v.state == (ChipEnum.eChipSelectState).StateNone then
        state = false
      else
        if v.state == (ChipEnum.eChipSelectState).StateSelected then
          state = true
        else
          error("DynEpRoomData:InitTreasureRoomData error:treasureGroup.data.state is nil")
          break
        end
      end
      Data.state = state
      Data.idx = k - 1
      ;
      (table.insert)((self.treasureData).chipDatas, Data)
    end
    do
      MsgCenter:Broadcast(eMsgEventId.OnTreasureRoomUpdate, self)
    end
  end
end

DynEpRoomData.InitStoreRoomData = function(self, storeGroup)
  -- function num : 0_10 , upvalues : _ENV, ChipData
  if storeGroup == nil then
    error("DynEpRoomData:InitStoreRoomData error:storeGroup is nil")
    return 
  end
  self.storeRoomData = {}
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.storeRoomData).currencyId = storeGroup.currency
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.storeRoomData).storeId = storeGroup.storeId
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.storeRoomData).refreshTimes = storeGroup.refreshTimes
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.storeRoomData).extraFetterFreeRefreshTimes = storeGroup.freeRefreshTimes
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.storeRoomData).discCountLimitTimes = storeGroup.discCountLimitTimes
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.storeRoomData).data = {}
  if storeGroup.data ~= nil then
    for idx,elem in ipairs(storeGroup.data) do
      local chipData = (ChipData.NewChipForServer)(elem.id)
      local storeData = {}
      storeData.idx = idx
      storeData.id = chipData.dataId
      storeData.discount = elem.discount
      storeData.saled = elem.saled
      storeData.chipData = chipData
      ;
      (table.insert)((self.storeRoomData).data, storeData)
    end
    MsgCenter:Broadcast(eMsgEventId.OnStoreRoomUpdate, self)
  end
end

DynEpRoomData.InitEventAndRecoveryRoomData = function(self, eventGroup, jumpCat)
  -- function num : 0_11 , upvalues : _ENV
  if eventGroup == nil then
    error("DynEpRoomData:InitEventAndRecoveryRoomData error:eventGroup is nil")
    return 
  end
  eventGroup.choiceDatalist = {}
  local isHaveRandom = false
  for index,value in ipairs(eventGroup.data) do
    local isRandom = value.random
    local choiceData = {}
    choiceData.idx = index - 1
    choiceData.choiceId = value.id
    choiceData.isRandom = isRandom
    choiceData.catId = value.cat
    if isRandom then
      isHaveRandom = true
    end
    ;
    (table.insert)(eventGroup.choiceDatalist, choiceData)
  end
  eventGroup.data = nil
  eventGroup.isHaveRandom = isHaveRandom
  eventGroup.eRoomType = self.type
  self.eventData = eventGroup
  if jumpCat == nil or jumpCat == 0 then
    MsgCenter:Broadcast(eMsgEventId.OnEventAndRecoveryRoomUpdate, self)
  end
end

DynEpRoomData.InitResetRoomData = function(self, resetRoomGroup)
  -- function num : 0_12 , upvalues : _ENV
  if resetRoomGroup == nil then
    error("DynEpRoomData:InitResetRoomData error:resetGroup is nil")
    return 
  end
  self.roomRecordList = {}
  self.roomRecordList = resetRoomGroup.record
  MsgCenter:Broadcast(eMsgEventId.OnResetRoomUpdate, self)
end

DynEpRoomData.InitEpBuffEffective = function(self, data)
  -- function num : 0_13
  self.epBuffEffective = data
end

DynEpRoomData.GetEpBuffEffective = function(self, dynPlayer)
  -- function num : 0_14 , upvalues : _ENV
  local curRoomActiveBuff = {}
  if self:IsBattleRoom() then
    local epBuffList = dynPlayer:GetEpBuffList()
    for _,epBuff in pairs(epBuffList) do
      local buffCfg = epBuff:GetEpBuffCfg()
      if buffCfg.tigger_type == 2 then
        if buffCfg.is_battleShow then
          (table.insert)(curRoomActiveBuff, buffCfg)
        end
      end
    end
  end
  do
    if (ConfigData.game_config).epBuffShowMax <= #curRoomActiveBuff or self.epBuffEffective ~= nil then
      for buffId,count in pairs(self.epBuffEffective) do
        if (ConfigData.game_config).epBuffShowMax > #curRoomActiveBuff then
          local buffCfg = (ConfigData.exploration_buff)[buffId]
          if buffCfg == nil then
            error("exploration buff cfg is null,id:" .. tostring(R12_PC54))
          else
            local i = 1
            while i <= count and #curRoomActiveBuff < (ConfigData.game_config).epBuffShowMax do
              if buffCfg.is_battleShow then
                (table.insert)(curRoomActiveBuff, R12_PC54)
              end
              i = i + 1
            end
          end
          do
            -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    if #curRoomActiveBuff == 0 then
      return nil
    end
    ;
    (table.sort)(curRoomActiveBuff, function(b1, b2)
    -- function num : 0_14_0
    do return b1.id < b2.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    return curRoomActiveBuff
  end
end

DynEpRoomData.GetNextRoom = function(self)
  -- function num : 0_15 , upvalues : _ENV, ExplorationEnum
  if self:IsEpSpecialRoom() then
    warn("EpSpecialRoom hasn\'t next room.")
    return 
  end
  if self.nextRooms ~= nil then
    return self.nextRooms
  end
  self.nextRooms = {}
  local colTrackType = (self.mapData):GetMapColTrackType(self.x)
  if colTrackType == (ExplorationEnum.eTrackLineType).EndTrack then
    return self.nextRooms
  end
  if colTrackType == (ExplorationEnum.eTrackLineType).ReverseETrack or colTrackType == (ExplorationEnum.eTrackLineType).SingleTrack then
    (table.insert)(self.nextRooms, (self.mapData):GetRoomByXY(self.x + 1, 0))
    return self.nextRooms
  end
  if colTrackType == (ExplorationEnum.eTrackLineType).NormalETrack then
    for k,room in pairs(((self.mapData).roomMap)[self.x + 1]) do
      (table.insert)(self.nextRooms, room)
    end
    return self.nextRooms
  end
  local tx = self.x + 1
  local ty = self.y
  local tmpRoom = (self.mapData):GetRoomByXY(tx, ty)
  if tmpRoom ~= nil then
    (table.insert)(self.nextRooms, tmpRoom)
  end
  if self:IsMaxWidthCol() then
    ty = self.y - 1
  else
    ty = self.y + 1
  end
  tmpRoom = (self.mapData):GetRoomByXY(tx, ty)
  if tmpRoom ~= nil then
    (table.insert)(self.nextRooms, tmpRoom)
  end
  return self.nextRooms
end

DynEpRoomData.GetLastRoom = function(self)
  -- function num : 0_16 , upvalues : ExplorationEnum, _ENV
  if self.lastRooms ~= nil then
    return self.lastRooms
  end
  self.lastRooms = {}
  if self.x == 0 then
    return self.lastRooms
  end
  local lastColTrackType = (self.mapData):GetMapColTrackType(self.x - 1)
  if lastColTrackType == (ExplorationEnum.eTrackLineType).NormalETrack or lastColTrackType == (ExplorationEnum.eTrackLineType).SingleTrack then
    (table.insert)(self.lastRooms, (self.mapData):GetRoomByXY(self.x - 1, 0))
    return self.lastRooms
  end
  if lastColTrackType == (ExplorationEnum.eTrackLineType).ReverseETrack then
    for k,room in pairs(((self.mapData).roomMap)[self.x - 1]) do
      (table.insert)(self.lastRooms, room)
    end
    return self.lastRooms
  end
  local tx = self.x - 1
  local ty = self.y
  local tmpRoom = (self.mapData):GetRoomByXY(tx, ty)
  if tmpRoom ~= nil then
    (table.insert)(self.lastRooms, tmpRoom)
  end
  if self:IsMaxWidthCol() then
    ty = self.y - 1
  else
    ty = self.y + 1
  end
  tmpRoom = (self.mapData):GetRoomByXY(tx, ty)
  if tmpRoom ~= nil then
    (table.insert)(self.lastRooms, tmpRoom)
  end
  return self.lastRooms
end

DynEpRoomData.GetNextDownDirRoom = function(self)
  -- function num : 0_17 , upvalues : ExplorationEnum
  local colTrackType = (self.mapData):GetMapColTrackType(self.x)
  if colTrackType ~= (ExplorationEnum.eTrackLineType).NormalYTrack then
    return nil
  end
  local tx = self.x + 1
  local ty = self.y
  if self:IsMaxWidthCol() then
    ty = ty - 1
  end
  local tmpRoom = (self.mapData):GetRoomByXY(tx, ty)
  return tmpRoom
end

DynEpRoomData.GetNextUpDirRoom = function(self)
  -- function num : 0_18 , upvalues : ExplorationEnum
  local colTrackType = (self.mapData):GetMapColTrackType(self.x)
  if colTrackType ~= (ExplorationEnum.eTrackLineType).NormalYTrack then
    return nil
  end
  local tx = self.x + 1
  local ty = self.y
  if not self:IsMaxWidthCol() then
    ty = ty + 1
  end
  local tmpRoom = (self.mapData):GetRoomByXY(tx, ty)
  return tmpRoom
end

DynEpRoomData.GetNextParallelRoom = function(self)
  -- function num : 0_19 , upvalues : ExplorationEnum
  local colTrackType = (self.mapData):GetMapColTrackType(self.x)
  if colTrackType ~= (ExplorationEnum.eTrackLineType).SingleTrack then
    return nil
  end
  local tmpRoom = (self.mapData):GetRoomByXY(self.x + 1, self.y)
  return tmpRoom
end

DynEpRoomData.GetNextAllRoom = function(self)
  -- function num : 0_20
  local tmpRooms = (self.mapData):GetRoomsByX(self.x + 1)
  return tmpRooms
end

DynEpRoomData.IsBattleRoom = function(self, jumpCat)
  -- function num : 0_21 , upvalues : ExplorationEnum
  if jumpCat ~= nil and jumpCat > 0 then
    self.jumpCat = jumpCat
  end
  local roomType = self:GetRoomType()
  local isBattleRoom = roomType == (ExplorationEnum.eRoomType).enemy or roomType == (ExplorationEnum.eRoomType).elite or roomType == (ExplorationEnum.eRoomType).challenge or roomType == (ExplorationEnum.eRoomType).boss
  do return isBattleRoom end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynEpRoomData.IsDeployRoom = function(self)
  -- function num : 0_22 , upvalues : ExplorationEnum
  do return self.type == (ExplorationEnum.eRoomType).deploy end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynEpRoomData.IsStartRoom = function(self)
  -- function num : 0_23 , upvalues : ExplorationEnum
  do return self.type == (ExplorationEnum.eRoomType).start end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynEpRoomData.IsHiddenRoom = function(self)
  -- function num : 0_24
  return self.hidden
end

DynEpRoomData.SetVisible = function(self, visible)
  -- function num : 0_25
  self.visible = visible
end

DynEpRoomData.GetVisible = function(self)
  -- function num : 0_26
  return self.visible
end

DynEpRoomData.IsCrossRoom = function(self)
  -- function num : 0_27
  return self.isCrossRoom
end

DynEpRoomData.GetTotalFightingPower = function(self)
  -- function num : 0_28 , upvalues : _ENV
  if not self:IsBattleRoom() then
    return 0
  end
  local fightingPower = 0
  for k,dynMonster in pairs(self.monsterList) do
    fightingPower = fightingPower + dynMonster:GetFightingPower()
  end
  return fightingPower
end

DynEpRoomData.GetMonsterList = function(self)
  -- function num : 0_29
  return self.monsterList
end

DynEpRoomData.GetRewardChipList = function(self)
  -- function num : 0_30
  return self.rewardChipList
end

DynEpRoomData.GetRoomPosition = function(self)
  -- function num : 0_31
  return self.position
end

DynEpRoomData.IsBossRoom = function(self)
  -- function num : 0_32 , upvalues : ExplorationEnum
  do return self.type == (ExplorationEnum.eRoomType).boss end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynEpRoomData.IsRealBossRoom = function(self)
  -- function num : 0_33
  do return self == (self.mapData):GetRealBossRoom() end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynEpRoomData.IsHideBossRoom = function(self)
  -- function num : 0_34
  if self:IsBossRoom() then
    return not self:IsRealBossRoom()
  end
end

DynEpRoomData.GetRoomChipPreview = function(self)
  -- function num : 0_35
  return self.chipPreview or 0
end

DynEpRoomData.GetMosterChipList = function(self)
  -- function num : 0_36
  return self.monsterChipList
end

DynEpRoomData.GetRoomType = function(self)
  -- function num : 0_37
  local roomType = self.type
  if self.jumpCat ~= nil and self.jumpCat > 0 then
    roomType = self.jumpCat
  end
  return roomType
end

DynEpRoomData.ResetJumpCat = function(self)
  -- function num : 0_38
  self.jumpCat = nil
end

DynEpRoomData.SetAmbushAndSneakData = function(self, ambushData, stealthData)
  -- function num : 0_39 , upvalues : _ENV
  if (ambushData ~= 0 or stealthData ~= 0) and (self.ambushData ~= ambushData or self.stealthData ~= stealthData) then
    self.ambushData = ambushData
    self.stealthData = stealthData
    MsgCenter:Broadcast(eMsgEventId.OnBeforeBattleRandomDataChange, ambushData, stealthData, self:GetRoomPosition())
  end
end

DynEpRoomData.GetAmbushAndSneakData = function(self)
  -- function num : 0_40
  return self.ambushData, self.stealthData
end

DynEpRoomData.GetIsInWeeklyChallenge = function(self)
  -- function num : 0_41 , upvalues : _ENV
  if ExplorationManager == nil then
    return false
  end
  return ExplorationManager:GetIsInWeeklyChallenge()
end

DynEpRoomData.GetIsInWeeklyChallengeBigBossRoom = function(self)
  -- function num : 0_42
  do return not self:GetIsInWeeklyChallenge() or self.mode == 5 end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

DynEpRoomData.IsEpSpecialRoom = function(self)
  -- function num : 0_43 , upvalues : _ENV
  do return self.position == proto_object_EplSpecialPosition.EplSpecialPositionInit end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DynEpRoomData.SetEpSpecialRoomType = function(self, type)
  -- function num : 0_44
  if type > 0 then
    self.type = type
  else
    self.type = nil
  end
end

DynEpRoomData.ClearEpRoomData = function(self)
  -- function num : 0_45
  self.battleId = nil
  self.dungeonType = nil
  self.battleMap = nil
  self.monsterList = nil
  self.chipPreview = nil
  self.rewardChipList = nil
  self.rewardList = nil
  self.monsterChipList = nil
  self.effectGridList = nil
  self.crazyTime = nil
  self.refreshAlgCntAfterBattle = nil
  self.treasureData = nil
  self.storeRoomData = nil
  self.eventData = nil
  self.roomRecordList = nil
  self.ambushData = nil
  self.stealthData = nil
  self.epBuffEffective = nil
end

return DynEpRoomData

