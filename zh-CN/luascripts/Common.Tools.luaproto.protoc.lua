-- params : ...
-- function num : 0 , upvalues : _ENV
local meta = function(name, t)
  -- function num : 0_0
  if not t then
    t = {}
  end
  t.__name = name
  t.__index = t
  return t
end

local default = function(t, k, def)
  -- function num : 0_1
  local v = t[k]
  if not v and not def then
    v = {}
  end
  t[k] = v
  return v
end

local Lexer = meta("Lexer")
local escape = {a = "\a", b = "\b", f = "\f", n = "\n", r = "\r", t = "\t", v = "\v"}
do
  local tohex = function(x)
  -- function num : 0_2 , upvalues : _ENV
  return (string.byte)(tonumber(x, 16))
end

  do
    local todec = function(x)
  -- function num : 0_3 , upvalues : _ENV
  return (string.byte)(tonumber(x, 10))
end

    do
      local toesc = function(x)
  -- function num : 0_4 , upvalues : escape
  return escape[x] or x
end

      do
        Lexer.new = function(name, src)
  -- function num : 0_5 , upvalues : _ENV, Lexer
  local self = {name = name, src = src, pos = 1}
  return setmetatable(self, Lexer)
end

        Lexer.__call = function(self, patt, pos)
  -- function num : 0_6
  if not pos then
    return (self.src):match(patt, self.pos)
  end
end

        Lexer.test = function(self, patt)
  -- function num : 0_7
  self:whitespace()
  local pos = self("^" .. patt .. "%s*()")
  if not pos then
    return false
  end
  self.pos = pos
  return true
end

        Lexer.expected = function(self, patt, name)
  -- function num : 0_8
  if not self:test(patt) then
    if not name then
      do return self:error("\'" .. patt .. "\'" .. " expected") end
      return self
    end
  end
end

        Lexer.pos2loc = function(self, pos)
  -- function num : 0_9
  local linenr = 1
  if not pos then
    pos = self.pos
  end
  for start,stop in (self.src):gmatch("()[^\n]*()\n?") do
    if start <= pos and pos <= stop then
      return linenr, pos - start + 1
    end
    linenr = linenr + 1
  end
end

        Lexer.error = function(self, fmt, ...)
  -- function num : 0_10 , upvalues : _ENV
  local ln, co = self:pos2loc()
  return error(("%s:%d:%d: " .. fmt):format(self.name, ln, co, ...))
end

        Lexer.opterror = function(self, opt, msg)
  -- function num : 0_11
  if not opt then
    return self:error(msg)
  end
  return nil
end

        Lexer.whitespace = function(self)
  -- function num : 0_12
  local pos, c = self("^%s*()(%/?)")
  self.pos = pos
  if c == "" then
    return self
  end
  return self:comment()
end

        Lexer.comment = function(self)
  -- function num : 0_13
  local pos = self("^%/%/[^\n]*\n?()")
  if not pos and self("^%/%*") then
    pos = self("^%/%*.-%*%/()")
    if not pos then
      self:error("unfinished comment")
    end
  end
  if not pos then
    return self
  end
  self.pos = pos
  return self:whitespace()
end

        Lexer.line_end = function(self, opt)
  -- function num : 0_14
  self:whitespace()
  local pos = self("^[%s;]*%s*()")
  if not pos then
    return self:opterror(opt, "\';\' expected")
  end
  self.pos = pos
  return pos
end

        Lexer.eof = function(self)
  -- function num : 0_15
  self:whitespace()
  do return #self.src < self.pos end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

        Lexer.keyword = function(self, kw, opt)
  -- function num : 0_16
  self:whitespace()
  local ident, pos = self("^([%a_][%w_]*)%s*()")
  if not ident or ident ~= kw then
    return self:opterror(opt, "\'\'" .. kw .. "\" expected")
  end
  self.pos = pos
  return kw
end

        Lexer.ident = function(self, name, opt)
  -- function num : 0_17
  self:whitespace()
  local b, ident, pos = self("^()([%a_][%w_]*)%s*()")
  if not name then
    do return self:opterror(opt, (ident or "name") .. " expected") end
    self.pos = pos
    return ident, b
  end
end

        Lexer.full_ident = function(self, name, opt)
  -- function num : 0_18
  self:whitespace()
  local b, ident, pos = self("^()([%a_][%w_.]*)%s*()")
  if not name then
    do return self:opterror(opt, (ident and not ident:match("%.%.+") or "name") .. " expected") end
    self.pos = pos
    return ident, b
  end
end

        Lexer.integer = function(self, opt)
  -- function num : 0_19 , upvalues : _ENV
  self:whitespace()
  local ns, oct, hex, s, pos = self("^([+-]?)(0?)([xX]?)([0-9a-fA-F]+)%s*()")
  local n = nil
  if oct == "0" and hex == "" then
    n = tonumber(s, 8)
  else
    if oct == "" and hex == "" then
      n = tonumber(s, 10)
    else
      if oct == "0" and hex ~= "" then
        n = tonumber(s, 16)
      end
    end
  end
  if not n then
    return self:opterror(opt, "integer expected")
  end
  self.pos = pos
  return ns == "-" and -n or n
end

        Lexer.number = function(self, opt)
  -- function num : 0_20 , upvalues : _ENV
  self:whitespace()
  if self:test("nan%f[%A]") then
    return 0 / 0
  else
    if self:test("inf%f[%A]") then
      return 1 / 0
    end
  end
  local ns, d1, s, d2, s2, pos = self("^([+-]?)(%.?)([0-9]+)(%.?)([0-9]*)()")
  if not ns then
    return self:opterror(opt, "floating-point number expected")
  end
  local es, pos2 = self("(^[eE][+-]?[0-9]+)%s*()", pos)
  if d1 == "." and d2 == "." then
    return self:error("malformed floating-point number")
  end
  self.pos = pos2 or pos
  local n = tonumber(d1 .. s .. d2 .. s2 .. (es or ""))
  return ns == "-" and -n or n
end

        Lexer.quote = function(self, opt)
  -- function num : 0_21 , upvalues : tohex, todec, toesc
  self:whitespace()
  local q, start = self("^([\"\'])()")
  if not start then
    return self:opterror(opt, "string expected")
  end
  self.pos = start
  local patt = "()(\\?" .. q .. ")%s*()"
  while 1 do
    local stop, s, pos = self(patt)
    if not stop then
      self.pos = start - 1
      return self:error("unfinished string")
    end
    self.pos = pos
    if s == q then
      return ((((self.src):sub(start, stop - 1)):gsub("\\x(%x+)", tohex)):gsub("\\(%d+)", todec)):gsub("\\(.)", toesc)
    end
  end
end

        Lexer.constant = function(self, opt)
  -- function num : 0_22
  if not self:full_ident("constant", "opt") and not self:number("opt") then
    local c = self:quote("opt")
  end
  if not c and not opt then
    return self:error("constant expected")
  end
  return c
end

        Lexer.option_name = function(self)
  -- function num : 0_23
  local ident = nil
  if self:test("%(") then
    ident = self:full_ident("option name")
    self:expected("%)")
  else
    ident = self:ident("option name")
  end
  while self:test("%.") do
    ident = ident .. "." .. self:ident()
  end
  return ident
end

        Lexer.type_name = function(self)
  -- function num : 0_24
  if self:test("%.") then
    local id, pos = self:full_ident("type name")
    return "." .. id, pos
  else
    do
      do return self:full_ident("type name") end
    end
  end
end

      end
      local Parser = meta("Parser")
      Parser.typemap = {}
      Parser.loaded = {}
      Parser.paths = {"", "."}
      Parser.new = function()
  -- function num : 0_25 , upvalues : _ENV, Parser
  local self = {}
  self.typemap = {}
  self.loaded = {}
  self.paths = {"", "."}
  return setmetatable(self, Parser)
end

      Parser.error = function(self, msg)
  -- function num : 0_26
  return (self.lex):error(msg)
end

      Parser.addpath = function(self, path)
  -- function num : 0_27
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  (self.paths)[#self.paths + 1] = path
end

      Parser.parsefile = function(self, name)
  -- function num : 0_28 , upvalues : _ENV
  local info = (self.loaded)[name]
  if info then
    return info
  end
  local errors = {}
  for _,path in ipairs(self.paths) do
    local fn = path ~= "" and path .. "/" .. name or name
    local fh, err = (io.open)(fn)
    do
      if fh then
        local content = fh:read("*a")
        info = self:parse(content, name)
        fh:close()
        return info
      end
      if not err then
        do
          errors[#errors + 1] = fn .. ": " .. "unknown error"
          -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
  if self.import_fallback then
    info = (self.import_fallback)(name)
  end
  if not info then
    error("module load error: " .. name .. "\n\t" .. (table.concat)(errors, "\n\t"))
  end
  return info
end

      local labels = {optional = 1, required = 2, repeated = 3}
      local key_types = {int32 = 5, int64 = 3, uint32 = 13, uint64 = 4, sint32 = 17, sint64 = 18, fixed32 = 7, fixed64 = 6, sfixed32 = 15, sfixed64 = 16, bool = 8, string = 9}
      local com_types = {group = 10, message = 11, enum = 14}
      local types = {double = 1, float = 2, int32 = 5, int64 = 3, uint32 = 13, uint64 = 4, sint32 = 17, sint64 = 18, fixed32 = 7, fixed64 = 6, sfixed32 = 15, sfixed64 = 16, bool = 8, string = 9, bytes = 12, group = 10, message = 11, enum = 14}
      local register_type = function(self, lex, tname, type)
  -- function num : 0_29
  if not tname:match("%.") then
    tname = self.prefix .. tname
  end
  if (self.typemap)[tname] then
    return lex:error("type %s already defined", tname)
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.typemap)[tname] = type
end

      local type_info = function(lex, tname)
  -- function num : 0_30 , upvalues : types, com_types
  local tenum = types[tname]
  if com_types[tname] then
    return lex:error("invalid type name: " .. tname)
  else
    if tenum then
      tname = nil
    end
  end
  return tenum, tname
end

      local map_info = function(lex)
  -- function num : 0_31 , upvalues : key_types, _ENV, type_info, types, labels
  local keyt = lex:ident("key type")
  if not key_types[keyt] then
    return lex:error("invalid key type: " .. keyt)
  end
  local valt = (lex:expected(",")):type_name()
  local name = (lex:expected(">")):ident()
  local ident = (name:gsub("^%a", string.upper)):gsub("_(%a)", string.upper) .. "Entry"
  local kt, ktn = type_info(lex, keyt)
  local vt, vtn = type_info(lex, valt)
  return name, types.message, ident, {name = ident, 
field = {
{name = "key", number = 1, label = labels.optional, type = kt, type_name = ktn}
, 
{name = "value", number = 2, label = labels.optional, type = vt, type_name = vtn}
}
, 
options = {map_entry = true}
}
end

      local inline_option = function(lex, info)
  -- function num : 0_32
  if lex:test("%[") then
    if not info then
      info = {}
    end
    while 1 do
      local name = lex:option_name()
      local value = (lex:expected("=")):constant()
      info[name] = value
      if lex:test("%]") then
        return info
      end
      lex:expected(",")
    end
  end
end

      do
        local field = function(self, lex, ident)
  -- function num : 0_33 , upvalues : map_info, register_type, types, type_info, labels, inline_option, _ENV
  local name, type, type_name, map_entry = nil, nil, nil, nil
  if ident == "map" and lex:test("%<") then
    name = map_info(lex)
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.locmap)[(map_entry.field)[1]] = lex.pos
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self.locmap)[(map_entry.field)[2]] = lex.pos
    register_type(self, lex, type_name, types.message)
  else
    -- DECOMPILER ERROR at PC36: Overwrote pending register: R5 in 'AssignReg'

    -- DECOMPILER ERROR at PC37: Overwrote pending register: R4 in 'AssignReg'

    name = lex:ident()
  end
  local info = {name = name, number = (lex:expected("=")):integer(), label = ident == "map" and labels.repeated or labels.optional, type = type, type_name = type_name}
  local options = inline_option(lex)
  if options then
    info.default_value = tostring(options.default)
    info.json_name = options.json_name
    if options.packed and options.packed == "false" then
      options.packed = false
    end
  end
  info.options = options
  if info.number <= 0 then
    lex:error("invalid tag number: " .. info.number)
  end
  return info, map_entry
end

        local label_field = function(self, lex, ident)
  -- function num : 0_34 , upvalues : labels, field
  local label = labels[ident]
  local info, map_entry = nil, nil
  if not label then
    if self.syntax == "proto2" and ident ~= "map" then
      return lex:error("proto2 disallow missing label")
    end
    return field(self, lex, ident)
  end
  if label == labels.optional and self.syntax == "proto3" then
    return lex:error("proto3 disallow \'optional\' label")
  end
  info = field(self, lex, lex:type_name())
  info.label = label
  return info, map_entry
end

        local toplevel = {}
        toplevel.package = function(self, lex, info)
  -- function num : 0_35
  local package = lex:full_ident("package name")
  lex:line_end()
  info.package = package
  self.prefix = "." .. package .. "."
  return self
end

        toplevel.import = function(self, lex, info)
  -- function num : 0_36 , upvalues : default
  local mode = lex:ident("\"weak\" or \"public\"", "opt") or "public"
  if mode ~= "weak" and mode ~= "public" then
    return lex:error("\"weak or \"public\" expected")
  end
  local name = lex:quote()
  lex:line_end()
  local result = self:parsefile(name)
  if self.on_import then
    (self.on_import)(result)
  end
  local dep = default(info, "dependency")
  local index = #dep
  dep[index + 1] = name
  if mode == "public" then
    local it = default(info, "public_dependency")
    it[#it + 1] = index
  else
    do
      local it = default(info, "weak_dependency")
      it[#it + 1] = index
    end
  end
end

        local msg_body = {}
        msg_body.message = function(self, lex, info)
  -- function num : 0_37 , upvalues : default, toplevel
  local nested_type = default(info, "nested_type")
  nested_type[#nested_type + 1] = (toplevel.message)(self, lex)
  return self
end

        msg_body.enum = function(self, lex, info)
  -- function num : 0_38 , upvalues : default, toplevel
  local nested_type = default(info, "enum_type")
  nested_type[#nested_type + 1] = (toplevel.enum)(self, lex)
  return self
end

        msg_body.extend = function(self, lex, info)
  -- function num : 0_39 , upvalues : default, toplevel, _ENV
  local extension = default(info, "extension")
  local nested_type = default(info, "nested_type")
  local ft, mt = (toplevel.extend)(self, lex, {})
  for _,v in ipairs(ft) do
    extension[#extension + 1] = v
  end
  for _,v in ipairs(mt) do
    nested_type[#nested_type + 1] = v
  end
  return self
end

        msg_body.extensions = function(self, lex, info)
  -- function num : 0_40 , upvalues : default, _ENV
  local rt = default(info, "extension_range")
  repeat
    local start = lex:integer("field number range")
    local stop = (math.floor)(536870912)
    lex:keyword("to")
    if not lex:keyword("max", "opt") then
      stop = lex:integer("field number range end or \'max\'")
    end
    rt[#rt + 1] = {start = start, ["end"] = stop}
  until not lex:test(",")
  lex:line_end()
  return self
end

        msg_body.reserved = function(self, lex, info)
  -- function num : 0_41 , upvalues : default
  if lex:test("%a") then
    local rt = default(info, "reserved_name")
    repeat
      rt[#rt + 1] = lex:ident("field name")
    until not lex:test(",")
  else
    do
      local rt = default(info, "reserved_range")
      local first = true
      repeat
        local start = lex:integer(first and "field name or number range" or "field number range")
        if lex:keyword("to", "opt") then
          local stop = lex:integer("field number range end")
          rt[#rt + 1] = {start = start, ["end"] = stop}
        else
          do
            rt[#rt + 1] = {start = start, ["end"] = start}
            first = false
          end
        end
      until not lex:test(",")
      do
        lex:line_end()
        return self
      end
    end
  end
end

        msg_body.oneof = function(self, lex, info)
  -- function num : 0_42 , upvalues : default, toplevel, field
  local fs = default(info, "field")
  local ts = default(info, "nested_type")
  local ot = default(info, "oneof_decl")
  local index = #ot + 1
  local oneof = {name = lex:ident()}
  lex:expected("{")
  while 1 do
    if not lex:test("}") then
      local ident = lex:type_name()
      if ident == "option" then
        (toplevel.option)(self, lex, oneof)
      else
        local f, t = field(self, lex, ident, "no_label")
        -- DECOMPILER ERROR at PC44: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (self.locmap)[f] = lex.pos
        if t then
          ts[#ts + 1] = t
        end
        f.oneof_index = index - 1
        fs[#fs + 1] = f
      end
      do
        do
          lex:line_end("opt")
          -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  ot[index] = oneof
end

        toplevel.message = function(self, lex, info)
  -- function num : 0_43 , upvalues : register_type, types, msg_body, default, label_field
  local name = lex:ident("message name")
  local type = {name = name}
  register_type(self, lex, name, types.message)
  local prefix = self.prefix
  self.prefix = prefix .. name .. "."
  lex:expected("{")
  while 1 do
    if not lex:test("}") then
      local ident, pos = lex:type_name()
      local body_parser = msg_body[ident]
      if body_parser then
        body_parser(self, lex, type)
      else
        local fs = default(type, "field")
        local f, t = label_field(self, lex, ident)
        -- DECOMPILER ERROR at PC46: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (self.locmap)[f] = pos
        fs[#fs + 1] = f
        if t then
          local ts = default(type, "nested_type")
          ts[#ts + 1] = t
        end
      end
      do
        do
          lex:line_end("opt")
          -- DECOMPILER ERROR at PC62: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC62: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC62: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  lex:line_end("opt")
  if info then
    info = default(info, "message_type")
    info[#info + 1] = type
  end
  self.prefix = prefix
  return type
end

        toplevel.enum = function(self, lex, info)
  -- function num : 0_44 , upvalues : register_type, types, toplevel, default, inline_option
  local name = lex:ident("enum name")
  local enum = {name = name}
  register_type(self, lex, name, types.enum)
  lex:expected("{")
  while 1 do
    if not lex:test("}") then
      local ident = lex:ident("enum constant name")
      if ident == "option" then
        (toplevel.option)(self, lex, default(enum, "options"))
      else
        local values = default(enum, "value")
        local number = (lex:expected("=")):integer()
        lex:line_end()
        values[#values + 1] = {name = ident, number = number, options = inline_option(lex)}
      end
      do
        do
          lex:line_end("opt")
          -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  lex:line_end("opt")
  if info then
    info = default(info, "enum_type")
    info[#info + 1] = enum
  end
  return enum
end

        toplevel.option = function(self, lex, info)
  -- function num : 0_45 , upvalues : default
  local ident = lex:option_name()
  lex:expected("=")
  local value = lex:constant()
  lex:line_end()
  if not info or not default(info, "options") then
    local options = {}
  end
  options[ident] = value
  return options, self
end

        toplevel.extend = function(self, lex, info)
  -- function num : 0_46 , upvalues : default, label_field
  local name = lex:type_name()
  if not info or not default(info, "extension") then
    local ft = {}
  end
  if not info or not default(info, "message_type") then
    local mt = {}
  end
  lex:expected("{")
  while not lex:test("}") do
    local ident, pos = lex:type_name()
    local f, t = label_field(self, lex, ident)
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (self.locmap)[f] = pos
    f.extendee = name
    ft[#ft + 1] = f
    mt[#mt + 1] = t
    lex:line_end("opt")
  end
  do
    return ft, mt
  end
end

        do
          local svr_body = {}
          svr_body.rpc = function(self, lex, info)
  -- function num : 0_47 , upvalues : type_info, toplevel, default
  local name, pos = lex:ident("rpc name")
  local rpc = {name = name}
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self.locmap)[rpc] = pos
  local _, tn = nil, nil
  lex:expected("%(")
  rpc.client_stream = lex:keyword("stream", "opt")
  _ = type_info(lex, lex:type_name())
  if not tn then
    return lex:error("rpc input type must by message")
  end
  rpc.input_type = tn
  ;
  ((lex:expected("%)")):expected("returns")):expected("%(")
  rpc.server_stream = lex:keyword("stream", "opt")
  -- DECOMPILER ERROR at PC49: Overwrote pending register: R7 in 'AssignReg'

  _ = type_info(lex, lex:type_name())
  if not tn then
    return lex:error("rpc output type must by message")
  end
  rpc.output_type = tn
  lex:expected("%)")
  while lex:test("{") and not lex:test("}") do
    lex:line_end("opt")
    lex:keyword("option")
    ;
    (toplevel.option)(self, lex, default(rpc, "options"))
  end
  lex:line_end("opt")
  local t = default(info, "method")
  t[#t + 1] = rpc
end

          svr_body.stream = function(_, lex)
  -- function num : 0_48
  lex:error("stream not implement yet")
end

          toplevel.service = function(self, lex, info)
  -- function num : 0_49 , upvalues : svr_body, default
  local name = lex:ident("service name")
  local svr = {name = name}
  lex:expected("{")
  while not lex:test("}") do
    local ident = lex:type_name()
    local body_parser = svr_body[ident]
    if body_parser then
      body_parser(self, lex, svr)
    else
      return lex:error("expected \'rpc\' or \'option\' in service body")
    end
    lex:line_end("opt")
  end
  do
    lex:line_end("opt")
    if info then
      info = default(info, "service")
      info[#info + 1] = svr
    end
    return svr
  end
end

          local make_context = function(self, lex)
  -- function num : 0_50 , upvalues : _ENV, Parser
  local ctx = {syntax = "proto2", 
locmap = {}
, prefix = ".", lex = lex, parser = self}
  ctx.loaded = self.loaded
  ctx.typemap = self.typemap
  ctx.paths = self.paths
  ctx.import_fallback = function(import_name)
    -- function num : 0_50_0 , upvalues : self, _ENV
    if self.unknown_import == true then
      return true
    else
      if not import_name:match(self.unknown_import) or not true then
        do return type(self.unknown_import) ~= "string" or nil end
        if self.unknown_import then
          return self:unknown_import(import_name)
        end
      end
    end
  end

  ctx.type_fallback = function(type_name)
    -- function num : 0_50_1 , upvalues : self, _ENV
    if self.unknown_type == true then
      return true
    else
      if type_name:match(self.unknown_type) then
        do return type(self.unknown_type) ~= "string" or true end
        if self.unknown_type then
          return self:unknown_type(type_name)
        end
      end
    end
  end

  ctx.on_import = function(info)
    -- function num : 0_50_2 , upvalues : self
    if self.on_import then
      return (self.on_import)(info)
    end
  end

  return setmetatable(ctx, Parser)
end

          Parser.parse = function(self, src, name)
  -- function num : 0_51 , upvalues : _ENV, Lexer, make_context, toplevel
  local loaded = (self.loaded)[name]
  -- DECOMPILER ERROR at PC10: Unhandled construct in 'MakeBoolean' P1

  if loaded and loaded == true then
    error("loop loaded: " .. name)
  end
  do return loaded end
  if not name then
    name = "<input>"
  end
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.loaded)[name] = true
  local lex = (Lexer.new)(name, src)
  local info = {name = lex.name}
  local ctx = make_context(self, lex)
  local syntax = lex:keyword("syntax", "opt")
  if syntax then
    info.syntax = (lex:expected("=")):quote()
    ctx.syntax = info.syntax
    lex:line_end()
  end
  while not lex:eof() do
    local ident = lex:ident()
    local top_parser = toplevel[ident]
    if top_parser then
      top_parser(ctx, lex, info)
    else
      lex:error("unknown keyword \'" .. ident .. "\'")
    end
    lex:line_end("opt")
  end
  do
    -- DECOMPILER ERROR at PC75: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self.loaded)[name] = name ~= "<input>" and info or nil
    return ctx:resolve(lex, info)
  end
end

          local empty = function()
  -- function num : 0_52
end

          local iter = function(t, k)
  -- function num : 0_53 , upvalues : _ENV, empty
  local v = t[k]
  if v then
    return ipairs(v)
  end
  return empty
end

          local check_dup = function(self, lex, type, map, k, v)
  -- function num : 0_54
  local old = map[v[k]]
  do
    if old then
      local ln, co = lex:pos2loc((self.locmap)[old])
      lex:error("%s \'%s\' exists, previous at %d:%d", type, v[k], ln, co)
    end
    map[v[k]] = v
  end
end

          local check_type = function(self, lex, tname)
  -- function num : 0_55 , upvalues : _ENV, types
  do
    if tname:match("^%.") then
      local t = (self.typemap)[tname]
      if not t then
        return lex:error("unknown type \'%s\'", tname)
      end
      return t, tname
    end
    local prefix = self.prefix
    for i = #prefix + 1, 1, -1 do
      local op = prefix[i]
      prefix[i] = tname
      local tn = (table.concat)(prefix, ".", 1, i)
      prefix[i] = op
      local t = (self.typemap)[tn]
      if t then
        return t, tn
      end
    end
    local tn, t = nil, nil
    if self.type_fallback then
      tn = (self.type_fallback)(tname)
    end
    -- DECOMPILER ERROR at PC55: Overwrote pending register: R5 in 'AssignReg'

    if t or tn == true then
      tn = "." .. tname
    end
    do return t, tn end
    return lex:error("unknown type \'%s\'", tname)
  end
end

          local check_field = function(self, lex, info)
  -- function num : 0_56 , upvalues : check_type, types
  do
    if info.extendee then
      local t, tn = check_type(self, lex, info.extendee)
      if t ~= types.message then
        lex:error("message type expected in extension")
      end
      info.extendee = tn
    end
    if info.type_name then
      local t, tn = check_type(self, lex, info.type_name)
      info.type = t
      info.type_name = tn
    end
  end
end

          local check_enum = function(self, lex, info)
  -- function num : 0_57 , upvalues : iter, check_dup
  local names, numbers = {}, {}
  for _,v in iter(info, "value") do
    lex.pos = (self.locmap)[v]
    check_dup(self, lex, "enum name", names, "name", v)
    if not info.options or not (info.options).options or not ((info.options).options).allow_alias then
      check_dup(self, lex, "enum number", numbers, "number", v)
    end
  end
end

          local check_message = function(self, lex, info)
  -- function num : 0_58 , upvalues : iter, _ENV, check_dup, check_field, check_message
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  (self.prefix)[#self.prefix + 1] = info.name
  local names, numbers = {}, {}
  for _,v in iter(info, "field") do
    lex.pos = assert((self.locmap)[v])
    check_dup(self, lex, "field name", names, "name", v)
    check_dup(self, lex, "field number", numbers, "number", v)
    check_field(self, lex, v)
  end
  for _,v in iter(info, "nested_type") do
    check_message(self, lex, v)
  end
  for _,v in iter(info, "extension") do
    lex.pos = assert((self.locmap)[v])
    check_field(self, lex, v)
  end
  -- DECOMPILER ERROR at PC73: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self.prefix)[#self.prefix] = nil
end

          local check_service = function(self, lex, info)
  -- function num : 0_59 , upvalues : iter, check_dup, check_type, types
  local names = {}
  for _,v in iter(info, "method") do
    lex.pos = (self.locmap)[v]
    check_dup(self, lex, "rpc name", names, "name", v)
    local t, tn = check_type(self, lex, v.input_type)
    v.input_type = tn
    if t ~= types.message then
      lex:error("message type expected in parameter")
    end
    t = check_type(self, lex, v.output_type)
    v.output_type = tn
    if t ~= types.message then
      lex:error("message type expected in return")
    end
  end
end

          Parser.resolve = function(self, lex, info)
  -- function num : 0_60 , upvalues : iter, check_message, check_enum, check_service, _ENV, check_field
  self.prefix = {"", info.package}
  for _,v in iter(info, "message_type") do
    check_message(self, lex, v)
  end
  for _,v in iter(info, "enum_type") do
    check_enum(self, lex, v)
  end
  for _,v in iter(info, "service") do
    check_service(self, lex, v)
  end
  for _,v in iter(info, "extension") do
    lex.pos = assert((self.locmap)[v])
    check_field(self, lex, v)
  end
  self.prefix = nil
  return info
end

        end
        do
          local has_pb, pb = pcall(require, "pb")
          if has_pb then
            local descriptor_pb = "\n\249#\n\016descriptor.proto\018\015google.protobuf\"G\n\017FileDescript" .. "orSet\0182\n\004file\024\001 \003(\v2$.google.protobuf.FileDescriptorProto\"" .. "\219\003\n\019FileDescriptorProto\018\f\n\004name\024\001 \001(\t\018\015\n\apack" .. "age\024\002 \001(\t\018\018\n\ndependency\024\003 \003(\t\018\025\n\017public_depend" .. "ency\024\n \003(\005\018\023\n\015weak_dependency\024\v \003(\005\0186\n\fmessag" .. "e_type\024\004 \003(\v2 .google.protobuf.DescriptorProto\0187\n\tenum_type" .. "\024\005 \003(\v2$.google.protobuf.EnumDescriptorProto\0188\n\aservice\024" .. "\006 \003(\v2\'.google.protobuf.ServiceDescriptorProto\0188\n\textension" .. "\024\a \003(\v2%.google.protobuf.FieldDescriptorProto\018-\n\aoptions\024" .. "\b \001(\v2\028.google.protobuf.FileOptions\0189\n\016source_code_info\024" .. "\t \001(\v2\031.google.protobuf.SourceCodeInfo\018\014\n\006syntax\024\f \001(" .. "\t\"\228\003\n\015DescriptorProto\018\f\n\004name\024\001 \001(\t\0184\n\005field" .. "\024\002 \003(\v2%.google.protobuf.FieldDescriptorProto\0188\n\textension" .. "\024\006 \003(\v2%.google.protobuf.FieldDescriptorProto\0185\n\vnested_ty" .. "pe\024\003 \003(\v2 .google.protobuf.DescriptorProto\0187\n\tenum_type\024" .. "\004 \003(\v2$.google.protobuf.EnumDescriptorProto\018H\n\015extension_rang" .. "e\024\005 \003(\v2/.google.protobuf.DescriptorProto.ExtensionRange\0189\n" .. "\noneof_decl\024\b \003(\v2%.google.protobuf.OneofDescriptorProto\0180" .. "\n\aoptions\024\a \001(\v2\031.google.protobuf.MessageOptions\026,\n\014Ex" .. "tensionRange\018\r\n\005start\024\001 \001(\005\018\v\n\003end\024\002 \001(\005\"\169\005" .. "\n\020FieldDescriptorProto\018\f\n\004name\024\001 \001(\t\018\014\n\006number\024" .. "\003 \001(\005\018:\n\005label\024\004 \001(\0142+.google.protobuf.FieldDescriptorPro" .. "to.Label\0188\n\004type\024\005 \001(\0142*.google.protobuf.FieldDescriptorPro" .. "to.Type\018\017\n\ttype_name\024\006 \001(\t\018\016\n\bextendee\024\002 \001(\t\018" .. "\021\n\rdefault_value\024\a \001(\t\018\019\n\voneof_index\024\t \001(\005\018." .. "\n\aoptions\024\b \001(\v2\029.google.protobuf.FieldOptions\"\182\002\n\004T" .. "ype\018\015\n\vTYPE_DOUBLE\016\001\018\014\n\nTYPE_FLOAT\016\002\018\014\n\nTY" .. "PE_INT64\016\003\018\015\n\vTYPE_UINT64\016\004\018\014\n\nTYPE_INT32\016\005\018" .. "\016\n\fTYPE_FIXED64\016\006\018\016\n\fTYPE_FIXED32\016\a\018\r\n\tTYPE_B" .. "OOL\016\b\018\015\n\vTYPE_STRING\016\t\018\014\n\nTYPE_GROUP\016\n\018\016" .. "\n\fTYPE_MESSAGE\016\v\018\014\n\nTYPE_BYTES\016\f\018\015\n\vTYPE_UIN" .. "T32\016\r\018\r\n\tTYPE_ENUM\016\014\018\017\n\rTYPE_SFIXED32\016\015\018\017" .. "\n\rTYPE_SFIXED64\016\016\018\015\n\vTYPE_SINT32\016\017\018\015\n\vTYPE_S" .. "INT64\016\018\"C\n\005Label\018\018\n\014LABEL_OPTIONAL\016\001\018\018\n\014LABEL" .. "_REQUIRED\016\002\018\018\n\014LABEL_REPEATED\016\003\"$\n\020OneofDescriptorPro" .. "to\018\f\n\004name\024\001 \001(\t\"\140\001\n\019EnumDescriptorProto\018\f\n\004" .. "name\024\001 \001(\t\0188\n\005value\024\002 \003(\v2).google.protobuf.EnumValueD" .. "escriptorProto\018-\n\aoptions\024\003 \001(\v2\028.google.protobuf.EnumOpti" .. "ons\"l\n\024EnumValueDescriptorProto\018\f\n\004name\024\001 \001(\t\018\014\n" .. "\006number\024\002 \001(\005\0182\n\aoptions\024\003 \001(\v2!.google.protobuf.Enum" .. "ValueOptions\"\144\001\n\022ServiceDescriptorProto\018\f\n\004name\024\001 \001(" .. "\t\0186\n\006method\024\002 \003(\v2&.google.protobuf.MethodDescriptorProto" .. "\0180\n\aoptions\024\003 \001(\v2\031.google.protobuf.ServiceOptions\"\193" .. "\001\n\021MethodDescriptorProto\018\f\n\004name\024\001 \001(\t\018\018\n\ninput" .. "_type\024\002 \001(\t\018\019\n\voutput_type\024\003 \001(\t\018/\n\aoptions\024\004 " .. "\001(\v2\030.google.protobuf.MethodOptions\018\031\n\016client_streaming\024" .. "\005 \001(\b:\005false\018\031\n\016server_streaming\024\006 \001(\b:\005false\"\231\004" .. "\n\vFileOptions\018\020\n\fjava_package\024\001 \001(\t\018\028\n\020java_out" .. "er_classname\024\b \001(\t\018\"\n\019java_multiple_files\024\n \001(\b:\005fals" .. "e\018,\n\029java_generate_equals_and_hash\024\020 \001(\b:\005false\018%\n\022ja" .. "va_string_check_utf8\024\027 \001(\b:\005false\018F\n\foptimize_for\024\t \001(" .. "\0142).google.protobuf.FileOptions.OptimizeMode:\005SPEED\018\018\n\ngo_pa" .. "ckage\024\v \001(\t\018\"\n\019cc_generic_services\024\016 \001(\b:\005false\018$" .. "\n\021java_generic_services\024\017 \001(\b:\005false\018\"\n\019py_generic_ser" .. "vices\024\018 \001(\b:\005false\018\025\n\ndeprecated\024\023 \001(\b:\005false\018" .. "\031\n\016cc_enable_arenas\024\031 \001(\b:\005false\018\025\n\017objc_class_pref" .. "ix\024$ \001(\t\018C\n\020uninterpreted_option\024\231\a \003(\v2$.google.pro" .. "tobuf.UninterpretedOption\":\n\fOptimizeMode\018\t\n\005SPEED\016\001\018\r" .. "\n\tCODE_SIZE\016\002\018\016\n\fLITE_RUNTIME\016\003*\t\b\232\a\016\128\128" .. "\128\128\002\"\230\001\n\014MessageOptions\018&\n\023message_set_wire_format" .. "\024\001 \001(\b:\005false\018.\n\031no_standard_descriptor_accessor\024\002 \001(\b:" .. "\005false\018\025\n\ndeprecated\024\003 \001(\b:\005false\018\017\n\tmap_entry\024" .. "\a \001(\b\018C\n\020uninterpreted_option\024\231\a \003(\v2$.google.protobu" .. "f.UninterpretedOption*\t\b\232\a\016\128\128\128\128\002\"\160\002\n\fField" .. "Options\018:\n\005ctype\024\001 \001(\0142#.google.protobuf.FieldOptions.CType:" .. "\006STRING\018\014\n\006packed\024\002 \001(\b\018\019\n\004lazy\024\005 \001(\b:\005false" .. "\018\025\n\ndeprecated\024\003 \001(\b:\005false\018\019\n\004weak\024\n \001(\b:\005f" .. "alse\018C\n\020uninterpreted_option\024\231\a \003(\v2$.google.protobuf.Un" .. "interpretedOption\"/\n\005CType\018\n\n\006STRING\016\000\018\b\n\004CORD\016\001" .. "\018\016\n\fSTRING_PIECE\016\002*\t\b\232\a\016\128\128\128\128\002\"\141\001\n" .. "\vEnumOptions\018\019\n\vallow_alias\024\002 \001(\b\018\025\n\ndeprecated" .. "\024\003 \001(\b:\005false\018C\n\020uninterpreted_option\024\231\a \003(\v2$.goo" .. "gle.protobuf.UninterpretedOption*\t\b\232\a\016\128\128\128\128\002\"}\n" .. "\016EnumValueOptions\018\025\n\ndeprecated\024\001 \001(\b:\005false\018C\n\020un" .. "interpreted_option\024\231\a \003(\v2$.google.protobuf.UninterpretedOptio" .. "n*\t\b\232\a\016\128\128\128\128\002\"{\n\014ServiceOptions\018\025\n\ndepr" .. "ecated\024! \001(\b:\005false\018C\n\020uninterpreted_option\024\231\a \003(\v2" .. "$.google.protobuf.UninterpretedOption*\t\b\232\a\016\128\128\128\128\002\"z" .. "\n\rMethodOptions\018\025\n\ndeprecated\024! \001(\b:\005false\018C\n\020uni" .. "nterpreted_option\024\231\a \003(\v2$.google.protobuf.UninterpretedOption" .. "*\t\b\232\a\016\128\128\128\128\002\"\158\002\n\019UninterpretedOption\018;\n" .. "\004name\024\002 \003(\v2-.google.protobuf.UninterpretedOption.NamePart\018\024" .. "\n\016identifier_value\024\003 \001(\t\018\026\n\018positive_int_value\024\004 \001(" .. "\004\018\026\n\018negative_int_value\024\005 \001(\003\018\020\n\fdouble_value\024\006" .. " \001(\001\018\020\n\fstring_value\024\a \001(\f\018\023\n\015aggregate_value" .. "\024\b \001(\t\0263\n\bNamePart\018\017\n\tname_part\024\001 \002(\t\018\020\n\f" .. "is_extension\024\002 \002(\b\"\213\001\n\014SourceCodeInfo\018:\n\blocation\024" .. "\001 \003(\v2(.google.protobuf.SourceCodeInfo.Location\026\134\001\n\bLocati" .. "on\018\016\n\004path\024\001 \003(\005B\002\016\001\018\016\n\004span\024\002 \003(\005B\002\016\001" .. "\018\024\n\016leading_comments\024\003 \001(\t\018\025\n\017trailing_comments\024" .. "\004 \001(\t\018!\n\025leading_detached_comments\024\006 \003(\tB)\n\019com.google" .. ".protobufB\016DescriptorProtosH\001"
            Parser.reload = function()
  -- function num : 0_61 , upvalues : _ENV, pb, descriptor_pb
  assert((pb.load)(descriptor_pb))
end

            local do_compile = function(self, f, ...)
  -- function num : 0_62
  if self.include_imports then
    local old = self.on_import
    do
      local infos = {}
      self.on_import = function(info)
    -- function num : 0_62_0 , upvalues : infos
    infos[#infos + 1] = info
  end

      local r = f(...)
      infos[#infos + 1] = r
      self.on_import = old
      return {file = infos}
    end
  end
  do
    return {
file = {f(...)}
}
  end
end

            Parser.compile = function(self, s, name)
  -- function num : 0_63 , upvalues : do_compile, pb
  local set = do_compile(self, self.parse, self, s, name)
  return (pb.encode)(".google.protobuf.FileDescriptorSet", set)
end

            Parser.compilefile = function(self, fn)
  -- function num : 0_64 , upvalues : do_compile, pb
  local set = do_compile(self, self.parsefile, self, fn)
  return (pb.encode)(".google.protobuf.FileDescriptorSet", set)
end

            Parser.load = function(self, s, name)
  -- function num : 0_65 , upvalues : pb, _ENV
  local ret, pos = (pb.load)(self:compile(s, name))
  if ret then
    return ret, pos
  end
  error("load failed at offset " .. pos)
end

            Parser.loadfile = function(self, fn)
  -- function num : 0_66 , upvalues : pb, _ENV
  local ret, pos = (pb.load)(self:compilefile(fn))
  if ret then
    return ret, pos
  end
  error("load failed at offset " .. pos)
end

            ;
            (Parser.reload)()
          end
          do
            return Parser
          end
        end
      end
    end
  end
end

-- params : ...
-- function num : 0 , upvalues : _ENV
local meta = function(name, t)
    -- function num : 0_0
    if not t then t = {} end
    t.__name = name
    t.__index = t
    return t
end

local default = function(t, k, def)
    -- function num : 0_1
    local v = t[k]
    if not v and not def then v = {} end
    t[k] = v
    return v
end

local Lexer = meta("Lexer")
local escape = {
    a = "\a",
    b = "\b",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t",
    v = "\v"
}
do
    local tohex = function(x)
        -- function num : 0_2 , upvalues : _ENV
        return (string.byte)(tonumber(x, 16))
    end

    do
        local todec = function(x)
            -- function num : 0_3 , upvalues : _ENV
            return (string.byte)(tonumber(x, 10))
        end

        do
            local toesc = function(x)
                -- function num : 0_4 , upvalues : escape
                return escape[x] or x
            end

            do
                Lexer.new = function(name, src)
                    -- function num : 0_5 , upvalues : _ENV, Lexer
                    local self = {name = name, src = src, pos = 1}
                    return setmetatable(self, Lexer)
                end

                Lexer.__call = function(self, patt, pos)
                    -- function num : 0_6
                    if not pos then
                        return (self.src):match(patt, self.pos)
                    end
                end

                Lexer.test = function(self, patt)
                    -- function num : 0_7
                    self:whitespace()
                    local pos = self("^" .. patt .. "%s*()")
                    if not pos then return false end
                    self.pos = pos
                    return true
                end

                Lexer.expected = function(self, patt, name)
                    -- function num : 0_8
                    if not self:test(patt) then
                        if not name then
                            do
                                return self:error(
                                           "\'" .. patt .. "\'" .. " expected")
                            end
                            return self
                        end
                    end
                end

                Lexer.pos2loc = function(self, pos)
                    -- function num : 0_9
                    local linenr = 1
                    if not pos then pos = self.pos end
                    for start, stop in (self.src):gmatch("()[^\n]*()\n?") do
                        if start <= pos and pos <= stop then
                            return linenr, pos - start + 1
                        end
                        linenr = linenr + 1
                    end
                end

                Lexer.error = function(self, fmt, ...)
                    -- function num : 0_10 , upvalues : _ENV
                    local ln, co = self:pos2loc()
                    return error(("%s:%d:%d: " .. fmt):format(self.name, ln, co,
                                                              ...))
                end

                Lexer.opterror = function(self, opt, msg)
                    -- function num : 0_11
                    if not opt then return self:error(msg) end
                    return nil
                end

                Lexer.whitespace = function(self)
                    -- function num : 0_12
                    local pos, c = self("^%s*()(%/?)")
                    self.pos = pos
                    if c == "" then return self end
                    return self:comment()
                end

                Lexer.comment = function(self)
                    -- function num : 0_13
                    local pos = self("^%/%/[^\n]*\n?()")
                    if not pos and self("^%/%*") then
                        pos = self("^%/%*.-%*%/()")
                        if not pos then
                            self:error("unfinished comment")
                        end
                    end
                    if not pos then return self end
                    self.pos = pos
                    return self:whitespace()
                end

                Lexer.line_end = function(self, opt)
                    -- function num : 0_14
                    self:whitespace()
                    local pos = self("^[%s;]*%s*()")
                    if not pos then
                        return self:opterror(opt, "\';\' expected")
                    end
                    self.pos = pos
                    return pos
                end

                Lexer.eof = function(self)
                    -- function num : 0_15
                    self:whitespace()
                    do return #self.src < self.pos end
                    -- DECOMPILER ERROR: 1 unprocessed JMP targets
                end

                Lexer.keyword = function(self, kw, opt)
                    -- function num : 0_16
                    self:whitespace()
                    local ident, pos = self("^([%a_][%w_]*)%s*()")
                    if not ident or ident ~= kw then
                        return self:opterror(opt, "\'\'" .. kw .. "\" expected")
                    end
                    self.pos = pos
                    return kw
                end

                Lexer.ident = function(self, name, opt)
                    -- function num : 0_17
                    self:whitespace()
                    local b, ident, pos = self("^()([%a_][%w_]*)%s*()")
                    if not name then
                        do
                            return self:opterror(opt, (ident or "name") ..
                                                     " expected")
                        end
                        self.pos = pos
                        return ident, b
                    end
                end

                Lexer.full_ident = function(self, name, opt)
                    -- function num : 0_18
                    self:whitespace()
                    local b, ident, pos = self("^()([%a_][%w_.]*)%s*()")
                    if not name then
                        do
                            return self:opterror(opt, (ident and
                                                     not ident:match("%.%.+") or
                                                     "name") .. " expected")
                        end
                        self.pos = pos
                        return ident, b
                    end
                end

                Lexer.integer = function(self, opt)
                    -- function num : 0_19 , upvalues : _ENV
                    self:whitespace()
                    local ns, oct, hex, s, pos =
                        self("^([+-]?)(0?)([xX]?)([0-9a-fA-F]+)%s*()")
                    local n = nil
                    if oct == "0" and hex == "" then
                        n = tonumber(s, 8)
                    else
                        if oct == "" and hex == "" then
                            n = tonumber(s, 10)
                        else
                            if oct == "0" and hex ~= "" then
                                n = tonumber(s, 16)
                            end
                        end
                    end
                    if not n then
                        return self:opterror(opt, "integer expected")
                    end
                    self.pos = pos
                    return ns == "-" and -n or n
                end

                Lexer.number = function(self, opt)
                    -- function num : 0_20 , upvalues : _ENV
                    self:whitespace()
                    if self:test("nan%f[%A]") then
                        return 0 / 0
                    else
                        if self:test("inf%f[%A]") then
                            return 1 / 0
                        end
                    end
                    local ns, d1, s, d2, s2, pos =
                        self("^([+-]?)(%.?)([0-9]+)(%.?)([0-9]*)()")
                    if not ns then
                        return self:opterror(opt,
                                             "floating-point number expected")
                    end
                    local es, pos2 = self("(^[eE][+-]?[0-9]+)%s*()", pos)
                    if d1 == "." and d2 == "." then
                        return self:error("malformed floating-point number")
                    end
                    self.pos = pos2 or pos
                    local n = tonumber(d1 .. s .. d2 .. s2 .. (es or ""))
                    return ns == "-" and -n or n
                end

                Lexer.quote = function(self, opt)
                    -- function num : 0_21 , upvalues : tohex, todec, toesc
                    self:whitespace()
                    local q, start = self("^([\"\'])()")
                    if not start then
                        return self:opterror(opt, "string expected")
                    end
                    self.pos = start
                    local patt = "()(\\?" .. q .. ")%s*()"
                    while 1 do
                        local stop, s, pos = self(patt)
                        if not stop then
                            self.pos = start - 1
                            return self:error("unfinished string")
                        end
                        self.pos = pos
                        if s == q then
                            return ((((self.src):sub(start, stop - 1)):gsub(
                                       "\\x(%x+)", tohex)):gsub("\\(%d+)", todec)):gsub(
                                       "\\(.)", toesc)
                        end
                    end
                end

                Lexer.constant = function(self, opt)
                    -- function num : 0_22
                    if not self:full_ident("constant", "opt") and
                        not self:number("opt") then
                        local c = self:quote("opt")
                    end
                    if not c and not opt then
                        return self:error("constant expected")
                    end
                    return c
                end

                Lexer.option_name = function(self)
                    -- function num : 0_23
                    local ident = nil
                    if self:test("%(") then
                        ident = self:full_ident("option name")
                        self:expected("%)")
                    else
                        ident = self:ident("option name")
                    end
                    while self:test("%.") do
                        ident = ident .. "." .. self:ident()
                    end
                    return ident
                end

                Lexer.type_name = function(self)
                    -- function num : 0_24
                    if self:test("%.") then
                        local id, pos = self:full_ident("type name")
                        return "." .. id, pos
                    else
                        do
                            do
                                return self:full_ident("type name")
                            end
                        end
                    end
                end

            end
            local Parser = meta("Parser")
            Parser.typemap = {}
            Parser.loaded = {}
            Parser.paths = {"", "."}
            Parser.new = function()
                -- function num : 0_25 , upvalues : _ENV, Parser
                local self = {}
                self.typemap = {}
                self.loaded = {}
                self.paths = {"", "."}
                return setmetatable(self, Parser)
            end

            Parser.error = function(self, msg)
                -- function num : 0_26
                return (self.lex):error(msg)
            end

            Parser.addpath = function(self, path)
                -- function num : 0_27
                -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

                (self.paths)[#self.paths + 1] = path
            end

            Parser.parsefile = function(self, name)
                -- function num : 0_28 , upvalues : _ENV
                local info = (self.loaded)[name]
                if info then return info end
                local errors = {}
                for _, path in ipairs(self.paths) do
                    local fn = path ~= "" and path .. "/" .. name or name
                    local fh, err = (io.open)(fn)
                    do
                        if fh then
                            local content = fh:read("*a")
                            info = self:parse(content, name)
                            fh:close()
                            return info
                        end
                        if not err then
                            do
                                errors[#errors + 1] =
                                    fn .. ": " .. "unknown error"
                                -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_STMT

                                -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out DO_STMT

                            end
                        end
                    end
                end
                if self.import_fallback then
                    info = (self.import_fallback)(name)
                end
                if not info then
                    error("module load error: " .. name .. "\n\t" ..
                              (table.concat)(errors, "\n\t"))
                end
                return info
            end

            local labels = {optional = 1, required = 2, repeated = 3}
            local key_types = {
                int32 = 5,
                int64 = 3,
                uint32 = 13,
                uint64 = 4,
                sint32 = 17,
                sint64 = 18,
                fixed32 = 7,
                fixed64 = 6,
                sfixed32 = 15,
                sfixed64 = 16,
                bool = 8,
                string = 9
            }
            local com_types = {group = 10, message = 11, enum = 14}
            local types = {
                double = 1,
                float = 2,
                int32 = 5,
                int64 = 3,
                uint32 = 13,
                uint64 = 4,
                sint32 = 17,
                sint64 = 18,
                fixed32 = 7,
                fixed64 = 6,
                sfixed32 = 15,
                sfixed64 = 16,
                bool = 8,
                string = 9,
                bytes = 12,
                group = 10,
                message = 11,
                enum = 14
            }
            local register_type = function(self, lex, tname, type)
                -- function num : 0_29
                if not tname:match("%.") then
                    tname = self.prefix .. tname
                end
                if (self.typemap)[tname] then
                    return lex:error("type %s already defined", tname)
                end -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'
                
                (self.typemap)[tname] = type
            end

            local type_info = function(lex, tname)
                -- function num : 0_30 , upvalues : types, com_types
                local tenum = types[tname]
                if com_types[tname] then
                    return lex:error("invalid type name: " .. tname)
                else
                    if tenum then tname = nil end
                end
                return tenum, tname
            end

            local map_info = function(lex)
                -- function num : 0_31 , upvalues : key_types, _ENV, type_info, types, labels
                local keyt = lex:ident("key type")
                if not key_types[keyt] then
                    return lex:error("invalid key type: " .. keyt)
                end
                local valt = (lex:expected(",")):type_name()
                local name = (lex:expected(">")):ident()
                local ident = (name:gsub("^%a", string.upper)):gsub("_(%a)",
                                                                    string.upper) ..
                                  "Entry"
                local kt, ktn = type_info(lex, keyt)
                local vt, vtn = type_info(lex, valt)
                return name, types.message, ident, {
                    name = ident,
                    field = {
                        {
                            name = "key",
                            number = 1,
                            label = labels.optional,
                            type = kt,
                            type_name = ktn
                        }, {
                            name = "value",
                            number = 2,
                            label = labels.optional,
                            type = vt,
                            type_name = vtn
                        }
                    },
                    options = {map_entry = true}
                }
            end

            local inline_option = function(lex, info)
                -- function num : 0_32
                if lex:test("%[") then
                    if not info then info = {} end
                    while 1 do
                        local name = lex:option_name()
                        local value = (lex:expected("=")):constant()
                        info[name] = value
                        if lex:test("%]") then
                            return info
                        end
                        lex:expected(",")
                    end
                end
            end

            do
                local field = function(self, lex, ident)
                    -- function num : 0_33 , upvalues : map_info, register_type, types, type_info, labels, inline_option, _ENV
                    local name, type, type_name, map_entry = nil, nil, nil, nil
                    if ident == "map" and lex:test("%<") then
                        name = map_info(lex) -- DECOMPILER ERROR at PC19: Confused about usage of register: R7 in 'UnsetPending'
                        ;
                        (self.locmap)[(map_entry.field)[1]] = lex.pos -- DECOMPILER ERROR at PC24: Confused about usage of register: R7 in 'UnsetPending'
                        ;
                        (self.locmap)[(map_entry.field)[2]] = lex.pos
                        register_type(self, lex, type_name, types.message)
                    else
                        -- DECOMPILER ERROR at PC36: Overwrote pending register: R5 in 'AssignReg'

                        -- DECOMPILER ERROR at PC37: Overwrote pending register: R4 in 'AssignReg'

                        name = lex:ident()
                    end
                    local info = {
                        name = name,
                        number = (lex:expected("=")):integer(),
                        label = ident == "map" and labels.repeated or
                            labels.optional,
                        type = type,
                        type_name = type_name
                    }
                    local options = inline_option(lex)
                    if options then
                        info.default_value = tostring(options.default)
                        info.json_name = options.json_name
                        if options.packed and options.packed == "false" then
                            options.packed = false
                        end
                    end
                    info.options = options
                    if info.number <= 0 then
                        lex:error("invalid tag number: " .. info.number)
                    end
                    return info, map_entry
                end

                local label_field = function(self, lex, ident)
                    -- function num : 0_34 , upvalues : labels, field
                    local label = labels[ident]
                    local info, map_entry = nil, nil
                    if not label then
                        if self.syntax == "proto2" and ident ~= "map" then
                            return lex:error("proto2 disallow missing label")
                        end
                        return field(self, lex, ident)
                    end
                    if label == labels.optional and self.syntax == "proto3" then
                        return lex:error("proto3 disallow \'optional\' label")
                    end
                    info = field(self, lex, lex:type_name())
                    info.label = label
                    return info, map_entry
                end

                local toplevel = {}
                toplevel.package = function(self, lex, info)
                    -- function num : 0_35
                    local package = lex:full_ident("package name")
                    lex:line_end()
                    info.package = package
                    self.prefix = "." .. package .. "."
                    return self
                end

                toplevel.import = function(self, lex, info)
                    -- function num : 0_36 , upvalues : default
                    local mode = lex:ident("\"weak\" or \"public\"", "opt") or
                                     "public"
                    if mode ~= "weak" and mode ~= "public" then
                        return lex:error("\"weak or \"public\" expected")
                    end
                    local name = lex:quote()
                    lex:line_end()
                    local result = self:parsefile(name)
                    if self.on_import then
                        (self.on_import)(result)
                    end
                    local dep = default(info, "dependency")
                    local index = #dep
                    dep[index + 1] = name
                    if mode == "public" then
                        local it = default(info, "public_dependency")
                        it[#it + 1] = index
                    else
                        do
                            local it = default(info, "weak_dependency")
                            it[#it + 1] = index
                        end
                    end
                end

                local msg_body = {}
                msg_body.message = function(self, lex, info)
                    -- function num : 0_37 , upvalues : default, toplevel
                    local nested_type = default(info, "nested_type")
                    nested_type[#nested_type + 1] =
                        (toplevel.message)(self, lex)
                    return self
                end

                msg_body.enum = function(self, lex, info)
                    -- function num : 0_38 , upvalues : default, toplevel
                    local nested_type = default(info, "enum_type")
                    nested_type[#nested_type + 1] = (toplevel.enum)(self, lex)
                    return self
                end

                msg_body.extend = function(self, lex, info)
                    -- function num : 0_39 , upvalues : default, toplevel, _ENV
                    local extension = default(info, "extension")
                    local nested_type = default(info, "nested_type")
                    local ft, mt = (toplevel.extend)(self, lex, {})
                    for _, v in ipairs(ft) do
                        extension[#extension + 1] = v
                    end
                    for _, v in ipairs(mt) do
                        nested_type[#nested_type + 1] = v
                    end
                    return self
                end

                msg_body.extensions = function(self, lex, info)
                    -- function num : 0_40 , upvalues : default, _ENV
                    local rt = default(info, "extension_range")
                    repeat
                        local start = lex:integer("field number range")
                        local stop = (math.floor)(536870912)
                        lex:keyword("to")
                        if not lex:keyword("max", "opt") then
                            stop = lex:integer(
                                       "field number range end or \'max\'")
                        end
                        rt[#rt + 1] = {start = start, ["end"] = stop}
                    until not lex:test(",")
                    lex:line_end()
                    return self
                end

                msg_body.reserved = function(self, lex, info)
                    -- function num : 0_41 , upvalues : default
                    if lex:test("%a") then
                        local rt = default(info, "reserved_name")
                        repeat
                            rt[#rt + 1] = lex:ident("field name")
                        until not lex:test(",")
                    else
                        do
                            local rt = default(info, "reserved_range")
                            local first = true
                            repeat
                                local start =
                                    lex:integer(
                                        first and "field name or number range" or
                                            "field number range")
                                if lex:keyword("to", "opt") then
                                    local stop =
                                        lex:integer("field number range end")
                                    rt[#rt + 1] =
                                        {start = start, ["end"] = stop}
                                else
                                    do
                                        rt[#rt + 1] =
                                            {start = start, ["end"] = start}
                                        first = false
                                    end
                                end
                            until not lex:test(",")
                            do
                                lex:line_end()
                                return self
                            end
                        end
                    end
                end

                msg_body.oneof = function(self, lex, info)
                    -- function num : 0_42 , upvalues : default, toplevel, field
                    local fs = default(info, "field")
                    local ts = default(info, "nested_type")
                    local ot = default(info, "oneof_decl")
                    local index = #ot + 1
                    local oneof = {name = lex:ident()}
                    lex:expected("{")
                    while 1 do
                        if not lex:test("}") then
                            local ident = lex:type_name()
                            if ident == "option" then
                                (toplevel.option)(self, lex, oneof)
                            else
                                local f, t = field(self, lex, ident, "no_label") -- DECOMPILER ERROR at PC44: Confused about usage of register: R11 in 'UnsetPending'
                                ;
                                (self.locmap)[f] = lex.pos
                                if t then
                                    ts[#ts + 1] = t
                                end
                                f.oneof_index = index - 1
                                fs[#fs + 1] = f
                            end
                            do
                                do
                                    lex:line_end("opt")
                                    -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out DO_STMT

                                    -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                    -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_STMT

                                end
                            end
                        end
                    end
                    ot[index] = oneof
                end

                toplevel.message = function(self, lex, info)
                    -- function num : 0_43 , upvalues : register_type, types, msg_body, default, label_field
                    local name = lex:ident("message name")
                    local type = {name = name}
                    register_type(self, lex, name, types.message)
                    local prefix = self.prefix
                    self.prefix = prefix .. name .. "."
                    lex:expected("{")
                    while 1 do
                        if not lex:test("}") then
                            local ident, pos = lex:type_name()
                            local body_parser = msg_body[ident]
                            if body_parser then
                                body_parser(self, lex, type)
                            else
                                local fs = default(type, "field")
                                local f, t = label_field(self, lex, ident) -- DECOMPILER ERROR at PC46: Confused about usage of register: R12 in 'UnsetPending'
                                ;
                                (self.locmap)[f] = pos
                                fs[#fs + 1] = f
                                if t then
                                    local ts = default(type, "nested_type")
                                    ts[#ts + 1] = t
                                end
                            end
                            do
                                do
                                    lex:line_end("opt")
                                    -- DECOMPILER ERROR at PC62: LeaveBlock: unexpected jumping out DO_STMT

                                    -- DECOMPILER ERROR at PC62: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                    -- DECOMPILER ERROR at PC62: LeaveBlock: unexpected jumping out IF_STMT

                                end
                            end
                        end
                    end
                    lex:line_end("opt")
                    if info then
                        info = default(info, "message_type")
                        info[#info + 1] = type
                    end
                    self.prefix = prefix
                    return type
                end

                toplevel.enum = function(self, lex, info)
                    -- function num : 0_44 , upvalues : register_type, types, toplevel, default, inline_option
                    local name = lex:ident("enum name")
                    local enum = {name = name}
                    register_type(self, lex, name, types.enum)
                    lex:expected("{")
                    while 1 do
                        if not lex:test("}") then
                            local ident = lex:ident("enum constant name")
                            if ident == "option" then
                                (toplevel.option)(self, lex,
                                                  default(enum, "options"))
                            else
                                local values = default(enum, "value")
                                local number = (lex:expected("=")):integer()
                                lex:line_end()
                                values[#values + 1] =
                                    {
                                        name = ident,
                                        number = number,
                                        options = inline_option(lex)
                                    }
                            end
                            do
                                do
                                    lex:line_end("opt")
                                    -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out DO_STMT

                                    -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                    -- DECOMPILER ERROR at PC57: LeaveBlock: unexpected jumping out IF_STMT

                                end
                            end
                        end
                    end
                    lex:line_end("opt")
                    if info then
                        info = default(info, "enum_type")
                        info[#info + 1] = enum
                    end
                    return enum
                end

                toplevel.option = function(self, lex, info)
                    -- function num : 0_45 , upvalues : default
                    local ident = lex:option_name()
                    lex:expected("=")
                    local value = lex:constant()
                    lex:line_end()
                    if not info or not default(info, "options") then
                        local options = {}
                    end
                    options[ident] = value
                    return options, self
                end

                toplevel.extend = function(self, lex, info)
                    -- function num : 0_46 , upvalues : default, label_field
                    local name = lex:type_name()
                    if not info or not default(info, "extension") then
                        local ft = {}
                    end
                    if not info or not default(info, "message_type") then
                        local mt = {}
                    end
                    lex:expected("{")
                    while not lex:test("}") do
                        local ident, pos = lex:type_name()
                        local f, t = label_field(self, lex, ident) -- DECOMPILER ERROR at PC36: Confused about usage of register: R10 in 'UnsetPending'
                        ;
                        (self.locmap)[f] = pos
                        f.extendee = name
                        ft[#ft + 1] = f
                        mt[#mt + 1] = t
                        lex:line_end("opt")
                    end
                    do return ft, mt end
                end

                do
                    local svr_body = {}
                    svr_body.rpc = function(self, lex, info)
                        -- function num : 0_47 , upvalues : type_info, toplevel, default
                        local name, pos = lex:ident("rpc name")
                        local rpc = {name = name} -- DECOMPILER ERROR at PC6: Confused about usage of register: R6 in 'UnsetPending'
                        ;
                        (self.locmap)[rpc] = pos
                        local _, tn = nil, nil
                        lex:expected("%(")
                        rpc.client_stream = lex:keyword("stream", "opt")
                        _ = type_info(lex, lex:type_name())
                        if not tn then
                            return lex:error("rpc input type must by message")
                        end
                        rpc.input_type = tn;
                        ((lex:expected("%)")):expected("returns")):expected("%(")
                        rpc.server_stream = lex:keyword("stream", "opt")
                        -- DECOMPILER ERROR at PC49: Overwrote pending register: R7 in 'AssignReg'

                        _ = type_info(lex, lex:type_name())
                        if not tn then
                            return lex:error("rpc output type must by message")
                        end
                        rpc.output_type = tn
                        lex:expected("%)")
                        while lex:test("{") and not lex:test("}") do
                            lex:line_end("opt")
                            lex:keyword("option");
                            (toplevel.option)(self, lex, default(rpc, "options"))
                        end
                        lex:line_end("opt")
                        local t = default(info, "method")
                        t[#t + 1] = rpc
                    end

                    svr_body.stream = function(_, lex)
                        -- function num : 0_48
                        lex:error("stream not implement yet")
                    end

                    toplevel.service = function(self, lex, info)
                        -- function num : 0_49 , upvalues : svr_body, default
                        local name = lex:ident("service name")
                        local svr = {name = name}
                        lex:expected("{")
                        while not lex:test("}") do
                            local ident = lex:type_name()
                            local body_parser = svr_body[ident]
                            if body_parser then
                                body_parser(self, lex, svr)
                            else
                                return lex:error(
                                           "expected \'rpc\' or \'option\' in service body")
                            end
                            lex:line_end("opt")
                        end
                        do
                            lex:line_end("opt")
                            if info then
                                info = default(info, "service")
                                info[#info + 1] = svr
                            end
                            return svr
                        end
                    end

                    local make_context =
                        function(self, lex)
                            -- function num : 0_50 , upvalues : _ENV, Parser
                            local ctx = {
                                syntax = "proto2",
                                locmap = {},
                                prefix = ".",
                                lex = lex,
                                parser = self
                            }
                            ctx.loaded = self.loaded
                            ctx.typemap = self.typemap
                            ctx.paths = self.paths
                            ctx.import_fallback =
                                function(import_name)
                                    -- function num : 0_50_0 , upvalues : self, _ENV
                                    if self.unknown_import == true then
                                        return true
                                    else
                                        if not import_name:match(
                                            self.unknown_import) or not true then
                                            do
                                                return
                                                    type(self.unknown_import) ~=
                                                        "string" or nil
                                            end
                                            if self.unknown_import then
                                                return
                                                    self:unknown_import(
                                                        import_name)
                                            end
                                        end
                                    end
                                end

                            ctx.type_fallback =
                                function(type_name)
                                    -- function num : 0_50_1 , upvalues : self, _ENV
                                    if self.unknown_type == true then
                                        return true
                                    else
                                        if type_name:match(self.unknown_type) then
                                            do
                                                return
                                                    type(self.unknown_type) ~=
                                                        "string" or true
                                            end
                                            if self.unknown_type then
                                                return
                                                    self:unknown_type(type_name)
                                            end
                                        end
                                    end
                                end

                            ctx.on_import =
                                function(info)
                                    -- function num : 0_50_2 , upvalues : self
                                    if self.on_import then
                                        return (self.on_import)(info)
                                    end
                                end

                            return setmetatable(ctx, Parser)
                        end

                    Parser.parse = function(self, src, name)
                        -- function num : 0_51 , upvalues : _ENV, Lexer, make_context, toplevel
                        local loaded = (self.loaded)[name]
                        -- DECOMPILER ERROR at PC10: Unhandled construct in 'MakeBoolean' P1

                        if loaded and loaded == true then
                            error("loop loaded: " .. name)
                        end
                        do return loaded end
                        if not name then name = "<input>" end -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'
                        
                        (self.loaded)[name] = true
                        local lex = (Lexer.new)(name, src)
                        local info = {name = lex.name}
                        local ctx = make_context(self, lex)
                        local syntax = lex:keyword("syntax", "opt")
                        if syntax then
                            info.syntax = (lex:expected("=")):quote()
                            ctx.syntax = info.syntax
                            lex:line_end()
                        end
                        while not lex:eof() do
                            local ident = lex:ident()
                            local top_parser = toplevel[ident]
                            if top_parser then
                                top_parser(ctx, lex, info)
                            else
                                lex:error("unknown keyword \'" .. ident .. "\'")
                            end
                            lex:line_end("opt")
                        end
                        do
                            -- DECOMPILER ERROR at PC75: Confused about usage of register: R8 in 'UnsetPending'


                            (self.loaded)[name] =
                                name ~= "<input>" and info or nil
                            return ctx:resolve(lex, info)
                        end
                    end

                    local empty = function()
                        -- function num : 0_52
                    end

                    local iter = function(t, k)
                        -- function num : 0_53 , upvalues : _ENV, empty
                        local v = t[k]
                        if v then return ipairs(v) end
                        return empty
                    end

                    local check_dup = function(self, lex, type, map, k, v)
                        -- function num : 0_54
                        local old = map[v[k]]
                        do
                            if old then
                                local ln, co = lex:pos2loc((self.locmap)[old])
                                lex:error("%s \'%s\' exists, previous at %d:%d",
                                          type, v[k], ln, co)
                            end
                            map[v[k]] = v
                        end
                    end

                    local check_type = function(self, lex, tname)
                        -- function num : 0_55 , upvalues : _ENV, types
                        do
                            if tname:match("^%.") then
                                local t = (self.typemap)[tname]
                                if not t then
                                    return
                                        lex:error("unknown type \'%s\'", tname)
                                end
                                return t, tname
                            end
                            local prefix = self.prefix
                            for i = #prefix + 1, 1, -1 do
                                local op = prefix[i]
                                prefix[i] = tname
                                local tn = (table.concat)(prefix, ".", 1, i)
                                prefix[i] = op
                                local t = (self.typemap)[tn]
                                if t then
                                    return t, tn
                                end
                            end
                            local tn, t = nil, nil
                            if self.type_fallback then
                                tn = (self.type_fallback)(tname)
                            end
                            -- DECOMPILER ERROR at PC55: Overwrote pending register: R5 in 'AssignReg'

                            if t or tn == true then
                                tn = "." .. tname
                            end
                            do return t, tn end
                            return lex:error("unknown type \'%s\'", tname)
                        end
                    end

                    local check_field = function(self, lex, info)
                        -- function num : 0_56 , upvalues : check_type, types
                        do
                            if info.extendee then
                                local t, tn =
                                    check_type(self, lex, info.extendee)
                                if t ~= types.message then
                                    lex:error(
                                        "message type expected in extension")
                                end
                                info.extendee = tn
                            end
                            if info.type_name then
                                local t, tn =
                                    check_type(self, lex, info.type_name)
                                info.type = t
                                info.type_name = tn
                            end
                        end
                    end

                    local check_enum = function(self, lex, info)
                        -- function num : 0_57 , upvalues : iter, check_dup
                        local names, numbers = {}, {}
                        for _, v in iter(info, "value") do
                            lex.pos = (self.locmap)[v]
                            check_dup(self, lex, "enum name", names, "name", v)
                            if not info.options or not (info.options).options or
                                not ((info.options).options).allow_alias then
                                check_dup(self, lex, "enum number", numbers,
                                          "number", v)
                            end
                        end
                    end

                    local check_message =
                        function(self, lex, info)
                            -- function num : 0_58 , upvalues : iter, _ENV, check_dup, check_field, check_message
                            -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

                            (self.prefix)[#self.prefix + 1] = info.name
                            local names, numbers = {}, {}
                            for _, v in iter(info, "field") do
                                lex.pos = assert((self.locmap)[v])
                                check_dup(self, lex, "field name", names,
                                          "name", v)
                                check_dup(self, lex, "field number", numbers,
                                          "number", v)
                                check_field(self, lex, v)
                            end
                            for _, v in iter(info, "nested_type") do
                                check_message(self, lex, v)
                            end
                            for _, v in iter(info, "extension") do
                                lex.pos = assert((self.locmap)[v])
                                check_field(self, lex, v)
                            end -- DECOMPILER ERROR at PC73: Confused about usage of register: R5 in 'UnsetPending'
                            
                            (self.prefix)[#self.prefix] = nil
                        end

                    local check_service =
                        function(self, lex, info)
                            -- function num : 0_59 , upvalues : iter, check_dup, check_type, types
                            local names = {}
                            for _, v in iter(info, "method") do
                                lex.pos = (self.locmap)[v]
                                check_dup(self, lex, "rpc name", names, "name",
                                          v)
                                local t, tn =
                                    check_type(self, lex, v.input_type)
                                v.input_type = tn
                                if t ~= types.message then
                                    lex:error(
                                        "message type expected in parameter")
                                end
                                t = check_type(self, lex, v.output_type)
                                v.output_type = tn
                                if t ~= types.message then
                                    lex:error("message type expected in return")
                                end
                            end
                        end

                    Parser.resolve = function(self, lex, info)
                        -- function num : 0_60 , upvalues : iter, check_message, check_enum, check_service, _ENV, check_field
                        self.prefix = {"", info.package}
                        for _, v in iter(info, "message_type") do
                            check_message(self, lex, v)
                        end
                        for _, v in iter(info, "enum_type") do
                            check_enum(self, lex, v)
                        end
                        for _, v in iter(info, "service") do
                            check_service(self, lex, v)
                        end
                        for _, v in iter(info, "extension") do
                            lex.pos = assert((self.locmap)[v])
                            check_field(self, lex, v)
                        end
                        self.prefix = nil
                        return info
                    end

                end
                do
                    local has_pb, pb = pcall(require, "pb")
                    if has_pb then
                        local descriptor_pb =
                            "\n\249#\n\016descriptor.proto\018\015google.protobuf\"G\n\017FileDescript" ..
                                "orSet\0182\n\004file\024\001 \003(\v2$.google.protobuf.FileDescriptorProto\"" ..
                                "\219\003\n\019FileDescriptorProto\018\f\n\004name\024\001 \001(\t\018\015\n\apack" ..
                                "age\024\002 \001(\t\018\018\n\ndependency\024\003 \003(\t\018\025\n\017public_depend" ..
                                "ency\024\n \003(\005\018\023\n\015weak_dependency\024\v \003(\005\0186\n\fmessag" ..
                                "e_type\024\004 \003(\v2 .google.protobuf.DescriptorProto\0187\n\tenum_type" ..
                                "\024\005 \003(\v2$.google.protobuf.EnumDescriptorProto\0188\n\aservice\024" ..
                                "\006 \003(\v2\'.google.protobuf.ServiceDescriptorProto\0188\n\textension" ..
                                "\024\a \003(\v2%.google.protobuf.FieldDescriptorProto\018-\n\aoptions\024" ..
                                "\b \001(\v2\028.google.protobuf.FileOptions\0189\n\016source_code_info\024" ..
                                "\t \001(\v2\031.google.protobuf.SourceCodeInfo\018\014\n\006syntax\024\f \001(" ..
                                "\t\"\228\003\n\015DescriptorProto\018\f\n\004name\024\001 \001(\t\0184\n\005field" ..
                                "\024\002 \003(\v2%.google.protobuf.FieldDescriptorProto\0188\n\textension" ..
                                "\024\006 \003(\v2%.google.protobuf.FieldDescriptorProto\0185\n\vnested_ty" ..
                                "pe\024\003 \003(\v2 .google.protobuf.DescriptorProto\0187\n\tenum_type\024" ..
                                "\004 \003(\v2$.google.protobuf.EnumDescriptorProto\018H\n\015extension_rang" ..
                                "e\024\005 \003(\v2/.google.protobuf.DescriptorProto.ExtensionRange\0189\n" ..
                                "\noneof_decl\024\b \003(\v2%.google.protobuf.OneofDescriptorProto\0180" ..
                                "\n\aoptions\024\a \001(\v2\031.google.protobuf.MessageOptions\026,\n\014Ex" ..
                                "tensionRange\018\r\n\005start\024\001 \001(\005\018\v\n\003end\024\002 \001(\005\"\169\005" ..
                                "\n\020FieldDescriptorProto\018\f\n\004name\024\001 \001(\t\018\014\n\006number\024" ..
                                "\003 \001(\005\018:\n\005label\024\004 \001(\0142+.google.protobuf.FieldDescriptorPro" ..
                                "to.Label\0188\n\004type\024\005 \001(\0142*.google.protobuf.FieldDescriptorPro" ..
                                "to.Type\018\017\n\ttype_name\024\006 \001(\t\018\016\n\bextendee\024\002 \001(\t\018" ..
                                "\021\n\rdefault_value\024\a \001(\t\018\019\n\voneof_index\024\t \001(\005\018." ..
                                "\n\aoptions\024\b \001(\v2\029.google.protobuf.FieldOptions\"\182\002\n\004T" ..
                                "ype\018\015\n\vTYPE_DOUBLE\016\001\018\014\n\nTYPE_FLOAT\016\002\018\014\n\nTY" ..
                                "PE_INT64\016\003\018\015\n\vTYPE_UINT64\016\004\018\014\n\nTYPE_INT32\016\005\018" ..
                                "\016\n\fTYPE_FIXED64\016\006\018\016\n\fTYPE_FIXED32\016\a\018\r\n\tTYPE_B" ..
                                "OOL\016\b\018\015\n\vTYPE_STRING\016\t\018\014\n\nTYPE_GROUP\016\n\018\016" ..
                                "\n\fTYPE_MESSAGE\016\v\018\014\n\nTYPE_BYTES\016\f\018\015\n\vTYPE_UIN" ..
                                "T32\016\r\018\r\n\tTYPE_ENUM\016\014\018\017\n\rTYPE_SFIXED32\016\015\018\017" ..
                                "\n\rTYPE_SFIXED64\016\016\018\015\n\vTYPE_SINT32\016\017\018\015\n\vTYPE_S" ..
                                "INT64\016\018\"C\n\005Label\018\018\n\014LABEL_OPTIONAL\016\001\018\018\n\014LABEL" ..
                                "_REQUIRED\016\002\018\018\n\014LABEL_REPEATED\016\003\"$\n\020OneofDescriptorPro" ..
                                "to\018\f\n\004name\024\001 \001(\t\"\140\001\n\019EnumDescriptorProto\018\f\n\004" ..
                                "name\024\001 \001(\t\0188\n\005value\024\002 \003(\v2).google.protobuf.EnumValueD" ..
                                "escriptorProto\018-\n\aoptions\024\003 \001(\v2\028.google.protobuf.EnumOpti" ..
                                "ons\"l\n\024EnumValueDescriptorProto\018\f\n\004name\024\001 \001(\t\018\014\n" ..
                                "\006number\024\002 \001(\005\0182\n\aoptions\024\003 \001(\v2!.google.protobuf.Enum" ..
                                "ValueOptions\"\144\001\n\022ServiceDescriptorProto\018\f\n\004name\024\001 \001(" ..
                                "\t\0186\n\006method\024\002 \003(\v2&.google.protobuf.MethodDescriptorProto" ..
                                "\0180\n\aoptions\024\003 \001(\v2\031.google.protobuf.ServiceOptions\"\193" ..
                                "\001\n\021MethodDescriptorProto\018\f\n\004name\024\001 \001(\t\018\018\n\ninput" ..
                                "_type\024\002 \001(\t\018\019\n\voutput_type\024\003 \001(\t\018/\n\aoptions\024\004 " ..
                                "\001(\v2\030.google.protobuf.MethodOptions\018\031\n\016client_streaming\024" ..
                                "\005 \001(\b:\005false\018\031\n\016server_streaming\024\006 \001(\b:\005false\"\231\004" ..
                                "\n\vFileOptions\018\020\n\fjava_package\024\001 \001(\t\018\028\n\020java_out" ..
                                "er_classname\024\b \001(\t\018\"\n\019java_multiple_files\024\n \001(\b:\005fals" ..
                                "e\018,\n\029java_generate_equals_and_hash\024\020 \001(\b:\005false\018%\n\022ja" ..
                                "va_string_check_utf8\024\027 \001(\b:\005false\018F\n\foptimize_for\024\t \001(" ..
                                "\0142).google.protobuf.FileOptions.OptimizeMode:\005SPEED\018\018\n\ngo_pa" ..
                                "ckage\024\v \001(\t\018\"\n\019cc_generic_services\024\016 \001(\b:\005false\018$" ..
                                "\n\021java_generic_services\024\017 \001(\b:\005false\018\"\n\019py_generic_ser" ..
                                "vices\024\018 \001(\b:\005false\018\025\n\ndeprecated\024\023 \001(\b:\005false\018" ..
                                "\031\n\016cc_enable_arenas\024\031 \001(\b:\005false\018\025\n\017objc_class_pref" ..
                                "ix\024$ \001(\t\018C\n\020uninterpreted_option\024\231\a \003(\v2$.google.pro" ..
                                "tobuf.UninterpretedOption\":\n\fOptimizeMode\018\t\n\005SPEED\016\001\018\r" ..
                                "\n\tCODE_SIZE\016\002\018\016\n\fLITE_RUNTIME\016\003*\t\b\232\a\016\128\128" ..
                                "\128\128\002\"\230\001\n\014MessageOptions\018&\n\023message_set_wire_format" ..
                                "\024\001 \001(\b:\005false\018.\n\031no_standard_descriptor_accessor\024\002 \001(\b:" ..
                                "\005false\018\025\n\ndeprecated\024\003 \001(\b:\005false\018\017\n\tmap_entry\024" ..
                                "\a \001(\b\018C\n\020uninterpreted_option\024\231\a \003(\v2$.google.protobu" ..
                                "f.UninterpretedOption*\t\b\232\a\016\128\128\128\128\002\"\160\002\n\fField" ..
                                "Options\018:\n\005ctype\024\001 \001(\0142#.google.protobuf.FieldOptions.CType:" ..
                                "\006STRING\018\014\n\006packed\024\002 \001(\b\018\019\n\004lazy\024\005 \001(\b:\005false" ..
                                "\018\025\n\ndeprecated\024\003 \001(\b:\005false\018\019\n\004weak\024\n \001(\b:\005f" ..
                                "alse\018C\n\020uninterpreted_option\024\231\a \003(\v2$.google.protobuf.Un" ..
                                "interpretedOption\"/\n\005CType\018\n\n\006STRING\016\000\018\b\n\004CORD\016\001" ..
                                "\018\016\n\fSTRING_PIECE\016\002*\t\b\232\a\016\128\128\128\128\002\"\141\001\n" ..
                                "\vEnumOptions\018\019\n\vallow_alias\024\002 \001(\b\018\025\n\ndeprecated" ..
                                "\024\003 \001(\b:\005false\018C\n\020uninterpreted_option\024\231\a \003(\v2$.goo" ..
                                "gle.protobuf.UninterpretedOption*\t\b\232\a\016\128\128\128\128\002\"}\n" ..
                                "\016EnumValueOptions\018\025\n\ndeprecated\024\001 \001(\b:\005false\018C\n\020un" ..
                                "interpreted_option\024\231\a \003(\v2$.google.protobuf.UninterpretedOptio" ..
                                "n*\t\b\232\a\016\128\128\128\128\002\"{\n\014ServiceOptions\018\025\n\ndepr" ..
                                "ecated\024! \001(\b:\005false\018C\n\020uninterpreted_option\024\231\a \003(\v2" ..
                                "$.google.protobuf.UninterpretedOption*\t\b\232\a\016\128\128\128\128\002\"z" ..
                                "\n\rMethodOptions\018\025\n\ndeprecated\024! \001(\b:\005false\018C\n\020uni" ..
                                "nterpreted_option\024\231\a \003(\v2$.google.protobuf.UninterpretedOption" ..
                                "*\t\b\232\a\016\128\128\128\128\002\"\158\002\n\019UninterpretedOption\018;\n" ..
                                "\004name\024\002 \003(\v2-.google.protobuf.UninterpretedOption.NamePart\018\024" ..
                                "\n\016identifier_value\024\003 \001(\t\018\026\n\018positive_int_value\024\004 \001(" ..
                                "\004\018\026\n\018negative_int_value\024\005 \001(\003\018\020\n\fdouble_value\024\006" ..
                                " \001(\001\018\020\n\fstring_value\024\a \001(\f\018\023\n\015aggregate_value" ..
                                "\024\b \001(\t\0263\n\bNamePart\018\017\n\tname_part\024\001 \002(\t\018\020\n\f" ..
                                "is_extension\024\002 \002(\b\"\213\001\n\014SourceCodeInfo\018:\n\blocation\024" ..
                                "\001 \003(\v2(.google.protobuf.SourceCodeInfo.Location\026\134\001\n\bLocati" ..
                                "on\018\016\n\004path\024\001 \003(\005B\002\016\001\018\016\n\004span\024\002 \003(\005B\002\016\001" ..
                                "\018\024\n\016leading_comments\024\003 \001(\t\018\025\n\017trailing_comments\024" ..
                                "\004 \001(\t\018!\n\025leading_detached_comments\024\006 \003(\tB)\n\019com.google" ..
                                ".protobufB\016DescriptorProtosH\001"
                        Parser.reload = function()
                            -- function num : 0_61 , upvalues : _ENV, pb, descriptor_pb
                            assert((pb.load)(descriptor_pb))
                        end

                        local do_compile =
                            function(self, f, ...)
                                -- function num : 0_62
                                if self.include_imports then
                                    local old = self.on_import
                                    do
                                        local infos = {}
                                        self.on_import =
                                            function(info)
                                                -- function num : 0_62_0 , upvalues : infos
                                                infos[#infos + 1] = info
                                            end

                                        local r = f(...)
                                        infos[#infos + 1] = r
                                        self.on_import = old
                                        return {file = infos}
                                    end
                                end
                                do
                                    return {file = {f(...)}}
                                end
                            end

                        Parser.compile =
                            function(self, s, name)
                                -- function num : 0_63 , upvalues : do_compile, pb
                                local set =
                                    do_compile(self, self.parse, self, s, name)
                                return (pb.encode)(
                                           ".google.protobuf.FileDescriptorSet",
                                           set)
                            end

                        Parser.compilefile =
                            function(self, fn)
                                -- function num : 0_64 , upvalues : do_compile, pb
                                local set =
                                    do_compile(self, self.parsefile, self, fn)
                                return (pb.encode)(
                                           ".google.protobuf.FileDescriptorSet",
                                           set)
                            end

                        Parser.load = function(self, s, name)
                            -- function num : 0_65 , upvalues : pb, _ENV
                            local ret, pos = (pb.load)(self:compile(s, name))
                            if ret then
                                return ret, pos
                            end
                            error("load failed at offset " .. pos)
                        end

                        Parser.loadfile =
                            function(self, fn)
                                -- function num : 0_66 , upvalues : pb, _ENV
                                local ret, pos = (pb.load)(self:compilefile(fn))
                                if ret then
                                    return ret, pos
                                end
                                error("load failed at offset " .. pos)
                            end;
                        (Parser.reload)()
                    end
                    do return Parser end
                end
            end
        end
    end
end

