local DormRoomCharacterCtrl = class("DormRoomCharacterCtrl")
local DormCharacterEntity = require("Game.Dorm.Character.Entity.DormCharacterEntity")
local DormUtil = require("Game.Dorm.DormUtil")
local cs_DormAStarUtils = CS.DormAStarUtils
DormRoomCharacterCtrl.ctor = function(self, characterCtrl, roomEntity)
  -- function num : 0_0 , upvalues : _ENV
  self.characterCtrl = characterCtrl
  self.roomEntity = roomEntity
  self.roomData = roomEntity.roomData
  self.__isCurEnterRoom = false
  self.__onUpdate = BindCallback(self, self.OnUpdate)
  self.characterDic = {}
  self.__charCount = 0
  self:InitDormRoomCharacterCtrl()
end

DormRoomCharacterCtrl.GetRoomCharacterCount = function(self)
  -- function num : 0_1
  return self.__charCount
end

DormRoomCharacterCtrl.GetRoomCharcterIdDic = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local heroIdDic = {}
  for heroId,_ in pairs(self.characterDic) do
    heroIdDic[heroId] = true
  end
  return heroIdDic
end

DormRoomCharacterCtrl.GetRoomUnbindCharacterId = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local heroIdDic = {}
  for heroId,charEntity in pairs(self.characterDic) do
    if not charEntity.isBind then
      heroIdDic[heroId] = true
    end
  end
  return heroIdDic
end

DormRoomCharacterCtrl.IsRoomCharacterFull = function(self)
  -- function num : 0_4 , upvalues : _ENV
  do return (ConfigData.game_config).DormRoomRoleMaxCount <= self.__charCount end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DormRoomCharacterCtrl.InitDormRoomCharacterCtrl = function(self)
  -- function num : 0_5 , upvalues : _ENV, DormUtil
  self.mapDic = setmetatable({}, {__index = function(tab, key)
    -- function num : 0_5_0
    return 0
  end
})
  for k,fntData in pairs((self.roomData).fntDataList) do
    local sizeX, sizeY = fntData:GetFntSize()
    ;
    (DormUtil.AddFntToMapDic)(self.mapDic, fntData.x, fntData.y, sizeX, sizeY, fntData.r)
  end
  local canBindfntDataList = (self.roomData):GetRoomCanBindList()
  for k,fntData in ipairs(canBindfntDataList) do
    local param = fntData:GetFntParam()
    local heroData = (PlayerDataCenter.heroDic)[param]
    if heroData ~= nil then
      self:AddBindCharacter(heroData, fntData)
    end
  end
end

DormRoomCharacterCtrl.StartCharacterLogic = function(self)
  -- function num : 0_6 , upvalues : _ENV
  for heroId,charEntity in pairs(self.characterDic) do
    charEntity:StartAIBehavior()
  end
end

DormRoomCharacterCtrl.__RandomUnBindActiveTime = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local minTime = ((ConfigData.game_config).DormUnBindActiveTime)[1]
  local maxTime = ((ConfigData.game_config).DormUnBindActiveTime)[2]
  local time = minTime + (math.random)(maxTime - minTime + 1) - 1
  return time
end

DormRoomCharacterCtrl.AddUnBindCharacter = function(self, heroData, activeTime)
  -- function num : 0_8 , upvalues : cs_DormAStarUtils, DormCharacterEntity
  local ok, pos = (cs_DormAStarUtils.RandomOnePoint)(((self.roomEntity).transform).position, 10000)
  if not ok then
    return 
  end
  self.__charCount = self.__charCount + 1
  if not activeTime then
    local charEntity = (DormCharacterEntity.New)(heroData, pos, self, self:__RandomUnBindActiveTime())
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.characterDic)[heroData.dataId] = charEntity
    charEntity:LoadDormCharacter((self.roomEntity).characterHolder)
    return charEntity
  end
end

DormRoomCharacterCtrl.AddUnBindCharacterAction = function(self, heroData, action)
  -- function num : 0_9 , upvalues : DormCharacterEntity
  self.__charCount = self.__charCount + 1
  local charEntity = (DormCharacterEntity.New)(heroData, nil, self, self:__RandomUnBindActiveTime())
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.characterDic)[heroData.dataId] = charEntity
  charEntity:LoadDormCharacter((self.roomEntity).characterHolder, action)
  return charEntity
end

DormRoomCharacterCtrl.AddBindCharacter = function(self, heroData, fntData)
  -- function num : 0_10 , upvalues : cs_DormAStarUtils, DormCharacterEntity
  local ok, pos = (cs_DormAStarUtils.RandomOnePoint)(((self.roomEntity).transform).position, 10000)
  if not ok then
    return 
  end
  self.__charCount = self.__charCount + 1
  local charEntity = (DormCharacterEntity.New)(heroData, pos, self, -1)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.characterDic)[heroData.dataId] = charEntity
  charEntity:LoadDormCharacter((self.roomEntity).characterHolder)
end

DormRoomCharacterCtrl.FindActivePosNearby = function(self, x, y)
  -- function num : 0_11 , upvalues : DormUtil, _ENV
  if not (DormUtil.IsFntCoordLegal)(x, y) then
    return 
  end
  local pos = (DormUtil.XYCoord2Fnt)(x, y)
  if (self.mapDic)[pos] == 0 then
    return x, y
  end
  local pointQue = {}
  local closeQue = {}
  ;
  (table.insert)(pointQue, pos)
  closeQue[pos] = true
  while #pointQue > 0 do
    local pos = (table.remove)(pointQue, 1)
    local dx, dy = (DormUtil.FntCoord2XY)(pos)
    for k,v in ipairs(DormUtil.FntForOffset) do
      local idx = dx + v.x
      local idy = dy + v.y
      local ipos = (DormUtil.XYCoord2Fnt)(idx, idy)
      if not closeQue[ipos] and (DormUtil.IsFntCoordLegal)(idx, idy) then
        if (self.mapDic)[ipos] == 0 then
          return idx, idy
        else
          ;
          (table.insert)(pointQue, ipos)
          closeQue[ipos] = true
        end
      end
    end
  end
end

DormRoomCharacterCtrl.GetCharacterEntityById = function(self, heroId)
  -- function num : 0_12
  local findEntity = (self.characterDic)[heroId]
  return findEntity
end

DormRoomCharacterCtrl.RemoveCharacterEntity = function(self, charEntity)
  -- function num : 0_13
  local heroId = (charEntity.heroData).dataId
  local findEntity = (self.characterDic)[heroId]
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'

  if findEntity == charEntity then
    (self.characterDic)[heroId] = nil
    self.__charCount = self.__charCount - 1
  end
end

DormRoomCharacterCtrl.DeleteCharacterById = function(self, heroId)
  -- function num : 0_14
  local findEntity = (self.characterDic)[heroId]
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  if findEntity ~= nil then
    (self.characterDic)[heroId] = nil
    findEntity:OnDelete()
    self.__charCount = self.__charCount - 1
    return true
  end
  return false
end

DormRoomCharacterCtrl.AddCharacterEntity = function(self, charEntity)
  -- function num : 0_15
  local heroId = (charEntity.heroData).dataId
  if (self.characterDic)[heroId] ~= nil then
    return 
  end
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.characterDic)[heroId] = charEntity
  ;
  (charEntity.transform):SetParent((self.roomEntity).characterHolder)
  charEntity:SetNewRoomCtrl(self)
  self.__charCount = self.__charCount + 1
end

DormRoomCharacterCtrl.FindNearActivePoint = function(self, count, x, y)
  -- function num : 0_16 , upvalues : DormUtil, _ENV
  local pos = (DormUtil.XYCoord2Fnt)(x, y)
  local pointQue = {}
  local closeQue = {}
  local findQue = {}
  ;
  (table.insert)(pointQue, pos)
  closeQue[pos] = true
  while #pointQue > 0 do
    local pos = (table.remove)(pointQue, 1)
    local dx, dy = (DormUtil.FntCoord2XY)(pos)
    for k,v in ipairs(DormUtil.FntForOffset) do
      local idx = dx + v.x
      local idy = dy + v.y
      local ipos = (DormUtil.XYCoord2Fnt)(idx, idy)
      if not closeQue[ipos] and (DormUtil.IsFntCoordLegal)(idx, idy) and (self.mapDic)[ipos] == 0 then
        (table.insert)(findQue, ipos)
        ;
        (table.insert)(pointQue, ipos)
        closeQue[ipos] = true
      end
    end
    if count <= #findQue then
      return findQue
    end
  end
  do
    return findQue
  end
end

DormRoomCharacterCtrl.OnUpdate = function(self)
  -- function num : 0_17 , upvalues : _ENV
  if self.characterDic == nil then
    return 
  end
  for heroId,charEntity in pairs(self.characterDic) do
    charEntity:OnUpdate()
  end
end

DormRoomCharacterCtrl.HidePauseRoomCharacter = function(self)
  -- function num : 0_18 , upvalues : _ENV
  for k,v in pairs(self.characterDic) do
    v:HidePauseCharacter()
  end
end

DormRoomCharacterCtrl.ShowResumeRoomCharacter = function(self)
  -- function num : 0_19 , upvalues : _ENV
  for k,v in pairs(self.characterDic) do
    v:ShowResumeCharacter()
  end
end

DormRoomCharacterCtrl.SetAsEnterActiveRoom = function(self)
  -- function num : 0_20
  self.__isCurEnterRoom = true
  self:GenRoomInterPointEntity()
end

DormRoomCharacterCtrl.UnSetAsEnterActiveRoom = function(self)
  -- function num : 0_21
  if not self.__isCurEnterRoom then
    return 
  end
  self.__isCurEnterRoom = false
  self:ClearSelectInterPoint()
  self:RecoveryInterPointEntity()
end

DormRoomCharacterCtrl.GenRoomInterPointEntity = function(self)
  -- function num : 0_22 , upvalues : _ENV
  self.pointEntityList = {}
  for _,interPoint in pairs((self.roomData).interpoint) do
    local fntEntity = (self.roomEntity):GetFntByData(interPoint.fntData)
    local offsetWorld = (fntEntity.transform):TransformPoint(interPoint:GetInterOffsetCoord())
    local startPos = (fntEntity.transform):TransformPoint(interPoint:GetInterStartCoord())
    local pointEntity = (self.characterCtrl):GenInterPointEntity(interPoint, offsetWorld)
    pointEntity:InitInterPointEntity(interPoint, startPos, offsetWorld, fntEntity)
    ;
    (table.insert)(self.pointEntityList, pointEntity)
  end
end

DormRoomCharacterCtrl.GetInterPointEntityList = function(self)
  -- function num : 0_23
  return self.pointEntityList
end

DormRoomCharacterCtrl.GetRoomCharacterDic = function(self)
  -- function num : 0_24
  return self.characterDic
end

DormRoomCharacterCtrl.RefreshInterPointDistanceState = function(self, touchScreenPos)
  -- function num : 0_25 , upvalues : DormUtil, _ENV
  if self.pointEntityList == nil then
    return 
  end
  local selectPoint = nil
  local minDistance = DormUtil.NearInterPointDistance
  for _,pointEntity in pairs(self.pointEntityList) do
    local dis = pointEntity:GetSqrDistanceToScreenTouch(touchScreenPos)
    if dis <= minDistance then
      selectPoint = pointEntity
      minDistance = dis
    end
  end
  if selectPoint == self.selectPoint then
    return 
  end
  if selectPoint ~= nil and self.selectPoint ~= nil and (self.selectPoint):GetPointFromFntEntity() == selectPoint:GetPointFromFntEntity() then
    self.selectPoint = selectPoint
    return 
  end
  if self.selectPoint ~= nil then
    (self.selectPoint):RemovePointFntHighlight()
  end
  self.selectPoint = selectPoint
  if self.selectPoint ~= nil then
    (self.selectPoint):AddPointFntHighlight()
  end
end

DormRoomCharacterCtrl.ClearSelectInterPoint = function(self)
  -- function num : 0_26
  if self.selectPoint == nil then
    return 
  end
  ;
  (self.selectPoint):RemovePointFntHighlight()
  self.selectPoint = nil
end

DormRoomCharacterCtrl.RecoveryInterPointEntity = function(self)
  -- function num : 0_27 , upvalues : _ENV
  if self.pointEntityList == nil then
    return 
  end
  for _,pointEntity in pairs(self.pointEntityList) do
    (self.characterCtrl):RecoveryInterPoint(pointEntity)
  end
  self.pointEntityList = nil
end

DormRoomCharacterCtrl.FinishCharacterOperate = function(self, charEntity)
  -- function num : 0_28
  do
    if self.selectPoint ~= nil then
      local charEntity = ((self.selectPoint):GetInterPointData()):GetBindCharacter()
      if charEntity ~= nil then
        charEntity:QuickExitAIState()
      end
    end
    charEntity:SetCharacterOperateEnd(self.selectPoint)
    self:ClearSelectInterPoint()
  end
end

DormRoomCharacterCtrl.ChangeCharacterToOtherRoom = function(self, charEntity)
  -- function num : 0_29
  local roomCtrl = (self.characterCtrl):RangeOtherNoFullRoomCtrl(self)
  if roomCtrl == nil then
    return false
  end
  self:RemoveCharacterEntity(charEntity)
  roomCtrl:AddCharacterEntity(charEntity)
  return true
end

DormRoomCharacterCtrl.IsHaveOtherUnBindCharacter = function(self)
  -- function num : 0_30
  do return #(self.characterCtrl).unbindCharList > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DormRoomCharacterCtrl.ExchangeUnBindCharacter = function(self, oldEntity)
  -- function num : 0_31 , upvalues : DormUtil
  if oldEntity ~= nil then
    self:DeleteCharacterById((oldEntity.heroData).dataId)
  end
  local wallId, worldPos, startPos = (self.roomEntity):GetRoomDoorPos()
  ;
  (self.characterCtrl):RandChangeUnBindCharacter(self, oldEntity, function(charEntity)
    -- function num : 0_31_0 , upvalues : DormUtil, wallId, worldPos, startPos
    if charEntity == nil then
      return 
    end
    charEntity:SetStarAIPathActive(false)
    charEntity:SetMoveAniSpeed(1)
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (charEntity.transform).rotation = (DormUtil.GetDormWallRot)(wallId)
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (charEntity.transform).position = worldPos
    charEntity:DoMoveUnityPos(startPos, function()
      -- function num : 0_31_0_0 , upvalues : charEntity
      charEntity:SetMoveAniSpeed(0)
      if charEntity ~= nil then
        charEntity:StartAIBehavior(true)
      end
    end
)
  end
)
end

DormRoomCharacterCtrl.HaveOtherNoFullRoom = function(self)
  -- function num : 0_32 , upvalues : _ENV
  local count = 0
  for _,v in pairs((self.characterCtrl).roomCharacter) do
    if v ~= self and not v:IsRoomCharacterFull() then
      count = count + 1
    end
  end
  do return count > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DormRoomCharacterCtrl.RandRemoveUnBindCharacter = function(self)
  -- function num : 0_33 , upvalues : _ENV
  local unbindList = {}
  for heroId,charEntity in pairs(self.characterDic) do
    if not charEntity.isBind then
      (table.insert)(unbindList, heroId)
    end
  end
  if #unbindList == 0 then
    return 
  end
  local index = (math.random)(#unbindList)
  local heroId = unbindList[index]
  self:DeleteCharacterById(heroId)
end

DormRoomCharacterCtrl.OnDelete = function(self)
  -- function num : 0_34 , upvalues : _ENV
  self:ClearSelectInterPoint()
  self:UnSetAsEnterActiveRoom()
  if self.characterDic ~= nil then
    for k,v in pairs(self.characterDic) do
      v:OnDelete()
    end
  end
end

return DormRoomCharacterCtrl

