-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillLogicTimerCtrl = class("LuaSkillTimerCtrl")
local SkillLogicTimer = require("GamePlay.LogicTime.SkillLogicTimer")
SkillLogicTimerCtrl.ctor = function(self)
  -- function num : 0_0
  self.__pool = {}
  self.__logic_timer = {}
  self.__logic_toadd = {}
end

local InnerGetTimer = function(self, delay, func, obj, is_loop, start_time)
  -- function num : 0_1 , upvalues : _ENV, SkillLogicTimer
  local timer = nil
  if (table.length)(self.__pool) > 0 then
    timer = (table.remove)(self.__pool)
    if delay and func then
      timer:Init(delay, func, obj, is_loop, start_time)
    end
  else
    timer = (SkillLogicTimer.New)(delay, func, obj, is_loop, start_time)
  end
  return timer
end

local DelayRecycle = function(self, timers)
  -- function num : 0_2 , upvalues : _ENV
  for timer,_ in pairs(timers) do
    if timer:IsOver() then
      timer:Stop()
      ;
      (table.insert)(self.__pool, timer)
      timers[timer] = nil
      timer:RecycleInLuaSkill()
    end
  end
end

SkillLogicTimerCtrl.OnUpdateLogic = function(self)
  -- function num : 0_3 , upvalues : _ENV, DelayRecycle
  for timer,_ in pairs(self.__logic_toadd) do
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R6 in 'UnsetPending'

    (self.__logic_timer)[timer] = true
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (self.__logic_toadd)[timer] = nil
  end
  for timer,_ in pairs(self.__logic_timer) do
    timer:Update()
  end
  DelayRecycle(self, self.__logic_timer)
end

SkillLogicTimerCtrl.GetTimer = function(self, delay, func, obj, is_loop, start_time)
  -- function num : 0_4 , upvalues : InnerGetTimer
  local timer = InnerGetTimer(self, delay, func, obj, is_loop, start_time)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (self.__logic_toadd)[timer] = true
  return timer
end

local RecycleAllTimer = function(self, timers)
  -- function num : 0_5 , upvalues : _ENV
  for timer,_ in pairs(timers) do
    timer:Stop()
    ;
    (table.insert)(self.__pool, timer)
    timers[timer] = nil
  end
end

SkillLogicTimerCtrl.StopAllTimer = function(self)
  -- function num : 0_6 , upvalues : RecycleAllTimer
  RecycleAllTimer(self, self.__logic_toadd)
  RecycleAllTimer(self, self.__logic_timer)
end

return SkillLogicTimerCtrl

