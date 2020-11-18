-- params : ...
-- function num : 0 , upvalues : _ENV
local socket = require("socket")
local url = require("socket.url")
local ltn12 = require("ltn12")
local mime = require("mime")
local string = require("string")
local headers = require("socket.headers")
local base = _G
local table = require("table")
socket.http = {}
local _M = socket.http
_M.TIMEOUT = 60
_M.USERAGENT = socket._VERSION
local SCHEMES = {http = true}
local PORT = 80
local receiveheaders = function(sock, headers)
  -- function num : 0_0 , upvalues : socket, string
  local line, name, value, err = nil, nil, nil, nil
  if not headers then
    headers = {}
  end
  line = sock:receive()
  if err then
    return nil, err
  end
  while 1 do
    while 1 do
      if line ~= "" then
        name = (socket.skip)(2, (string.find)(line, "^(.-):%s*(.*)"))
        if not name or not value then
          return nil, "malformed reponse headers"
        end
        name = (string.lower)(name)
        -- DECOMPILER ERROR at PC38: Overwrote pending register: R5 in 'AssignReg'

        line = sock:receive()
        if err then
          return nil, err
        end
        while 1 do
          -- DECOMPILER ERROR at PC53: Overwrote pending register: R4 in 'AssignReg'

          if (string.find)(line, "^%s") then
            line = sock:receive()
            if err then
              return nil, err
            end
            -- DECOMPILER ERROR at PC62: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC62: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
        if headers[name] then
          headers[name] = headers[name] .. ", " .. value
          -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC71: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    headers[name] = value
  end
  return headers
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R12 in 'UnsetPending'

;
(socket.sourcet)["http-chunked"] = function(sock, headers)
  -- function num : 0_1 , upvalues : base, string, receiveheaders
  return (base.setmetatable)({getfd = function()
    -- function num : 0_1_0 , upvalues : sock
    return sock:getfd()
  end
, dirty = function()
    -- function num : 0_1_1 , upvalues : sock
    return sock:dirty()
  end
}, {__call = function()
    -- function num : 0_1_2 , upvalues : sock, base, string, headers, receiveheaders
    local line, err = sock:receive()
    if err then
      return nil, err
    end
    local size = (base.tonumber)((string.gsub)(line, ";.*", ""), 16)
    if not size then
      return nil, "invalid chunk size"
    end
    if size > 0 then
      local chunk, err, part = sock:receive(size)
      if chunk then
        sock:receive()
      end
      return chunk, err
    else
      do
        headers = receiveheaders(sock, headers)
        if not headers then
          return nil, err
        end
      end
    end
  end
})
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R12 in 'UnsetPending'

;
(socket.sinkt)["http-chunked"] = function(sock)
  -- function num : 0_2 , upvalues : base, string
  return (base.setmetatable)({getfd = function()
    -- function num : 0_2_0 , upvalues : sock
    return sock:getfd()
  end
, dirty = function()
    -- function num : 0_2_1 , upvalues : sock
    return sock:dirty()
  end
}, {__call = function(self, chunk, err)
    -- function num : 0_2_2 , upvalues : sock, string
    if not chunk then
      return sock:send("0\r\n\r\n")
    end
    local size = (string.format)("%X\r\n", (string.len)(chunk))
    return sock:send(size .. chunk .. "\r\n")
  end
})
end

local metat = {
__index = {}
}
_M.open = function(host, port, create)
  -- function num : 0_3 , upvalues : socket, base, metat, _M, PORT
  local c = (socket.try)((create or socket.tcp)())
  local h = (base.setmetatable)({c = c}, metat)
  h.try = (socket.newtry)(function()
    -- function num : 0_3_0 , upvalues : h
    h:close()
  end
)
  ;
  (h.try)(c:settimeout(_M.TIMEOUT))
  ;
  (h.try)(c:connect(host, port or PORT))
  return h
end

-- DECOMPILER ERROR at PC45: Confused about usage of register: R13 in 'UnsetPending'

;
(metat.__index).sendrequestline = function(self, method, uri)
  -- function num : 0_4 , upvalues : string
  local reqline = (string.format)("%s %s HTTP/1.1\r\n", method or "GET", uri)
  return (self.try)((self.c):send(reqline))
end

-- DECOMPILER ERROR at PC48: Confused about usage of register: R13 in 'UnsetPending'

;
(metat.__index).sendheaders = function(self, tosend)
  -- function num : 0_5 , upvalues : headers, base
  local canonic = headers.canonic
  local h = "\r\n"
  for f,v in (base.pairs)(tosend) do
    h = (canonic[f] or f) .. ": " .. v .. "\r\n" .. h
  end
  ;
  (self.try)((self.c):send(h))
  return 1
end

-- DECOMPILER ERROR at PC51: Confused about usage of register: R13 in 'UnsetPending'

;
(metat.__index).sendbody = function(self, headers, source, step)
  -- function num : 0_6 , upvalues : ltn12, socket
  if not source then
    source = ((ltn12.source).empty)()
  end
  if not step then
    step = (ltn12.pump).step
  end
  local mode = "http-chunked"
  if headers["content-length"] then
    mode = "keep-open"
  end
  return (self.try)(((ltn12.pump).all)(source, (socket.sink)(mode, self.c), step))
end

-- DECOMPILER ERROR at PC54: Confused about usage of register: R13 in 'UnsetPending'

;
(metat.__index).receivestatusline = function(self)
  -- function num : 0_7 , upvalues : socket, string, base
  local status = (self.try)((self.c):receive(5))
  if status ~= "HTTP/" then
    return nil, status
  end
  status = (self.try)((self.c):receive("*l", status))
  local code = (socket.skip)(2, (string.find)(status, "HTTP/%d*%.%d* (%d%d%d)"))
  return (self.try)((base.tonumber)(code), status)
end

-- DECOMPILER ERROR at PC57: Confused about usage of register: R13 in 'UnsetPending'

;
(metat.__index).receiveheaders = function(self)
  -- function num : 0_8 , upvalues : receiveheaders
  return (self.try)(receiveheaders(self.c))
end

-- DECOMPILER ERROR at PC60: Confused about usage of register: R13 in 'UnsetPending'

;
(metat.__index).receivebody = function(self, headers, sink, step)
  -- function num : 0_9 , upvalues : ltn12, base, socket
  if not sink then
    sink = ((ltn12.sink).null)()
  end
  if not step then
    step = (ltn12.pump).step
  end
  local length = (base.tonumber)(headers["content-length"])
  local t = headers["transfer-encoding"]
  local mode = "default"
  if t and t ~= "identity" then
    mode = "http-chunked"
  else
    if (base.tonumber)(headers["content-length"]) then
      mode = "by-length"
    end
  end
  return (self.try)(((ltn12.pump).all)((socket.source)(mode, self.c, length), sink, step))
end

-- DECOMPILER ERROR at PC63: Confused about usage of register: R13 in 'UnsetPending'

;
(metat.__index).receive09body = function(self, status, sink, step)
  -- function num : 0_10 , upvalues : ltn12, socket
  local source = ((ltn12.source).rewind)((socket.source)("until-closed", self.c))
  source(status)
  return (self.try)(((ltn12.pump).all)(source, sink, step))
end

-- DECOMPILER ERROR at PC66: Confused about usage of register: R13 in 'UnsetPending'

;
(metat.__index).close = function(self)
  -- function num : 0_11
  return (self.c):close()
end

local adjusturi = function(reqt)
  -- function num : 0_12 , upvalues : _M, socket, url
  local u = reqt
  if not reqt.proxy and not _M.PROXY then
    u = {path = (socket.try)(reqt.path, "invalid path \'nil\'"), params = reqt.params, query = reqt.query, fragment = reqt.fragment}
  end
  return (url.build)(u)
end

local adjustproxy = function(reqt)
  -- function num : 0_13 , upvalues : _M, url
  local proxy = reqt.proxy or _M.PROXY
  if proxy then
    proxy = (url.parse)(proxy)
    return proxy.host, proxy.port or 3128
  else
    return reqt.host, reqt.port
  end
end

local adjustheaders = function(reqt)
  -- function num : 0_14 , upvalues : string, _M, mime, url, base
  local host = (string.gsub)(reqt.authority, "^.-@", "")
  local lower = {["user-agent"] = _M.USERAGENT, host = host, connection = "close, TE", te = "trailers"}
  if reqt.user and reqt.password then
    lower.authorization = "Basic " .. (mime.b64)(reqt.user .. ":" .. reqt.password)
  end
  local proxy = reqt.proxy or _M.PROXY
  if proxy then
    proxy = (url.parse)(proxy)
    if proxy.user and proxy.password then
      lower["proxy-authorization"] = "Basic " .. (mime.b64)(proxy.user .. ":" .. proxy.password)
    end
  end
  for i,v in (base.pairs)(reqt.headers or lower) do
    lower[(string.lower)(i)] = v
  end
  return lower
end

local default = {host = "", port = PORT, path = "/", scheme = "http"}
local adjustrequest = function(reqt)
  -- function num : 0_15 , upvalues : url, default, base, PORT, socket, adjusturi, adjustheaders, adjustproxy
  if not reqt.url or not (url.parse)(reqt.url, default) then
    local nreqt = {}
  end
  for i,v in (base.pairs)(reqt) do
    nreqt[i] = v
  end
  if nreqt.port == "" then
    nreqt.port = PORT
  end
  if not nreqt.host or nreqt.host == "" then
    (socket.try)(nil, "invalid host \'" .. (base.tostring)(nreqt.host) .. "\'")
  end
  if not reqt.uri then
    nreqt.uri = adjusturi(nreqt)
    nreqt.headers = adjustheaders(nreqt)
    nreqt.host = adjustproxy(nreqt)
    return nreqt
  end
end

local shouldredirect = function(reqt, code, headers)
  -- function num : 0_16 , upvalues : string, SCHEMES
  local location = headers.location
  if not location then
    return false
  end
  location = (string.gsub)(location, "%s", "")
  if location == "" then
    return false
  end
  local scheme = (string.match)(location, "^([%w][%w%+%-%.]*)%:")
  if scheme and not SCHEMES[scheme] then
    return false
  end
  -- DECOMPILER ERROR at PC52: Unhandled construct in 'MakeBoolean' P3

  do return reqt.redirect ~= false and ((code == 301 or code == 302 or code == 303 or code == 307) and reqt.method and reqt.method ~= "GET" and reqt.nredirects and reqt.nredirects < 5) end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

local shouldreceivebody = function(reqt, code)
  -- function num : 0_17
  if reqt.method == "HEAD" then
    return nil
  end
  if code == 204 or code == 304 then
    return nil
  end
  if code >= 100 and code < 200 then
    return nil
  end
  return 1
end

local trequest, tredirect = nil, nil
tredirect = function(reqt, location)
  -- function num : 0_18 , upvalues : trequest, url
  local result, code, headers, status = trequest({url = (url.absolute)(reqt.url, location), source = reqt.source, sink = reqt.sink, headers = reqt.headers, proxy = reqt.proxy, nredirects = (reqt.nredirects or 0) + 1, create = reqt.create})
  if not headers then
    headers = {}
  end
  headers.location = headers.location or location
  return result, code, headers, status
end

trequest = function(reqt)
  -- function num : 0_19 , upvalues : adjustrequest, _M, shouldredirect, tredirect, shouldreceivebody
  local nreqt = adjustrequest(reqt)
  local h = (_M.open)(nreqt.host, nreqt.port, nreqt.create)
  h:sendrequestline(nreqt.method, nreqt.uri)
  h:sendheaders(nreqt.headers)
  if nreqt.source then
    h:sendbody(nreqt.headers, nreqt.source, nreqt.step)
  end
  local code, status = h:receivestatusline()
  if not code then
    h:receive09body(status, nreqt.sink, nreqt.step)
    return 1, 200
  end
  local headers = nil
  while code == 100 do
    headers = h:receiveheaders()
    code = h:receivestatusline()
  end
  headers = h:receiveheaders()
  if shouldredirect(nreqt, code, headers) and not nreqt.source then
    h:close()
    return tredirect(reqt, headers.location)
  end
  if shouldreceivebody(nreqt, code) then
    h:receivebody(headers, nreqt.sink, nreqt.step)
  end
  h:close()
  return 1, code, headers, status
end

local genericform = function(u, b)
  -- function num : 0_20 , upvalues : ltn12, string
  local t = {}
  local reqt = {url = u, sink = ((ltn12.sink).table)(t), target = t}
  if b then
    reqt.source = ((ltn12.source).string)(b)
    reqt.headers = {["content-length"] = (string.len)(b), ["content-type"] = "application/x-www-form-urlencoded"}
    reqt.method = "POST"
  end
  return reqt
end

_M.genericform = genericform
local srequest = function(u, b)
  -- function num : 0_21 , upvalues : genericform, trequest, table
  local reqt = genericform(u, b)
  local _, code, headers, status = trequest(reqt)
  return (table.concat)(reqt.target), code, headers, status
end

_M.request = (socket.protect)(function(reqt, body)
  -- function num : 0_22 , upvalues : base, srequest, trequest
  if (base.type)(reqt) == "string" then
    return srequest(reqt, body)
  else
    return trequest(reqt)
  end
end
)
return _M

