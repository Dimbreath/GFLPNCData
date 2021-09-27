local EpSceneA = class("EpSceneA", EpSceneBase)
local base = EpSceneBase
local CS_CameraController = CS.CameraController
local CS_Ease = ((CS.DG).Tweening).Ease
local tl_Start = nil
EpSceneA.OnSceneLoadCompleted = function(self, onSceneLoadCompletedGeneral)
  -- function num : 0_0 , upvalues : base
  (base.OnSceneLoadCompleted)(self, onSceneLoadCompletedGeneral)
end

EpSceneA.InitTimeLineCtr = function(self)
  -- function num : 0_1 , upvalues : base, _ENV
  (base.InitTimeLineCtr)(self)
  if (self.bind).tl_Start_array ~= nil then
    for i = 1, #(self.bind).tl_Start_array do
      ((((self.bind).tl_Start_array)[i]).gameObject):SetActive(false)
    end
    ;
    (math.randomseed)((os.time)())
    local randomRes = (math.random)(1, #(self.bind).tl_Start_array)
    self.tl_Start = ((self.bind).tl_Start_array)[randomRes]
    ;
    ((self.tl_Start).gameObject):SetActive(true)
  else
    do
      self.tl_Start = (self.bind).tl_Start
      if self.tl_Start ~= nil then
        self._onSceneLoadedComplete = BindCallback(self, self.OnSceneLoadedComplete)
        ;
        (self.timeLineCtr):RegistTLEvent((TimeLineType.TLEventType).OnSceneLoadedTL, self.tl_Start, self._onSceneLoadedComplete)
      end
      if (self.bind).tl_EpToBattleLeft ~= nil then
        self._onReconnectToBattleComplete = BindCallback(self, self.OnReconnectToBattleComplete)
        ;
        (self.timeLineCtr):RegistTLEvent((TimeLineType.TLEventType).OnReconnectToBattleTL, (self.bind).tl_EpToBattleLeft, self._onReconnectToBattleComplete)
      end
      if (self.bind).tl_BattleToEp ~= nil then
        self._onExitBattleComplete = BindCallback(self, self.OnExitBattleComplete)
        ;
        (self.timeLineCtr):RegistTLEvent((TimeLineType.TLEventType).OnExitBattleTL, (self.bind).tl_BattleToEp, self._onExitBattleComplete)
      end
      if (self.bind).tl_BattleEndToBattle ~= nil then
        self._OnBattleEndToBattleComplete = BindCallback(self, self.OnBattleEndToBattleComplete)
        ;
        (self.timeLineCtr):RegistTLEvent((TimeLineType.TLEventType).OnBattleEndToBattle, (self.bind).tl_BattleEndToBattle, self._OnBattleEndToBattleComplete)
      end
      ;
      (base.RegistExpVcam)(self, (self.bind).vcam_Exploration)
      ;
      (base.RegistBattleVcam)(self, (self.bind).vcam_Battle)
      ;
      (base.RegistEpCamFollowTarget)(self, (self.bind).epCamFollowTarget)
    end
  end
end

EpSceneA.OnSceneLoadedPlay = function(self, onCompleteEvent)
  -- function num : 0_2 , upvalues : base
  self:InitEpCamNormal()
  self._onStartTimeLineCompleteEvent = onCompleteEvent
  ;
  (base.OnSceneLoadedPlay)(self)
end

EpSceneA.OnSceneLoadedComplete = function(self, playableDirector)
  -- function num : 0_3
  if playableDirector ~= self.tl_Start then
    return 
  end
  if self._onStartTimeLineCompleteEvent ~= nil then
    (self._onStartTimeLineCompleteEvent)()
  end
end

EpSceneA.OnStartBattlePlay = function(self, onCompleteEvent)
  -- function num : 0_4 , upvalues : base
  self._onStartBattleTimeLineCompleteEvent = onCompleteEvent
  ;
  (((self.bind).vcam_Battle).gameObject):SetActive(true)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.bind).battleCanvasGroup).alpha = 0
  ;
  (base.OnStartBattlePlay)(self)
end

EpSceneA.OnReconnectToBattlePlay = function(self, onCompleteEvent)
  -- function num : 0_5 , upvalues : base
  self._onReconnectToBattleCompleteEvent = onCompleteEvent
  ;
  (((self.bind).vcam_Battle).gameObject):SetActive(true)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.bind).battleCanvasGroup).alpha = 0
  ;
  (base.OnReconnectToBattlePlay)(self)
end

EpSceneA.OnReconnectToBattleComplete = function(self, playableDirector)
  -- function num : 0_6
  if playableDirector ~= (self.bind).tl_EpToBattleLeft then
    return 
  end
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.bind).battleCanvasGroup).alpha = 1
  ;
  (((self.bind).vcam_Exploration).gameObject):SetActive(false)
  if self._onReconnectToBattleCompleteEvent ~= nil then
    (self._onReconnectToBattleCompleteEvent)()
  end
end

EpSceneA.OnExitBattlePlay = function(self, onCompleteEvent)
  -- function num : 0_7 , upvalues : base
  self._onExitBattleCompleteEvent = onCompleteEvent
  ;
  (((self.bind).vcam_Exploration).gameObject):SetActive(true)
  ;
  (((self.bind).vcam_Battle).gameObject):SetActive(false)
  ;
  (base.OnExitBattlePlay)(self)
end

EpSceneA.OnExitBattleComplete = function(self, playableDirector)
  -- function num : 0_8
  if playableDirector ~= (self.bind).tl_BattleToEp then
    return 
  end
  if self._onExitBattleCompleteEvent ~= nil then
    (self._onExitBattleCompleteEvent)()
  end
end

EpSceneA.PlayBattleEndToBattle = function(self, onCompleteEvent)
  -- function num : 0_9 , upvalues : base
  self.__OnBattleEndToBattleEvent = onCompleteEvent
  ;
  (((self.bind).vcam_Exploration).gameObject):SetActive(false)
  ;
  (((self.bind).vcam_Battle).gameObject):SetActive(true)
  ;
  (base.OnBattleEndToBattlePlay)(self)
end

EpSceneA.OnBattleEndToBattleComplete = function(self, playableDirector)
  -- function num : 0_10
  if playableDirector ~= (self.bind).tl_BattleEndToBattle then
    return 
  end
  if self.__OnBattleEndToBattleEvent ~= nil then
    (self.__OnBattleEndToBattleEvent)()
  end
end

EpSceneA.CalculateExpToBattleNormalTL = function(self, dir)
  -- function num : 0_11 , upvalues : _ENV
  local tlIndex = 1
  if dir == 1 then
    tlIndex = (math.random)(1, #(self.bind).tl_EpToBattleRightUp)
    self._onStartBattleTL = ((self.bind).tl_EpToBattleRightUp)[tlIndex]
  else
    if dir == -1 then
      tlIndex = (math.random)(1, #(self.bind).tl_EpToBattleRightDown)
      self._onStartBattleTL = ((self.bind).tl_EpToBattleRightDown)[tlIndex]
    else
      self._onStartBattleTL = (self.bind).tl_EpToBattleBoss
    end
  end
  if self._onStartBattleComplete == nil then
    self._onStartBattleComplete = BindCallback(self, self.OnStartBattleComplete)
  end
  ;
  (self.timeLineCtr):RegistTLEvent((TimeLineType.TLEventType).OnStartBattleTL, self._onStartBattleTL, self._onStartBattleComplete)
  return tlIndex
end

EpSceneA.OnStartBattleComplete = function(self, playableDirector)
  -- function num : 0_12
  if playableDirector ~= self._onStartBattleTL then
    return 
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.bind).battleCanvasGroup).alpha = 1
  ;
  (((self.bind).vcam_Exploration).gameObject):SetActive(false)
  if self._onStartBattleTimeLineCompleteEvent ~= nil then
    (self._onStartBattleTimeLineCompleteEvent)()
  end
end

EpSceneA.GetBattleCanvasGroup = function(self)
  -- function num : 0_13
  return (self.bind).battleCanvasGroup
end

EpSceneA.GetMainCam = function(self)
  -- function num : 0_14
  return (self.bind).mainCamera
end

EpSceneA.GetBattleToMapLine = function(self)
  -- function num : 0_15
  return (self.bind).battleToMapLine
end

EpSceneA.InitEpCamNormal = function(self)
  -- function num : 0_16 , upvalues : _ENV, CS_CameraController
  local vcam_Exploration = self:GetExpVcam()
  local vcam_Battle = self:GetBattleVcam()
  self.__epCamOriginalPos = (vcam_Exploration.transform).position
  local roomRoot = (ExplorationManager.epCtrl):GetRoomRoot()
  local crossPos = self:__GetIntersectWithLineAndPlane(self.__epCamOriginalPos, (vcam_Exploration.transform).forward, (Vector3.New)(0, 1, 0), roomRoot.position)
  local followOffset = self.__epCamOriginalPos - crossPos
  self.__epCamFollowOriginalPos = crossPos
  ;
  (CS_CameraController.Instance):InitEpCam(self.__epCamFollowOriginalPos, followOffset)
  self:EpRoomCoverBattleMap()
  ;
  (vcam_Exploration.gameObject):SetActive(true)
  ;
  (vcam_Battle.gameObject):SetActive(false)
end

EpSceneA.EpRoomCoverBattleMap = function(self, withTween, tweenCompleteFunc, playerPos)
  -- function num : 0_17 , upvalues : _ENV, CS_Ease
  local roomRoot = ((self.sceneCtr).epCtrl):GetRoomRoot()
  do
    if playerPos == nil then
      local playerPosItem = (((self.sceneCtr).epCtrl).mapCtrl):GetPlayerPosItem()
      playerPos = (playerPosItem.transform).position
    end
    local opDetail = (((self.sceneCtr).epCtrl).dynPlayer):GetOperatorDetail()
    local mapPosOffset = Vector3.zero
    local curRoomData = ((self.sceneCtr).epCtrl):GetCurrentRoomData(true)
    if not curRoomData:IsCrossRoom() then
      mapPosOffset = (ConfigData.buildinConfig).EpMapPosOffset
    end
    if opDetail.state ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Secleted and not curRoomData:IsBossRoom() then
      playerPos = playerPos + mapPosOffset
    end
    local battleMapPos = Vector3.zero
    local direct = self.__epCamOriginalPos - battleMapPos
    local crossPos = self:__GetIntersectWithLineAndPlane(battleMapPos, direct, (Vector3.New)(0, 1, 0), roomRoot.position)
    local offset = crossPos - (playerPos)
    if withTween then
      ((roomRoot:DOMove(roomRoot.position + offset, (ConfigData.buildinConfig).EpMapMoveTweenDuration)):OnComplete(tweenCompleteFunc)):SetEase(CS_Ease.InOutQuad)
    else
      roomRoot.position = roomRoot.position + offset
    end
    if withTween then
      ((self:GetEpCamFollowTarget()):DOMove(self.__epCamFollowOriginalPos, (ConfigData.buildinConfig).EpMapMoveTweenDuration)):SetEase(CS_Ease.InOutQuad)
    else
      ;
      (self:GetEpCamFollowTarget()).position = self.__epCamFollowOriginalPos
    end
    ;
    (((self.sceneCtr).epCtrl).mapCtrl):OffsetMapRect(offset, self.__epCamFollowOriginalPos)
  end
end

EpSceneA.__GetIntersectWithLineAndPlane = function(self, point, direct, planeNormal, planePoint)
  -- function num : 0_18 , upvalues : _ENV
  local directNormal = (Vector3.Normalize)(direct)
  local result = (Vector3.Dot)(directNormal, planeNormal)
  if result == 0 then
    error("直线和平面平行")
    return 
  end
  local d = (Vector3.Dot)(planePoint - point, planeNormal) / result
  return directNormal * d + point
end

EpSceneA.OnDelete = function(self)
  -- function num : 0_19 , upvalues : base
  (base.OnDelete)(self)
  self._onStartTimeLineCompleteEvent = nil
  self._onStartBattleTimeLineCompleteEvent = nil
  self._onReconnectToBattleCompleteEvent = nil
  self._onExitBattleCompleteEvent = nil
  self._onStartTimelineComplete = nil
  self._onSceneLoadedComplete = nil
  self._onReconnectToBattleComplete = nil
  self._onExitBattleComplete = nil
  self._onStartBattleComplete = nil
end

return EpSceneA

