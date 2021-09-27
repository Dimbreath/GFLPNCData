local SkillLogicTimer = class("SkillLogicTimer")
SkillLogicTimer.ctor = function(self, delay, func, obj, is_loop, start_time)
  -- function num : 0_0
  if delay and func then
    self:Init(delay, func, obj, is_loop, start_time)
  end
end

SkillLogicTimer.Init = function(self, delay, func, obj, is_loop, start_time)
  -- function num : 0_1 , upvalues : _ENV
  assert(type(delay) == "number" and delay >= 0)
  assert(func ~= nil)
  self.delay = delay
  self.func = func
  self.obj = obj
  self.is_loop = is_loop or 0
  self.started = false
  self.left = delay - (start_time or 0)
  self.over = false
  self.obj_not_nil = obj and true or false
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

SkillLogicTimer.Update = function(self)
  -- function num : 0_2
  if not self.started or self.over then
    return 
  end
  self.left = self.left - 1
  local timeup = self.left <= 0
  if timeup then
    if self.is_loop == 0 then
      self.over = true
    elseif self.is_loop > 0 then
      self.left = self.delay
      self.is_loop = self.is_loop - 1
    else
      self.left = self.delay
    end
    if self.obj_not_nil then
      (self.func)(self.obj)
    else
      (self.func)()
    end
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

SkillLogicTimer.Start = function(self)
  -- function num : 0_3
  if not self.started then
    self.started = true
  end
  return self
end

SkillLogicTimer.Stop = function(self)
  -- function num : 0_4
  self.left = 0
  self.is_loop = 0
  self.func = nil
  self.obj = nil
  self.started = false
  self.over = true
end

SkillLogicTimer.IsOver = function(self)
  -- function num : 0_5
  return self.over
end

SkillLogicTimer.InjectLuaSkill = function(self, luaSkill)
  -- function num : 0_6
  self.luaSkill = luaSkill
  ;
  (self.luaSkill):AddTimer(self)
end

SkillLogicTimer.RecycleInLuaSkill = function(self)
  -- function num : 0_7
  if self.luaSkill ~= nil then
    (self.luaSkill):RemoveTimer(self)
  end
end

return SkillLogicTimer

