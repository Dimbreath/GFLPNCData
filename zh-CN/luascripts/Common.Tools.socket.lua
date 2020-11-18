-- params : ...
-- function num : 0 , upvalues : _ENV
local base = _G
local string = require("string")
local math = require("math")
local socket = require("socket.core")
local _M = socket
_M.connect4 = function(address, port, laddress, lport)
  -- function num : 0_0 , upvalues : socket
  return (socket.connect)(address, port, laddress, lport, "inet")
end

_M.connect6 = function(address, port, laddress, lport)
  -- function num : 0_1 , upvalues : socket
  return (socket.connect)(address, port, laddress, lport, "inet6")
end

_M.bind = function(host, port, backlog)
  -- function num : 0_2 , upvalues : socket, base
  if host == "*" then
    host = "0.0.0.0"
  end
  local addrinfo, err = ((socket.dns).getaddrinfo)(host)
  if not addrinfo then
    return nil, err
  end
  local sock, res = nil, nil
  err = "no info on address"
  for i,alt in (base.ipairs)(addrinfo) do
    if alt.family == "inet" then
      sock = (socket.tcp4)()
    else
      -- DECOMPILER ERROR at PC28: Overwrote pending register: R4 in 'AssignReg'

      sock = (socket.tcp6)()
    end
    if not sock then
      return nil, err
    end
    sock:setoption("reuseaddr", true)
    -- DECOMPILER ERROR at PC43: Overwrote pending register: R4 in 'AssignReg'

    res = sock:bind(alt.addr, port)
    if not res then
      sock:close()
    else
      -- DECOMPILER ERROR at PC53: Overwrote pending register: R4 in 'AssignReg'

      res = sock:listen(backlog)
      if not res then
        sock:close()
      else
        return sock
      end
    end
  end
  return nil, err
end

_M.try = (_M.newtry)()
_M.choose = function(table)
  -- function num : 0_3 , upvalues : base
  return function(name, opt1, opt2)
    -- function num : 0_3_0 , upvalues : base, table
    if (base.type)(name) ~= "string" then
      name = "default"
    end
    local f = table[name or "nil"]
    if not f then
      (base.error)("unknown key (" .. (base.tostring)(name) .. ")", 3)
    else
      return f(opt1, opt2)
    end
  end

end

local sourcet, sinkt = {}, {}
_M.sourcet = sourcet
_M.sinkt = sinkt
_M.BLOCKSIZE = 2048
sinkt["close-when-done"] = function(sock)
  -- function num : 0_4 , upvalues : base
  return (base.setmetatable)({getfd = function()
    -- function num : 0_4_0 , upvalues : sock
    return sock:getfd()
  end
, dirty = function()
    -- function num : 0_4_1 , upvalues : sock
    return sock:dirty()
  end
}, {__call = function(self, chunk, err)
    -- function num : 0_4_2 , upvalues : sock
    if not chunk then
      sock:close()
      return 1
    else
      return sock:send(chunk)
    end
  end
})
end

sinkt["keep-open"] = function(sock)
  -- function num : 0_5 , upvalues : base
  return (base.setmetatable)({getfd = function()
    -- function num : 0_5_0 , upvalues : sock
    return sock:getfd()
  end
, dirty = function()
    -- function num : 0_5_1 , upvalues : sock
    return sock:dirty()
  end
}, {__call = function(self, chunk, err)
    -- function num : 0_5_2 , upvalues : sock
    if chunk then
      return sock:send(chunk)
    else
      return 1
    end
  end
})
end

sinkt.default = sinkt["keep-open"]
_M.sink = (_M.choose)(sinkt)
sourcet["by-length"] = function(sock, length)
  -- function num : 0_6 , upvalues : base, math, socket, string
  return (base.setmetatable)({getfd = function()
    -- function num : 0_6_0 , upvalues : sock
    return sock:getfd()
  end
, dirty = function()
    -- function num : 0_6_1 , upvalues : sock
    return sock:dirty()
  end
}, {__call = function()
    -- function num : 0_6_2 , upvalues : length, math, socket, sock, string
    if length <= 0 then
      return nil
    end
    local size = (math.min)(socket.BLOCKSIZE, length)
    local chunk, err = sock:receive(size)
    if err then
      return nil, err
    end
    length = length - (string.len)(chunk)
    return chunk
  end
})
end

sourcet["until-closed"] = function(sock)
  -- function num : 0_7 , upvalues : base, socket
  local done = nil
  return (base.setmetatable)({getfd = function()
    -- function num : 0_7_0 , upvalues : sock
    return sock:getfd()
  end
, dirty = function()
    -- function num : 0_7_1 , upvalues : sock
    return sock:dirty()
  end
}, {__call = function()
    -- function num : 0_7_2 , upvalues : done, sock, socket
    if done then
      return nil
    end
    local chunk, err, partial = sock:receive(socket.BLOCKSIZE)
    if not err then
      return chunk
    else
      if err == "closed" then
        sock:close()
        done = 1
        return partial
      else
        return nil, err
      end
    end
  end
})
end

sourcet.default = sourcet["until-closed"]
_M.source = (_M.choose)(sourcet)
return _M

