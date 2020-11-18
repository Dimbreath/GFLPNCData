-- params : ...
-- function num : 0 , upvalues : _ENV
local DormCtrlBase = require("Game.Dorm.Ctrl.DormCtrlBase")
local DormCharacterCtrl = class("DormCharacterCtrl", DormCtrlBase)
local DormUtil = require("Game.Dorm.DormUtil")
local eDormFntType = require("Game.Dorm.Enum.eDormFntType")
local eDormState = require("Game.Dorm.Enum.eDormState")
local DormRoomCharacterCtrl = require("Game.Dorm.Character.DormRoomCharacterCtrl")
local DormInterPointEntity = require("Game.Dorm.Entity.DormInterPointEntity")
local CS_Physics = CS.PhysicsUtility
local CS_LeanTouch = ((CS.Lean).Touch).LeanTouch
DormCharacterCtrl.ctor = function(self, dormCtrl)
  -- function num : 0_0 , upvalues : _ENV
  self.dormCtrl = dormCtrl
  self.houseCtrl = dormCtrl.houseCtrl
  self.__onUpdate = BindCallback(self, self.OnUpdate)
  UpdateManager:AddUpdate(self.__onUpdate)
  self.__timeActive = false
  self.__onFingerDown = BindCallback(self, self.OnFingerDown)
  self.__onFingerSet = BindCallback(self, self.OnFingerSet)
  self.__onFingerUp = BindCallback(self, self.OnFingerUp)
end

DormCharacterCtrl.OnEnterDormScene = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.interPointHolder = (((CS.UnityEngine).GameObject)("InterPointHolder")).transform
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.interPointHolder).position = Vector3.zero
  self.__interPointPool = {}
  self.__dragIndicatorGo = (((self.dormCtrl).comRes).fntBottomPrefab):Instantiate()
  ;
  (self.__dragIndicatorGo):SetActive(false)
end

DormCharacterCtrl.OnEnterDormHouse = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self.charResloader ~= nil then
    (self.charResloader):Put2Pool()
  end
  self.charResloader = ((CS.ResLoader).Create)()
  self:__InitCharacterCtrl()
  self.__timeActive = true
end

DormCharacterCtrl.GetActiveRoomCount = function(self)
  -- function num : 0_3
  return self.__activeRoomCount
end

DormCharacterCtrl.__InitCharacterCtrl = function(self)
  -- function num : 0_4 , upvalues : _ENV, DormRoomCharacterCtrl
  self.__activeRoomCount = 0
  self.roomCharacter = {}
  for pos,v in pairs((self.houseCtrl).roomEnityDic) do
    if not v:IsEmptyRoom() then
      local roomCharacterCtrl = (DormRoomCharacterCtrl.New)(self, v, self.charResloader)
      -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self.roomCharacter)[pos] = roomCharacterCtrl
      self.__activeRoomCount = self.__activeRoomCount + 1
    end
  end
  if self.__activeRoomCount > 0 then
    self:AddUnBindCharacterEvenly()
  end
  for _,v in pairs(self.roomCharacter) do
    v:StartCharacterLogic()
  end
end

DormCharacterCtrl.AddUnBindCharacterEvenly = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local allBindFntData = (self.dormCtrl):GetAllBindFntData()
  self.unbindCharList = {}
  for heroId,heroData in pairs(PlayerDataCenter.heroDic) do
    if (allBindFntData.boundDic)[heroId] == nil then
      (table.insert)(self.unbindCharList, heroId)
    end
  end
  local nowRoleCount = 0
  for _,v in pairs(self.roomCharacter) do
    nowRoleCount = nowRoleCount + v:GetRoomCharacterCount()
  end
  do
    while nowRoleCount < (ConfigData.game_config).DormRoleMaxCount and #self.unbindCharList > 0 do
      local isAllRoomFull = true
      for _,roomCtrl in pairs(self.roomCharacter) do
        if not roomCtrl:IsRoomCharacterFull() then
          isAllRoomFull = false
          local index = (math.random)(#self.unbindCharList)
          local heroId = (self.unbindCharList)[index]
          local heroData = (PlayerDataCenter.heroDic)[heroId]
          local charEntity = roomCtrl:AddUnBindCharacter(heroData)
          if charEntity ~= nil then
            (table.remove)(self.unbindCharList, index)
          end
          nowRoleCount = nowRoleCount + 1
        end
      end
    end
    do
      if (ConfigData.game_config).DormRoleMaxCount <= nowRoleCount or #self.unbindCharList <= 0 or not isAllRoomFull then
      end
    end
  end
end

DormCharacterCtrl.RandChangeUnBindCharacter = function(self, roomCtrl, oldEntity)
  -- function num : 0_6 , upvalues : _ENV
  local index = (math.random)(#self.unbindCharList)
  local heroId = (self.unbindCharList)[index]
  local heroData = (PlayerDataCenter.heroDic)[heroId]
  local charEntity = roomCtrl:AddUnBindCharacter(heroData, (roomCtrl.roomData):GetDoorCoord())
  if charEntity ~= nil then
    (table.remove)(self.unbindCharList, index)
  end
  ;
  (table.insert)(self.unbindCharList, (oldEntity.heroData).dataId)
  return charEntity
end

DormCharacterCtrl.RangeOtherNoFullRoomCtrl = function(self, roomCtrl)
  -- function num : 0_7 , upvalues : _ENV
  local activeRoomList = {}
  for pos,v in pairs(self.roomCharacter) do
    if v ~= roomCtrl and not v:IsRoomCharacterFull() then
      (table.insert)(activeRoomList, v)
    end
  end
  if #activeRoomList == 0 then
    return nil
  end
  local index = (math.random)(#activeRoomList)
  return activeRoomList[index]
end

DormCharacterCtrl.ResetDormCharacter = function(self)
  -- function num : 0_8 , upvalues : _ENV
  for k,v in pairs(self.roomCharacter) do
    v:OnDelete()
  end
  self:OnEnterDormHouse()
end

DormCharacterCtrl.ResetRoomCharacter = function(self, pos)
  -- function num : 0_9 , upvalues : _ENV, DormRoomCharacterCtrl
  local oldCharCtrl = (self.roomCharacter)[pos]
  if oldCharCtrl ~= nil then
    for k,charEntity in pairs(oldCharCtrl.characterDic) do
      if charEntity ~= nil and not charEntity.isBind then
        (table.insert)(self.unbindCharList, (charEntity.heroData).dataId)
      end
    end
    oldCharCtrl:OnDelete()
  end
  local roomEntity = ((self.houseCtrl).roomEnityDic)[pos]
  if roomEntity == nil or roomEntity:IsEmptyRoom() then
    return 
  end
  local roomCharacterCtrl = (DormRoomCharacterCtrl.New)(self, roomEntity, self.charResloader)
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.roomCharacter)[pos] = roomCharacterCtrl
  local nowRoleCount = 0
  for _,v in pairs(self.roomCharacter) do
    nowRoleCount = nowRoleCount + v:GetRoomCharacterCount()
  end
  do
    while nowRoleCount < (ConfigData.game_config).DormRoleMaxCount and #self.unbindCharList > 0 and roomCharacterCtrl:IsRoomCharacterFull() == false do
      local index = (math.random)(#self.unbindCharList)
      local heroId = (self.unbindCharList)[index]
      local heroData = (PlayerDataCenter.heroDic)[heroId]
      local charEntity = roomCharacterCtrl:AddUnBindCharacter(heroData)
      if charEntity ~= nil then
        (table.remove)(self.unbindCharList, index)
      end
      nowRoleCount = nowRoleCount + 1
    end
    do
      roomCharacterCtrl:StartCharacterLogic()
    end
  end
end

DormCharacterCtrl.SetBindCharacterChange = function(self, fntData, oldHeroId, newHeroId)
  -- function num : 0_10 , upvalues : _ENV
  local successOld = false
  local findNewHero = false
  local newCharacterEntity = nil
  if oldHeroId ~= nil then
    for _,roomCtrl in pairs(self.roomCharacter) do
      if not successOld then
        successOld = roomCtrl:DeleteCharacterById(oldHeroId)
        if successOld then
          (table.insert)(self.unbindCharList, oldHeroId)
        end
      end
      if not findNewHero then
        newCharacterEntity = roomCtrl:GetCharacterEntityById(newHeroId)
        if newCharacterEntity ~= nil then
          findNewHero = true
          roomCtrl:RemoveCharacterEntity(newCharacterEntity)
        end
      end
    end
  end
  do
    local roomData = fntData:GetFntRoom()
    local roomCtrl = (self.roomCharacter)[roomData.spos]
    local heroData = (PlayerDataCenter.heroDic)[newHeroId]
    if roomCtrl == nil or heroData == nil then
      return 
    end
    if newCharacterEntity ~= nil then
      roomCtrl:AddCharacterEntity(newCharacterEntity)
      newCharacterEntity:ResetToDoorCoord()
      newCharacterEntity:StartAIBehavior()
    else
      if roomCtrl:IsRoomCharacterFull() then
        roomCtrl:RandRemoveUnBindCharacter()
      end
      roomCtrl:AddBindCharacter(heroData, fntData)
    end
  end
end

DormCharacterCtrl.OnEnterDormEditMode = function(self)
  -- function num : 0_11 , upvalues : _ENV
  self.__timeActive = false
  for k,v in pairs(self.roomCharacter) do
    v:HidePauseRoomCharacter()
  end
end

DormCharacterCtrl.OnEnterRoomEditMode = function(self, pos)
  -- function num : 0_12 , upvalues : _ENV
  self.__timeActive = false
  for k,v in pairs(self.roomCharacter) do
    v:HidePauseRoomCharacter()
  end
end

DormCharacterCtrl.OnEixtDormEditMode = function(self, success)
  -- function num : 0_13 , upvalues : _ENV
  self.__timeActive = true
  if not success then
    for k,v in pairs(self.roomCharacter) do
      v:ShowResumeRoomCharacter()
    end
    return 
  end
  self:ResetDormCharacter()
end

DormCharacterCtrl.OnExitRoomEditMode = function(self, success, pos)
  -- function num : 0_14 , upvalues : _ENV
  self.__timeActive = true
  if not success then
    for k,v in pairs(self.roomCharacter) do
      v:ShowResumeRoomCharacter()
    end
    return 
  end
  for k,v in pairs(self.roomCharacter) do
    if k ~= pos then
      v:ShowResumeRoomCharacter()
    end
  end
  self:ResetRoomCharacter(pos)
  self:SetCurRoomCharacterCtrl()
end

DormCharacterCtrl.OnEnterRoomMode = function(self)
  -- function num : 0_15 , upvalues : CS_LeanTouch
  (CS_LeanTouch.OnFingerDown)("+", self.__onFingerDown)
  ;
  (CS_LeanTouch.OnFingerSet)("+", self.__onFingerSet)
  ;
  (CS_LeanTouch.OnFingerUp)("+", self.__onFingerUp)
  self.roomEntity = ((self.dormCtrl).roomCtrl).roomEntity
  self:SetCurRoomCharacterCtrl()
end

DormCharacterCtrl.SetCurRoomCharacterCtrl = function(self)
  -- function num : 0_16
  self.curRoomCharCtrl = (self.roomCharacter)[(self.roomEntity).spos]
  ;
  (self.curRoomCharCtrl):SetCurEnterRoom()
end

DormCharacterCtrl.GenInterPointEntity = function(self, interPoint, unityPos)
  -- function num : 0_17 , upvalues : _ENV, DormInterPointEntity
  local gameObject = nil
  if #self.__interPointPool > 0 then
    gameObject = (table.remove)(self.__interPointPool)
    gameObject:SetActive(true)
  else
    gameObject = (((self.dormCtrl).comRes).interPointPrefab):Instantiate(self.interPointHolder)
  end
  local interPointEntity = (DormInterPointEntity.New)()
  interPointEntity:InitInterPointEntity(interPoint, gameObject, unityPos)
  return interPointEntity
end

DormCharacterCtrl.RecoveryInterPoint = function(self, pointEntity)
  -- function num : 0_18 , upvalues : _ENV
  if IsNull(pointEntity.gameObject) then
    return 
  end
  local go = pointEntity.gameObject
  go:SetActive(false)
  ;
  (table.insert)(self.__interPointPool, go)
end

DormCharacterCtrl.OnExitRoomMode = function(self)
  -- function num : 0_19 , upvalues : CS_LeanTouch
  if self.curRoomCharCtrl ~= nil then
    (self.curRoomCharCtrl):UnSetCurEnterRoom()
  end
  self.roomEntity = nil
  self.curRoomCharCtrl = nil
  ;
  (CS_LeanTouch.OnFingerDown)("-", self.__onFingerDown)
  ;
  (CS_LeanTouch.OnFingerSet)("-", self.__onFingerSet)
  ;
  (CS_LeanTouch.OnFingerUp)("-", self.__onFingerUp)
end

DormCharacterCtrl.OnUpdate = function(self)
  -- function num : 0_20 , upvalues : _ENV
  if not self.__timeActive or self.roomCharacter == nil then
    return 
  end
  for spos,roomCharacterCtrl in pairs(self.roomCharacter) do
    roomCharacterCtrl:OnUpdate()
  end
end

DormCharacterCtrl.SetSelectCharacter = function(self, charEntity)
  -- function num : 0_21
  self.__selectCharEntity = charEntity
  ;
  (self.__selectCharEntity):SetCharacterOperateStart()
  ;
  (self.curRoomCharCtrl):SetAllPointNormalActive(true)
  ;
  (self.__dragIndicatorGo):SetActive(true)
  self:SetDragIndicatorPosition((self.__selectCharEntity).x, (self.__selectCharEntity).y)
end

DormCharacterCtrl.SetDragIndicatorPosition = function(self, x, y)
  -- function num : 0_22 , upvalues : DormUtil
  local pos = (DormUtil.GetFntUnityCoord)((self.__selectCharEntity).x, (self.__selectCharEntity).y)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.__dragIndicatorGo).transform).position = (((self.curRoomCharCtrl).roomEntity).fntHolder):TransformPoint(pos)
end

DormCharacterCtrl.OnFingerDown = function(self, finger)
  -- function num : 0_23 , upvalues : eDormState, CS_Physics, _ENV
  if (self.dormCtrl).state ~= eDormState.Room or finger.IsOverGui then
    return 
  end
  if self.curRoomCharCtrl == nil then
    return 
  end
  if self.__selectCharEntity ~= nil then
    return 
  end
  local hits = (CS_Physics.Raycast)(((self.dormCtrl).bind).camera, 1 << LayerMask.Raycast, true)
  for i = 0, hits.Length - 1 do
    local hitCollider = (hits[i]).collider
    if not IsNull(hitCollider) and hitCollider.tag == TagConsts.Character then
      local gameObject = hitCollider.gameObject
      for k,charEntity in pairs((self.curRoomCharCtrl).characterDic) do
        if charEntity.gameObject == gameObject then
          self:SetSelectCharacter(charEntity)
          self.__fingerId = finger.Index
          break
        end
      end
    end
  end
  do
    if self.__fingerId == nil then
    end
  end
end

DormCharacterCtrl.OnFingerSet = function(self, finger)
  -- function num : 0_24 , upvalues : CS_Physics, _ENV
  if self.__selectCharEntity == nil or finger.Index ~= self.__fingerId then
    return 
  end
  local hits = (CS_Physics.Raycast)(((self.dormCtrl).bind).camera, 1 << LayerMask.Raycast)
  for i = 0, hits.Length - 1 do
    local hitCollider = (hits[i]).collider
    if not IsNull(hitCollider) and hitCollider.tag == TagConsts.DormFloor then
      (self.curRoomCharCtrl):RefreshInterPointDistanceState(finger.ScreenPosition)
      local hitPos = (((self.curRoomCharCtrl).roomEntity).fntHolder):InverseTransformPoint((hits[i]).point)
      hitPos.y = 0
      local move, newX, newY = (self.__selectCharEntity):SetCharacterPosFromUnity(hitPos)
      if move then
        self:SetDragIndicatorPosition(newX, newY)
      end
    end
  end
end

DormCharacterCtrl.OnFingerUp = function(self, finger)
  -- function num : 0_25
  if self.__selectCharEntity == nil or finger.Index ~= self.__fingerId then
    return 
  end
  self:EndOperateCharacter()
end

DormCharacterCtrl.EndOperateCharacter = function(self)
  -- function num : 0_26
  (self.curRoomCharCtrl):FinishCharacterOperate(self.__selectCharEntity)
  ;
  (self.curRoomCharCtrl):SetAllPointNormalActive(false)
  ;
  (self.__dragIndicatorGo):SetActive(false)
  self.__fingerId = nil
  self.__selectCharEntity = nil
end

DormCharacterCtrl.IsDragCharacter = function(self)
  -- function num : 0_27
  if self.__fingerId ~= nil or self.__selectCharEntity ~= nil then
    return true
  end
  return false
end

DormCharacterCtrl.OnDelete = function(self)
  -- function num : 0_28 , upvalues : CS_LeanTouch, _ENV
  (CS_LeanTouch.OnFingerDown)("-", self.__onFingerDown)
  ;
  (CS_LeanTouch.OnFingerSet)("-", self.__onFingerSet)
  ;
  (CS_LeanTouch.OnFingerUp)("-", self.__onFingerUp)
  if self.charResloader ~= nil then
    (self.charResloader):Put2Pool()
    self.charResloader = nil
  end
  if self.roomCharacter ~= nil then
    for spos,roomCharacterCtrl in pairs(self.roomCharacter) do
      roomCharacterCtrl:OnDelete()
    end
    self.roomCharacter = nil
  end
  UpdateManager:RemoveUpdate(self.__onUpdate)
end

return DormCharacterCtrl

