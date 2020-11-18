-- params : ...
-- function num : 0 , upvalues : _ENV
local EpSceneTimeLineCtr = class("EpSceneTimeLineCtr")
require("Common.TableUtil")
EpSceneTimeLineCtr.ctor = function(self, sceneEntity)
  -- function num : 0_0
  self.sceneEntity = sceneEntity
  self.TLEventDic = {}
  self.VCamDic = {}
end

EpSceneTimeLineCtr.OnCustomEvent = function(self, tlEventType)
  -- function num : 0_1 , upvalues : _ENV
  self:TLExecute(tlEventType, (TimeLineType.TLAction).Play)
end

EpSceneTimeLineCtr.OnSceneLoaded = function(self)
  -- function num : 0_2 , upvalues : _ENV
  self:TLExecute((TimeLineType.TLEventType).OnSceneLoadedTL, (TimeLineType.TLAction).Stop)
  self:TLExecute((TimeLineType.TLEventType).OnSceneLoadedTL, (TimeLineType.TLAction).Play)
end

EpSceneTimeLineCtr.OnStartBattle = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self:TLExecute((TimeLineType.TLEventType).OnStartBattleTL, (TimeLineType.TLAction).Stop)
  self:TLExecute((TimeLineType.TLEventType).OnStartBattleTL, (TimeLineType.TLAction).Play)
end

EpSceneTimeLineCtr.OnExitBattle = function(self)
  -- function num : 0_4 , upvalues : _ENV
  self:TLExecute((TimeLineType.TLEventType).OnExitBattleTL, (TimeLineType.TLAction).Stop)
  self:TLExecute((TimeLineType.TLEventType).OnExitBattleTL, (TimeLineType.TLAction).Play)
end

EpSceneTimeLineCtr.OnReconnectToBattle = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self:TLExecute((TimeLineType.TLEventType).OnReconnectToBattleTL, (TimeLineType.TLAction).Stop)
  self:TLExecute((TimeLineType.TLEventType).OnReconnectToBattleTL, (TimeLineType.TLAction).Play)
end

EpSceneTimeLineCtr.SkipTL = function(self, tlEventType)
  -- function num : 0_6
  local pbDirector = ((self.TLEventDic)[tlEventType]).playableDirector
  if pbDirector ~= nil then
    pbDirector.time = pbDirector.duration
  end
end

EpSceneTimeLineCtr.RegistVCam = function(self, vcamType, vcam)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self.VCamDic)[vcamType] = vcam
end

EpSceneTimeLineCtr.RegistTLEvent = function(self, tlEventType, plyDire, onComplete, onStart)
  -- function num : 0_8 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R5 in 'UnsetPending'

  (self.TLEventDic)[tlEventType] = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.TLEventDic)[tlEventType]).playableDirector = plyDire
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.TLEventDic)[tlEventType]).event = {}
  local TLEventTB = ((self.TLEventDic)[tlEventType]).event
  if onStart ~= nil then
    TLEventTB[(TimeLineType.EventTick).OnStarted] = onStart
    plyDire:played("-", TLEventTB[(TimeLineType.EventTick).OnStarted])
    plyDire:played("+", TLEventTB[(TimeLineType.EventTick).OnStarted])
  end
  if onComplete ~= nil then
    TLEventTB[(TimeLineType.EventTick).OnStopped] = onComplete
    plyDire:stopped("-", TLEventTB[(TimeLineType.EventTick).OnStopped])
    plyDire:stopped("+", TLEventTB[(TimeLineType.EventTick).OnStopped])
  end
end

EpSceneTimeLineCtr.RemoveTLEvent = function(self, tlEventType, eventTick)
  -- function num : 0_9 , upvalues : _ENV
  if (self.TLEventDic)[tlEventType] ~= nil then
    local tl = ((self.TLEventDic)[tlEventType]).playableDirector
    if ((self.TLEventDic)[tlEventType]).event ~= nil then
      local tlEvntTB = ((self.TLEventDic)[tlEventType]).event
      if tlEvntTB[eventTick] ~= nil then
        if eventTick == (TimeLineType.EventTick).OnStarted then
          tl:played("-", tlEvntTB[eventTick])
        else
          if eventTick == (TimeLineType.EventTick).OnStopped then
            tl:stopped("-", tlEvntTB[eventTick])
          end
        end
        -- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (((self.TLEventDic)[tlEventType]).event)[eventTick] = nil
      end
    end
  end
end

EpSceneTimeLineCtr.RemoveAllTLEvent = function(self, tlEventType)
  -- function num : 0_10 , upvalues : _ENV
  if (self.TLEventDic)[tlEventType] ~= nil then
    local tl = ((self.TLEventDic)[tlEventType]).playableDirector
    if ((self.TLEventDic)[tlEventType]).event ~= nil then
      local tlEvntTB = ((self.TLEventDic)[tlEventType]).event
      if tlEvntTB[(TimeLineType.EventTick).OnStarted] ~= nil then
        tl:played("-", tlEvntTB[(TimeLineType.EventTick).OnStarted])
      end
      if tlEvntTB[(TimeLineType.EventTick).OnStopped] ~= nil then
        tl:stopped("-", tlEvntTB[(TimeLineType.EventTick).OnStopped])
      end
      -- DECOMPILER ERROR at PC44: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (((self.TLEventDic)[tlEventType]).event)[tlEventType] = nil
    end
  end
end

EpSceneTimeLineCtr.TLExecute = function(self, tlEventType, TLActionType)
  -- function num : 0_11 , upvalues : _ENV
  if (self.TLEventDic)[tlEventType] ~= nil and ((self.TLEventDic)[tlEventType]).playableDirector ~= nil then
    if TLActionType == (TimeLineType.TLAction).Play then
      (((self.TLEventDic)[tlEventType]).playableDirector):Play()
    else
      if TLActionType == (TimeLineType.TLAction).Stop then
        (((self.TLEventDic)[tlEventType]).playableDirector):Stop()
      else
        if TLActionType == (TimeLineType.TLAction).Pause then
          (((self.TLEventDic)[tlEventType]).playableDirector):Pause()
        end
      end
    end
  end
end

EpSceneTimeLineCtr.TLSetTime = function(self, tlEventType, tarTime)
  -- function num : 0_12
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  if (self.TLEventDic)[tlEventType] ~= nil and ((self.TLEventDic)[tlEventType]).playableDirector ~= nil then
    (((self.TLEventDic)[tlEventType]).playableDirector).time = tarTime
  end
end

EpSceneTimeLineCtr.OnDelete = function(self)
  -- function num : 0_13 , upvalues : _ENV
  for k,v in pairs(self.TLEventDic) do
    self:RemoveAllTLEvent(k)
  end
  self.TLEventDic = table.emptytable
  self.VCamDic = table.emptytable
end

return EpSceneTimeLineCtr

