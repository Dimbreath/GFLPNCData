local DormCtrlBase = require("Game.Dorm.Ctrl.DormCtrlBase")
local DormCmderCtrl = class("DormCtrlBase", DormCtrlBase)
local DormInteractActionData = require("Game.Dorm.Data.DormInteractActionData")
local DormUtil = require("Game.Dorm.DormUtil")
local DormEnum = require("Game.Dorm.DormEnum")
local DormAIStateConfig = require("Game.Dorm.Character.AI.DormAIStateConfig")
local CheckFntDistance = 0.3
local CheckTalkDistance = 1
local cs_UnityUtility = CS.UnityUtility
local DormCmderEntity = require("Game.Dorm.Character.Entity.DormCmderEntity")
local InteractPool = (CommonPool.New)(function()
  -- function num : 0_0 , upvalues : DormInteractActionData
  return (DormInteractActionData.New)()
end
, function(p)
  -- function num : 0_1
  p:ResetData()
  return true
end
)
DormCmderCtrl.ctor = function(self, dormCtrl)
  -- function num : 0_2 , upvalues : DormEnum, _ENV
  self.__checkFrame = 0
  self.__checkpaused = false
  self.__interactState = (DormEnum.CharInteractState).None
  self.__checkCmderInteract = BindCallback(self, self.CheckCmderInteract)
  self.__startFntInteractAction = BindCallback(self, self.StartFntInteractAction)
  self.__startTalkInteractAction = BindCallback(self, self.StartTalkInteractAction)
  self.__startGreetInteractAction = BindCallback(self, self.StartGreetInteractAction)
  self.__startDoorInteractAction = BindCallback(self, self.StartDoorInteractAction)
  self.__onRoomCharacterOpChanged = BindCallback(self, self.OnRoomCharacterOpChanged)
  MsgCenter:AddListener(eMsgEventId.OnDormCharacterOpChanged, self.__onRoomCharacterOpChanged)
end

DormCmderCtrl.OnEnterDormScene = function(self)
  -- function num : 0_3 , upvalues : DormCmderEntity, _ENV
  local cmderObject = (((self.dormCtrl).comRes).cmderPrefab):Instantiate()
  self:_InitHeadFx(cmderObject)
  self.cmderEntity = (DormCmderEntity.New)()
  ;
  (self.cmderEntity):InitDormCmderEntity(cmderObject)
  ;
  (self.cmderEntity):HideDormCmder()
  self.__interactActionList = {}
  self.__highLightFntDic = {}
  UIManager:ShowWindowAsync(UIWindowTypeID.DormInput, function(inputWindow)
    -- function num : 0_3_0 , upvalues : self, _ENV
    self.__inputWindow = inputWindow
    ;
    (self.__inputWindow):InitDormInput(BindCallback(self, self.OnDormJoystickMove), BindCallback(self, self.OnDormJoystickUp))
    if not self.__cmderActive then
      (self.__inputWindow):Hide()
    end
  end
)
  UIManager:ShowWindowAsync(UIWindowTypeID.DormInteract, function(interactWindow)
    -- function num : 0_3_1 , upvalues : self
    self.__interactWindow = interactWindow
    if not self.__cmderActive then
      (self.__interactWindow):Hide()
    end
  end
)
end

DormCmderCtrl._InitHeadFx = function(self, cmderObject)
  -- function num : 0_4 , upvalues : _ENV, DormUtil
  local cmderHeadFxGo = (((self.dormCtrl).comRes).cmderHeadFxPrefab):Instantiate(cmderObject.transform)
  local posConstraint = cmderHeadFxGo:GetComponent(typeof(((CS.UnityEngine).Animations).PositionConstraint))
  if posConstraint ~= nil then
    local constraintSource = posConstraint:GetSource(0)
    local headPath = (DormUtil.GetDormCmderResName)() .. "/root/Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Neck/Bip001 Head"
    local headTran = (cmderObject.transform):Find(headPath)
    if IsNull(headTran) then
      warn("Commander head point is null : " .. tostring(headPath))
    end
    constraintSource.sourceTransform = headTran
    posConstraint:SetSource(0, constraintSource)
  end
end

DormCmderCtrl.OnEnterDormHouse = function(self)
  -- function num : 0_5
end

DormCmderCtrl.OnEnterDormHouseEditMode = function(self)
  -- function num : 0_6
  self:__SwitchDormCmderState(false)
end

DormCmderCtrl.OnExitDormEditMode = function(self)
  -- function num : 0_7
  self:__SwitchDormCmderState(true)
end

DormCmderCtrl.OnEnterDormRoomEnd = function(self, roomEntity)
  -- function num : 0_8 , upvalues : DormUtil
  self.__cmderInRoom = roomEntity
  local wallId, worldPos, startPos = roomEntity:GetRoomDoorPos()
  ;
  (self.cmderEntity):CmderAddToRoom(self.__cmderInRoom, worldPos)
  ;
  (self.cmderEntity):ShowDormCmder()
  ;
  (self.cmderEntity):SetStarAIPathActive(false)
  ;
  (self.cmderEntity):SetMoveAniSpeed(1)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.cmderEntity).transform).rotation = (DormUtil.GetDormWallRot)(wallId)
  ;
  (self.cmderEntity):DoMoveUnityPos(startPos, function()
    -- function num : 0_8_0 , upvalues : self
    (self.cmderEntity):SetMoveAniSpeed(0)
    self:__SwitchDormCmderState(true)
  end
)
end

DormCmderCtrl.OnExitDormRoomStart = function(self, roomEntity)
  -- function num : 0_9
  self.__cmderInRoom = nil
  self:__SwitchDormCmderState(false)
  ;
  ((self.cmderEntity).transform):SetParent(nil)
end

DormCmderCtrl.OnEnterDormRoomEditMode = function(self, roomEntity)
  -- function num : 0_10
  self:__SwitchDormCmderState(false)
end

DormCmderCtrl.OnExitDormRoomEditMode = function(self, roomEntity, success)
  -- function num : 0_11
  if success then
    self:OnEnterDormRoomEnd(roomEntity)
    return 
  end
  self:__SwitchDormCmderState(true)
end

DormCmderCtrl.GetCurRoomCharCtrl = function(self)
  -- function num : 0_12
  return ((self.dormCtrl).characterCtrl):GetRoomCharacterCtrl(self.__cmderInRoom)
end

DormCmderCtrl.IsCmderInteractStateNone = function(self)
  -- function num : 0_13 , upvalues : DormEnum
  do return self.__interactState == (DormEnum.CharInteractState).None end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

DormCmderCtrl.__SwitchDormCmderState = function(self, active)
  -- function num : 0_14 , upvalues : _ENV, DormEnum
  self.__cmderActive = active
  if active then
    (self.cmderEntity):ShowDormCmder()
    ;
    (self.__inputWindow):Show()
    ;
    (self.__interactWindow):Show()
    ;
    (self.cmderEntity):StartCmderCheckMove((ConfigData.buildinConfig).MinDistanceCheck, self.__checkCmderInteract)
    self.__checkTimerId = TimerManager:StartTimer((ConfigData.buildinConfig).DormInteractCheck, self.__checkCmderInteract, nil, false, false)
    ;
    (self.cmderEntity):SetStarAIPathActive(true)
    self:CheckCmderInteract()
    self.__checkpaused = false
    if (ConfigData.buildinConfig).DormStopCollideFeature then
      ((self.cmderEntity):GetCharAStarComp()):SetNavMeshCutOnMoveStop(true)
    end
    ;
    ((self.cmderEntity):GetCharAStarComp()):SetNavMeshCutEnabled(true)
    ;
    (self.cmderEntity):SetStarAIPathActive(false)
  else
    ;
    (self.cmderEntity):HideDormCmder()
    ;
    (self.__inputWindow):Hide()
    ;
    (self.__interactWindow):Hide()
    ;
    (self.cmderEntity):StopCmderCheckMove()
    TimerManager:StopTimer(self.__checkTimerId)
    ;
    (self.cmderEntity):SetStarAIPathActive(false)
    ;
    (self.cmderEntity):DormForceStopMove()
    self.__interactState = (DormEnum.CharInteractState).None
    self:RemoveAllHightLightFnt()
  end
end

DormCmderCtrl.OnRoomCharacterOpChanged = function(self, start)
  -- function num : 0_15
  self.__checkpaused = start
  if start then
    (self.__interactWindow):Hide()
    self:RemoveAllHightLightFnt()
  else
    ;
    (self.__interactWindow):Show()
    self:CheckCmderInteract()
  end
end

DormCmderCtrl.RemoveAllHightLightFnt = function(self)
  -- function num : 0_16 , upvalues : _ENV, DormUtil
  for fntEntity,_ in pairs(self.__highLightFntDic) do
    (DormUtil.RemovePointFntHighlight)(fntEntity.gameObject)
  end
  self.__highLightFntDic = {}
end

DormCmderCtrl.OnDormJoystickMove = function(self, moveData)
  -- function num : 0_17 , upvalues : DormEnum
  if self.__interactState == (DormEnum.CharInteractState).Fnt then
    self.__interactState = (DormEnum.CharInteractState).WaitExit
    ;
    (self.cmderEntity):AIStartExitWait(function(success)
    -- function num : 0_17_0 , upvalues : self, DormEnum
    if not success then
      self.__interactState = (DormEnum.CharInteractState).Fnt
      return 
    end
    if self.__interactState == (DormEnum.CharInteractState).WaitExit then
      self.__interactState = (DormEnum.CharInteractState).None
    end
  end
, true)
    return 
  end
  if self.__interactState == (DormEnum.CharInteractState).None then
    (self.cmderEntity):SetStarAIPathActive(true)
    ;
    ((self.cmderEntity):GetCharAStarComp()):SetNavMeshCutEnabled(false)
    ;
    (self.cmderEntity):CmderStartMove(moveData)
  end
end

DormCmderCtrl.OnDormJoystickUp = function(self)
  -- function num : 0_18 , upvalues : DormEnum
  if self.__interactState == (DormEnum.CharInteractState).None then
    (self.cmderEntity):SetStarAIPathActive(false)
    ;
    ((self.cmderEntity):GetCharAStarComp()):SetNavMeshCutEnabled(true)
  end
  ;
  (self.cmderEntity):CmderEndMove()
end

DormCmderCtrl.CheckCmderInteract = function(self)
  -- function num : 0_19 , upvalues : DormEnum, _ENV, InteractPool, cs_UnityUtility, CheckFntDistance, DormUtil, CheckTalkDistance
  if self.__checkpaused then
    return 
  end
  if self.__interactState ~= (DormEnum.CharInteractState).None then
    return 
  end
  if self.__checkFrame == Time.frameCount then
    return 
  end
  self.__checkFrame = Time.frameCount
  local roomCharaCtrl = self:GetCurRoomCharCtrl()
  local interPointList = roomCharaCtrl:GetInterPointEntityList()
  for i = #self.__interactActionList, 1, -1 do
    local interactAction = (self.__interactActionList)[i]
    InteractPool:PoolPut(interactAction)
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self.__interactActionList)[i] = nil
  end
  local fntEntityDic = {}
  for _,interPoint in pairs(interPointList) do
    if (cs_UnityUtility.IsCloseDistance)((self.cmderEntity).transform, interPoint:GetPointStartPos(), CheckFntDistance) then
      local interactAction = InteractPool:PoolGet()
      interactAction:InitFntAction(interPoint, self.__startFntInteractAction)
      ;
      (table.insert)(self.__interactActionList, interactAction)
      fntEntityDic[interPoint:GetPointFromFntEntity()] = true
    end
  end
  for fntEntity,_ in pairs(fntEntityDic) do
    -- DECOMPILER ERROR at PC77: Confused about usage of register: R9 in 'UnsetPending'

    if (self.__highLightFntDic)[fntEntity] then
      (self.__highLightFntDic)[fntEntity] = nil
    else
      ;
      (DormUtil.AddHighLightTarget)(fntEntity.gameObject)
    end
  end
  for fntEntity,_ in pairs(self.__highLightFntDic) do
    (DormUtil.RemovePointFntHighlight)(fntEntity.gameObject)
  end
  self.__highLightFntDic = fntEntityDic
  local wallId, worldPos, startPos = (self.__cmderInRoom):GetRoomDoorPos()
  do
    if (cs_UnityUtility.IsCloseDistance)((self.cmderEntity).transform, startPos, CheckFntDistance) then
      local interactAction = InteractPool:PoolGet()
      interactAction:InitDoorAction(self.__startDoorInteractAction)
      ;
      (table.insert)(self.__interactActionList, interactAction)
    end
    local charDic = roomCharaCtrl:GetRoomCharacterDic()
    for heroId,charEntity in pairs(charDic) do
      if charEntity.gameObject ~= nil and charEntity:IsDormCharacterReady() then
        local hasTalk = true
        local talkList = charEntity:GetUnlockDormTalkList()
        if talkList == nil or #talkList == 0 then
          hasTalk = false
        end
        local hasGreet = charEntity:GetDormGreetConfig() ~= nil
        if (hasGreet or hasTalk) and (cs_UnityUtility.IsCloseDistance)((self.cmderEntity).transform, (charEntity.gameObject).transform, CheckTalkDistance) and (cs_UnityUtility.CheckTargetDirForMe)((self.cmderEntity).transform, charEntity.transform, (ConfigData.buildinConfig).DormInteractAngle) then
          do
            if hasTalk then
              local interactAction = InteractPool:PoolGet()
              interactAction:InitTalkAction(charEntity, self.__startTalkInteractAction)
              ;
              (table.insert)(self.__interactActionList, interactAction)
            end
            do
              if hasGreet then
                local interactAction = InteractPool:PoolGet()
                interactAction:InitGreetAction(charEntity, self.__startGreetInteractAction)
                ;
                (table.insert)(self.__interactActionList, interactAction)
              end
              -- DECOMPILER ERROR at PC195: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC195: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC195: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC195: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC195: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
    ;
    (self.__interactWindow):UpdateInteractList(self.__interactActionList)
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

DormCmderCtrl.__OnStartInteractAction = function(self)
  -- function num : 0_20
  (self.__interactWindow):HideInteractList()
  self:RemoveAllHightLightFnt()
end

DormCmderCtrl.StartFntInteractAction = function(self, interactAction)
  -- function num : 0_21 , upvalues : DormEnum
  self:__OnStartInteractAction()
  local interPointEntity = interactAction.interPointEntity
  do
    if interPointEntity ~= nil then
      local charEntity = (interPointEntity:GetInterPointData()):GetBindCharacter()
      if charEntity ~= nil then
        charEntity:QuickExitAIState()
      end
    end
    self.__interactState = (DormEnum.CharInteractState).Fnt
    ;
    ((self.cmderEntity).aiCtrl):StartFntInterPointState(interPointEntity:GetInterPointData())
  end
end

DormCmderCtrl.StartTalkInteractAction = function(self, interactAction)
  -- function num : 0_22 , upvalues : _ENV, DormEnum
  self:__OnStartInteractAction()
  local talkCharEntity = interactAction.talkCharEntity
  if talkCharEntity == nil or talkCharEntity.gameObject == nil then
    warn("talk character is nil,or gameObject is nil")
    return 
  end
  self.__interactState = (DormEnum.CharInteractState).Talk
  local talkList = talkCharEntity:GetUnlockDormTalkList()
  if #talkList == 0 then
    return 
  end
  ;
  (self.cmderEntity):StartSmoothLookAtTarget(talkCharEntity.transform)
  ;
  (talkCharEntity.aiCtrl):AIStartExitWait(function(success)
    -- function num : 0_22_0 , upvalues : self, DormEnum, _ENV, talkCharEntity, talkList
    if not success then
      self.__interactState = (DormEnum.CharInteractState).None
      return 
    end
    UIManager:HideWindow(UIWindowTypeID.TopStatus)
    UIManager:HideWindow(UIWindowTypeID.DormRoom)
    ;
    (self.__inputWindow):Hide()
    talkCharEntity:StartSmoothLookAtTarget((self.cmderEntity).transform)
    local talkAvgName = talkList[(math.random)(#talkList)]
    local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
    avgCtrl:ShowAvg(talkAvgName, function()
      -- function num : 0_22_0_0 , upvalues : _ENV, self, talkCharEntity, DormEnum, talkAvgName
      UIManager:ShowWindowOnly(UIWindowTypeID.TopStatus)
      UIManager:ShowWindowOnly(UIWindowTypeID.DormRoom)
      ;
      (self.__inputWindow):Show()
      ;
      (talkCharEntity.aiCtrl):RandNewAction()
      self.__interactState = (DormEnum.CharInteractState).None
      local talkCfg = (ConfigData.dorm_hero_talk)[(talkCharEntity.heroData).dataId]
      if talkCfg == nil then
        return 
      end
      for talkIndex,talkName in pairs(talkCfg.talk_list) do
        if talkName == talkAvgName then
          local heroId = (talkCharEntity.heroData).dataId
          ;
          ((self.dormCtrl).allDormData):AddDormHeroTalked(heroId, talkIndex)
          local sendKey = ((self.dormCtrl).allDormData):GetDormHeroTalkKey(heroId)
          ;
          ((self.dormCtrl).dormNetwork):CS_DORM_SaveHeroTalk(heroId, sendKey)
          talkCharEntity:GenUnlockDormTalkList()
          break
        end
      end
    end
, true)
  end
, true)
end

DormCmderCtrl.StartGreetInteractAction = function(self, interactAction)
  -- function num : 0_23 , upvalues : _ENV, DormEnum, DormUtil
  self:__OnStartInteractAction()
  local talkCharEntity = interactAction.talkCharEntity
  if talkCharEntity == nil or talkCharEntity.gameObject == nil then
    warn("talk character is nil,or gameObject is nil")
    return 
  end
  self.__interactState = (DormEnum.CharInteractState).Greet
  local greetCfg = talkCharEntity:GetDormGreetConfig()
  if greetCfg == nil then
    return 
  end
  ;
  (self.cmderEntity):StartSmoothLookAtTarget(talkCharEntity.transform)
  ;
  (talkCharEntity.aiCtrl):AIStartExitWait(function(success)
    -- function num : 0_23_0 , upvalues : self, DormEnum, _ENV, talkCharEntity, greetCfg, DormUtil
    if not success then
      self.__interactState = (DormEnum.CharInteractState).None
      return 
    end
    UIManager:HideWindow(UIWindowTypeID.TopStatus)
    UIManager:HideWindow(UIWindowTypeID.DormRoom)
    ;
    (self.__inputWindow):Hide()
    talkCharEntity:StartSmoothLookAtTarget((self.cmderEntity).transform)
    if self.__greetEffect == nil then
      self.__greetEffect = (((self.dormCtrl).comRes).greetRolePrefab):Instantiate()
    end
    ;
    ((self.__greetEffect).transform):SetParent(talkCharEntity.transform)
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.__greetEffect).transform).localPosition = Vector3.zero
    ;
    (self.__greetEffect):SetActive(true)
    self.__interactTimer = TimerManager:StartTimer(0.5, function()
      -- function num : 0_23_0_0 , upvalues : self, _ENV, talkCharEntity, greetCfg, DormUtil, DormEnum
      self.__interactTimer = nil
      ;
      ((self.__greetEffect).transform):SetParent(nil)
      ;
      (self.__greetEffect):SetActive(false)
      local voiceId = ConfigData:GetVoicePointRandom(7)
      do
        if voiceId ~= nil then
          local cvCtrl = ControllerManager:GetController(ControllerTypeId.Cv, true)
          cvCtrl:PlayCv((talkCharEntity.heroData).dataId, voiceId)
        end
        talkCharEntity:AnimatorCrossFade(greetCfg.hero_action)
        ;
        (self.cmderEntity):AnimatorCrossFade(((DormUtil.GetDormCmderConfig)()).greet_action)
        self.__interactTimer = TimerManager:StartTimer(greetCfg.loop_time, function()
        -- function num : 0_23_0_0_0 , upvalues : self, _ENV, DormEnum, talkCharEntity
        self.__interactTimer = nil
        UIManager:ShowWindowOnly(UIWindowTypeID.TopStatus)
        UIManager:ShowWindowOnly(UIWindowTypeID.DormRoom)
        ;
        (self.__inputWindow):Show()
        self.__interactState = (DormEnum.CharInteractState).None
        talkCharEntity:AnimatorStand()
        ;
        (self.cmderEntity):AnimatorStand()
        ;
        (talkCharEntity.aiCtrl):RandNewAction()
      end
, nil, true)
      end
    end
, nil, true)
  end
, true)
end

DormCmderCtrl.StartDoorInteractAction = function(self, interactAction)
  -- function num : 0_24 , upvalues : DormEnum, _ENV
  self:__OnStartInteractAction()
  self.__interactState = (DormEnum.CharInteractState).LeaveDoor
  ;
  (self.cmderEntity):SetStarAIPathActive(false)
  ;
  ((self.cmderEntity).aiCtrl):StartVisitOtherRoom(function()
    -- function num : 0_24_0 , upvalues : _ENV, self
    UIManager:ShowWindowAsync(UIWindowTypeID.SceneChangesMask, function(win)
      -- function num : 0_24_0_0 , upvalues : self
      win:InitSceneChangesMask(function()
        -- function num : 0_24_0_0_0 , upvalues : self
        (self.cmderEntity):SetStarAIPathActive(true)
        ;
        ((self.dormCtrl).houseCtrl):RandEnterNextDormRoom()
      end
, function()
        -- function num : 0_24_0_0_1 , upvalues : self
        ((self.dormCtrl).roomCtrl):ShowDormRoomUI()
      end
)
    end
)
  end
)
end

DormCmderCtrl.OnDelete = function(self)
  -- function num : 0_25 , upvalues : _ENV
  MsgCenter:RemoveListener(eMsgEventId.OnDormCharacterOpChanged, self.__onRoomCharacterOpChanged)
  self:RemoveAllHightLightFnt()
  TimerManager:StopTimer(self.__checkTimerId)
  TimerManager:StopTimer(self.__interactTimer)
end

return DormCmderCtrl

