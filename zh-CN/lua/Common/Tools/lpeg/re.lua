local tonumber, type, print, error = tonumber, type, print, error
local setmetatable = setmetatable
local m = require("lpeg")
local mm = m
local mt = getmetatable((mm.P)(0))
local version = _VERSION
if version == "Lua 5.2" then
  _ENV = nil
end
local any = (m.P)(1)
local Predef = {nl = (m.P)("\n")}
local mem, fmem, gmem = nil, nil, nil
local updatelocale = function()
  -- function num : 0_0 , upvalues : mm, Predef, any, mem, fmem, gmem, setmetatable
  (mm.locale)(Predef)
  Predef.a = Predef.alpha
  Predef.c = Predef.cntrl
  Predef.d = Predef.digit
  Predef.g = Predef.graph
  Predef.l = Predef.lower
  Predef.p = Predef.punct
  Predef.s = Predef.space
  Predef.u = Predef.upper
  Predef.w = Predef.alnum
  Predef.x = Predef.xdigit
  Predef.A = any - Predef.a
  Predef.C = any - Predef.c
  Predef.D = any - Predef.d
  Predef.G = any - Predef.g
  Predef.L = any - Predef.l
  Predef.P = any - Predef.p
  Predef.S = any - Predef.s
  Predef.U = any - Predef.u
  Predef.W = any - Predef.w
  Predef.X = any - Predef.x
  mem = {}
  fmem = {}
  gmem = {}
  local mt = {__mode = "v"}
  setmetatable(mem, mt)
  setmetatable(fmem, mt)
  setmetatable(gmem, mt)
end

updatelocale()
local I = (m.P)(function(s, i)
  -- function num : 0_1 , upvalues : print
  print(i, s:sub(1, i - 1))
  return i
end
)
local getdef = function(id, defs)
  -- function num : 0_2 , upvalues : error
  if defs then
    local c = defs[id]
  end
  if not c then
    error("undefined name: " .. id)
  end
  return c
end

local patt_error = function(s, i)
  -- function num : 0_3 , upvalues : error
  if #s >= i + 20 or not s:sub(i) then
    local msg = s:sub(i, i + 20) .. "..."
  end
  msg = ("pattern error near \'%s\'"):format(msg)
  error(msg, 2)
end

local mult = function(p, n)
  -- function num : 0_4 , upvalues : mm
  local np = (mm.P)(true)
  while n >= 1 do
    if n % 2 >= 1 then
      np = np * p
    end
    p = p * p
    n = n / 2
  end
  return np
end

local equalcap = function(s, i, c)
  -- function num : 0_5 , upvalues : type
  if type(c) ~= "string" then
    return nil
  end
  local e = #c + i
  if s:sub(i, e - 1) == c then
    return e
  else
    return nil
  end
end

local S = Predef.space + "--" * any - Predef.nl ^ 0 ^ 0
local name = (m.R)("AZ", "az", "__") * (m.R)("AZ", "az", "__", "09") ^ 0
local arrow = S * "<-"
local seq_follow = (m.P)("/") + ")" + "}" + ":}" + "~}" + "|}" + name * arrow + -1
name = (m.C)(name)
local Def = name * (m.Carg)(1)
local num = (m.C)((m.R)("09") ^ 1) * S / tonumber
local String = "\'" * (m.C)(any - "\'" ^ 0) * "\'" + "\"" * (m.C)(any - "\"" ^ 0) * "\""
local defined = "%" * Def / function(c, Defs)
  -- function num : 0_6 , upvalues : Predef, error
  local cat = Defs and Defs[c] or Predef[c]
  if not cat then
    error("name \'" .. c .. "\' undefined")
  end
  return cat
end

local Range = (m.Cs)(any * ((m.P)("-") / "") * (any - "]")) / mm.R
local item = defined + Range + (m.C)(any)
local Class = "[" * (m.C)((m.P)("^") ^ -1) * (m.Cf)(item * item - "]" ^ 0, mt.__add) / function(c, p)
  -- function num : 0_7 , upvalues : any
  return c == "^" and any - p or p
end
 * "]"
local adddef = function(t, k, exp)
  -- function num : 0_8 , upvalues : error
  if t[k] then
    error("\'" .. k .. "\' already defined as a rule")
  else
    t[k] = exp
  end
  return t
end

local firstdef = function(n, r)
  -- function num : 0_9 , upvalues : adddef
  return adddef({n}, n, r)
end

local NT = function(n, b)
  -- function num : 0_10 , upvalues : error, mm
  if not b then
    error("rule \'" .. n .. "\' used outside a grammar")
  else
    return (mm.V)(n)
  end
end

local exp = (m.P)({"Exp"; Exp = S * ((m.V)("Grammar") + (m.Cf)((m.V)("Seq") * "/" * S * (m.V)("Seq") ^ 0, mt.__add)), Seq = (m.Cf)((m.Cc)((m.P)("")) * (m.V)("Prefix") ^ 0, mt.__mul) * (#seq_follow + patt_error), Prefix = "&" * S * (m.V)("Prefix") / mt.__len + "!" * S * (m.V)("Prefix") / mt.__unm + (m.V)("Suffix"), Suffix = (m.Cf)((m.V)("Primary") * S * ((m.P)("+") * (m.Cc)(1, mt.__pow) + (m.P)("*") * (m.Cc)(0, mt.__pow) + (m.P)("?") * (m.Cc)(-1, mt.__pow) + "^" * ((m.Cg)(num * (m.Cc)(mult)) + (m.Cg)((m.C)((m.S)("+-") * (m.R)("09") ^ 1) * (m.Cc)(mt.__pow))) + "->" * S * ((m.Cg)((String + num) * (m.Cc)(mt.__div)) + (m.P)("{}") * (m.Cc)(nil, m.Ct) + (m.Cg)(Def / getdef * (m.Cc)(mt.__div))) + "=>" * S * (m.Cg)(Def / getdef * (m.Cc)(m.Cmt))) * S ^ 0, function(a, b, f)
  -- function num : 0_11
  return f(a, b)
end
), Primary = "(" * (m.V)("Exp") * ")" + String / mm.P + Class + defined + "{:" * (name * ":" + (m.Cc)(nil)) * (m.V)("Exp") * ":}" / function(n, p)
  -- function num : 0_12 , upvalues : mm
  return (mm.Cg)(p, n)
end
 + "=" * name / function(n)
  -- function num : 0_13 , upvalues : mm, equalcap
  return (mm.Cmt)((mm.Cb)(n), equalcap)
end
 + (m.P)("{}") / mm.Cp + "{~" * (m.V)("Exp") * "~}" / mm.Cs + "{|" * (m.V)("Exp") * "|}" / mm.Ct + "{" * (m.V)("Exp") * "}" / mm.C + (m.P)(".") * (m.Cc)(any) + (name * -arrow + "<" * name * ">") * (m.Cb)("G") / NT, Definition = name * arrow * (m.V)("Exp"), Grammar = (m.Cg)((m.Cc)(true), "G") * (m.Cf)((m.V)("Definition") / firstdef * (m.Cg)((m.V)("Definition")) ^ 0, adddef) / mm.P})
local pattern = S * (m.Cg)((m.Cc)(false), "G") * exp / mm.P * (-any + patt_error)
local compile = function(p, defs)
  -- function num : 0_14 , upvalues : mm, pattern, error
  if (mm.type)(p) == "pattern" then
    return p
  end
  local cp = pattern:match(p, 1, defs)
  if not cp then
    error("incorrect pattern", 3)
  end
  return cp
end

local match = function(s, p, i)
  -- function num : 0_15 , upvalues : mem, compile
  local cp = mem[p]
  if not cp then
    cp = compile(p)
    mem[p] = cp
  end
  return cp:match(s, i or 1)
end

local find = function(s, p, i)
  -- function num : 0_16 , upvalues : fmem, compile, mm
  local cp = fmem[p]
  if not cp then
    cp = compile(p) / 0
    cp = (mm.P)({(mm.Cp)() * (cp) * (mm.Cp)() + 1 * (mm.V)(1)})
    fmem[p] = cp
  end
  local i, e = cp:match(s, i or 1)
  if i then
    return i, e - 1
  else
    return i
  end
end

local gsub = function(s, p, rep)
  -- function num : 0_17 , upvalues : gmem, compile, mm
  if not gmem[p] then
    local g = {}
  end
  gmem[p] = g
  local cp = g[rep]
  if not cp then
    cp = compile(p)
    cp = (mm.Cs)(cp / rep + 1 ^ 0)
    g[rep] = cp
  end
  return cp:match(s)
end

local re = {compile = compile, match = match, find = find, gsub = gsub, updatelocale = updatelocale}
if version == "Lua 5.1" then
  return re
end

