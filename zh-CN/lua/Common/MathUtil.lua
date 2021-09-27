MathUtil = {}
local bezierPool = (CommonPool.New)(function()
  -- function num : 0_0
  return {}
end
, function(p)
  -- function num : 0_1 , upvalues : _ENV
  while #p > 0 do
    (table.remove)(p)
  end
  return true
end
)
-- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

MathUtil.BezierN = function(t, p)
  -- function num : 0_2 , upvalues : bezierPool, _ENV
  if #p < 2 then
    return p[1]
  end
  local newp = bezierPool:PoolGet()
  for i = 1, #p - 1 do
    local p0p1 = p[i] * (1 - t) + p[i + 1] * t
    ;
    (table.insert)(newp, p0p1)
  end
  local result = (MathUtil.BezierN)(t, newp)
  bezierPool:PoolPut(newp)
  return result
end


