local DormCtrlBase = require("Game.Dorm.Ctrl.DormCtrlBase")
local DormCharacterCtrl = class("DormCharacterCtrl", DormCtrlBase)
local DormUtil = require("Game.Dorm.DormUtil")
local DormEnum = require("Game.Dorm.DormEnum")
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
  self.__charcterActive = false
  self.__onFingerDown = BindCallback(self, self.OnFingerDown)
  self.__onFingerSet = BindCallback(self, self.OnFingerSet)
  self.__onFingerUp = BindCallback(self, self.OnFingerUp)
  self.__OnDormBindRoleChanged = BindCallback(self, self.OnDormBindRoleChanged)
  MsgCenter:AddListener(eMsgEventId.DormBindRoleChanged, self.__OnDormBindRoleChanged)
  self.__OnDormUnbindSwitchChanged = BindCallback(self, self.OnDormUnbindSwitchChanged)
  MsgCenter:AddListener(eMsgEventId.DormUnbindSwitchChanged, self.__OnDormUnbindSwitchChanged)
  self.__OnChangeHeroSkin = BindCallback(self, self.OnChangeHeroSkin)
  MsgCenter:AddListener(eMsgEventId.OnHeroSkinChange, self.__OnChangeHeroSkin)
end

DormCharacterCtrl.OnEnterDormScene = function(self)
  -- function num : 0_1
  self.__interPointPool = {}
  self.__dragIndicatorGo = (((self.dormCtrl).comRes).selectRolePrefab):Instantiate()
  ;
  (self.__dragIndicatorGo):SetActive(false)
end

DormCharacterCtrl.OnEnterDormHouse = function(self)
  -- function num : 0_2
  self:__InitCharacterCtrl()
  self.__charcterActive = true
end

DormCharacterCtrl.GetActiveRoomCount = function(self)
  -- function num : 0_3
  return self.__activeRoomCount
end

DormCharacterCtrl.IsDormCharacterActive = function(self)
  -- function num : 0_4
  return self.__charcterActive
end

DormCharacterCtrl.OnEnterDormHouseEditMode = function(self)
  -- function num : 0_5
  self.__charcterActive = false
end

DormCharacterCtrl.OnExitDormHouseEditMode = function(self, success)
  -- function num : 0_6
  self.__charcterActive = true
end

DormCharacterCtrl.OnEnterDormRoomEditMode = function(self, roomEntity)
  -- function num : 0_7 , upvalues : _ENV
  self.__charcterActive = false
  for k,v in pairs(self.roomCharacter) do
    v:HidePauseRoomCharacter()
  end
end

DormCharacterCtrl.OnExitDormRoomEditMode = function(self, roomEntity, success)
  -- function num : 0_8 , upvalues : _ENV
  local pos = roomEntity.spos
  self.__charcterActive = true
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
end

DormCharacterCtrl.OnEnterDormRoomEnd = function(self, roomEntity)
  -- function num : 0_9 , upvalues : CS_LeanTouch, DormRoomCharacterCtrl
  (CS_LeanTouch.OnFingerDown)("+", self.__onFingerDown)
  ;
  (CS_LeanTouch.OnFingerSet)("+", self.__onFingerSet)
  ;
  (CS_LeanTouch.OnFingerUp)("+", self.__onFingerUp)
  self.roomEntity = roomEntity
  local roomCharacterCtrl = (DormRoomCharacterCtrl.New)(self, roomEntity)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.roomCharacter)[roomEntity.spos] = roomCharacterCtrl
  self:SetCurRoomCharacterCtrl()
  self:FirstAddUnBindCharacter()
  roomCharacterCtrl:StartCharacterLogic()
end

DormCharacterCtrl.OnExitDormRoomStart = function(self, roomEntity, toOtherRoom)
  -- function num : 0_10 , upvalues : CS_LeanTouch
  if toOtherRoom then
    self:BeforeEnterNextRoom()
  end
  if self.curRoomCharCtrl ~= nil then
    (self.curRoomCharCtrl):UnSetAsEnterActiveRoom()
  end
  ;
  (roomEntity.roomData):ClearDormRoom()
  self.roomEntity = nil
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.roomCharacter)[roomEntity.spos] = nil
  if self.curRoomCharCtrl ~= nil then
    (self.curRoomCharCtrl):OnDelete()
    self.curRoomCharCtrl = nil
  end
  ;
  (CS_LeanTouch.OnFingerDown)("-", self.__onFingerDown)
  ;
  (CS_LeanTouch.OnFingerSet)("-", self.__onFingerSet)
  ;
  (CS_LeanTouch.OnFingerUp)("-", self.__onFingerUp)
end

DormCharacterCtrl.GetRoomCharacterCtrl = function(self, roomEntity)
  -- function num : 0_11
  local roomCharCtrl = (self.roomCharacter)[roomEntity.spos]
  return roomCharCtrl
end

DormCharacterCtrl.__InitCharacterCtrl = function(self)
  -- function num : 0_12
  self.roomCharacter = {}
end

DormCharacterCtrl.OnDormBindRoleChanged = function(self)
  -- function num : 0_13
  if self.roomEntity == nil then
    return 
  end
  self:__ReGenUnbindCharList()
  self:ResetRoomCharacter((self.roomEntity).spos, true)
end

DormCharacterCtrl.OnDormUnbindSwitchChanged = function(self, opDic)
  -- function num : 0_14
  if self.roomEntity == nil then
    return 
  end
  local changeValue = opDic[(self.roomEntity).spos]
  if changeValue ~= nil then
    if changeValue then
      self:__RandAddUnBindCharacterEvenly()
    else
      self:ResetRoomCharacter((self.roomEntity).spos)
    end
  end
end

DormCharacterCtrl.BeforeEnterNextRoom = function(self)
  -- function num : 0_15
  if self.curRoomCharCtrl == nil then
    return 
  end
  self.__lastUnbindIds = (self.curRoomCharCtrl):GetRoomUnbindCharacterId()
end

DormCharacterCtrl.FirstAddUnBindCharacter = function(self)
  -- function num : 0_16 , upvalues : _ENV
  self:__ReGenUnbindCharList()
  self:__RandAddUnBindCharacterEvenly()
  if self.__lastUnbindIds ~= nil then
    for heroId,_ in pairs(self.__lastUnbindIds) do
      (table.insert)(self.unbindCharList, heroId)
    end
    self.__lastUnbindIds = nil
  end
end

DormCharacterCtrl.__ReGenUnbindCharList = function(self)
  -- function num : 0_17 , upvalues : _ENV
  local allBindFntData = (self.dormCtrl):GetAllBindFntData()
  self.unbindCharList = {}
  for heroId,heroData in pairs(PlayerDataCenter.heroDic) do
    if (allBindFntData.boundDic)[heroId] == nil and (self.__lastUnbindIds == nil or (self.__lastUnbindIds)[heroId] == nil) then
      (table.insert)(self.unbindCharList, heroId)
    end
  end
end

DormCharacterCtrl.__RandAddUnBindCharacterEvenly = function(self, resetCharCtrl)
  -- function num : 0_18 , upvalues : _ENV
  if isEditorMode and (resetCharCtrl ~= nil or self.roomEntity ~= nil) then
    local customeDormHero = ((CS.GMController).Instance).CustomeDormHero
    if not (string.IsNullOrEmpty)(customeDormHero) then
      local heroIds = (string.split)(customeDormHero, "|")
      if #heroIds > 0 then
        if not resetCharCtrl then
          resetCharCtrl = (self.roomCharacter)[(self.roomEntity).spos]
        end
        for _,heroId in pairs(heroIds) do
          local heroData = (PlayerDataCenter.heroDic)[tonumber(heroId)]
          if heroData == nil then
            error("current not heroData heroId:" .. tostring(heroId))
          else
            local charEntity = resetCharCtrl:AddUnBindCharacter(heroData, 9999999)
          end
        end
        return 
      end
    end
  end
  do
    local roomCtrl = self.curRoomCharCtrl
    if not (roomCtrl.roomData):GetEnableUnbind() then
      return 
    end
    local nowRoleCount = roomCtrl:GetRoomCharacterCount()
    local MaxRoomRole = (ConfigData.game_config).DormRoomRoleMaxCount
    while 1 do
      if nowRoleCount < MaxRoomRole and #self.unbindCharList > 0 and not roomCtrl:IsRoomCharacterFull() then
        nowRoleCount = nowRoleCount + 1
        local sign = (math.random)(100)
        if 100 - (ConfigData.game_config).DormUnbindRoleChance >= sign then
          local index = (math.random)(#self.unbindCharList)
          local heroId = (self.unbindCharList)[index]
          local heroData = (PlayerDataCenter.heroDic)[heroId]
          local charEntity = roomCtrl:AddUnBindCharacter(heroData)
          if charEntity ~= nil then
            (table.remove)(self.unbindCharList, index)
          end
        end
      end
    end
  end
end

DormCharacterCtrl.RandChangeUnBindCharacter = function(self, roomCtrl, oldEntity, action)
  -- function num : 0_19 , upvalues : _ENV
  local charEntity = nil
  local sign = (math.random)(100)
  if #self.unbindCharList > 0 and sign <= 100 - (ConfigData.game_config).DormUnbindRoleChance then
    local index = (math.random)(#self.unbindCharList)
    local heroId = (self.unbindCharList)[index]
    local heroData = (PlayerDataCenter.heroDic)[heroId]
    charEntity = roomCtrl:AddUnBindCharacterAction(heroData, action)
    if charEntity ~= nil then
      (table.remove)(self.unbindCharList, index)
    end
  end
  do
    ;
    (table.insert)(self.unbindCharList, (oldEntity.heroData).dataId)
    return charEntity
  end
end

DormCharacterCtrl.RangeOtherNoFullRoomCtrl = function(self, roomCtrl)
  -- function num : 0_20 , upvalues : _ENV
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
  -- function num : 0_21 , upvalues : _ENV
  for k,v in pairs(self.roomCharacter) do
    v:OnDelete()
  end
  self:OnEnterDormHouse()
end

DormCharacterCtrl.ResetRoomCharacter = function(self, pos, totalReset)
  -- function num : 0_22 , upvalues : DormRoomCharacterCtrl, _ENV
  local oldCharCtrl = (self.roomCharacter)[pos]
  local lastHeroDic = nil
  if oldCharCtrl ~= nil then
    lastHeroDic = oldCharCtrl:GetRoomCharcterIdDic()
    oldCharCtrl:OnDelete()
  else
    lastHeroDic = {}
  end
  local roomEntity = ((self.houseCtrl).roomEnityDic)[pos]
  if roomEntity == nil or roomEntity:IsEmptyRoom() then
    return 
  end
  local roomCharacterCtrl = (DormRoomCharacterCtrl.New)(self, roomEntity)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (self.roomCharacter)[pos] = roomCharacterCtrl
  self:SetCurRoomCharacterCtrl()
  local roomCtrl = self.curRoomCharCtrl
  local nowRoleCount = roomCharacterCtrl:GetRoomCharacterCount()
  local allBindFntData = (self.dormCtrl):GetAllBindFntData()
  local addedUnbindHeros = {}
  if (roomEntity.roomData):GetEnableUnbind() then
    for heroId,_ in pairs(lastHeroDic) do
      if (ConfigData.game_config).DormRoomRoleMaxCount > nowRoleCount then
        if (allBindFntData.boundDic)[heroId] == nil then
          addedUnbindHeros[heroId] = true
          nowRoleCount = nowRoleCount + 1
          local heroData = (PlayerDataCenter.heroDic)[heroId]
          local charEntity = roomCtrl:AddUnBindCharacter(heroData)
        end
        do
          -- DECOMPILER ERROR at PC64: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC64: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  if totalReset then
    for i = #self.unbindCharList, 1, -1 do
      local heroId = (self.unbindCharList)[i]
      if addedUnbindHeros[heroId] then
        (table.remove)(self.unbindCharList, i)
      end
    end
  else
    do
      for heroId,_ in pairs(lastHeroDic) do
        if (allBindFntData.boundDic)[heroId] == nil and not addedUnbindHeros[heroId] then
          (table.insert)(self.unbindCharList, heroId)
        end
      end
      do
        roomCharacterCtrl:StartCharacterLogic()
      end
    end
  end
end

DormCharacterCtrl.SetCurRoomCharacterCtrl = function(self)
  -- function num : 0_23
  self.curRoomCharCtrl = (self.roomCharacter)[(self.roomEntity).spos]
  ;
  (self.curRoomCharCtrl):SetAsEnterActiveRoom()
end

DormCharacterCtrl.SetBindCharacterChange = function(self, fntData, oldHeroId, newHeroId)
  -- function num : 0_24 , upvalues : _ENV
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

DormCharacterCtrl.GenInterPointEntity = function(self, interPoint, unityPos)
  -- function num : 0_25 , upvalues : _ENV, DormInterPointEntity
  local interPointEntity = nil
  if #self.__interPointPool > 0 then
    interPointEntity = (table.remove)(self.__interPointPool)
  else
    interPointEntity = (DormInterPointEntity.New)()
  end
  return interPointEntity
end

DormCharacterCtrl.RecoveryInterPoint = function(self, pointEntity)
  -- function num : 0_26 , upvalues : _ENV
  pointEntity:ClearPointEntityData()
  ;
  (table.insert)(self.__interPointPool, pointEntity)
end

DormCharacterCtrl.OnUpdate = function(self)
  -- function num : 0_27 , upvalues : _ENV
  if not self.__charcterActive or self.roomCharacter == nil then
    return 
  end
  for spos,roomCharacterCtrl in pairs(self.roomCharacter) do
    roomCharacterCtrl:OnUpdate()
  end
end

DormCharacterCtrl.SetSelectCharacter = function(self, charEntity)
  -- function num : 0_28 , upvalues : _ENV
  self.__selectCharEntity = charEntity
  ;
  (self.__selectCharEntity):SetCharacterOperateStart()
  ;
  (self.__dragIndicatorGo):SetActive(true)
  self:SetDragIndicatorPosition((self.__selectCharEntity).x, (self.__selectCharEntity).y)
  MsgCenter:Broadcast(eMsgEventId.OnDormCharacterOpChanged, true)
end

DormCharacterCtrl.SetDragIndicatorPosition = function(self, x, y)
  -- function num : 0_29 , upvalues : DormUtil
  local pos = (DormUtil.GetFntUnityCoord)((self.__selectCharEntity).x, (self.__selectCharEntity).y)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.__dragIndicatorGo).transform).position = (((self.curRoomCharCtrl).roomEntity).fntHolder):TransformPoint(pos)
end

DormCharacterCtrl.OnFingerDown = function(self, finger)
  -- function num : 0_30 , upvalues : DormEnum, CS_Physics, _ENV
  if (self.dormCtrl).state ~= (DormEnum.eDormState).Room or finger.IsOverGui then
    return 
  end
  if not ((self.dormCtrl).cmderCtrl):IsCmderInteractStateNone() then
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
  -- function num : 0_31 , upvalues : CS_Physics, _ENV
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
  -- function num : 0_32
  if self.__selectCharEntity == nil or finger.Index ~= self.__fingerId then
    return 
  end
  self:EndOperateCharacter()
end

DormCharacterCtrl.EndOperateCharacter = function(self)
  -- function num : 0_33 , upvalues : _ENV
  (self.curRoomCharCtrl):FinishCharacterOperate(self.__selectCharEntity)
  ;
  (self.__dragIndicatorGo):SetActive(false)
  self.__fingerId = nil
  self.__selectCharEntity = nil
  MsgCenter:Broadcast(eMsgEventId.OnDormCharacterOpChanged, false)
end

DormCharacterCtrl.IsDragCharacter = function(self)
  -- function num : 0_34
  if self.__fingerId ~= nil or self.__selectCharEntity ~= nil then
    return true
  end
  return false
end

DormCharacterCtrl.OnChangeHeroSkin = function(self, changeSkinHeroId, skinId)
  -- function num : 0_35
  if self.curRoomCharCtrl == nil then
    return 
  end
  ;
  (self.curRoomCharCtrl):TryRefreshCharacterModle(changeSkinHeroId)
end

DormCharacterCtrl.OnDelete = function(self)
  -- function num : 0_36 , upvalues : _ENV, CS_LeanTouch
  MsgCenter:RemoveListener(eMsgEventId.DormBindRoleChanged, self.__OnDormBindRoleChanged)
  MsgCenter:RemoveListener(eMsgEventId.DormUnbindSwitchChanged, self.__OnDormUnbindSwitchChanged)
  MsgCenter:RemoveListener(eMsgEventId.OnHeroSkinChange, self.__OnChangeHeroSkin)
  ;
  (CS_LeanTouch.OnFingerDown)("-", self.__onFingerDown)
  ;
  (CS_LeanTouch.OnFingerSet)("-", self.__onFingerSet)
  ;
  (CS_LeanTouch.OnFingerUp)("-", self.__onFingerUp)
  if self.roomCharacter ~= nil then
    for spos,roomCharacterCtrl in pairs(self.roomCharacter) do
      roomCharacterCtrl:OnDelete()
    end
    self.roomCharacter = nil
  end
  UpdateManager:RemoveUpdate(self.__onUpdate)
end

return DormCharacterCtrl

