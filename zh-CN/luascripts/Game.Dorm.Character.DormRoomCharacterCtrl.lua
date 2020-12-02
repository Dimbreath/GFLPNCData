-- params : ...
-- function num : 0 , upvalues : _ENV
local DormRoomCharacterCtrl = class("DormRoomCharacterCtrl")
local DormCharacterEntity = require("Game.Dorm.Character.Entity.DormCharacterEntity")
local DormUtil = require("Game.Dorm.DormUtil")
DormRoomCharacterCtrl.ctor = function(self, characterCtrl, roomEntity, resloader)
  -- function num : 0_0 , upvalues : _ENV
  self.characterCtrl = characterCtrl
  self.roomEntity = roomEntity
  self.roomData = roomEntity.roomData
  self.resloader = resloader
  self.__isCurEnterRoom = false
  self.__isDelete = false
  self.__onUpdate = BindCallback(self, self.OnUpdate)
  self.characterDic = {}
  self.__charCount = 0
  self:InitDormRoomCharacterCtrl()
end

DormRoomCharacterCtrl.GetRoomCharacterCount = function(self)
  -- function num : 0_1
  return self.__charCount
end

DormRoomCharacterCtrl.IsRoomCharacterFull = function(self)
  -- function num : 0_2 , upvalues : _ENV
  do return (ConfigData.game_config).DormRoomRoleMaxCount <= self.__charCount end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DormRoomCharacterCtrl.InitDormRoomCharacterCtrl = function(self)
  -- function num : 0_3 , upvalues : _ENV, DormUtil
  self.mapDic = setmetatable({}, {__index = function(tab, key)
    -- function num : 0_3_0
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
  -- function num : 0_4 , upvalues : _ENV
  for heroId,charEntity in pairs(self.characterDic) do
    charEntity:StartAIBehavior()
  end
end

DormRoomCharacterCtrl.AddUnBindCharacter = function(self, heroData, posX, posY)
  -- function num : 0_5 , upvalues : _ENV, DormCharacterEntity
  if posX == nil or posY == nil then
    local randX = (math.random)((ConfigData.game_config).HouseGridCount) - 1
    do
      local randY = (math.random)((ConfigData.game_config).HouseGridCount) - 1
      posX = self:FindActivePosNearby(randX, randY)
    end
  end
  do
    if posX ~= nil and posY ~= nil then
      self.__charCount = self.__charCount + 1
      local charEntity = (DormCharacterEntity.New)(heroData, posX, posY, self, false)
      -- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self.characterDic)[heroData.dataId] = charEntity
      ;
      (self.resloader):LoadABAssetAsync(PathConsts:GetCharacterDormModelPath(heroData:GetResName()), function(prefab)
    -- function num : 0_5_0 , upvalues : _ENV, self, charEntity
    if IsNull(prefab) or self.__isDelete then
      return 
    end
    local go = prefab:Instantiate((self.roomEntity).characterHolder)
    charEntity:InitCharacterGo(go)
  end
)
      return charEntity
    end
    do
      return nil
    end
  end
end

DormRoomCharacterCtrl.FindActivePosNearby = function(self, x, y)
  -- function num : 0_6 , upvalues : DormUtil, _ENV
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

DormRoomCharacterCtrl.AddBindCharacter = function(self, heroData, fntData)
  -- function num : 0_7 , upvalues : DormCharacterEntity, _ENV
  local posX, posY = self:FindActivePosNearby(fntData.x, fntData.y)
  if posX == nil or posY == nil then
    return 
  end
  self.__charCount = self.__charCount + 1
  local charEntity = (DormCharacterEntity.New)(heroData, posX, posY, self, true)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.characterDic)[heroData.dataId] = charEntity
  ;
  (self.resloader):LoadABAssetAsync(PathConsts:GetCharacterDormModelPath(heroData:GetResName()), function(prefab)
    -- function num : 0_7_0 , upvalues : _ENV, self, charEntity
    if IsNull(prefab) or self.__isDelete then
      return 
    end
    local go = prefab:Instantiate((self.roomEntity).characterHolder)
    charEntity:InitCharacterGo(go)
  end
)
end

DormRoomCharacterCtrl.GetCharacterEntityById = function(self, heroId)
  -- function num : 0_8
  local findEntity = (self.characterDic)[heroId]
  return findEntity
end

DormRoomCharacterCtrl.RemoveCharacterEntity = function(self, charEntity)
  -- function num : 0_9
  local heroId = (charEntity.heroData).dataId
  local findEntity = (self.characterDic)[heroId]
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R4 in 'UnsetPending'

  if findEntity == charEntity then
    (self.characterDic)[heroId] = nil
    self.__charCount = self.__charCount - 1
  end
end

DormRoomCharacterCtrl.DeleteCharacterById = function(self, heroId)
  -- function num : 0_10
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
  -- function num : 0_11
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
  -- function num : 0_12 , upvalues : DormUtil, _ENV
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

DormRoomCharacterCtrl.GetPointPath = function(self, pos1, pos2)
  -- function num : 0_13 , upvalues : DormUtil, _ENV
  local path = {}
  if pos1 == pos2 then
    return path
  end
  local startX, startY = (DormUtil.FntCoord2XY)(pos1)
  local destX, destY = (DormUtil.FntCoord2XY)(pos2)
  if not (DormUtil.IsFntCoordLegal)(startX, startY) or not (DormUtil.IsFntCoordLegal)(destX, destY) then
    return 
  end
  local pointQue = {}
  local closeQue = {}
  local parentDic = {}
  closeQue[pos1] = true
  ;
  (table.insert)(pointQue, pos1)
  while #pointQue > 0 do
    local pos = (table.remove)(pointQue, 1)
    local dx, dy = (DormUtil.FntCoord2XY)(pos)
    for k,v in ipairs(DormUtil.FntForOffset) do
      local idx = dx + v.x
      local idy = dy + v.y
      local ipos = (DormUtil.XYCoord2Fnt)(idx, idy)
      if not closeQue[ipos] and (DormUtil.IsFntCoordLegal)(idx, idy) then
        parentDic[ipos] = pos
        do
          do
            if ipos == pos2 then
              local dd = ipos
              while parentDic[dd] ~= nil do
                (table.insert)(path, 1, dd)
                dd = parentDic[dd]
              end
              return path
            end
            if (self.mapDic)[ipos] == 0 then
              (table.insert)(pointQue, ipos)
              closeQue[ipos] = true
            end
            -- DECOMPILER ERROR at PC90: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC90: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC90: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  do
    return false
  end
end

DormRoomCharacterCtrl.IsPointDirectMove = function(self, pos1, pos2)
  -- function num : 0_14 , upvalues : DormUtil, _ENV
  local x1, y1 = (DormUtil.FntCoord2XY)(pos1)
  local x2, y2 = (DormUtil.FntCoord2XY)(pos2)
  local minX = (math.min)(x1, x2)
  local maxX = (math.max)(x1, x2)
  local minY = (math.max)(y1, y2)
  local maxY = (math.max)(y1, y2)
  for dx = minX, maxX do
    for dy = minY, maxY do
      local ipos = (DormUtil.XYCoord2Fnt)(dx, dy)
      if ipos ~= pos1 and ipos ~= pos2 and (self.mapDic)[ipos] ~= 0 then
        return false
      end
    end
  end
  return true
end

DormRoomCharacterCtrl.OnUpdate = function(self)
  -- function num : 0_15 , upvalues : _ENV
  if self.characterDic == nil then
    return 
  end
  for heroId,charEntity in pairs(self.characterDic) do
    charEntity:OnUpdate()
  end
end

DormRoomCharacterCtrl.HidePauseRoomCharacter = function(self)
  -- function num : 0_16 , upvalues : _ENV
  for k,v in pairs(self.characterDic) do
    v:HidePauseCharacter()
  end
end

DormRoomCharacterCtrl.ShowResumeRoomCharacter = function(self)
  -- function num : 0_17 , upvalues : _ENV
  for k,v in pairs(self.characterDic) do
    v:ShowResumeCharacter()
  end
end

DormRoomCharacterCtrl.SetCurEnterRoom = function(self)
  -- function num : 0_18
  if self.__isCurEnterRoom then
    self:RefreshPointEntityPos()
  else
    self.__isCurEnterRoom = true
    self:GenRoomInterPointEntity()
  end
end

DormRoomCharacterCtrl.UnSetCurEnterRoom = function(self)
  -- function num : 0_19
  if not self.__isCurEnterRoom then
    return 
  end
  self.__isCurEnterRoom = false
  self:ClearSelectInterPoint()
  self:RecoveryInterPointEntity()
end

DormRoomCharacterCtrl.GenRoomInterPointEntity = function(self)
  -- function num : 0_20 , upvalues : _ENV
  self.pointEntityList = {}
  for _,interPoint in pairs((self.roomData).interpoint) do
    local fntEntity = (self.roomEntity):GetFntByData(interPoint.fntData)
    local offsetWorld = (fntEntity.transform):TransformPoint(interPoint:GetInterOffsetCoord())
    offsetWorld.y = offsetWorld.y + interPoint:GetInterHeight()
    local pointEntity = (self.characterCtrl):GenInterPointEntity(interPoint, offsetWorld)
    ;
    (table.insert)(self.pointEntityList, pointEntity)
  end
end

DormRoomCharacterCtrl.GetInterPointEntityList = function(self)
  -- function num : 0_21
  return self.pointEntityList
end

DormRoomCharacterCtrl.RefreshPointEntityPos = function(self)
  -- function num : 0_22 , upvalues : _ENV
  if self.pointEntityList == nil then
    return 
  end
  for _,pointEntity in pairs(self.pointEntityList) do
    local fntEntity = (self.roomEntity):GetFntByData((pointEntity.interPoint).fntData)
    local offsetWorld = (fntEntity.transform):TransformPoint((pointEntity.interPoint):GetInterOffsetCoord())
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (pointEntity.transform).position = offsetWorld
  end
end

DormRoomCharacterCtrl.RefreshInterPointDistanceState = function(self, touchScreenPos)
  -- function num : 0_23 , upvalues : DormUtil, _ENV
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
  if self.selectPoint ~= nil then
    (self.selectPoint):SetPointSelectActive(false)
  end
  self.selectPoint = selectPoint
  if self.selectPoint ~= nil then
    (self.selectPoint):SetPointSelectActive(true)
  end
end

DormRoomCharacterCtrl.SetAllPointNormalActive = function(self, active)
  -- function num : 0_24 , upvalues : _ENV
  if self.pointEntityList == nil then
    return 
  end
  for _,pointEntity in pairs(self.pointEntityList) do
    pointEntity:SetPointNormalActive(active)
  end
end

DormRoomCharacterCtrl.ClearSelectInterPoint = function(self)
  -- function num : 0_25
  if self.selectPoint == nil then
    return 
  end
  ;
  (self.selectPoint):SetPointSelectActive(false)
end

DormRoomCharacterCtrl.RecoveryInterPointEntity = function(self)
  -- function num : 0_26 , upvalues : _ENV
  if self.pointEntityList == nil then
    return 
  end
  for _,pointEntity in pairs(self.pointEntityList) do
    (self.characterCtrl):RecoveryInterPoint(pointEntity)
  end
  self.pointEntityList = nil
end

DormRoomCharacterCtrl.FinishCharacterOperate = function(self, charEntity)
  -- function num : 0_27
  do
    if self.selectPoint ~= nil then
      local charEntity = ((self.selectPoint).interPoint):GetBindCharacter()
      if charEntity ~= nil then
        charEntity:QuickExitAIState()
      end
    end
    charEntity:SetCharacterOperateEnd(self.selectPoint)
    self:ClearSelectInterPoint()
  end
end

DormRoomCharacterCtrl.ChangeCharacterToOtherRoom = function(self, charEntity)
  -- function num : 0_28
  local roomCtrl = (self.characterCtrl):RangeOtherNoFullRoomCtrl(self)
  if roomCtrl == nil then
    return false
  end
  self:RemoveCharacterEntity(charEntity)
  roomCtrl:AddCharacterEntity(charEntity)
  return true
end

DormRoomCharacterCtrl.IsHaveOtherUnBindCharacter = function(self)
  -- function num : 0_29
  do return #(self.characterCtrl).unbindCharList > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DormRoomCharacterCtrl.ExchangeUnBindCharacter = function(self, oldEntity)
  -- function num : 0_30
  if oldEntity ~= nil then
    self:DeleteCharacterById((oldEntity.heroData).dataId)
  end
  local charEntity = (self.characterCtrl):RandChangeUnBindCharacter(self, oldEntity)
  if charEntity ~= nil then
    charEntity:StartAIBehavior()
  end
end

DormRoomCharacterCtrl.HaveOtherNoFullRoom = function(self)
  -- function num : 0_31 , upvalues : _ENV
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
  -- function num : 0_32 , upvalues : _ENV
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
  -- function num : 0_33 , upvalues : _ENV
  self:UnSetCurEnterRoom()
  if self.characterDic ~= nil then
    for k,v in pairs(self.characterDic) do
      v:OnDelete()
    end
  end
  do
    self.__isDelete = true
  end
end

return DormRoomCharacterCtrl

