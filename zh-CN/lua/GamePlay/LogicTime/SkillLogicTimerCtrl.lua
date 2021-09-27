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
  if timers == nil or #timers <= 0 then
    return 
  end
  for i = #timers, 1, -1 do
    local curTimer = timers[i]
    if curTimer:IsOver() then
      curTimer:Stop()
      ;
      (table.insert)(self.__pool, curTimer)
      ;
      (table.remove)(timers, i)
      curTimer:RecycleInLuaSkill()
    end
  end
end

SkillLogicTimerCtrl.OnUpdateLogic = function(self)
  -- function num : 0_3 , upvalues : _ENV, DelayRecycle
  for i = #self.__logic_toadd, 1, -1 do
    (table.insert)(self.__logic_timer, (self.__logic_toadd)[i])
    ;
    (table.remove)(self.__logic_toadd, i)
  end
  for _,timer in ipairs(self.__logic_timer) do
    timer:Update()
  end
  DelayRecycle(self, self.__logic_timer)
end

SkillLogicTimerCtrl.GetTimer = function(self, delay, func, obj, is_loop, start_time)
  -- function num : 0_4 , upvalues : InnerGetTimer, _ENV
  local timer = InnerGetTimer(self, delay, func, obj, is_loop, start_time)
  ;
  (table.insert)(self.__logic_toadd, timer)
  return timer
end

local RecycleAllTimer = function(self, timers)
  -- function num : 0_5 , upvalues : _ENV
  for i = #timers, 1, -1 do
    (timers[i]):Stop()
    ;
    (table.insert)(self.__pool, timers[i])
    ;
    (table.remove)(timers, i)
  end
end

SkillLogicTimerCtrl.StopAllTimer = function(self)
  -- function num : 0_6 , upvalues : RecycleAllTimer
  RecycleAllTimer(self, self.__logic_toadd)
  RecycleAllTimer(self, self.__logic_timer)
end

return SkillLogicTimerCtrl

