local DormRoleBaseEntity = require("Game.Dorm.Character.Entity.DormRoleBaseEntity")
local DormCharacterEntity = class("DormCharacterEntity", DormRoleBaseEntity)
local DormUtil = require("Game.Dorm.DormUtil")
local DormCharacterAI = require("Game.Dorm.Character.AI.DormCharacterAI")
local DormEnum = require("Game.Dorm.DormEnum")
local DormChecker = require("Game.Dorm.DormChecker")
local cs_ResLoader = CS.ResLoader
local UnBindActiveTime = 30
DormCharacterEntity.ctor = function(self, heroData, worldPos, roomCharCtrl, activeTime)
  -- function num : 0_0 , upvalues : _ENV, DormCharacterAI
  self.__loaded = false
  self.heroData = heroData
  self.__initWorldPos = worldPos
  self.x = 0
  self.y = 0
  self.roomCharCtrl = roomCharCtrl
  self.roomData = roomCharCtrl.roomData
  self.roomEntity = roomCharCtrl.roomEntity
  self.isBind = activeTime < 0
  self.__activeTime = activeTime
  self.__isOperate = false
  self.__endUnBindTime = false
  self.__isReadyToInteract = true
  self.__curModleResName = nil
  local aiCfg = (ConfigData.dorm_ai)[((self.heroData).heroCfg).dorm_ai]
  if aiCfg == nil then
    error("hero ai config is null,heroId:" .. tostring((self.heroData).dataId) .. " aiId:" .. tostring(((self.heroData).heroCfg).dorm_ai))
    return 
  end
  self.aiCtrl = (DormCharacterAI.New)(aiCfg, self, true)
  self.__dormGreetCfg = (ConfigData.dorm_hero_greet)[(self.heroData).dataId]
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

DormCharacterEntity.LoadDormCharacter = function(self, charholder, action)
  -- function num : 0_1 , upvalues : cs_ResLoader, _ENV
  if self.__resloader ~= nil then
    (self.__resloader):Put2Pool()
  end
  self.__resloader = (cs_ResLoader.Create)()
  ;
  (self.__resloader):LoadABAssetAsync(PathConsts:GetCharacterDormModelPath((self.heroData):GetResModelName()), function(prefab)
    -- function num : 0_1_0 , upvalues : _ENV, self, charholder, action
    if IsNull(prefab) then
      return 
    end
    self.__curModleResName = (self.heroData):GetResModelName()
    local go = prefab:Instantiate(charholder)
    self:__InitDormCharacterGo(go)
    if action ~= nil then
      action(self)
    end
  end
)
end

DormCharacterEntity.__InitDormCharacterGo = function(self, gameObject)
  -- function num : 0_2 , upvalues : DormUtil, _ENV, DormEnum
  self.__loaded = true
  self.gameObject = gameObject
  self.transform = gameObject.transform
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  if self.__initWorldPos ~= nil then
    (self.transform).position = self.__initWorldPos
  else
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self.transform).position = (DormUtil.GetFntUnityCoord)(self.x, self.y)
  end
  self.animator = (self.gameObject):FindComponent(eUnityComponentID.Animator)
  self.astarCharcter = ((CS.DormAStarCharacter).Create)(self.gameObject)
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self.astarCharcter).speed = self:GetDormMoveSpeed()
  ;
  (self.astarCharcter):AddAStarComponents(false)
  if (ConfigData.buildinConfig).DormStopCollideFeature then
    (self.astarCharcter):SetNavMeshCutOnMoveStop(true)
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((self.astarCharcter).rvoController).lockWhenNotMoving = true
    self.__OnStartFntInteract = BindCallback(self, self.__StartFntInteract)
    self.__OnStartExitInteract = BindCallback(self, self.__StartExitInteract)
    ;
    (self.aiCtrl):AddListenerForDormAI((DormEnum.CharacterAIEventId).StartFntInteract, self.__OnStartFntInteract)
    ;
    (self.aiCtrl):AddListenerForDormAI((DormEnum.CharacterAIEventId).ExitFntInteract, self.__OnStartExitInteract)
  end
  self:GenUnlockDormTalkList()
  self:StartAIBehavior()
end

DormCharacterEntity.GetRoleName = function(self)
  -- function num : 0_3
  return (self.heroData):GetName()
end

DormCharacterEntity.GetDormRoleResName = function(self)
  -- function num : 0_4
  return (self.heroData):GetResModelName(true)
end

DormCharacterEntity.GetCurModleResName = function(self)
  -- function num : 0_5
  return self.__curModleResName
end

DormCharacterEntity.IsHaveNewModleRes = function(self)
  -- function num : 0_6
  do return self.__curModleResName ~= (self.heroData):GetResModelName() end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DormCharacterEntity.GetCharAStarComp = function(self)
  -- function num : 0_7
  return self.astarCharcter
end

DormCharacterEntity.GetBelongRoomEntity = function(self)
  -- function num : 0_8
  return self.roomEntity
end

DormCharacterEntity.GetDormMoveSpeed = function(self)
  -- function num : 0_9
  return (self.heroData):GetDormMoveSpeed()
end

DormCharacterEntity.StartAIBehavior = function(self, fromDoor)
  -- function num : 0_10 , upvalues : _ENV
  if self.__getReady then
    (self.aiCtrl):AIInterruptCurrState(false)
    if fromDoor then
      (self.aiCtrl):RandToRoomOnePoint()
    else
      ;
      (self.aiCtrl):RandNewAction()
    end
    if not self.isBind then
      self.unbindTimerId = TimerManager:StartTimer(self.__activeTime, self.EndUnBindCharacter, self, true)
    end
    if not ((self.roomCharCtrl).characterCtrl):IsDormCharacterActive() then
      self:HidePauseCharacter()
    end
  else
    self.__getReady = true
  end
end

DormCharacterEntity.EndUnBindCharacter = function(self)
  -- function num : 0_11
  self.__endUnBindTime = true
  self.unbindTimerId = nil
end

DormCharacterEntity.IsDormUnBindTimeout = function(self)
  -- function num : 0_12
  return self.__endUnBindTime
end

DormCharacterEntity.StartExChangeUnBindChar = function(self)
  -- function num : 0_13
  (self.roomCharCtrl):ExchangeUnBindCharacter(self)
end

DormCharacterEntity.ChangeOtherDormRoom = function(self)
  -- function num : 0_14
  return (self.roomCharCtrl):ChangeCharacterToOtherRoom(self)
end

DormCharacterEntity.SetNewRoomCtrl = function(self, roomCharCtrl)
  -- function num : 0_15
  self.roomCharCtrl = roomCharCtrl
  self.roomData = roomCharCtrl.roomData
  self.roomEntity = roomCharCtrl.roomEntity
end

DormCharacterEntity.HidePauseCharacter = function(self)
  -- function num : 0_16 , upvalues : DormUtil, _ENV
  if not self.__loaded then
    return 
  end
  ;
  (self:GetCharAStarComp()).isPause = true
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self:GetCharAStarComp()).aiPath).enabled = false
  self.__position = (self.transform).position
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.transform).position = DormUtil.CharacterNoShowPos
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.animator).speed = 0
  if self.curTweener ~= nil then
    (self.curTweener):Pause()
  end
  if self.operateTimerId ~= nil then
    TimerManager:PauseTimer(self.operateTimerId)
  end
  if self.unbindTimerId ~= nil then
    TimerManager:PauseTimer(self.unbindTimerId)
  end
end

DormCharacterEntity.ShowResumeCharacter = function(self)
  -- function num : 0_17 , upvalues : _ENV
  if not self.__loaded then
    return 
  end
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  if self.__position ~= nil then
    (self.transform).position = self.__position
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.animator).speed = 1
  ;
  (self:GetCharAStarComp()).isPause = false
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self:GetCharAStarComp()).aiPath).enabled = true
  if self.curTweener ~= nil then
    (self.curTweener):Play()
  end
  if self.operateTimerId ~= nil then
    TimerManager:ResumeTimer(self.operateTimerId)
  end
  if self.unbindTimerId ~= nil then
    TimerManager:ResumeTimer(self.unbindTimerId)
  end
end

DormCharacterEntity.ResetToDoorCoord = function(self)
  -- function num : 0_18
  local logicX, logicY = (self.roomData):GetDoorCoord()
  self:SetLogicPos(logicX, logicY)
end

DormCharacterEntity.SetCharacterOperateStart = function(self)
  -- function num : 0_19 , upvalues : _ENV
  self.__isOperate = true
  self:StopCheckAnimator()
  self:DormForceStopMove()
  TimerManager:StopTimer(self.operateTimerId)
  ;
  (self.aiCtrl):AIInterruptCurrState(false)
  self:AnimatorFloat()
  ;
  (self:GetCharAStarComp()):SetNavMeshCutEnabled(false)
end

DormCharacterEntity.SetCharacterOperateEnd = function(self, interPointEntity)
  -- function num : 0_20 , upvalues : DormUtil, DormEnum
  self.__isOperate = false
  if interPointEntity ~= nil then
    self:ResetAnimatorTrigger()
    ;
    (self.aiCtrl):StartFntInterPointState(interPointEntity:GetInterPointData(), true)
  else
    self.__isReadyToInteract = false
    local newX, newY = (self.roomCharCtrl):FindActivePosNearby(self.x, self.y)
    if self.x ~= nil and self.x ~= nil then
      newX = self.x
      newY = self.y
    end
    local localDestPos = (DormUtil.GetFntUnityCoord)(newX, newY)
    local destPos = ((self.roomEntity).characterHolder):TransformPoint(localDestPos)
    if not (DormUtil.IsPositionOnNavmesh)(destPos) then
      destPos = (DormUtil.FindNearestActivePoint)(destPos)
    end
    self:SetUnityWorldPos(destPos)
    ;
    (self.transform):SetLocalY(0)
    self:AnimatorStand()
    self:StartCheckAnimator(DormEnum.DormAnimatorNormalName, function()
    -- function num : 0_20_0 , upvalues : self
    if self.__isOperate then
      return 
    end
    ;
    (self.aiCtrl):RandNewAction()
    self.__isReadyToInteract = true
  end
)
  end
end

DormCharacterEntity.IsDormCharacterReady = function(self)
  -- function num : 0_21
  if self.__isOperate then
    return false
  end
  return self.__isReadyToInteract
end

DormCharacterEntity.OnUpdate = function(self)
  -- function num : 0_22
  if self.__isOperate then
    return 
  end
  ;
  (self.aiCtrl):OnUpdate()
end

DormCharacterEntity.DoMoveLogic = function(self, pos, completeAction)
  -- function num : 0_23
  local worldPos = self:DormLogicToWorld(pos)
  return self:DoMoveAStar(worldPos, completeAction)
end

DormCharacterEntity.GenUnlockDormTalkList = function(self)
  -- function num : 0_24 , upvalues : _ENV, DormChecker
  self.__talkIdList = {}
  local talkCfg = (ConfigData.dorm_hero_talk)[(self.heroData).dataId]
  if talkCfg == nil then
    return 
  end
  self.__isAllTalked = true
  local talkedDic = {}
  local allDormData = (ControllerManager:GetController(ControllerTypeId.Dorm)).allDormData
  for talkIndex,unlockType in pairs(talkCfg.pre_type) do
    local unlockArg = (talkCfg.pre_para)[talkIndex]
    if (DormChecker.CheckerTalkUnlock)((self.heroData).dataId, unlockType, unlockArg) then
      local talkId = (talkCfg.talk_list)[talkIndex]
      ;
      (table.insert)(self.__talkIdList, talkId)
      if not allDormData:IsDormHeroTalked((self.heroData).dataId, talkIndex) then
        self.__isAllTalked = false
      else
        talkedDic[talkId] = true
      end
    end
  end
  if #self.__talkIdList == 0 then
    return 
  end
  if self.__isAllTalked then
    return 
  end
  local i = 1
  while 1 do
    while 1 do
      if i <= #self.__talkIdList then
        local talkId = (self.__talkIdList)[i]
        if talkedDic[talkId] then
          (table.remove)(self.__talkIdList, i)
          -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC75: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    i = i + 1
  end
end

DormCharacterEntity.GetUnlockDormTalkList = function(self)
  -- function num : 0_25
  return self.__talkIdList
end

DormCharacterEntity.IsAllTalked = function(self)
  -- function num : 0_26
  return self.__isAllTalked
end

DormCharacterEntity.GetDormGreetConfig = function(self)
  -- function num : 0_27
  return self.__dormGreetCfg
end

DormCharacterEntity.__StartFntInteract = function(self)
  -- function num : 0_28
  self:SetStarAIPathActive(false)
  self:SetNavmeshCutActive(false)
end

DormCharacterEntity.__StartExitInteract = function(self)
  -- function num : 0_29
  self:SetNavmeshCutActive(true)
end

DormCharacterEntity.OnDelete = function(self)
  -- function num : 0_30 , upvalues : DormRoleBaseEntity, _ENV
  (DormRoleBaseEntity.OnDelete)(self)
  if self.astarCharcter ~= nil then
    (self.astarCharcter):ForceStopMove()
    self.astarCharcter = nil
  end
  if self.curTweener ~= nil then
    (self.curTweener):Kill()
    self.curTweener = nil
  end
  if self.__resloader ~= nil then
    (self.__resloader):Put2Pool()
    self.__resloader = nil
  end
  TimerManager:StopTimer(self.operateTimerId)
  TimerManager:StopTimer(self.unbindTimerId)
  DestroyUnityObject(self.gameObject)
  self.gameObject = nil
  self.transform = nil
end

return DormCharacterEntity

