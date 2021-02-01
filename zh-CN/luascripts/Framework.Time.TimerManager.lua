-- params : ...
-- function num : 0 , upvalues : _ENV
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
end

local DelayRecycle = function(self, timers)
  -- function num : 0_1 , upvalues : _ENV
  for timer,_ in pairs(timers) do
    if timer:IsOver() then
      timer:Stop()
      ;
      (table.insert)(self.__pool, timer)
      timers[timer] = nil
    end
  end
end

local UpdateHandle = function(self)
  -- function num : 0_2 , upvalues : _ENV, DelayRecycle
  for timer,_ in pairs(self.__update_timer) do
    timer:Update(false)
  end
  DelayRecycle(self, self.__update_timer)
end

local LateUpdateHandle = function(self)
  -- function num : 0_3 , upvalues : _ENV, DelayRecycle
  for timer,_ in pairs(self.__lateupdate_timer) do
    timer:Update(false)
  end
  DelayRecycle(self, self.__lateupdate_timer)
  for timer,_ in pairs(self.__update_toadd) do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

    (self.__update_timer)[timer] = true
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.__update_toadd)[timer] = nil
  end
  for timer,_ in pairs(self.__lateupdate_toadd) do
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R6 in 'UnsetPending'

    (self.__lateupdate_timer)[timer] = true
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.__lateupdate_toadd)[timer] = nil
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
  for timer,_ in pairs(self.__fixedupdate_timer) do
    timer:Update(true)
  end
  DelayRecycle(self, self.__fixedupdate_timer)
  for timer,_ in pairs(self.__fixedupdate_toadd) do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

    (self.__fixedupdate_timer)[timer] = true
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.__fixedupdate_toadd)[timer] = nil
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

TimerManager.GetTimer = function(self, delay, func, obj, one_shot, use_frame, unscaled)
  -- function num : 0_9 , upvalues : _ENV, InnerGetTimer
  assert((not (self.__update_timer)[timer] and not (self.__update_toadd)[timer]))
  local timer = InnerGetTimer(self, delay, func, obj, one_shot, use_frame, unscaled)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self.__update_toadd)[timer] = true
  do return timer end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

TimerManager.GetLateTimer = function(self, delay, func, obj, one_shot, use_frame, unscaled)
  -- function num : 0_10 , upvalues : _ENV, InnerGetTimer
  assert((not (self.__lateupdate_timer)[timer] and not (self.__lateupdate_toadd)[timer]))
  local timer = InnerGetTimer(self, delay, func, obj, one_shot, use_frame, unscaled)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (self.__lateupdate_toadd)[timer] = true
  do return timer end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

TimerManager.GetFixedTimer = function(self, delay, func, obj, one_shot, use_frame)
  -- function num : 0_11 , upvalues : _ENV, InnerGetTimer
  assert((not (self.__fixedupdate_timer)[timer] and not (self.__fixedupdate_toadd)[timer]))
  local timer = InnerGetTimer(self, delay, func, obj, one_shot, use_frame, false)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (self.__fixedupdate_toadd)[timer] = true
  do return timer end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

TimerManager.AddLateCommand = function(self, func)
  -- function num : 0_12 , upvalues : _ENV
  (table.insert)(self.__lateCommand, func)
end

return TimerManager

