-- params : ...
-- function num : 0 , upvalues : _ENV
local json = require("cjson")
local is_array = function(table)
  -- function num : 0_0 , upvalues : _ENV
  local max = 0
  local count = 0
  for k,v in pairs(table) do
    if type(k) == "number" then
      if max < k then
        max = k
      end
      count = count + 1
    else
      return -1
    end
  end
  if (count) * 2 < max then
    return -1
  end
  return max
end

local serialise_value = nil
local serialise_table = function(value, indent, depth)
  -- function num : 0_1 , upvalues : is_array, _ENV, serialise_value
  local spacing, spacing2, indent2 = nil, nil, nil
  if indent then
    spacing = "\n" .. indent
    spacing2 = spacing .. "  "
    indent2 = indent .. "  "
  else
    spacing = " "
  end
  depth = depth + 1
  if depth > 50 then
    return "Cannot serialise any further: too many nested tables"
  end
  local max = is_array(value)
  local comma = false
  local fragment = {"{" .. spacing2}
  if max > 0 then
    for i = 1, max do
      if comma then
        (table.insert)(fragment, "," .. spacing2)
      end
      ;
      (table.insert)(fragment, serialise_value(value[i], indent2, depth))
      comma = true
    end
  else
    do
      if max < 0 then
        for k,v in pairs(value) do
          if comma then
            (table.insert)(fragment, "," .. spacing2)
          end
          ;
          (table.insert)(fragment, ("[%s] = %s"):format(serialise_value(k, indent2, depth), serialise_value(v, indent2, depth)))
          comma = true
        end
      end
      do
        ;
        (table.insert)(fragment, spacing .. "}")
        return (table.concat)(fragment)
      end
    end
  end
end

serialise_value = function(value, indent, depth)
  -- function num : 0_2 , upvalues : json, _ENV, serialise_table
  if indent == nil then
    indent = ""
  end
  if depth == nil then
    depth = 0
  end
  if value == json.null then
    return "json.null"
  else
    if type(value) == "string" then
      return ("%q"):format(value)
    else
      if type(value) == "nil" or type(value) == "number" or type(value) == "boolean" then
        return tostring(value)
      else
        if type(value) == "table" then
          return serialise_table(value, indent, depth)
        else
          return "\"<" .. type(value) .. ">\""
        end
      end
    end
  end
end

local file_load = function(filename)
  -- function num : 0_3 , upvalues : _ENV
  local file = nil
  if filename == nil then
    file = io.stdin
  else
    local err = nil
    file = (io.open)(filename, "rb")
    if file == nil then
      error(("Unable to read \'%s\': %s"):format(filename, err))
    end
  end
  do
    -- DECOMPILER ERROR at PC23: Overwrote pending register: R2 in 'AssignReg'

    local data = err(file, "*a")
    if filename ~= nil then
      file:close()
    end
    if not filename then
      error("Failed to read " .. (data ~= nil or ""))
      return data
    end
  end
end

local file_save = function(filename, data)
  -- function num : 0_4 , upvalues : _ENV
  local file = nil
  if filename == nil then
    file = io.stdout
  else
    local err = nil
    file = (io.open)(filename, "wb")
    if file == nil then
      error(("Unable to write \'%s\': %s"):format(filename, err))
    end
  end
  do
    -- DECOMPILER ERROR at PC23: Overwrote pending register: R3 in 'AssignReg'

    err(file, data)
    if filename ~= nil then
      file:close()
    end
  end
end

local compare_values = function(val1, val2)
  -- function num : 0_5 , upvalues : _ENV, compare_values
  local type1 = type(val1)
  local type2 = type(val2)
  if type1 ~= type2 then
    return false
  end
  if type1 == "number" and val1 ~= val1 and val2 ~= val2 then
    return true
  end
  if val1 ~= val2 then
    do return type1 == "table" end
    local check_keys = {}
    for k,_ in pairs(val1) do
      check_keys[k] = true
    end
    for k,v in pairs(val2) do
      if not check_keys[k] then
        return false
      end
      if not compare_values(val1[k], val2[k]) then
        return false
      end
      check_keys[k] = nil
    end
    for k,_ in pairs(check_keys) do
      return false
    end
    do return true end
    -- DECOMPILER ERROR: 7 unprocessed JMP targets
  end
end

local test_count_pass = 0
local test_count_total = 0
local run_test_summary = function()
  -- function num : 0_6 , upvalues : test_count_pass, test_count_total
  return test_count_pass, test_count_total
end

local run_test = function(testname, func, input, should_work, output)
  -- function num : 0_7 , upvalues : _ENV, serialise_value, compare_values, test_count_pass, test_count_total
  local status_line = function(name, status, value)
    -- function num : 0_7_0 , upvalues : _ENV, serialise_value
    local statusmap = {[true] = ":success", [false] = ":error"}
    if status ~= nil then
      name = name .. statusmap[status]
    end
    print(("[%s] %s"):format(name, serialise_value(value, false)))
  end

  local result = {pcall(func, unpack(input))}
  local success = (table.remove)(result, 1)
  local correct = false
  if success == should_work and compare_values(result, output) then
    correct = true
    test_count_pass = test_count_pass + 1
  end
  test_count_total = test_count_total + 1
  local teststatus = {[true] = "PASS", [false] = "FAIL"}
  print(("==> Test [%d] %s: %s"):format(test_count_total, testname, teststatus[correct]))
  status_line("Input", nil, input)
  if not correct then
    status_line("Expected", should_work, output)
  end
  status_line("Received", success, result)
  print()
  return correct, result
end

local run_test_group = function(tests)
  -- function num : 0_8 , upvalues : _ENV, run_test
  local run_helper = function(name, func, input)
    -- function num : 0_8_0 , upvalues : _ENV
    if type(name) == "string" and #name > 0 then
      print("==> " .. name)
    end
    if not input then
      func(unpack({}))
      print()
    end
  end

  for _,v in ipairs(tests) do
    if v[4] == nil then
      run_helper(unpack(v))
    else
      run_test(unpack(v))
    end
  end
end

local run_script = function(script, env)
  -- function num : 0_9 , upvalues : _ENV
  if not env then
    local env = {}
  end
  local func = nil
  if _G.setfenv then
    func = loadstring(script)
    if func then
      setfenv(func, env)
    end
  else
    func = load(script, nil, nil, env)
  end
  if func == nil then
    error("Invalid syntax.")
  end
  func()
  return env
end

return {serialise_value = serialise_value, file_load = file_load, file_save = file_save, compare_values = compare_values, run_test_summary = run_test_summary, run_test = run_test, run_test_group = run_test_group, run_script = run_script}

-- params : ...
-- function num : 0 , upvalues : _ENV
local json = require("cjson")
local is_array = function(table)
    -- function num : 0_0 , upvalues : _ENV
    local max = 0
    local count = 0
    for k, v in pairs(table) do
        if type(k) == "number" then
            if max < k then max = k end
            count = count + 1
        else
            return -1
        end
    end
    if (count) * 2 < max then return -1 end
    return max
end

local serialise_value = nil
local serialise_table = function(value, indent, depth)
    -- function num : 0_1 , upvalues : is_array, _ENV, serialise_value
    local spacing, spacing2, indent2 = nil, nil, nil
    if indent then
        spacing = "\n" .. indent
        spacing2 = spacing .. "  "
        indent2 = indent .. "  "
    else
        spacing = " "
    end
    depth = depth + 1
    if depth > 50 then
        return "Cannot serialise any further: too many nested tables"
    end
    local max = is_array(value)
    local comma = false
    local fragment = {"{" .. spacing2}
    if max > 0 then
        for i = 1, max do
            if comma then (table.insert)(fragment, "," .. spacing2) end
            (table.insert)(fragment, serialise_value(value[i], indent2, depth))
            comma = true
        end
    else
        do
            if max < 0 then
                for k, v in pairs(value) do
                    if comma then
                        (table.insert)(fragment, "," .. spacing2)
                    end
                    (table.insert)(fragment,
                                   ("[%s] = %s"):format(
                                       serialise_value(k, indent2, depth),
                                       serialise_value(v, indent2, depth)))
                    comma = true
                end
            end
            do

                (table.insert)(fragment, spacing .. "}")
                return (table.concat)(fragment)
            end
        end
    end
end

serialise_value = function(value, indent, depth)
    -- function num : 0_2 , upvalues : json, _ENV, serialise_table
    if indent == nil then indent = "" end
    if depth == nil then depth = 0 end
    if value == json.null then
        return "json.null"
    else
        if type(value) == "string" then
            return ("%q"):format(value)
        else
            if type(value) == "nil" or type(value) == "number" or type(value) ==
                "boolean" then
                return tostring(value)
            else
                if type(value) == "table" then
                    return serialise_table(value, indent, depth)
                else
                    return "\"<" .. type(value) .. ">\""
                end
            end
        end
    end
end

local file_load = function(filename)
    -- function num : 0_3 , upvalues : _ENV
    local file = nil
    if filename == nil then
        file = io.stdin
    else
        local err = nil
        file = (io.open)(filename, "rb")
        if file == nil then
            error(("Unable to read \'%s\': %s"):format(filename, err))
        end
    end
    do
        -- DECOMPILER ERROR at PC23: Overwrote pending register: R2 in 'AssignReg'

        local data = err(file, "*a")
        if filename ~= nil then file:close() end
        if not filename then
            error("Failed to read " .. (data ~= nil or ""))
            return data
        end
    end
end

local file_save = function(filename, data)
    -- function num : 0_4 , upvalues : _ENV
    local file = nil
    if filename == nil then
        file = io.stdout
    else
        local err = nil
        file = (io.open)(filename, "wb")
        if file == nil then
            error(("Unable to write \'%s\': %s"):format(filename, err))
        end
    end
    do
        -- DECOMPILER ERROR at PC23: Overwrote pending register: R3 in 'AssignReg'

        err(file, data)
        if filename ~= nil then file:close() end
    end
end

local compare_values = function(val1, val2)
    -- function num : 0_5 , upvalues : _ENV, compare_values
    local type1 = type(val1)
    local type2 = type(val2)
    if type1 ~= type2 then return false end
    if type1 == "number" and val1 ~= val1 and val2 ~= val2 then return true end
    if val1 ~= val2 then
        do return type1 == "table" end
        local check_keys = {}
        for k, _ in pairs(val1) do check_keys[k] = true end
        for k, v in pairs(val2) do
            if not check_keys[k] then return false end
            if not compare_values(val1[k], val2[k]) then return false end
            check_keys[k] = nil
        end
        for k, _ in pairs(check_keys) do return false end
        do return true end
        -- DECOMPILER ERROR: 7 unprocessed JMP targets
    end
end

local test_count_pass = 0
local test_count_total = 0
local run_test_summary = function()
    -- function num : 0_6 , upvalues : test_count_pass, test_count_total
    return test_count_pass, test_count_total
end

local run_test = function(testname, func, input, should_work, output)
    -- function num : 0_7 , upvalues : _ENV, serialise_value, compare_values, test_count_pass, test_count_total
    local status_line = function(name, status, value)
        -- function num : 0_7_0 , upvalues : _ENV, serialise_value
        local statusmap = {[true] = ":success", [false] = ":error"}
        if status ~= nil then name = name .. statusmap[status] end
        print(("[%s] %s"):format(name, serialise_value(value, false)))
    end

    local result = {pcall(func, unpack(input))}
    local success = (table.remove)(result, 1)
    local correct = false
    if success == should_work and compare_values(result, output) then
        correct = true
        test_count_pass = test_count_pass + 1
    end
    test_count_total = test_count_total + 1
    local teststatus = {[true] = "PASS", [false] = "FAIL"}
    print(("==> Test [%d] %s: %s"):format(test_count_total, testname,
                                          teststatus[correct]))
    status_line("Input", nil, input)
    if not correct then status_line("Expected", should_work, output) end
    status_line("Received", success, result)
    print()
    return correct, result
end

local run_test_group = function(tests)
    -- function num : 0_8 , upvalues : _ENV, run_test
    local run_helper = function(name, func, input)
        -- function num : 0_8_0 , upvalues : _ENV
        if type(name) == "string" and #name > 0 then
            print("==> " .. name)
        end
        if not input then
            func(unpack({}))
            print()
        end
    end

    for _, v in ipairs(tests) do
        if v[4] == nil then
            run_helper(unpack(v))
        else
            run_test(unpack(v))
        end
    end
end

local run_script = function(script, env)
    -- function num : 0_9 , upvalues : _ENV
    if not env then local env = {} end
    local func = nil
    if _G.setfenv then
        func = loadstring(script)
        if func then setfenv(func, env) end
    else
        func = load(script, nil, nil, env)
    end
    if func == nil then error("Invalid syntax.") end
    func()
    return env
end

return {
    serialise_value = serialise_value,
    file_load = file_load,
    file_save = file_save,
    compare_values = compare_values,
    run_test_summary = run_test_summary,
    run_test = run_test,
    run_test_group = run_test_group,
    run_script = run_script
}

