-- params : ...
-- function num : 0 , upvalues : _ENV
local base = _G
local table = require("table")
local string = require("string")
local math = require("math")
local socket = require("socket")
local url = require("socket.url")
local tp = require("socket.tp")
local ltn12 = require("ltn12")
socket.ftp = {}
local _M = socket.ftp
_M.TIMEOUT = 60
local PORT = 21
_M.USER = "ftp"
_M.PASSWORD = "anonymous@anonymous.org"
local metat = {
__index = {}
}
_M.open = function(server, port, create)
  -- function num : 0_0 , upvalues : socket, tp, PORT, _M, base, metat
  local tp = (socket.try)((tp.connect)(server, port or PORT, _M.TIMEOUT, create))
  local f = (base.setmetatable)({tp = tp}, metat)
  f.try = (socket.newtry)(function()
    -- function num : 0_0_0 , upvalues : f
    f:close()
  end
)
  return f
end

-- DECOMPILER ERROR at PC36: Confused about usage of register: R11 in 'UnsetPending'

;
(metat.__index).portconnect = function(self)
  -- function num : 0_1 , upvalues : _M
  (self.try)((self.server):settimeout(_M.TIMEOUT))
  self.data = (self.try)((self.server):accept())
  ;
  (self.try)((self.data):settimeout(_M.TIMEOUT))
end

-- DECOMPILER ERROR at PC39: Confused about usage of register: R11 in 'UnsetPending'

;
(metat.__index).pasvconnect = function(self)
  -- function num : 0_2 , upvalues : socket, _M
  self.data = (self.try)((socket.tcp)())
  ;
  (self.try)((self.data):settimeout(_M.TIMEOUT))
  ;
  (self.try)((self.data):connect((self.pasvt).address, (self.pasvt).port))
end

-- DECOMPILER ERROR at PC42: Confused about usage of register: R11 in 'UnsetPending'

;
(metat.__index).login = function(self, user, password)
  -- function num : 0_3 , upvalues : _M
  ;
  (self.try)((self.tp):command("user", user or _M.USER))
  local code, reply = (self.try)((self.tp):check({"2..", 331}))
  if not password then
    (self.try)((self.tp):command("pass", code ~= 331 or _M.PASSWORD))
    ;
    (self.try)((self.tp):check("2.."))
    return 1
  end
end

-- DECOMPILER ERROR at PC45: Confused about usage of register: R11 in 'UnsetPending'

;
(metat.__index).pasv = function(self)
  -- function num : 0_4 , upvalues : socket, string
  (self.try)((self.tp):command("pasv"))
  local code, reply = (self.try)((self.tp):check("2.."))
  local pattern = "(%d+)%D(%d+)%D(%d+)%D(%d+)%D(%d+)%D(%d+)"
  local a, b, c, d, p1, p2 = (socket.skip)(2, (string.find)(reply, pattern))
  ;
  (self.try)(not a or not b or not c or not d or not p1 or p2, reply)
  self.pasvt = {address = (string.format)("%d.%d.%d.%d", a, b, c, d), port = p1 * 256 + p2}
  if self.server then
    (self.server):close()
    self.server = nil
  end
  return (self.pasvt).address, (self.pasvt).port
end

-- DECOMPILER ERROR at PC48: Confused about usage of register: R11 in 'UnsetPending'

;
(metat.__index).epsv = function(self)
  -- function num : 0_5 , upvalues : string
  (self.try)((self.tp):command("epsv"))
  local code, reply = (self.try)((self.tp):check("229"))
  local pattern = "%((.)(.-)%1(.-)%1(.-)%1%)"
  local d, prt, address, port = (string.match)(reply, pattern)
  ;
  (self.try)(port, "invalid epsv response")
  self.pasvt = {address = (self.tp):getpeername(), port = port}
  if self.server then
    (self.server):close()
    self.server = nil
  end
  return (self.pasvt).address, (self.pasvt).port
end

-- DECOMPILER ERROR at PC51: Confused about usage of register: R11 in 'UnsetPending'

;
(metat.__index).port = function(self, address, port)
  -- function num : 0_6 , upvalues : socket, _M, string
  self.pasvt = nil
  if not address then
    address = (self.try)((self.tp):getsockname())
    self.server = (self.try)((socket.bind)(address, 0))
    -- DECOMPILER ERROR at PC22: Overwrote pending register: R2 in 'AssignReg'

    address = (self.try)((self.server):getsockname())
    ;
    (self.try)((self.server):settimeout(_M.TIMEOUT))
  end
  local pl = port % 256
  local ph = (port - pl) / 256
  local arg = (string.gsub)((string.format)("%s,%d,%d", address, ph, pl), "%.", ",")
  ;
  (self.try)((self.tp):command("port", arg))
  ;
  (self.try)((self.tp):check("2.."))
  return 1
end

-- DECOMPILER ERROR at PC54: Confused about usage of register: R11 in 'UnsetPending'

;
(metat.__index).eprt = function(self, family, address, port)
  -- function num : 0_7 , upvalues : socket, _M, string
  self.pasvt = nil
  if not address then
    address = (self.try)((self.tp):getsockname())
    self.server = (self.try)((socket.bind)(address, 0))
    -- DECOMPILER ERROR at PC22: Overwrote pending register: R3 in 'AssignReg'

    address = (self.try)((self.server):getsockname())
    ;
    (self.try)((self.server):settimeout(_M.TIMEOUT))
  end
  local arg = (string.format)("|%s|%s|%d|", family, address, port)
  ;
  (self.try)((self.tp):command("eprt", arg))
  ;
  (self.try)((self.tp):check("2.."))
  return 1
end

-- DECOMPILER ERROR at PC57: Confused about usage of register: R11 in 'UnsetPending'

;
(metat.__index).send = function(self, sendt)
  -- function num : 0_8 , upvalues : url, string, ltn12, socket, tp
  if not self.pasvt then
    (self.try)(self.server, "need port or pasv first")
    if self.pasvt then
      self:pasvconnect()
    end
    if not sendt.path then
      local argument = (url.unescape)((string.gsub)(sendt.argument or "", "^[/\\]", ""))
      if argument == "" then
        argument = nil
      end
      local command = sendt.command or "stor"
      ;
      (self.try)((self.tp):command(command, argument))
      local code, reply = (self.try)((self.tp):check({"2..", "1.."}))
      if not self.pasvt then
        self:portconnect()
      end
      if not sendt.step then
        local step = (ltn12.pump).step
      end
      local readt = {self.tp}
      local checkstep = function(src, snk)
    -- function num : 0_8_0 , upvalues : socket, readt, tp, code, self, step
    local readyt = (socket.select)(readt, nil, 0)
    if readyt[tp] then
      code = (self.try)((self.tp):check("2.."))
    end
    return step(src, snk)
  end

      local sink = (socket.sink)("close-when-done", self.data)
      ;
      (self.try)(((ltn12.pump).all)(sendt.source, sink, checkstep))
      if (string.find)(code, "1..") then
        (self.try)((self.tp):check("2.."))
      end
      ;
      (self.data):close()
      local sent = (socket.skip)(1, (self.data):getstats())
      self.data = nil
      return sent
    end
  end
end

-- DECOMPILER ERROR at PC60: Confused about usage of register: R11 in 'UnsetPending'

;
(metat.__index).receive = function(self, recvt)
  -- function num : 0_9 , upvalues : url, string, socket, ltn12
  if not self.pasvt then
    (self.try)(self.server, "need port or pasv first")
    if self.pasvt then
      self:pasvconnect()
    end
    if not recvt.path then
      local argument = (url.unescape)((string.gsub)(recvt.argument or "", "^[/\\]", ""))
      if argument == "" then
        argument = nil
      end
      local command = recvt.command or "retr"
      ;
      (self.try)((self.tp):command(command, argument))
      local code, reply = (self.try)((self.tp):check({"1..", "2.."}))
      if code >= 200 and code <= 299 then
        (recvt.sink)(reply)
        return 1
      end
      if not self.pasvt then
        self:portconnect()
      end
      local source = (socket.source)("until-closed", self.data)
      if not recvt.step then
        local step = (ltn12.pump).step
      end
      ;
      (self.try)(((ltn12.pump).all)(source, recvt.sink, step))
      if (string.find)(code, "1..") then
        (self.try)((self.tp):check("2.."))
      end
      ;
      (self.data):close()
      self.data = nil
      return 1
    end
  end
end

-- DECOMPILER ERROR at PC63: Confused about usage of register: R11 in 'UnsetPending'

;
(metat.__index).cwd = function(self, dir)
  -- function num : 0_10
  (self.try)((self.tp):command("cwd", dir))
  ;
  (self.try)((self.tp):check(250))
  return 1
end

-- DECOMPILER ERROR at PC66: Confused about usage of register: R11 in 'UnsetPending'

;
(metat.__index).type = function(self, type)
  -- function num : 0_11
  (self.try)((self.tp):command("type", type))
  ;
  (self.try)((self.tp):check(200))
  return 1
end

-- DECOMPILER ERROR at PC69: Confused about usage of register: R11 in 'UnsetPending'

;
(metat.__index).greet = function(self)
  -- function num : 0_12 , upvalues : string
  local code = (self.try)((self.tp):check({"1..", "2.."}))
  if (string.find)(code, "1..") then
    (self.try)((self.tp):check("2.."))
  end
  return 1
end

-- DECOMPILER ERROR at PC72: Confused about usage of register: R11 in 'UnsetPending'

;
(metat.__index).quit = function(self)
  -- function num : 0_13
  (self.try)((self.tp):command("quit"))
  ;
  (self.try)((self.tp):check("2.."))
  return 1
end

-- DECOMPILER ERROR at PC75: Confused about usage of register: R11 in 'UnsetPending'

;
(metat.__index).close = function(self)
  -- function num : 0_14
  if self.data then
    (self.data):close()
  end
  if self.server then
    (self.server):close()
  end
  return (self.tp):close()
end

local override = function(t)
  -- function num : 0_15 , upvalues : url, base
  if t.url then
    local u = (url.parse)(t.url)
    for i,v in (base.pairs)(t) do
      u[i] = v
    end
    return u
  else
    do
      do return t end
    end
  end
end

local tput = function(putt)
  -- function num : 0_16 , upvalues : override, socket, _M
  putt = override(putt)
  ;
  (socket.try)(putt.host, "missing hostname")
  local f = (_M.open)(putt.host, putt.port, putt.create)
  f:greet()
  f:login(putt.user, putt.password)
  if putt.type then
    f:type(putt.type)
  end
  f:epsv()
  local sent = f:send(putt)
  f:quit()
  f:close()
  return sent
end

local default = {path = "/", scheme = "ftp"}
local genericform = function(u)
  -- function num : 0_17 , upvalues : socket, url, default, string
  local t = (socket.try)((url.parse)(u, default))
  ;
  (socket.try)(t.scheme == "ftp", "wrong scheme \'" .. t.scheme .. "\'")
  ;
  (socket.try)(t.host, "missing hostname")
  local pat = "^type=(.)$"
  if t.params then
    t.type = (socket.skip)(2, (string.find)(t.params, pat))
    ;
    (socket.try)(t.type == "a" or t.type == "i", "invalid type \'" .. t.type .. "\'")
  end
  do return t end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

_M.genericform = genericform
local sput = function(u, body)
  -- function num : 0_18 , upvalues : genericform, ltn12, tput
  local putt = genericform(u)
  putt.source = ((ltn12.source).string)(body)
  return tput(putt)
end

_M.put = (socket.protect)(function(putt, body)
  -- function num : 0_19 , upvalues : base, sput, tput
  if (base.type)(putt) == "string" then
    return sput(putt, body)
  else
    return tput(putt)
  end
end
)
local tget = function(gett)
  -- function num : 0_20 , upvalues : override, socket, _M
  gett = override(gett)
  ;
  (socket.try)(gett.host, "missing hostname")
  local f = (_M.open)(gett.host, gett.port, gett.create)
  f:greet()
  f:login(gett.user, gett.password)
  if gett.type then
    f:type(gett.type)
  end
  f:epsv()
  f:receive(gett)
  f:quit()
  return f:close()
end

local sget = function(u)
  -- function num : 0_21 , upvalues : genericform, ltn12, tget, table
  local gett = genericform(u)
  local t = {}
  gett.sink = ((ltn12.sink).table)(t)
  tget(gett)
  return (table.concat)(t)
end

_M.command = (socket.protect)(function(cmdt)
  -- function num : 0_22 , upvalues : override, socket, _M, _ENV
  cmdt = override(cmdt)
  ;
  (socket.try)(cmdt.host, "missing hostname")
  ;
  (socket.try)(cmdt.command, "missing command")
  local f = (_M.open)(cmdt.host, cmdt.port, cmdt.create)
  f:greet()
  f:login(cmdt.user, cmdt.password)
  if type(cmdt.command) == "table" then
    if not cmdt.argument then
      local argument = {}
    end
    if not cmdt.check then
      local check = {}
    end
    for i,cmd in ipairs(cmdt.command) do
      (f.try)((f.tp):command(cmd, argument[i]))
      if check[i] then
        (f.try)((f.tp):check(check[i]))
      end
    end
  else
    do
      ;
      (f.try)((f.tp):command(cmdt.command, cmdt.argument))
      if cmdt.check then
        (f.try)((f.tp):check(cmdt.check))
      end
      f:quit()
      return f:close()
    end
  end
end
)
_M.get = (socket.protect)(function(gett)
  -- function num : 0_23 , upvalues : base, sget, tget
  if (base.type)(gett) == "string" then
    return sget(gett)
  else
    return tget(gett)
  end
end
)
return _M

