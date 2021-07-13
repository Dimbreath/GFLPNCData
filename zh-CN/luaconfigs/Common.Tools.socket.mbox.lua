-- params : ...
-- function num : 0 , upvalues : _ENV
local _M = {}
if module then
  mbox = _M
end
_M.split_message = function(message_s)
  -- function num : 0_0 , upvalues : _ENV
  local message = {}
  message_s = (string.gsub)(message_s, "\r\n", "\n")
  ;
  (string.gsub)(message_s, "^(.-\n)\n", function(h)
    -- function num : 0_0_0 , upvalues : message
    message.headers = h
  end
)
  ;
  (string.gsub)(message_s, "^.-\n\n(.*)", function(b)
    -- function num : 0_0_1 , upvalues : message
    message.body = b
  end
)
  if not message.body then
    (string.gsub)(message_s, "^\n(.*)", function(b)
    -- function num : 0_0_2 , upvalues : message
    message.body = b
  end
)
  end
  if not message.headers and not message.body then
    message.headers = message_s
  end
  return message.headers or "", message.body or ""
end

_M.split_headers = function(headers_s)
  -- function num : 0_1 , upvalues : _ENV
  local headers = {}
  headers_s = (string.gsub)(headers_s, "\r\n", "\n")
  headers_s = (string.gsub)(headers_s, "\n[ ]+", " ")
  ;
  (string.gsub)("\n" .. headers_s, "\n([^\n]+)", function(h)
    -- function num : 0_1_0 , upvalues : _ENV, headers
    (table.insert)(headers, h)
  end
)
  return headers
end

_M.parse_header = function(header_s)
  -- function num : 0_2 , upvalues : _ENV
  header_s = (string.gsub)(header_s, "\n[ ]+", " ")
  header_s = (string.gsub)(header_s, "\n+", "")
  local _, __, name, value = (string.find)(header_s, "([^%s:]-):%s*(.*)")
  return name, value
end

_M.parse_headers = function(headers_s)
  -- function num : 0_3 , upvalues : _M, _ENV
  local headers_t = (_M.split_headers)(headers_s)
  local headers = {}
  for i = 1, #headers_t do
    local name, value = (_M.parse_header)(headers_t[i])
    if name then
      name = (string.lower)(name)
      if headers[name] then
        headers[name] = headers[name] .. ", " .. value
      else
        headers[name] = value
      end
    end
  end
  return headers
end

_M.parse_from = function(from)
  -- function num : 0_4 , upvalues : _ENV
  local _, __, name, address = (string.find)(from, "^%s*(.-)%s*%<(.-)%>")
  if not address then
    _ = (string.find)(from, "%s*(.+)%s*")
  end
  if not name then
    name = ""
  end
  -- DECOMPILER ERROR at PC20: Overwrote pending register: R4 in 'AssignReg'

  if address or name == "" then
    name = address
  end
  name = (string.gsub)(name, "\"", "")
  return name, address
end

_M.split_mbox = function(mbox_s)
  -- function num : 0_5 , upvalues : _ENV
  local mbox = {}
  mbox_s = (string.gsub)(mbox_s, "\r\n", "\n") .. "\n\nFrom \n"
  local nj, i, j = 1, 1, 1
  while 1 do
    i = (string.find)(mbox_s, "\n\nFrom .-\n", j)
    if i then
      do
        local message = (string.sub)(mbox_s, j, i - 1)
        ;
        (table.insert)(mbox, message)
        j = nj + 1
        -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC34: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  return mbox
end

_M.parse = function(mbox_s)
  -- function num : 0_6 , upvalues : _M
  local mbox = (_M.split_mbox)(mbox_s)
  for i = 1, #mbox do
    mbox[i] = (_M.parse_message)(mbox[i])
  end
  return mbox
end

_M.parse_message = function(message_s)
  -- function num : 0_7 , upvalues : _M
  local message = {}
  message.headers = (_M.split_message)(message_s)
  message.headers = (_M.parse_headers)(message.headers)
  return message
end

return _M

