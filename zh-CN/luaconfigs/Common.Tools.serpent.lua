-- params : ...
-- function num : 0 , upvalues : _ENV
local n, v = "serpent", "0.30"
local c, d = "Paul Kulchenko", "Lua serializer and pretty printer"
local snum = {[tostring(1 / 0)] = "1/0 --[[math.huge]]", [tostring(-1 / 0)] = "-1/0 --[[-math.huge]]", [tostring(0 / 0)] = "0/0"}
local badtype = {thread = true, userdata = true, cdata = true}
local getmetatable = debug and debug.getmetatable or getmetatable
local pairs = function(t)
  -- function num : 0_0 , upvalues : _ENV
  return next, t
end

local keyword, globals, G = {}, {}, _G or _ENV
for _,k in ipairs({"and", "break", "do", "else", "elseif", "end", "false", "for", "function", "goto", "if", "in", "local", "nil", "not", "or", "repeat", "return", "then", "true", "until", "while"}) do
  keyword[k] = true
end
for k,v in pairs(G) do
  globals[v] = k
end
for _,g in ipairs({"coroutine", "debug", "io", "math", "string", "table", "os"}) do
  if type(G[g]) ~= "table" or not G[g] then
    for k,v in pairs({}) do
      globals[v] = g .. "." .. k
    end
    do
      -- DECOMPILER ERROR at PC104: LeaveBlock: unexpected jumping out IF_THEN_STMT

      -- DECOMPILER ERROR at PC104: LeaveBlock: unexpected jumping out IF_STMT

    end
  end
end
local s = function(t, opts)
  -- function num : 0_1 , upvalues : _ENV, snum, globals, keyword, getmetatable, pairs, badtype
  local name, indent, fatal, maxnum = opts.name, opts.indent, opts.fatal, opts.maxnum
  local sparse, custom, huge = opts.sparse, opts.custom, not opts.nohuge
  if not opts.maxlevel then
    local space, maxl = opts.compact and "" or " ", math.huge
  end
  local maxlen, metatostring = tonumber(opts.maxlength), opts.metatostring
  if opts.comment and not tonumber(opts.comment) then
    local iname, comm = "_" .. (name or ""), math.huge
  end
  local numformat = opts.numformat or "%.17g"
  local seen, sref, syms, symn = {}, {"local " .. iname .. "={}"}, {}, 0
  local gensym = function(val)
    -- function num : 0_1_0 , upvalues : _ENV, syms, symn
    return "_" .. ((tostring(tostring(val))):gsub("[^%w]", "")):gsub("(%d%w+)", function(s)
      -- function num : 0_1_0_0 , upvalues : syms, symn, _ENV
      if not syms[s] then
        symn = symn + 1
        syms[s] = symn
      end
      return tostring(syms[s])
    end
)
  end

  local safestr = function(s)
    -- function num : 0_1_1 , upvalues : _ENV, huge, snum, numformat
    if (type(s) ~= "number" or ((huge and snum[tostring(s)]) or not tostring(numformat:format(s))) and (type(s) == "string" or not tostring(s))) then
      return ((("%q"):format(s)):gsub("\n", "n")):gsub("\026", "\\026")
    end
  end

  local comment = function(s, l)
    -- function num : 0_1_2 , upvalues : comm, _ENV
    return (l or not comm or 0 < comm) and " --[[" .. select(2, pcall(tostring, s)) .. "]]" or ""
  end

  local globerr = function(s, l)
    -- function num : 0_1_3 , upvalues : globals, comment, fatal, safestr, _ENV
    if (not globals[s] or not globals[s] .. comment(s, l)) and (fatal or not safestr(select(2, pcall(tostring, s)))) then
      return error("Can\'t serialize " .. tostring(s))
    end
  end

  local safename = function(path, name)
    -- function num : 0_1_4 , upvalues : _ENV, keyword, safestr
    local n = name == nil and "" or name
    local plain = (type(n) ~= "string" or n:match("^[%l%u_][%w_]*$")) and not keyword[n]
    if not plain or not n then
      local safe = "[" .. safestr(n) .. "]"
    end
    do return (path or "") .. (plain and path and "." or "") .. safe, safe end
    -- DECOMPILER ERROR: 7 unprocessed JMP targets
  end

  if type(opts.sortkeys) ~= "function" or not opts.sortkeys then
    local alphanumsort = function(k, o, n)
    -- function num : 0_1_5 , upvalues : _ENV
    local maxn, to = tonumber(n) or 12, {number = "a", string = "b"}
    local padnum = function(d)
      -- function num : 0_1_5_0 , upvalues : _ENV, maxn
      return ("%0" .. tostring(maxn) .. "d"):format(tonumber(d))
    end

    ;
    (table.sort)(k, function(a, b)
      -- function num : 0_1_5_1 , upvalues : k, to, _ENV, padnum
      do return ((k[a] ~= nil and 0) or to[type(a)] or "z") .. (tostring(a)):gsub("%d+", padnum) < ((k[b] ~= nil and 0) or to[type(b)] or "z") .. (tostring(b)):gsub("%d+", padnum) end
      -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end
)
  end

  end
  local val2str = function(t, name, indent, insref, path, plainindex, level)
    -- function num : 0_1_6 , upvalues : _ENV, getmetatable, safename, space, seen, sref, comment, opts, maxl, maxlen, maxnum, pairs, alphanumsort, sparse, badtype, globals, iname, gensym, val2str, custom, globerr, safestr
    local ttype, level, mt = type(t), level or 0, getmetatable(t)
    local spath, sname = safename(path, name)
    local tag = ((not plainindex or (type(name) == "number" and "") or not name .. space .. "=" .. space) and (name ~= nil and sname .. space .. "=" .. space)) or ""
    if seen[t] then
      sref[#sref + 1] = spath .. space .. "=" .. space .. seen[t]
      return tag .. "nil" .. comment("ref", level)
    end
    if type(mt) == "table" then
      local to, tr = pcall(function()
      -- function num : 0_1_6_0 , upvalues : mt, t
      return (mt.__tostring)(t)
    end
)
      local so, sr = pcall(function()
      -- function num : 0_1_6_1 , upvalues : mt, t
      return (mt.__serialize)(t)
    end
)
      if not insref then
        do
          seen[t] = (opts.metatostring == false or not to) and not so or spath
          t = so and sr or tr
          ttype = type(t)
          if ttype == "table" then
            if maxl <= level then
              return tag .. "{}" .. comment("maxlvl", level)
            end
            seen[t] = insref or spath
            if next(t) == nil then
              return tag .. "{}" .. comment(t, level)
            end
            if maxlen and maxlen < 0 then
              return tag .. "{}" .. comment("maxlen", level)
            end
            if not maxnum then
              local maxn, o, out = (math.min)(#(t), #(t)), {}, {}
              for key = 1, maxn do
                o[key] = key
              end
              do
                if not maxnum or #o < maxnum then
                  local n = #o
                  for key in pairs(t) do
                    if o[key] ~= key then
                      n = n + 1
                      o[n] = key
                    end
                  end
                end
                do
                  if maxnum and maxnum < #o then
                    o[maxnum + 1] = nil
                  end
                  if opts.sortkeys and maxn < #o then
                    alphanumsort(o, t, opts.sortkeys)
                  end
                  local sparse = not sparse or maxn < #o
                  for n,key in ipairs(o) do
                    local value, ktype, plainindex = t[key], type(key), (n <= maxn and not sparse)
                    if (((opts.valignore and (opts.valignore)[value]) or (opts.keyallow and not (opts.keyallow)[key]) or (opts.keyignore and (opts.keyignore)[key]) or (not opts.valtypeignore or not (opts.valtypeignore)[type(value)]))) then
                      -- DECOMPILER ERROR at PC266: Unhandled construct in 'MakeBoolean' P3

                      if (sparse and value == nil and ktype == "table") or badtype[ktype] then
                        if not seen[key] and not globals[key] then
                          sref[#sref + 1] = "placeholder"
                          local sname = safename(iname, gensym(key))
                          sref[#sref] = val2str(key, sname, indent, sname, iname, true)
                        end
                        sref[#sref + 1] = "placeholder"
                        if not seen[key] and not globals[key] then
                          local path = seen[t] .. "[" .. tostring(gensym(key)) .. "]"
                          if not seen[value] then
                            do
                              do
                                sref[#sref] = path .. space .. "=" .. space .. tostring(val2str(value, nil, indent, path))
                                out[#out + 1] = val2str(value, key, indent, insref, seen[t], plainindex, level + 1)
                                if maxlen then
                                  maxlen = maxlen - #out[#out]
                                end
                                -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out DO_STMT

                                -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_STMT

                                -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_STMT

                                -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_STMT

                                -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_STMT

                              end
                            end
                          end
                        end
                      end
                    end
                  end
                  local prefix = (string.rep)(maxlen >= 0 and indent or "", level)
                  local head = indent and "{\n" .. prefix .. indent or "{"
                  local body = (table.concat)(out, "," .. (indent and "\n" .. prefix .. indent or space))
                  local tail = indent and "\n" .. prefix .. "}" or "}"
                  if not custom or not custom(tag, head, body, tail, level) then
                    do
                      do return tag .. head .. body .. tail .. comment(t, level) end
                      if not insref then
                        seen[t] = not badtype[ttype] or spath
                        do return tag .. globerr(t, level) end
                        if not insref then
                          seen[t] = ttype ~= "function" or spath
                          if opts.nocode then
                            return tag .. "function() --[[..skipped..]] end" .. comment(t, level)
                          end
                          local ok, res = pcall(string.dump, t)
                          if ok then
                            local func = "((loadstring or load)(" .. safestr(res) .. ",\'@serialized\'))" .. comment(t, level)
                          end
                          if not func then
                            do
                              do return tag .. globerr(t, level) end
                              do return tag .. safestr(t) end
                              -- DECOMPILER ERROR: 34 unprocessed JMP targets
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  if not indent or not "\n" then
    local sepr = ";" .. space
  end
  local body = val2str(t, name, indent)
  local tail = #sref > 1 and (table.concat)(sref, sepr) .. sepr or ""
  local warn = opts.comment and #sref > 1 and space .. "--[[incomplete output with shared/self-references skipped]]" or ""
  if name or not body .. warn then
    return "do local " .. body .. sepr .. tail .. "return " .. name .. sepr .. "end"
  end
end

local deserialize = function(data, opts)
  -- function num : 0_2 , upvalues : G, _ENV
  if not opts or opts.safe ~= false or not G then
    local env = setmetatable({}, {__index = function(t, k)
    -- function num : 0_2_0
    return t
  end
, __call = function(t, ...)
    -- function num : 0_2_1 , upvalues : _ENV
    error("cannot call functions")
  end
})
  end
  local f, res = (loadstring or load)("return " .. data, nil, nil, env)
  if not loadstring then
    f = (f or load)(data, nil, nil, env)
    if not f then
      return f, res
    end
    if setfenv then
      setfenv(f, env)
    end
    return pcall(f)
  end
end

local merge = function(a, b)
  -- function num : 0_3 , upvalues : pairs
  if b then
    for k,v in pairs(b) do
      a[k] = v
    end
  end
  do
    return a
  end
end

return {_NAME = n, _COPYRIGHT = c, _DESCRIPTION = d, _VERSION = v, serialize = s, load = deserialize, dump = function(a, opts)
  -- function num : 0_4 , upvalues : s, merge
  return s(a, merge({name = "_", compact = true, sparse = true}, opts))
end
, line = function(a, opts)
  -- function num : 0_5 , upvalues : s, merge
  return s(a, merge({sortkeys = true, comment = true}, opts))
end
, block = function(a, opts)
  -- function num : 0_6 , upvalues : s, merge
  return s(a, merge({indent = "  ", sortkeys = true, comment = true}, opts))
end
}

