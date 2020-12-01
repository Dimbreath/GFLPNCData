-- params : ...
-- function num : 0 , upvalues : _ENV
local base = _G
local string = require("string")
local socket = require("socket")
local ltn12 = require("ltn12")
socket.tp = {}
local _M = socket.tp
_M.TIMEOUT = 60
local get_reply = function(c)
  -- function num : 0_0 , upvalues : socket, string
  local code, current, sep = nil, nil, nil
  local line, err = c:receive()
  local reply = line
  if err then
    return nil, err
  end
  code = (socket.skip)(2, (string.find)(line, "^(%d%d%d)(.?)"))
  if not code then
    return nil, "invalid server reply"
  end
  repeat
    repeat
      if sep == "-" then
        line = c:receive()
        if err then
          return nil, err
        end
        -- DECOMPILER ERROR at PC41: Overwrote pending register: R3 in 'AssignReg'

        current = (socket.skip)(2, (string.find)(line, "^(%d%d%d)(.?)"))
        reply = reply .. "\n" .. line
      end
    until code == current
  until sep == " "
  return code, reply
end

local metat = {
__index = {}
}
-- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

;
(metat.__index).getpeername = function(self)
  -- function num : 0_1
  return (self.c):getpeername()
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R7 in 'UnsetPending'

;
(metat.__index).getsockname = function(self)
  -- function num : 0_2
  return (self.c):getpeername()
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'

;
(metat.__index).check = function(self, ok)
  -- function num : 0_3 , upvalues : get_reply, base, string
  local code, reply = get_reply(self.c)
  if not code then
    return nil, reply
  end
  if (base.type)(ok) ~= "function" then
    if (base.type)(ok) == "table" then
      for i,v in (base.ipairs)(ok) do
        if (string.find)(code, v) then
          return (base.tonumber)(code), reply
        end
      end
      return nil, reply
    else
      if (string.find)(code, ok) then
        return (base.tonumber)(code), reply
      else
        return nil, reply
      end
    end
  else
    return ok((base.tonumber)(code), reply)
  end
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'

;
(metat.__index).command = function(self, cmd, arg)
  -- function num : 0_4 , upvalues : string
  cmd = (string.upper)(cmd)
  if arg then
    return (self.c):send(cmd .. " " .. arg .. "\r\n")
  else
    return (self.c):send(cmd .. "\r\n")
  end
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R7 in 'UnsetPending'

;
(metat.__index).sink = function(self, snk, pat)
  -- function num : 0_5
  local chunk, err = (self.c):receive(pat)
  return snk(chunk, err)
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R7 in 'UnsetPending'

;
(metat.__index).send = function(self, data)
  -- function num : 0_6
  return (self.c):send(data)
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R7 in 'UnsetPending'

;
(metat.__index).receive = function(self, pat)
  -- function num : 0_7
  return (self.c):receive(pat)
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R7 in 'UnsetPending'

;
(metat.__index).getfd = function(self)
  -- function num : 0_8
  return (self.c):getfd()
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R7 in 'UnsetPending'

;
(metat.__index).dirty = function(self)
  -- function num : 0_9
  return (self.c):dirty()
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R7 in 'UnsetPending'

;
(metat.__index).getcontrol = function(self)
  -- function num : 0_10
  return self.c
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R7 in 'UnsetPending'

;
(metat.__index).source = function(self, source, step)
  -- function num : 0_11 , upvalues : socket, ltn12
  local sink = (socket.sink)("keep-open", self.c)
  if not step then
    local ret, err = ((ltn12.pump).all)(source, sink, (ltn12.pump).step)
    return ret, err
  end
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R7 in 'UnsetPending'

;
(metat.__index).close = function(self)
  -- function num : 0_12
  (self.c):close()
  return 1
end

_M.connect = function(host, port, timeout, create)
  -- function num : 0_13 , upvalues : socket, _M, base, metat
  local c, e = (create or socket.tcp)()
  if not c then
    return nil, e
  end
  c:settimeout(timeout or _M.TIMEOUT)
  local r, e = c:connect(host, port)
  if not r then
    c:close()
    return nil, e
  end
  return (base.setmetatable)({c = c}, metat)
end

return _M

-- params : ...
-- function num : 0 , upvalues : _ENV
local base = _G
local string = require("string")
local socket = require("socket")
local ltn12 = require("ltn12")
socket.tp = {}
local _M = socket.tp
_M.TIMEOUT = 60
local get_reply = function(c)
    -- function num : 0_0 , upvalues : socket, string
    local code, current, sep = nil, nil, nil
    local line, err = c:receive()
    local reply = line
    if err then return nil, err end
    code = (socket.skip)(2, (string.find)(line, "^(%d%d%d)(.?)"))
    if not code then return nil, "invalid server reply" end
    repeat
        repeat
            if sep == "-" then
                line = c:receive()
                if err then return nil, err end
                -- DECOMPILER ERROR at PC41: Overwrote pending register: R3 in 'AssignReg'

                current = (socket.skip)(2, (string.find)(line, "^(%d%d%d)(.?)"))
                reply = reply .. "\n" .. line
            end
        until code == current
    until sep == " "
    return code, reply
end

local metat = {__index = {}} -- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'
;
(metat.__index).getpeername = function(self)
    -- function num : 0_1
    return (self.c):getpeername()
end -- DECOMPILER ERROR at PC23: Confused about usage of register: R7 in 'UnsetPending'
;
(metat.__index).getsockname = function(self)
    -- function num : 0_2
    return (self.c):getpeername()
end -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'
;
(metat.__index).check = function(self, ok)
    -- function num : 0_3 , upvalues : get_reply, base, string
    local code, reply = get_reply(self.c)
    if not code then return nil, reply end
    if (base.type)(ok) ~= "function" then
        if (base.type)(ok) == "table" then
            for i, v in (base.ipairs)(ok) do
                if (string.find)(code, v) then
                    return (base.tonumber)(code), reply
                end
            end
            return nil, reply
        else
            if (string.find)(code, ok) then
                return (base.tonumber)(code), reply
            else
                return nil, reply
            end
        end
    else
        return ok((base.tonumber)(code), reply)
    end
end -- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'
;
(metat.__index).command = function(self, cmd, arg)
    -- function num : 0_4 , upvalues : string
    cmd = (string.upper)(cmd)
    if arg then
        return (self.c):send(cmd .. " " .. arg .. "\r\n")
    else
        return (self.c):send(cmd .. "\r\n")
    end
end -- DECOMPILER ERROR at PC32: Confused about usage of register: R7 in 'UnsetPending'
;
(metat.__index).sink = function(self, snk, pat)
    -- function num : 0_5
    local chunk, err = (self.c):receive(pat)
    return snk(chunk, err)
end -- DECOMPILER ERROR at PC35: Confused about usage of register: R7 in 'UnsetPending'
;
(metat.__index).send = function(self, data)
    -- function num : 0_6
    return (self.c):send(data)
end -- DECOMPILER ERROR at PC38: Confused about usage of register: R7 in 'UnsetPending'
;
(metat.__index).receive = function(self, pat)
    -- function num : 0_7
    return (self.c):receive(pat)
end -- DECOMPILER ERROR at PC41: Confused about usage of register: R7 in 'UnsetPending'
;
(metat.__index).getfd = function(self)
    -- function num : 0_8
    return (self.c):getfd()
end -- DECOMPILER ERROR at PC44: Confused about usage of register: R7 in 'UnsetPending'
;
(metat.__index).dirty = function(self)
    -- function num : 0_9
    return (self.c):dirty()
end -- DECOMPILER ERROR at PC47: Confused about usage of register: R7 in 'UnsetPending'
;
(metat.__index).getcontrol = function(self)
    -- function num : 0_10
    return self.c
end -- DECOMPILER ERROR at PC50: Confused about usage of register: R7 in 'UnsetPending'
;
(metat.__index).source = function(self, source, step)
    -- function num : 0_11 , upvalues : socket, ltn12
    local sink = (socket.sink)("keep-open", self.c)
    if not step then
        local ret, err = ((ltn12.pump).all)(source, sink, (ltn12.pump).step)
        return ret, err
    end
end -- DECOMPILER ERROR at PC53: Confused about usage of register: R7 in 'UnsetPending'
;
(metat.__index).close = function(self)
    -- function num : 0_12
    (self.c):close()
    return 1
end

_M.connect = function(host, port, timeout, create)
    -- function num : 0_13 , upvalues : socket, _M, base, metat
    local c, e = (create or socket.tcp)()
    if not c then return nil, e end
    c:settimeout(timeout or _M.TIMEOUT)
    local r, e = c:connect(host, port)
    if not r then
        c:close()
        return nil, e
    end
    return (base.setmetatable)({c = c}, metat)
end

return _M

