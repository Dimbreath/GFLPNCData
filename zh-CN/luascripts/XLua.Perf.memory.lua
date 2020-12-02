-- params : ...
-- function num : 0 , upvalues : _ENV
local TYPE_NAME = {"GLOBAL", "REGISTRY", "UPVALUE", "LOCAL"}
local report_output_line = function(rp)
  -- function num : 0_0 , upvalues : _ENV, TYPE_NAME
  local size = (string.format)("%7i", rp.size)
  return (string.format)("%-40.40s: %-12s: %-12s: %-12s: %s\n", rp.name, size, TYPE_NAME[rp.type], rp.pointer, rp.used_in)
end

local snapshot = function()
  -- function num : 0_1 , upvalues : _ENV, report_output_line
  local ss = (perf.snapshot)()
  local FORMAT_HEADER_LINE = "%-40s: %-12s: %-12s: %-12s: %s\n"
  local header = (string.format)(FORMAT_HEADER_LINE, "NAME", "SIZE", "TYPE", "ID", "INFO")
  ;
  (table.sort)(ss, function(a, b)
    -- function num : 0_1_0
    do return b.size < a.size end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local output = header
  for i,rp in ipairs(ss) do
    output = output .. report_output_line(rp)
  end
  return output
end

local total = function()
  -- function num : 0_2 , upvalues : _ENV
  return collectgarbage("count")
end

return {snapshot = snapshot, total = total}

