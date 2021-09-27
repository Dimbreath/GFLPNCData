local Messenger = require("Framework.Common.Messenger")
local Timer = require("Framework.Time.Timer")
local TimerManager = class("TiemrManager")
TimerManager.ctor = function(self)
  -- function num : 0_0
  self.__update_handle = nil
  self.__lateupdate_handle = nil
  self.__fixedupdate_handle = nil
  self.__coupdate_handle = nil
  self.__colateupdate_handle = nil
  self.__cofixedupdate_handle = nil
  self.__update_timer = {}
  self.__lateupdate_timer = {}
  self.__fixedupdate_timer = {}
  self.__coupdate_timer = {}
  self.__colateupdate_timer = {}
  self.__cofixedupdate_timer = {}
  self.__pool = {}
  self.__update_toadd = {}
  self.__lateupdate_toadd = {}
  self.__fixedupdate_toadd = {}
  self.__coupdate_toadd = {}
  self.__colateupdate_toadd = {}
  self.__cofixedupdate_toadd = {}
  self.__lateCommand = {}
  self.started = false
  self.__incId = 0
end

local DelayRecycle = function(self, timers)
  -- function num : 0_1 , upvalues : _ENV
  for id,timer in pairs(timers) do
    if timer:IsOver() then
      timer:Stop()
      ;
      (table.insert)(self.__pool, timer)
      timers[id] = nil
    end
  end
end

local UpdateHandle = function(self)
  -- function num : 0_2 , upvalues : _ENV, DelayRecycle
  for id,timer in pairs(self.__update_timer) do
    timer:Update(false)
  end
  DelayRecycle(self, self.__update_timer)
end

local LateUpdateHandle = function(self)
  -- function num : 0_3 , upvalues : _ENV, DelayRecycle
  for id,timer in pairs(self.__lateupdate_timer) do
    timer:Update(false)
  end
  DelayRecycle(self, self.__lateupdate_timer)
  for id,timer in pairs(self.__update_toadd) do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

    (self.__update_timer)[id] = timer
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.__update_toadd)[id] = nil
  end
  for id,timer in pairs(self.__lateupdate_toadd) do
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R6 in 'UnsetPending'

    (self.__lateupdate_timer)[id] = timer
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.__lateupdate_toadd)[id] = nil
  end
  do
    while #self.__lateCommand > 0 do
      local func = (table.remove)(self.__lateCommand, 1)
      local status, err = pcall(func)
      if not status then
        error(err)
      end
    end
  end
end

local FixedUpdateHandle = function(self)
  -- function num : 0_4 , upvalues : _ENV, DelayRecycle
  for id,timer in pairs(self.__fixedupdate_timer) do
    timer:Update(true)
  end
  DelayRecycle(self, self.__fixedupdate_timer)
  for id,timer in pairs(self.__fixedupdate_toadd) do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

    (self.__fixedupdate_timer)[id] = timer
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.__fixedupdate_toadd)[id] = nil
  end
end

TimerManager.Start = function(self)
  -- function num : 0_5 , upvalues : _ENV, UpdateHandle, LateUpdateHandle, FixedUpdateHandle
  if self.started then
    return 
  end
  self.started = true
  self.__update_handle = UpdateBeat:CreateListener(UpdateHandle, self)
  self.__lateupdate_handle = LateUpdateBeat:CreateListener(LateUpdateHandle, self)
  self.__fixedupdate_handle = FixedUpdateBeat:CreateListener(FixedUpdateHandle, self)
  UpdateBeat:AddListener(self.__update_handle)
  LateUpdateBeat:AddListener(self.__lateupdate_handle)
  FixedUpdateBeat:AddListener(self.__fixedupdate_handle)
end

TimerManager.Stop = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if not self.started then
    return 
  end
  self.started = false
  if self.__update_handle ~= nil then
    UpdateBeat:RemoveListener(self.__update_handle)
    self.__update_handle = nil
  end
  if self.__lateupdate_handle ~= nil then
    LateUpdateBeat:RemoveListener(self.__lateupdate_handle)
    self.__lateupdate_handle = nil
  end
  if self.__fixedupdate_handle ~= nil then
    FixedUpdateBeat:RemoveListener(self.__fixedupdate_handle)
    self.__fixedupdate_handle = nil
  end
end

TimerManager.Cleanup = function(self, self)
  -- function num : 0_7
  self.__update_timer = {}
  self.__lateupdate_timer = {}
  self.__fixedupdate_timer = {}
  self.__pool = {}
  self.__update_toadd = {}
  self.__lateupdate_toadd = {}
  self.__fixedupdate_toadd = {}
end

local InnerGetTimer = function(self, delay, func, obj, one_shot, use_frame, unscaled)
  -- function num : 0_8 , upvalues : _ENV, Timer
  local timer = nil
  if (table.length)(self.__pool) > 0 then
    timer = (table.remove)(self.__pool)
    if delay and func then
      timer:Init(delay, func, obj, one_shot, use_frame, unscaled)
    end
  else
    timer = (Timer.New)(delay, func, obj, one_shot, use_frame, unscaled)
  end
  return timer
end

TimerManager.StartTimer = function(self, delay, func, obj, one_shot, use_frame, unscaled)
  -- function num : 0_9 , upvalues : _ENV, InnerGetTimer
  assert((not (self.__update_timer)[timer] and not (self.__update_toadd)[timer]))
  local timer = InnerGetTimer(self, delay, func, obj, one_shot, use_frame, unscaled)
  local id = self:__GenerateTimerId()
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (self.__update_toadd)[id] = timer
  timer:Start()
  do return id end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

TimerManager.StopTimer = function(self, id)
  -- function num : 0_10
  if id == nil then
    return true
  end
  local timer = self:__GetUpdateTimer(id)
  if timer ~= nil then
    timer:Stop()
    return true
  end
  return false
end

TimerManager.PauseTimer = function(self, id)
  -- function num : 0_11
  local timer = self:__GetUpdateTimer(id)
  if timer ~= nil then
    timer:Pause()
    return true
  end
  return false
end

TimerManager.ResumeTimer = function(self, id)
  -- function num : 0_12
  local timer = self:__GetUpdateTimer(id)
  if timer ~= nil then
    timer:Resume()
    return true
  end
  return false
end

TimerManager.ResetTimer = function(self, id)
  -- function num : 0_13
  local timer = self:__GetUpdateTimer(id)
  if timer ~= nil then
    timer:Reset()
    return true
  end
  return false
end

TimerManager.ContainTimer = function(self, id)
  -- function num : 0_14
  do return self:__GetUpdateTimer(id) ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

TimerManager.__GenerateTimerId = function(self)
  -- function num : 0_15
  self.__incId = self.__incId + 1
  return self.__incId
end

TimerManager.__GetUpdateTimer = function(self, id)
  -- function num : 0_16
  if id == nil then
    return nil
  end
  local timer = (self.__update_timer)[id]
  if timer ~= nil then
    return timer
  end
  timer = (self.__update_toadd)[id]
  return timer
end

TimerManager.AddLateCommand = function(self, func)
  -- function num : 0_17 , upvalues : _ENV
  (table.insert)(self.__lateCommand, func)
end

TimerManager.ClearCommand = function(self)
  -- function num : 0_18
  self.__lateCommand = {}
end

return TimerManager

