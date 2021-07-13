-- params : ...
-- function num : 0 , upvalues : _ENV
local CommonPool = {}
CommonPool.__index = CommonPool
CommonPool.New = function(NewFunc, ResetFunc)
  -- function num : 0_0 , upvalues : _ENV, CommonPool
  local self = {}
  self.__poollist = {}
  self.__newFunc = NewFunc
  self.__resetFunc = ResetFunc
  assert(self.__newFunc ~= nil, "new func must not be nil")
  setmetatable(self, CommonPool)
  do return self end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

CommonPool.PoolGet = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if #self.__poollist > 0 then
    return (table.remove)(self.__poollist)
  end
  return (self.__newFunc)()
end

CommonPool.PoolPut = function(self, ele)
  -- function num : 0_2 , upvalues : _ENV
  if self.__resetFunc ~= nil and not (self.__resetFunc)(ele) then
    return 
  end
  ;
  (table.insert)(self.__poollist, ele)
end

CommonPool.PoolClear = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if #self.__poollist > 10 then
    self.__poollist = {}
    return 
  end
  while #self.__poollist > 0 do
    (table.remove)(self.__poollist)
  end
end

return CommonPool

