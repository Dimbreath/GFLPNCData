-- params : ...
-- function num : 0 , upvalues : _ENV
local base = _G
local coroutine = require("coroutine")
local string = require("string")
local math = require("math")
local os = require("os")
local socket = require("socket")
local tp = require("socket.tp")
local ltn12 = require("ltn12")
local headers = require("socket.headers")
local mime = require("mime")
socket.smtp = {}
local _M = socket.smtp
_M.TIMEOUT = 60
_M.SERVER = "localhost"
_M.PORT = 25
_M.DOMAIN = (os.getenv)("SERVER_NAME") or "localhost"
_M.ZONE = "-0000"
local metat = {__index = {}} -- DECOMPILER ERROR at PC47: Confused about usage of register: R12 in 'UnsetPending'
;
(metat.__index).greet = function(self, domain)
    -- function num : 0_0 , upvalues : _M, socket
    (self.try)((self.tp):check("2.."));
    (self.try)((self.tp):command("EHLO", domain or _M.DOMAIN))
    return (socket.skip)(1, (self.try)((self.tp):check("2..")))
end -- DECOMPILER ERROR at PC50: Confused about usage of register: R12 in 'UnsetPending'
;
(metat.__index).mail = function(self, from)
    -- function num : 0_1
    (self.try)((self.tp):command("MAIL", "FROM:" .. from))
    return (self.try)((self.tp):check("2.."))
end -- DECOMPILER ERROR at PC53: Confused about usage of register: R12 in 'UnsetPending'
;
(metat.__index).rcpt = function(self, to)
    -- function num : 0_2
    (self.try)((self.tp):command("RCPT", "TO:" .. to))
    return (self.try)((self.tp):check("2.."))
end -- DECOMPILER ERROR at PC56: Confused about usage of register: R12 in 'UnsetPending'
;
(metat.__index).data = function(self, src, step)
    -- function num : 0_3
    (self.try)((self.tp):command("DATA"));
    (self.try)((self.tp):check("3.."));
    (self.try)((self.tp):source(src, step));
    (self.try)((self.tp):send("\r\n.\r\n"))
    return (self.try)((self.tp):check("2.."))
end -- DECOMPILER ERROR at PC59: Confused about usage of register: R12 in 'UnsetPending'
;
(metat.__index).quit = function(self)
    -- function num : 0_4
    (self.try)((self.tp):command("QUIT"))
    return (self.try)((self.tp):check("2.."))
end -- DECOMPILER ERROR at PC62: Confused about usage of register: R12 in 'UnsetPending'
;
(metat.__index).close = function(self)
    -- function num : 0_5
    return (self.tp):close()
end -- DECOMPILER ERROR at PC65: Confused about usage of register: R12 in 'UnsetPending'
;
(metat.__index).login = function(self, user, password)
    -- function num : 0_6 , upvalues : mime
    (self.try)((self.tp):command("AUTH", "LOGIN"));
    (self.try)((self.tp):check("3.."));
    (self.try)((self.tp):send((mime.b64)(user) .. "\r\n"));
    (self.try)((self.tp):check("3.."));
    (self.try)((self.tp):send((mime.b64)(password) .. "\r\n"))
    return (self.try)((self.tp):check("2.."))
end -- DECOMPILER ERROR at PC68: Confused about usage of register: R12 in 'UnsetPending'
;
(metat.__index).plain = function(self, user, password)
    -- function num : 0_7 , upvalues : mime
    local auth = "PLAIN " .. (mime.b64)("\000" .. user .. "\000" .. password);
    (self.try)((self.tp):command("AUTH", auth))
    return (self.try)((self.tp):check("2.."))
end -- DECOMPILER ERROR at PC71: Confused about usage of register: R12 in 'UnsetPending'
;
(metat.__index).auth = function(self, user, password, ext)
    -- function num : 0_8 , upvalues : string
    if not user or not password then return 1 end
    if (string.find)(ext, "AUTH[^\n]+LOGIN") then
        return self:login(user, password)
    else
        if (string.find)(ext, "AUTH[^\n]+PLAIN") then
            return self:plain(user, password)
        else

            (self.try)(nil, "authentication not supported")
        end
    end
end -- DECOMPILER ERROR at PC74: Confused about usage of register: R12 in 'UnsetPending'
;
(metat.__index).send = function(self, mailt)
    -- function num : 0_9 , upvalues : base, ltn12, mime
    self:mail(mailt.from)
    if (base.type)(mailt.rcpt) == "table" then
        for i, v in (base.ipairs)(mailt.rcpt) do self:rcpt(v) end
    else
        do
            self:rcpt(mailt.rcpt)
            self:data(((ltn12.source).chain)(mailt.source, (mime.stuff)()),
                      mailt.step)
        end
    end
end

_M.open = function(server, port, create)
    -- function num : 0_10 , upvalues : socket, tp, _M, base, metat
    local tp = (socket.try)((tp.connect)(server or _M.SERVER, port or _M.PORT,
                                         _M.TIMEOUT, create))
    local s = (base.setmetatable)({tp = tp}, metat)
    s.try = (socket.newtry)(function()
        -- function num : 0_10_0 , upvalues : s
        s:close()
    end)
    return s
end

local lower_headers = function(headers)
    -- function num : 0_11 , upvalues : base, string
    local lower = {}
    for i, v in (base.pairs)(headers or lower) do
        lower[(string.lower)(i)] = v
    end
    return lower
end

local seqno = 0
local newboundary = function()
    -- function num : 0_12 , upvalues : seqno, string, os, math
    seqno = seqno + 1
    return (string.format)("%s%05d==%05u", (os.date)("%d%m%Y%H%M%S"),
                           (math.random)(0, 99999), seqno)
end

local send_message = nil
local send_headers = function(tosend)
    -- function num : 0_13 , upvalues : headers, base, coroutine
    local canonic = headers.canonic
    local h = "\r\n"
    for f, v in (base.pairs)(tosend) do
        h = (canonic[f] or f) .. ": " .. v .. "\r\n" .. h
    end
    (coroutine.yield)(h)
end

local send_multipart = function(mesgt)
    -- function num : 0_14 , upvalues : newboundary, lower_headers, send_headers, coroutine, base, send_message
    local bd = newboundary()
    if not mesgt.headers then
        local headers = lower_headers({})
        headers["content-type"] = headers["content-type"] or "multipart/mixed"
        headers["content-type"] = headers["content-type"] .. "; boundary=\"" ..
                                      bd .. "\""
        send_headers(headers)
        if (mesgt.body).preamble then
            (coroutine.yield)((mesgt.body).preamble);
            (coroutine.yield)("\r\n")
        end
        for i, m in (base.ipairs)(mesgt.body) do
            (coroutine.yield)("\r\n--" .. bd .. "\r\n")
            send_message(m)
        end
        (coroutine.yield)("\r\n--" .. bd .. "--\r\n\r\n")
        if (mesgt.body).epilogue then
            (coroutine.yield)((mesgt.body).epilogue);
            (coroutine.yield)("\r\n")
        end
    end
end

local send_source = function(mesgt)
    -- function num : 0_15 , upvalues : lower_headers, send_headers, coroutine
    if not mesgt.headers then
        local headers = lower_headers({})
        headers["content-type"] = headers["content-type"] or
                                      "text/plain; charset=\"iso-8859-1\""
        send_headers(headers)
        while 1 do
            while 1 do
                while 1 do
                    local chunk, err = (mesgt.body)()
                    if err then
                        (coroutine.yield)(nil, err)
                        -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_THEN_STMT

                        -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_STMT

                    end
                end
                if chunk then
                    (coroutine.yield)(chunk)
                    -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_STMT

                end
            end
            break
        end
    end
end

local send_string = function(mesgt)
    -- function num : 0_16 , upvalues : lower_headers, send_headers, coroutine
    if not mesgt.headers then
        local headers = lower_headers({})
        headers["content-type"] = headers["content-type"] or
                                      "text/plain; charset=\"iso-8859-1\""
        send_headers(headers);
        (coroutine.yield)(mesgt.body)
    end
end

send_message = function(mesgt)
    -- function num : 0_17 , upvalues : base, send_multipart, send_source, send_string
    if (base.type)(mesgt.body) == "table" then
        send_multipart(mesgt)
    else
        if (base.type)(mesgt.body) == "function" then
            send_source(mesgt)
        else
            send_string(mesgt)
        end
    end
end

local adjust_headers = function(mesgt)
    -- function num : 0_18 , upvalues : lower_headers, os, _M, socket
    local lower = lower_headers(mesgt.headers)
    lower.date = (os.date)("!%a, %d %b %Y %H:%M:%S ") ..
                     (lower.date or mesgt.zone or _M.ZONE)
    lower["x-mailer"] = lower["x-mailer"] or socket._VERSION
    lower["mime-version"] = "1.0"
    return lower
end

_M.message = function(mesgt)
    -- function num : 0_19 , upvalues : adjust_headers, coroutine, send_message
    mesgt.headers = adjust_headers(mesgt)
    local co = (coroutine.create)(function()
        -- function num : 0_19_0 , upvalues : send_message, mesgt
        send_message(mesgt)
    end)
    return function()
        -- function num : 0_19_1 , upvalues : coroutine, co
        local ret, a, b = (coroutine.resume)(co)
        if ret then
            return a, b
        else
            return nil, a
        end
    end

end

_M.send = (socket.protect)(function(mailt)
    -- function num : 0_20 , upvalues : _M
    local s = (_M.open)(mailt.server, mailt.port, mailt.create)
    local ext = s:greet(mailt.domain)
    s:auth(mailt.user, mailt.password, ext)
    s:send(mailt)
    s:quit()
    return s:close()
end)
return _M

