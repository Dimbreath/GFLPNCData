local base = _G
local ltn12 = require("ltn12")
local mime = require("mime.core")
local io = require("io")
local string = require("string")
local _M = mime
local encodet, decodet, wrapt = {}, {}, {}
_M.encodet = encodet
_M.decodet = decodet
_M.wrapt = wrapt
local choose = function(table)
  -- function num : 0_0 , upvalues : base
  return function(name, opt1, opt2)
    -- function num : 0_0_0 , upvalues : base, table
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

encodet.base64 = function()
  -- function num : 0_1 , upvalues : ltn12, _M
  return ((ltn12.filter).cycle)(_M.b64, "")
end

encodet["quoted-printable"] = function(mode)
  -- function num : 0_2 , upvalues : ltn12, _M
  return ((ltn12.filter).cycle)(_M.qp, "", mode == "binary" and "=0D=0A" or "\r\n")
end

decodet.base64 = function()
  -- function num : 0_3 , upvalues : ltn12, _M
  return ((ltn12.filter).cycle)(_M.unb64, "")
end

decodet["quoted-printable"] = function()
  -- function num : 0_4 , upvalues : ltn12, _M
  return ((ltn12.filter).cycle)(_M.unqp, "")
end

local format = function(chunk)
  -- function num : 0_5 , upvalues : string
  if chunk then
    if chunk == "" then
      return "\'\'"
    else
      return (string.len)(chunk)
    end
  else
    return "nil"
  end
end

wrapt.text = function(length)
  -- function num : 0_6 , upvalues : ltn12, _M
  if not length then
    length = 76
  end
  return ((ltn12.filter).cycle)(_M.wrp, length, length)
end

wrapt.base64 = wrapt.text
wrapt.default = wrapt.text
wrapt["quoted-printable"] = function()
  -- function num : 0_7 , upvalues : ltn12, _M
  return ((ltn12.filter).cycle)(_M.qpwrp, 76, 76)
end

_M.encode = choose(encodet)
_M.decode = choose(decodet)
_M.wrap = choose(wrapt)
_M.normalize = function(marker)
  -- function num : 0_8 , upvalues : ltn12, _M
  return ((ltn12.filter).cycle)(_M.eol, 0, marker)
end

_M.stuff = function()
  -- function num : 0_9 , upvalues : ltn12, _M
  return ((ltn12.filter).cycle)(_M.dot, 2)
end

return _M

