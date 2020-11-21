-- params : ...
-- function num : 0 , upvalues : _ENV
local EpSceneA = class("EpSceneA", EpSceneBase)
local base = EpSceneBase
local CS_CameraController = CS.CameraController
local CS_MathUtility = CS.MathUtility
local CS_PlayState_Playing = (((CS.UnityEngine).Playables).PlayState).Playing
EpSceneA.OnSceneLoadCompleted = function(self, onSceneLoadCompletedGeneral)
    -- function num : 0_0 , upvalues : base
    (base.OnSceneLoadCompleted)(self, onSceneLoadCompletedGeneral)
end

EpSceneA.InitTimeLineCtr = function(self)
    -- function num : 0_1 , upvalues : base, _ENV
    (base.InitTimeLineCtr)(self)
    if (self.bind).tl_Start ~= nil then
        self._onSceneLoadedComplete = BindCallback(self,
                                                   self.OnSceneLoadedComplete);
        (self.timeLineCtr):RegistTLEvent(
            (TimeLineType.TLEventType).OnSceneLoadedTL, (self.bind).tl_Start,
            self._onSceneLoadedComplete)
    end
    if (self.bind).tl_EpToBattleLeft ~= nil then
        self._onReconnectToBattleComplete =
            BindCallback(self, self.OnReconnectToBattleComplete);
        (self.timeLineCtr):RegistTLEvent(
            (TimeLineType.TLEventType).OnReconnectToBattleTL,
            (self.bind).tl_EpToBattleLeft, self._onReconnectToBattleComplete)
    end
    if (self.bind).tl_BattleToEp ~= nil then
        self._onExitBattleComplete = BindCallback(self,
                                                  self.OnExitBattleComplete);
        (self.timeLineCtr):RegistTLEvent(
            (TimeLineType.TLEventType).OnExitBattleTL,
            (self.bind).tl_BattleToEp, self._onExitBattleComplete)
    end
    (base.RegistExpVcam)(self, (self.bind).vcam_Exploration);
    (base.RegistBattleVcam)(self, (self.bind).vcam_Battle);
    (base.RegistEpCamFollowTarget)(self, (self.bind).epCamFollowTarget)
end

EpSceneA.OnSceneLoadedPlay = function(self, onCompleteEvent)
    -- function num : 0_2 , upvalues : base
    self._onStartTimeLineCompleteEvent = onCompleteEvent;
    (base.OnSceneLoadedPlay)(self)
end

EpSceneA.OnSceneLoadedComplete = function(self, playableDirector)
    -- function num : 0_3
    if playableDirector ~= (self.bind).tl_Start then return end
    if self._onStartTimeLineCompleteEvent ~= nil then
        (self._onStartTimeLineCompleteEvent)()
    end
end

EpSceneA.OnStartBattlePlay = function(self, onCompleteEvent)
    -- function num : 0_4 , upvalues : base
    self._onStartBattleTimeLineCompleteEvent = onCompleteEvent;
    (((self.bind).vcam_Battle).gameObject):SetActive(true) -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.bind).battleCanvasGroup).alpha = 0;
    (base.OnStartBattlePlay)(self)
end

EpSceneA.OnReconnectToBattlePlay = function(self, onCompleteEvent)
    -- function num : 0_5 , upvalues : base
    self._onReconnectToBattleCompleteEvent = onCompleteEvent;
    (((self.bind).vcam_Battle).gameObject):SetActive(true) -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.bind).battleCanvasGroup).alpha = 0;
    (base.OnReconnectToBattlePlay)(self)
end

EpSceneA.OnReconnectToBattleComplete = function(self, playableDirector)
    -- function num : 0_6
    if playableDirector ~= (self.bind).tl_EpToBattleLeft then return end -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'
    
    ((self.bind).battleCanvasGroup).alpha = 1;
    (((self.bind).vcam_Exploration).gameObject):SetActive(false)
    if self._onReconnectToBattleCompleteEvent ~= nil then
        (self._onReconnectToBattleCompleteEvent)()
    end
end

EpSceneA.OnExitBattlePlay = function(self, onCompleteEvent)
    -- function num : 0_7 , upvalues : base
    self._onExitBattleCompleteEvent = onCompleteEvent;
    (((self.bind).vcam_Exploration).gameObject):SetActive(true);
    (((self.bind).vcam_Battle).gameObject):SetActive(false);
    (base.OnExitBattlePlay)(self)
end

EpSceneA.OnExitBattleComplete = function(self, playableDirector)
    -- function num : 0_8
    if playableDirector ~= (self.bind).tl_BattleToEp then return end
    if self._onExitBattleCompleteEvent ~= nil then
        (self._onExitBattleCompleteEvent)()
    end
end

EpSceneA.CalculateExpToBattleNormalTL = function(self, isUp)
    -- function num : 0_9 , upvalues : _ENV
    local tlIndex = 1
    if isUp then
        tlIndex = (math.random)(1, #(self.bind).tl_EpToBattleRightUp)
        self._onStartBattleTL = ((self.bind).tl_EpToBattleRightUp)[tlIndex]
    else
        tlIndex = (math.random)(1, #(self.bind).tl_EpToBattleRightDown)
        self._onStartBattleTL = ((self.bind).tl_EpToBattleRightDown)[tlIndex]
    end
    if self._onStartBattleComplete == nil then
        self._onStartBattleComplete = BindCallback(self,
                                                   self.OnStartBattleComplete)
    end
    (self.timeLineCtr):RegistTLEvent((TimeLineType.TLEventType).OnStartBattleTL,
                                     self._onStartBattleTL,
                                     self._onStartBattleComplete)
    return tlIndex
end

EpSceneA.OnStartBattleComplete = function(self, playableDirector)
    -- function num : 0_10
    if playableDirector ~= self._onStartBattleTL then return end -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'
    
    ((self.bind).battleCanvasGroup).alpha = 1;
    (((self.bind).vcam_Exploration).gameObject):SetActive(false)
    if self._onStartBattleTimeLineCompleteEvent ~= nil then
        (self._onStartBattleTimeLineCompleteEvent)()
    end
end

EpSceneA.GetBattleCanvasGroup = function(self)
    -- function num : 0_11
    return (self.bind).battleCanvasGroup
end

EpSceneA.GetMainCam = function(self)
    -- function num : 0_12
    return (self.bind).mainCamera
end

EpSceneA.GetBattleToMapLine = function(self)
    -- function num : 0_13
    return (self.bind).battleToMapLine
end

EpSceneA.OnDelete = function(self)
    -- function num : 0_14 , upvalues : base
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

