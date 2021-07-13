-- params : ...
-- function num : 0 , upvalues : _ENV
local string = require("string")
local base = _G
local table = require("table")
local socket = require("socket")
socket.url = {}
local _M = socket.url
_M._VERSION = "URL 1.0.3"
_M.escape = function(s)
  -- function num : 0_0 , upvalues : string
  return (string.gsub)(s, "([^A-Za-z0-9_])", function(c)
    -- function num : 0_0_0 , upvalues : string
    return (string.format)("%%%02x", (string.byte)(c))
  end
)
end

local make_set = function(t)
  -- function num : 0_1 , upvalues : base
  local s = {}
  for i,v in (base.ipairs)(t) do
    s[t[i]] = 1
  end
  return s
end

local segment_set = make_set({"-", "_", ".", "!", "~", "*", "\'", "(", ")", ":", "@", "&", "=", "+", "$", ","})
local protect_segment = function(s)
  -- function num : 0_2 , upvalues : string, segment_set
  return (string.gsub)(s, "([^A-Za-z0-9_])", function(c)
    -- function num : 0_2_0 , upvalues : segment_set, string
    if segment_set[c] then
      return c
    else
      return (string.format)("%%%02x", (string.byte)(c))
    end
  end
)
end

_M.unescape = function(s)
  -- function num : 0_3 , upvalues : string, base
  return (string.gsub)(s, "%%(%x%x)", function(hex)
    -- function num : 0_3_0 , upvalues : string, base
    return (string.char)((base.tonumber)(hex, 16))
  end
)
end

local absolute_path = function(base_path, relative_path)
  -- function num : 0_4 , upvalues : string
  if (string.sub)(relative_path, 1, 1) == "/" then
    return relative_path
  end
  local path = (string.gsub)(base_path, "[^/]*$", "")
  path = path .. relative_path
  path = (string.gsub)(path, "([^/]*%./)", function(s)
    -- function num : 0_4_0
    if s ~= "./" then
      return s
    else
      return ""
    end
  end
)
  path = (string.gsub)(path, "/%.$", "/")
  local reduced = nil
  while reduced ~= path do
    reduced = path
    path = (string.gsub)(reduced, "([^/]*/%.%./)", function(s)
    -- function num : 0_4_1
    if s ~= "../../" then
      return ""
    else
      return s
    end
  end
)
  end
  path = (string.gsub)(reduced, "([^/]*/%.%.)$", function(s)
    -- function num : 0_4_2
    if s ~= "../.." then
      return ""
    else
      return s
    end
  end
)
  return path
end

_M.parse = function(url, default)
  -- function num : 0_5 , upvalues : base, string
  local parsed = {}
  for i,v in (base.pairs)(default or parsed) do
    parsed[i] = v
  end
  do
    if not url or url == "" then
      return nil, "invalid url"
    end
    url = (string.gsub)(url, "#(.*)$", function(f)
    -- function num : 0_5_0 , upvalues : parsed
    parsed.fragment = f
    return ""
  end
)
    url = (string.gsub)(url, "^([%w][%w%+%-%.]*)%:", function(s)
    -- function num : 0_5_1 , upvalues : parsed
    parsed.scheme = s
    return ""
  end
)
    url = (string.gsub)(url, "^//([^/]*)", function(n)
    -- function num : 0_5_2 , upvalues : parsed
    parsed.authority = n
    return ""
  end
)
    url = (string.gsub)(url, "%?(.*)", function(q)
    -- function num : 0_5_3 , upvalues : parsed
    parsed.query = q
    return ""
  end
)
    url = (string.gsub)(url, "%;(.*)", function(p)
    -- function num : 0_5_4 , upvalues : parsed
    parsed.params = p
    return ""
  end
)
    if url ~= "" then
      parsed.path = url
    end
    local authority = parsed.authority
    if not authority then
      return parsed
    end
    authority = (string.gsub)(authority, "^([^@]*)@", function(u)
    -- function num : 0_5_5 , upvalues : parsed
    parsed.userinfo = u
    return ""
  end
)
    authority = (string.gsub)(authority, ":([^:%]]*)$", function(p)
    -- function num : 0_5_6 , upvalues : parsed
    parsed.port = p
    return ""
  end
)
    if not (string.match)(authority, "^%[(.+)%]$") then
      parsed.host = authority == "" or authority
      local userinfo = parsed.userinfo
      if not userinfo then
        return parsed
      end
      userinfo = (string.gsub)(userinfo, ":([^:]*)$", function(p)
    -- function num : 0_5_7 , upvalues : parsed
    parsed.password = p
    return ""
  end
)
      parsed.user = userinfo
      return parsed
    end
  end
end

_M.build = function(parsed)
  -- function num : 0_6 , upvalues : _M, string
  local ppath = (_M.parse_path)(parsed.path or "")
  local url = (_M.build_path)(ppath)
  if parsed.params then
    url = url .. ";" .. parsed.params
  end
  if parsed.query then
    url = url .. "?" .. parsed.query
  end
  local authority = parsed.authority
  if parsed.host then
    authority = parsed.host
    if (string.find)(authority, ":") then
      authority = "[" .. authority .. "]"
    end
    if parsed.port then
      authority = authority .. ":" .. parsed.port
    end
    local userinfo = parsed.userinfo
    if parsed.user then
      userinfo = parsed.user
      if parsed.password then
        userinfo = userinfo .. ":" .. parsed.password
      end
    end
    if userinfo then
      authority = userinfo .. "@" .. authority
    end
  end
  do
    if authority then
      url = "//" .. authority .. url
    end
    if parsed.scheme then
      url = parsed.scheme .. ":" .. url
    end
    if parsed.fragment then
      url = url .. "#" .. parsed.fragment
    end
    return url
  end
end

_M.absolute = function(base_url, relative_url)
  -- function num : 0_7 , upvalues : base, _M, absolute_path
  local base_parsed = nil
  if (base.type)(base_url) == "table" then
    base_parsed = base_url
    base_url = (_M.build)(base_parsed)
  else
    base_parsed = (_M.parse)(base_url)
  end
  local relative_parsed = (_M.parse)(relative_url)
  if not base_parsed then
    return relative_url
  else
    if not relative_parsed then
      return base_url
    else
      if relative_parsed.scheme then
        return relative_url
      else
        relative_parsed.scheme = base_parsed.scheme
        if not relative_parsed.authority then
          relative_parsed.authority = base_parsed.authority
          if not relative_parsed.path then
            relative_parsed.path = base_parsed.path
            if not relative_parsed.params then
              relative_parsed.params = base_parsed.params
              if not relative_parsed.query then
                relative_parsed.query = base_parsed.query
              end
            end
          else
            relative_parsed.path = absolute_path(base_parsed.path or "", relative_parsed.path)
          end
        end
        return (_M.build)(relative_parsed)
      end
    end
  end
end

_M.parse_path = function(path)
  -- function num : 0_8 , upvalues : string, table, _M
  local parsed = {}
  if not path then
    path = ""
  end
  ;
  (string.gsub)(path, "([^/]+)", function(s)
    -- function num : 0_8_0 , upvalues : table, parsed
    (table.insert)(parsed, s)
  end
)
  for i = 1, #parsed do
    parsed[i] = (_M.unescape)(parsed[i])
  end
  if (string.sub)(path, 1, 1) == "/" then
    parsed.is_absolute = 1
  end
  if (string.sub)(path, -1, -1) == "/" then
    parsed.is_directory = 1
  end
  return parsed
end

_M.build_path = function(parsed, unsafe)
  -- function num : 0_9 , upvalues : protect_segment
  local path = ""
  local n = #parsed
  if unsafe then
    for i = 1, n - 1 do
      path = path .. parsed[i]
      path = path .. "/"
    end
    if n > 0 then
      path = path .. parsed[n]
      if parsed.is_directory then
        path = path .. "/"
      end
    end
  else
    for i = 1, n - 1 do
      path = path .. protect_segment(parsed[i])
      path = path .. "/"
    end
    if n > 0 then
      path = path .. protect_segment(parsed[n])
      if parsed.is_directory then
        path = path .. "/"
      end
    end
  end
  if parsed.is_absolute then
    path = "/" .. path
  end
  return path
end

return _M

