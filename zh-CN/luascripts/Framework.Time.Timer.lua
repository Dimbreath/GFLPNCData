-- params : ...
-- function num : 0 , upvalues : _ENV
local Timer = class("Timer")
Timer.ctor = function(self, delay, func, obj, one_shot, use_frame, unscaled)
  -- function num : 0_0
  if delay and func then
    self:Init(delay, func, obj, one_shot, use_frame, unscaled)
  end
end

Timer.Init = function(self, delay, func, obj, one_shot, use_frame, unscaled)
  -- function num : 0_1 , upvalues : _ENV
  assert(type(delay) == "number" and delay >= 0)
  assert(func ~= nil)
  self.delay = delay
  self.func = func
  self.obj = obj
  self.one_shot = one_shot
  self.use_frame = use_frame
  self.unscaled = unscaled
  self.started = false
  self.left = delay
  self.over = false
  self.obj_not_nil = obj and true or false
  self.start_frame_count = Time.frameCount
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

Timer.Update = function(self, is_fixed)
  -- function num : 0_2 , upvalues : _ENV
  if not self.started or self.over then
    return 
  end
  local timeup = false
  if self.start_frame_count + self.delay > Time.frameCount then
    timeup = not self.use_frame
    do
      local delta = nil
      if is_fixed then
        delta = Time.fixedDeltaTime
      elseif self.unscaled or not Time.deltaTime then
        delta = Time.unscaledDeltaTime
      end
      self.left = self.left - delta
      timeup = self.left <= 0
      -- DECOMPILER ERROR at PC58: Unhandled construct in 'MakeBoolean' P1

      if timeup and self.func ~= nil then
        if not self.one_shot then
          if not self.use_frame then
            self.left = self.delay + self.left
          end
          self.start_frame_count = Time.frameCount
        else
          self.over = true
        end
        local status, err = nil, nil
        if self.obj_not_nil then
          status = pcall(self.func, self.obj)
        else
          -- DECOMPILER ERROR at PC78: Overwrote pending register: R4 in 'AssignReg'

          status = pcall(self.func)
        end
        if not status then
          self.over = true
          error(err)
        end
      else
        self.over = true
      end
      -- DECOMPILER ERROR: 14 unprocessed JMP targets
    end
  end
end

Timer.Start = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if self.over then
    error("You can\'t start a overed timer, try add a new one!")
  end
  if not self.started then
    self.left = self.delay
    self.started = true
    self.start_frame_count = Time.frameCount
  end
  return self
end

Timer.Pause = function(self)
  -- function num : 0_4
  self.started = false
end

Timer.Resume = function(self)
  -- function num : 0_5
  self.started = true
end

Timer.Stop = function(self)
  -- function num : 0_6
  self.left = 0
  self.one_shot = false
  self.func = nil
  self.obj = nil
  self.use_frame = false
  self.unscaled = false
  self.started = false
  self.over = true
end

Timer.Reset = function(self)
  -- function num : 0_7 , upvalues : _ENV
  self.left = self.delay
  self.start_frame_count = Time.frameCount
end

Timer.IsOver = function(self)
  -- function num : 0_8
  if self.func == nil then
    return true
  end
  if self.obj_not_nil and self.func == nil then
    return true
  end
  return self.over
end

return Timer

-- params : ...
-- function num : 0 , upvalues : _ENV
local Timer = class("Timer")
Timer.ctor = function(self, delay, func, obj, one_shot, use_frame, unscaled)
    -- function num : 0_0
    if delay and func then
        self:Init(delay, func, obj, one_shot, use_frame, unscaled)
    end
end

Timer.Init = function(self, delay, func, obj, one_shot, use_frame, unscaled)
    -- function num : 0_1 , upvalues : _ENV
    assert(type(delay) == "number" and delay >= 0)
    assert(func ~= nil)
    self.delay = delay
    self.func = func
    self.obj = obj
    self.one_shot = one_shot
    self.use_frame = use_frame
    self.unscaled = unscaled
    self.started = false
    self.left = delay
    self.over = false
    self.obj_not_nil = obj and true or false
    self.start_frame_count = Time.frameCount
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

Timer.Update = function(self, is_fixed)
    -- function num : 0_2 , upvalues : _ENV
    if not self.started or self.over then return end
    local timeup = false
    if self.start_frame_count + self.delay > Time.frameCount then
        timeup = not self.use_frame
        do
            local delta = nil
            if is_fixed then
                delta = Time.fixedDeltaTime
            elseif self.unscaled or not Time.deltaTime then
                delta = Time.unscaledDeltaTime
            end
            self.left = self.left - delta
            timeup = self.left <= 0
            -- DECOMPILER ERROR at PC58: Unhandled construct in 'MakeBoolean' P1

            if timeup and self.func ~= nil then
                if not self.one_shot then
                    if not self.use_frame then
                        self.left = self.delay + self.left
                    end
                    self.start_frame_count = Time.frameCount
                else
                    self.over = true
                end
                local status, err = nil, nil
                if self.obj_not_nil then
                    status = pcall(self.func, self.obj)
                else
                    -- DECOMPILER ERROR at PC78: Overwrote pending register: R4 in 'AssignReg'

                    status = pcall(self.func)
                end
                if not status then
                    self.over = true
                    error(err)
                end
            else
                self.over = true
            end
            -- DECOMPILER ERROR: 14 unprocessed JMP targets
        end
    end
end

Timer.Start = function(self)
    -- function num : 0_3 , upvalues : _ENV
    if self.over then
        error("You can\'t start a overed timer, try add a new one!")
    end
    if not self.started then
        self.left = self.delay
        self.started = true
        self.start_frame_count = Time.frameCount
    end
    return self
end

Timer.Pause = function(self)
    -- function num : 0_4
    self.started = false
end

Timer.Resume = function(self)
    -- function num : 0_5
    self.started = true
end

Timer.Stop = function(self)
    -- function num : 0_6
    self.left = 0
    self.one_shot = false
    self.func = nil
    self.obj = nil
    self.use_frame = false
    self.unscaled = false
    self.started = false
    self.over = true
end

Timer.Reset = function(self)
    -- function num : 0_7 , upvalues : _ENV
    self.left = self.delay
    self.start_frame_count = Time.frameCount
end

Timer.IsOver = function(self)
    -- function num : 0_8
    if self.func == nil then return true end
    if self.obj_not_nil and self.func == nil then return true end
    return self.over
end

return Timer

