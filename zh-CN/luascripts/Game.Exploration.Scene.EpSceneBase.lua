-- params : ...
-- function num : 0 , upvalues : _ENV
local EpSceneBase = class("EpSceneBase")
local CS_GSceneManager_Ins = (CS.GSceneManager).Instance
local CS_CameraController = CS.CameraController
local epSceneTimeLineCtr = require("Game.Exploration.Scene.EpSceneTimeLineCtr")
EpSceneBase.ctor = function(self, sceneName, sceneCtr)
  -- function num : 0_0
  self.sceneName = sceneName
  self.sceneCtr = sceneCtr
end

EpSceneBase.OnSceneLoadCompleted = function(self, onCompletedGeneral)
  -- function num : 0_1 , upvalues : _ENV, CS_CameraController
  self.bind = {}
  ;
  (UIUtil.LuaUIBindingTable)(((CS_CameraController.Instance).transform).parent, self.bind)
  self:InitTimeLineCtr()
  if onCompletedGeneral ~= nil then
    onCompletedGeneral()
  end
end

EpSceneBase.LoadArenaSceneForce = function(self, onCompletedGeneral, onStartedGeneral)
  -- function num : 0_2 , upvalues : _ENV, CS_GSceneManager_Ins
  local _onSceneLoadCompleted = BindCallback(self, self.OnSceneLoadCompleted, onCompletedGeneral)
  CS_GSceneManager_Ins:LoadSceneAsyncByABEx(self.sceneName, true, false, _onSceneLoadCompleted, onStartedGeneral)
end

EpSceneBase.OnSceneLoadedPlay = function(self, onCompleteEvent)
  -- function num : 0_3
  (self.timeLineCtr):OnSceneLoaded()
end

EpSceneBase.EndOnSceneLoadedTimeLine = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (self.timeLineCtr):SkipTL((TimeLineType.TLEventType).OnSceneLoadedTL)
end

EpSceneBase.OnStartBattlePlay = function(self)
  -- function num : 0_5
  (self.timeLineCtr):OnStartBattle()
end

EpSceneBase.EndOnStartBattleTimeLine = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (self.timeLineCtr):SkipTL((TimeLineType.TLEventType).OnStartBattleTL)
end

EpSceneBase.OnReconnectToBattlePlay = function(self)
  -- function num : 0_7
  (self.timeLineCtr):OnReconnectToBattle()
end

EpSceneBase.EndOnReconnectToBattleTimeLine = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (self.timeLineCtr):SkipTL((TimeLineType.TLEventType).OnReconnectToBattleTL)
end

EpSceneBase.OnExitBattlePlay = function(self)
  -- function num : 0_9
  (self.timeLineCtr):OnExitBattle()
end

EpSceneBase.EndOnExitBattleTimeLine = function(self)
  -- function num : 0_10 , upvalues : _ENV
  (self.timeLineCtr):SkipTL((TimeLineType.TLEventType).OnExitBattleTL)
end

EpSceneBase.RegistExpVcam = function(self, expVcamm)
  -- function num : 0_11 , upvalues : _ENV
  (self.timeLineCtr):RegistVCam(VcamType.ExpVcam, expVcamm)
end

EpSceneBase.GetExpVcam = function(self)
  -- function num : 0_12 , upvalues : _ENV
  return ((self.timeLineCtr).VCamDic)[VcamType.ExpVcam]
end

EpSceneBase.RegistBattleVcam = function(self, btlVcam)
  -- function num : 0_13 , upvalues : _ENV
  (self.timeLineCtr):RegistVCam(VcamType.BtlVcam, btlVcam)
end

EpSceneBase.GetBattleVcam = function(self)
  -- function num : 0_14 , upvalues : _ENV
  return ((self.timeLineCtr).VCamDic)[VcamType.BtlVcam]
end

EpSceneBase.RegistEpCamFollowTarget = function(self, target)
  -- function num : 0_15 , upvalues : _ENV
  (self.timeLineCtr):RegistVCam(VcamType.MainCamFollow, target)
end

EpSceneBase.GetEpCamFollowTarget = function(self)
  -- function num : 0_16 , upvalues : _ENV
  return ((self.timeLineCtr).VCamDic)[VcamType.MainCamFollow]
end

EpSceneBase.GetBattleCanvasGroup = function(self)
  -- function num : 0_17
end

EpSceneBase.GetMainCam = function(self)
  -- function num : 0_18
end

EpSceneBase.GetBattleToMapLine = function(self)
  -- function num : 0_19
end

EpSceneBase.CalculateExpToBattleNormalTL = function(self)
  -- function num : 0_20
end

EpSceneBase.GetOnSceneLoadedTL = function(self)
  -- function num : 0_21 , upvalues : _ENV
  return (((self.timeLineCtr).TLEventDic)[(TimeLineType.TLEventType).OnSceneLoadedTL]).playableDirector
end

EpSceneBase.GetOnExitBattleTL = function(self)
  -- function num : 0_22 , upvalues : _ENV
  return (((self.timeLineCtr).TLEventDic)[(TimeLineType.TLEventType).OnExitBattleTL]).playableDirector
end

EpSceneBase.GetOnStartBattleTL = function(self)
  -- function num : 0_23 , upvalues : _ENV
  return (((self.timeLineCtr).TLEventDic)[(TimeLineType.TLEventType).OnStartBattleTL]).playableDirector
end

EpSceneBase.GetOnReconnectToBattleTL = function(self)
  -- function num : 0_24 , upvalues : _ENV
  return (((self.timeLineCtr).TLEventDic)[(TimeLineType.TLEventType).OnReconnectToBattleTL]).playableDirector
end

EpSceneBase.InitTimeLineCtr = function(self)
  -- function num : 0_25
  self.timeLineCtr = self:GetTimeLineCtr()
end

EpSceneBase.GetTimeLineCtr = function(self)
  -- function num : 0_26 , upvalues : epSceneTimeLineCtr
  return (epSceneTimeLineCtr.New)(self)
end

EpSceneBase.OnDelete = function(self)
  -- function num : 0_27
  self.sceneName = nil
  self.sceneCtr = nil
  ;
  (self.timeLineCtr):OnDelete()
end

return EpSceneBase

-- params : ...
-- function num : 0 , upvalues : _ENV
local EpSceneBase = class("EpSceneBase")
local CS_GSceneManager_Ins = (CS.GSceneManager).Instance
local CS_CameraController = CS.CameraController
local epSceneTimeLineCtr = require("Game.Exploration.Scene.EpSceneTimeLineCtr")
EpSceneBase.ctor = function(self, sceneName, sceneCtr)
    -- function num : 0_0
    self.sceneName = sceneName
    self.sceneCtr = sceneCtr
end

EpSceneBase.OnSceneLoadCompleted = function(self, onCompletedGeneral)
    -- function num : 0_1 , upvalues : _ENV, CS_CameraController
    self.bind = {};
    (UIUtil.LuaUIBindingTable)(
        ((CS_CameraController.Instance).transform).parent, self.bind)
    self:InitTimeLineCtr()
    if onCompletedGeneral ~= nil then onCompletedGeneral() end
end

EpSceneBase.LoadArenaSceneForce = function(self, onCompletedGeneral,
                                           onStartedGeneral)
    -- function num : 0_2 , upvalues : _ENV, CS_GSceneManager_Ins
    local _onSceneLoadCompleted = BindCallback(self, self.OnSceneLoadCompleted,
                                               onCompletedGeneral)
    CS_GSceneManager_Ins:LoadSceneAsyncByABEx(self.sceneName, true, false,
                                              _onSceneLoadCompleted,
                                              onStartedGeneral)
end

EpSceneBase.OnSceneLoadedPlay = function(self, onCompleteEvent)
    -- function num : 0_3
    (self.timeLineCtr):OnSceneLoaded()
end

EpSceneBase.EndOnSceneLoadedTimeLine = function(self)
    -- function num : 0_4 , upvalues : _ENV
    (self.timeLineCtr):SkipTL((TimeLineType.TLEventType).OnSceneLoadedTL)
end

EpSceneBase.OnStartBattlePlay = function(self)
    -- function num : 0_5
    (self.timeLineCtr):OnStartBattle()
end

EpSceneBase.EndOnStartBattleTimeLine = function(self)
    -- function num : 0_6 , upvalues : _ENV
    (self.timeLineCtr):SkipTL((TimeLineType.TLEventType).OnStartBattleTL)
end

EpSceneBase.OnReconnectToBattlePlay = function(self)
    -- function num : 0_7
    (self.timeLineCtr):OnReconnectToBattle()
end

EpSceneBase.EndOnReconnectToBattleTimeLine =
    function(self)
        -- function num : 0_8 , upvalues : _ENV
        (self.timeLineCtr):SkipTL(
            (TimeLineType.TLEventType).OnReconnectToBattleTL)
    end

EpSceneBase.OnExitBattlePlay = function(self)
    -- function num : 0_9
    (self.timeLineCtr):OnExitBattle()
end

EpSceneBase.EndOnExitBattleTimeLine = function(self)
    -- function num : 0_10 , upvalues : _ENV
    (self.timeLineCtr):SkipTL((TimeLineType.TLEventType).OnExitBattleTL)
end

EpSceneBase.RegistExpVcam = function(self, expVcamm)
    -- function num : 0_11 , upvalues : _ENV
    (self.timeLineCtr):RegistVCam(VcamType.ExpVcam, expVcamm)
end

EpSceneBase.GetExpVcam = function(self)
    -- function num : 0_12 , upvalues : _ENV
    return ((self.timeLineCtr).VCamDic)[VcamType.ExpVcam]
end

EpSceneBase.RegistBattleVcam = function(self, btlVcam)
    -- function num : 0_13 , upvalues : _ENV
    (self.timeLineCtr):RegistVCam(VcamType.BtlVcam, btlVcam)
end

EpSceneBase.GetBattleVcam = function(self)
    -- function num : 0_14 , upvalues : _ENV
    return ((self.timeLineCtr).VCamDic)[VcamType.BtlVcam]
end

EpSceneBase.RegistEpCamFollowTarget = function(self, target)
    -- function num : 0_15 , upvalues : _ENV
    (self.timeLineCtr):RegistVCam(VcamType.MainCamFollow, target)
end

EpSceneBase.GetEpCamFollowTarget = function(self)
    -- function num : 0_16 , upvalues : _ENV
    return ((self.timeLineCtr).VCamDic)[VcamType.MainCamFollow]
end

EpSceneBase.GetBattleCanvasGroup = function(self)
    -- function num : 0_17
end

EpSceneBase.GetMainCam = function(self)
    -- function num : 0_18
end

EpSceneBase.GetBattleToMapLine = function(self)
    -- function num : 0_19
end

EpSceneBase.CalculateExpToBattleNormalTL =
    function(self)
        -- function num : 0_20
    end

EpSceneBase.GetOnSceneLoadedTL = function(self)
    -- function num : 0_21 , upvalues : _ENV
    return
        (((self.timeLineCtr).TLEventDic)[(TimeLineType.TLEventType).OnSceneLoadedTL]).playableDirector
end

EpSceneBase.GetOnExitBattleTL = function(self)
    -- function num : 0_22 , upvalues : _ENV
    return
        (((self.timeLineCtr).TLEventDic)[(TimeLineType.TLEventType).OnExitBattleTL]).playableDirector
end

EpSceneBase.GetOnStartBattleTL = function(self)
    -- function num : 0_23 , upvalues : _ENV
    return
        (((self.timeLineCtr).TLEventDic)[(TimeLineType.TLEventType).OnStartBattleTL]).playableDirector
end

EpSceneBase.GetOnReconnectToBattleTL = function(self)
    -- function num : 0_24 , upvalues : _ENV
    return
        (((self.timeLineCtr).TLEventDic)[(TimeLineType.TLEventType).OnReconnectToBattleTL]).playableDirector
end

EpSceneBase.InitTimeLineCtr = function(self)
    -- function num : 0_25
    self.timeLineCtr = self:GetTimeLineCtr()
end

EpSceneBase.GetTimeLineCtr = function(self)
    -- function num : 0_26 , upvalues : epSceneTimeLineCtr
    return (epSceneTimeLineCtr.New)(self)
end

EpSceneBase.OnDelete = function(self)
    -- function num : 0_27
    self.sceneName = nil
    self.sceneCtr = nil;
    (self.timeLineCtr):OnDelete()
end

return EpSceneBase

