-- params : ...
-- function num : 0 , upvalues : _ENV
local get_time = os.clock
if not xlua.sethook then
  local sethook = debug.sethook
end
local func_info_map, start_time = nil, nil
local create_func_info = function(db_info)
  -- function num : 0_0
  return {db_info = db_info, count = 0, total_time = 0}
end

local on_hook = function(event, func_info_id, source)
  -- function num : 0_1 , upvalues : func_info_map, create_func_info, _ENV, get_time
  local func_info = func_info_map[func_info_id]
  if not func_info then
    func_info = create_func_info((debug.getinfo)(2, "nS"))
    func_info_map[func_info_id] = func_info
  end
  if event == "call" then
    func_info.call_time = get_time()
    func_info.count = func_info.count + 1
    func_info.return_time = nil
  else
    if event == "return" or event == "tail return" then
      local now = get_time()
      if func_info.call_time then
        func_info.total_time = func_info.total_time + (now - func_info.call_time)
        func_info.call_time = nil
      else
        func_info.total_time = func_info.total_time + (now - (func_info.return_time or now))
        func_info.count = func_info.count + 1
      end
      func_info.return_time = now
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R5 in 'UnsetPending'

      if source and func_info.count == 1 then
        (func_info.db_info).short_src = source
      end
    end
  end
end

local start = function()
  -- function num : 0_2 , upvalues : func_info_map, start_time, get_time, sethook, on_hook
  func_info_map = {}
  start_time = get_time()
  sethook(on_hook, "cr")
end

local pause = function()
  -- function num : 0_3 , upvalues : sethook
  sethook()
end

local resume = function()
  -- function num : 0_4 , upvalues : sethook, on_hook
  sethook(on_hook, "cr")
end

local stop = function()
  -- function num : 0_5 , upvalues : sethook, func_info_map, start_time
  sethook()
  func_info_map = nil
  start_time = nil
end

local report_output_line = function(rp, stat_interval)
  -- function num : 0_6 , upvalues : _ENV
  local source = (rp.db_info).short_src or "[NA]"
  local linedefined = (rp.db_info).linedefined and (rp.db_info).linedefined >= 0 and (string.format)(":%i", (rp.db_info).linedefined) or ""
  source = source .. linedefined
  local name = (rp.db_info).name or "[anonymous]"
  local total_time = (string.format)("%04.3f", rp.total_time * 1000)
  local average_time = (string.format)("%04.3f", rp.total_time / rp.count * 1000)
  local relative_time = (string.format)("%03.2f%%", rp.total_time / stat_interval * 100)
  local count = (string.format)("%7i", rp.count)
  return (string.format)("|%-40.40s: %-50.50s: %-12s: %-12s: %-12s: %-12s|\n", name, source, total_time, average_time, relative_time, count)
end

local sort_funcs = {TOTAL = function(a, b)
  -- function num : 0_7
  do return b.total_time < a.total_time end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
, AVERAGE = function(a, b)
  -- function num : 0_8
  do return b.average < a.average end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
, CALLED = function(a, b)
  -- function num : 0_9
  do return b.count < a.count end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end
}
local report = function(sort_by)
  -- function num : 0_10 , upvalues : sethook, _ENV, sort_funcs, get_time, start_time, func_info_map, report_output_line, on_hook
  sethook()
  local sort_func = type(sort_by) == "function" and sort_by or sort_funcs[sort_by]
  local FORMAT_HEADER_LINE = "|%-40s: %-50s: %-12s: %-12s: %-12s: %-12s|\n"
  local header = (string.format)(FORMAT_HEADER_LINE, "FUNCTION", "SOURCE", "TOTAL(MS)", "AVERAGE(MS)", "RELATIVE", "CALLED")
  if not start_time then
    local stat_interval = get_time() - get_time()
    local report_list = {}
    for _,rp in pairs(func_info_map) do
      (table.insert)(report_list, {total_time = rp.total_time, count = rp.count, average = rp.total_time / rp.count, output = report_output_line(rp, stat_interval)})
    end
    do
      ;
      (table.sort)(report_list, sort_func or sort_funcs.TOTAL)
      local output = header
      for i,rp in ipairs(report_list) do
        output = output .. rp.output
      end
      sethook(on_hook, "cr")
      return output
    end
  end
end

return {start = start, report = report, stop = stop}

-- params : ...
-- function num : 0 , upvalues : _ENV
local get_time = os.clock
if not xlua.sethook then local sethook = debug.sethook end
local func_info_map, start_time = nil, nil
local create_func_info = function(db_info)
    -- function num : 0_0
    return {db_info = db_info, count = 0, total_time = 0}
end

local on_hook = function(event, func_info_id, source)
    -- function num : 0_1 , upvalues : func_info_map, create_func_info, _ENV, get_time
    local func_info = func_info_map[func_info_id]
    if not func_info then
        func_info = create_func_info((debug.getinfo)(2, "nS"))
        func_info_map[func_info_id] = func_info
    end
    if event == "call" then
        func_info.call_time = get_time()
        func_info.count = func_info.count + 1
        func_info.return_time = nil
    else
        if event == "return" or event == "tail return" then
            local now = get_time()
            if func_info.call_time then
                func_info.total_time = func_info.total_time +
                                           (now - func_info.call_time)
                func_info.call_time = nil
            else
                func_info.total_time = func_info.total_time +
                                           (now - (func_info.return_time or now))
                func_info.count = func_info.count + 1
            end
            func_info.return_time = now
            -- DECOMPILER ERROR at PC56: Confused about usage of register: R5 in 'UnsetPending'

            if source and func_info.count == 1 then
                (func_info.db_info).short_src = source
            end
        end
    end
end

local start = function()
    -- function num : 0_2 , upvalues : func_info_map, start_time, get_time, sethook, on_hook
    func_info_map = {}
    start_time = get_time()
    sethook(on_hook, "cr")
end

local pause = function()
    -- function num : 0_3 , upvalues : sethook
    sethook()
end

local resume = function()
    -- function num : 0_4 , upvalues : sethook, on_hook
    sethook(on_hook, "cr")
end

local stop = function()
    -- function num : 0_5 , upvalues : sethook, func_info_map, start_time
    sethook()
    func_info_map = nil
    start_time = nil
end

local report_output_line = function(rp, stat_interval)
    -- function num : 0_6 , upvalues : _ENV
    local source = (rp.db_info).short_src or "[NA]"
    local linedefined = (rp.db_info).linedefined and (rp.db_info).linedefined >=
                            0 and
                            (string.format)(":%i", (rp.db_info).linedefined) or
                            ""
    source = source .. linedefined
    local name = (rp.db_info).name or "[anonymous]"
    local total_time = (string.format)("%04.3f", rp.total_time * 1000)
    local average_time = (string.format)("%04.3f",
                                         rp.total_time / rp.count * 1000)
    local relative_time = (string.format)("%03.2f%%",
                                          rp.total_time / stat_interval * 100)
    local count = (string.format)("%7i", rp.count)
    return (string.format)("|%-40.40s: %-50.50s: %-12s: %-12s: %-12s: %-12s|\n",
                           name, source, total_time, average_time,
                           relative_time, count)
end

local sort_funcs = {
    TOTAL = function(a, b)
        -- function num : 0_7
        do return b.total_time < a.total_time end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end,
    AVERAGE = function(a, b)
        -- function num : 0_8
        do return b.average < a.average end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end,
    CALLED = function(a, b)
        -- function num : 0_9
        do return b.count < a.count end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end
}
local report = function(sort_by)
    -- function num : 0_10 , upvalues : sethook, _ENV, sort_funcs, get_time, start_time, func_info_map, report_output_line, on_hook
    sethook()
    local sort_func = type(sort_by) == "function" and sort_by or
                          sort_funcs[sort_by]
    local FORMAT_HEADER_LINE = "|%-40s: %-50s: %-12s: %-12s: %-12s: %-12s|\n"
    local header = (string.format)(FORMAT_HEADER_LINE, "FUNCTION", "SOURCE",
                                   "TOTAL(MS)", "AVERAGE(MS)", "RELATIVE",
                                   "CALLED")
    if not start_time then
        local stat_interval = get_time() - get_time()
        local report_list = {}
        for _, rp in pairs(func_info_map) do
            (table.insert)(report_list, {
                total_time = rp.total_time,
                count = rp.count,
                average = rp.total_time / rp.count,
                output = report_output_line(rp, stat_interval)
            })
        end
        do

            (table.sort)(report_list, sort_func or sort_funcs.TOTAL)
            local output = header
            for i, rp in ipairs(report_list) do
                output = output .. rp.output
            end
            sethook(on_hook, "cr")
            return output
        end
    end
end

return {start = start, report = report, stop = stop}

