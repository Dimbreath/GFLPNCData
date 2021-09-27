local utf8 = {}
utf8.next_raw = function(s, i)
  -- function num : 0_0
  if not i then
    if #s == 0 then
      return nil
    end
    return 1, true
  end
  if #s < i then
    return 
  end
  local c = s:byte(i)
  if c >= 0 and c <= 127 then
    i = i + 1
  else
    if c >= 194 and c <= 223 then
      i = i + 2
    else
      if c >= 224 and c <= 239 then
        i = i + 3
      else
        if c >= 240 and c <= 244 then
          i = i + 4
        else
          return i + 1, false
        end
      end
    end
  end
  if #s < i then
    return 
  end
  return i, true
end

utf8.next = utf8.next_raw
utf8.byte_indices = function(s, previ)
  -- function num : 0_1 , upvalues : utf8
  return utf8.next, s, previ
end

utf8.len = function(s)
  -- function num : 0_2 , upvalues : _ENV, utf8
  assert(s, "bad argument #1 to \'len\' (string expected, got nil)")
  local len = 0
  for _ in (utf8.byte_indices)(s) do
    len = len + 1
  end
  return len
end

utf8.byte_index = function(s, target_ci)
  -- function num : 0_3 , upvalues : utf8, _ENV
  if target_ci < 1 then
    return 
  end
  local ci = 0
  for i in (utf8.byte_indices)(s) do
    ci = ci + 1
    if ci == target_ci then
      return i
    end
  end
  assert(ci < target_ci, "invalid index")
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

utf8.char_index = function(s, target_i)
  -- function num : 0_4 , upvalues : utf8, _ENV
  if target_i < 1 or #s < target_i then
    return 
  end
  local ci = 0
  for i in (utf8.byte_indices)(s) do
    ci = ci + 1
    if i == target_i then
      return ci
    end
  end
  error("invalid index")
end

utf8.prev = function(s, nexti)
  -- function num : 0_5 , upvalues : utf8, _ENV
  if not nexti then
    nexti = #s + 1
  end
  if nexti <= 1 or #s + 1 < nexti then
    return 
  end
  local lasti, lastvalid = (utf8.next)(s)
  for i,valid in (utf8.byte_indices)(s) do
    if i == nexti then
      return lasti, lastvalid
    end
    lasti = i
  end
  if nexti == #s + 1 then
    return lasti, lastvalid
  end
  error("invalid index")
end

utf8.byte_indices_reverse = function(s, nexti)
  -- function num : 0_6 , upvalues : utf8, _ENV
  if #s < 200 then
    return utf8.prev, s, nexti
  else
    local t = {}
    do
      for i in (utf8.byte_indices)(s) do
        if not nexti or nexti > i then
          do
            (table.insert)(t, i)
            -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
      local i = #t + 1
      return function()
    -- function num : 0_6_0 , upvalues : i, t
    i = i - 1
    return t[i]
  end

    end
  end
end

utf8.sub = function(s, start_ci, end_ci)
  -- function num : 0_7 , upvalues : _ENV, utf8
  assert(start_ci >= 1)
  assert(not end_ci or end_ci >= 0)
  local ci = 0
  local start_i, end_i = nil, nil
  for i in (utf8.byte_indices)(s) do
    ci = ci + 1
    if ci == start_ci then
      start_i = i
    end
    if ci == end_ci then
      end_i = i
    end
  end
  if ci >= start_ci then
    assert(start_i, "invalid index")
    do return "" end
    if end_ci and not end_i then
      if end_ci < start_ci then
        return ""
      end
      assert(ci < end_ci, "invalid index")
    end
    if end_i then
      do return s:sub(start_i, end_i - 1) end
      -- DECOMPILER ERROR: 10 unprocessed JMP targets
    end
  end
end

utf8.contains = function(s, i, sub)
  -- function num : 0_8
  if i < 1 or #s < i then
    return nil
  end
  for si = 1, #sub do
    if s:byte(i + si - 1) ~= sub:byte(si) then
      return false
    end
  end
  return true
end

utf8.count = function(s, sub)
  -- function num : 0_9 , upvalues : _ENV, utf8
  assert(#sub > 0)
  local count = 0
  local i = 1
  while 1 do
    while 1 do
      if i then
        if (utf8.contains)(s, i, sub) then
          count = count + 1
          i = i + #sub
          -- DECOMPILER ERROR at PC24: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC24: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC24: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC24: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    if #s >= i then
      i = (utf8.next)(s, i)
      -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out IF_THEN_STMT

      -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out IF_STMT

    end
  end
  do return count end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

utf8.isvalid = function(s, i)
  -- function num : 0_10
  local c = s:byte(i)
  if not c then
    return false
  else
    if c >= 0 and c <= 127 then
      return true
    else
      if c >= 194 and c <= 223 then
        local c2 = s:byte(i + 1)
        return not c2 or (c2 >= 128 and c2 <= 191)
      elseif c >= 224 and c <= 239 then
        local c2 = s:byte(i + 1)
        local c3 = s:byte(i + 2)
        -- DECOMPILER ERROR at PC58: Unhandled construct in 'MakeBoolean' P1

        if c2 and c3 and (c2 < 160 or c2 > 191 or c3 < 128 or c3 > 191) then
          do return c ~= 224 end
          -- DECOMPILER ERROR at PC78: Unhandled construct in 'MakeBoolean' P1

          if c2 and c3 and (c2 < 128 or c2 > 191 or c3 < 128 or c3 > 191) then
            do return c < 225 or c > 236 end
            -- DECOMPILER ERROR at PC96: Unhandled construct in 'MakeBoolean' P1

            if c2 and c3 and (c2 < 128 or c2 > 159 or c3 < 128 or c3 > 191) then
              do
                do return c ~= 237 end
                if c >= 238 and c <= 239 then
                  if c == 239 and c2 == 191 and (c3 == 190 or c3 == 191) then
                    return false
                  end
                  return not c2 or not c3 or (c2 >= 128 and c2 <= 191 and c3 >= 128 and c3 <= 191)
                end
                if c >= 240 and c <= 244 then
                  local c2 = s:byte(i + 1)
                  local c3 = s:byte(i + 2)
                  local c4 = s:byte(i + 3)
                  -- DECOMPILER ERROR at PC163: Unhandled construct in 'MakeBoolean' P1

                  if c2 and c3 and c4 and (c2 < 144 or c2 > 191 or c3 < 128 or c3 > 191 or c4 < 128 or c4 > 191) then
                    do return c ~= 240 end
                    -- DECOMPILER ERROR at PC189: Unhandled construct in 'MakeBoolean' P1

                    if c2 and c3 and c4 and (c2 < 128 or c2 > 191 or c3 < 128 or c3 > 191 or c4 < 128 or c4 > 191) then
                      do return c < 241 or c > 243 end
                      -- DECOMPILER ERROR at PC213: Unhandled construct in 'MakeBoolean' P1

                      if c2 and c3 and c4 and (c2 < 128 or c2 > 143 or c3 < 128 or c3 > 191 or c4 < 128 or c4 > 191) then
                        do
                          do return c ~= 244 end
                          do return false end
                          -- DECOMPILER ERROR: 33 unprocessed JMP targets
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

utf8.next_valid = function(s, i)
  -- function num : 0_11 , upvalues : utf8
  local valid = nil
  i = (utf8.next_raw)(s, i)
  while 1 do
    -- DECOMPILER ERROR at PC21: Overwrote pending register: R2 in 'AssignReg'

    if i and (not valid or not (utf8.isvalid)(s, i)) then
      i = (utf8.next)(s, i)
      -- DECOMPILER ERROR at PC23: LeaveBlock: unexpected jumping out IF_THEN_STMT

      -- DECOMPILER ERROR at PC23: LeaveBlock: unexpected jumping out IF_STMT

    end
  end
  return i
end

utf8.valid_byte_indices = function(s)
  -- function num : 0_12 , upvalues : utf8
  return utf8.next_valid, s
end

utf8.validate = function(s)
  -- function num : 0_13 , upvalues : utf8, _ENV
  for i,valid in (utf8.byte_indices)(s) do
    if not valid or not (utf8.isvalid)(s, i) then
      error((string.format)("invalid utf8 char at #%d", i))
    end
  end
end

local table_lookup = function(s, i, j, t)
  -- function num : 0_14
  return t[s:sub(i, j)]
end

utf8.replace = function(s, f, ...)
  -- function num : 0_15 , upvalues : _ENV, utf8, table_lookup
  if type(f) == "table" then
    return (utf8.replace)(s, table_lookup, f)
  end
  if s == "" then
    return s
  end
  local t = {}
  local lasti = 1
  for i in (utf8.byte_indices)(s) do
    if not (utf8.next)(s, i) then
      local nexti = #s + 1
    end
    local repl = f(s, i, nexti - 1, ...)
    if repl then
      (table.insert)(t, s:sub(lasti, i - 1))
      ;
      (table.insert)(t, repl)
      lasti = nexti
    end
  end
  ;
  (table.insert)(t, s:sub(lasti))
  return (table.concat)(t)
end

local replace_invalid = function(s, i, j, repl_char)
  -- function num : 0_16 , upvalues : utf8
  if not (utf8.isvalid)(s, i) then
    return repl_char
  end
end

utf8.sanitize = function(s, repl_char)
  -- function num : 0_17 , upvalues : utf8, replace_invalid
  if not repl_char then
    repl_char = "�"
  end
  return (utf8.replace)(s, replace_invalid, repl_char)
end

return utf8

