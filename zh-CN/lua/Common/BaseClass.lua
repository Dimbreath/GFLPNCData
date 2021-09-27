ClassType = {class = 1, instance = 2}
local _class = {}
class = function(classname, super)
  -- function num : 0_0 , upvalues : _ENV, _class
  assert(type(classname) == "string" and #classname > 0)
  local class_type = {}
  class_type.ctor = false
  class_type.__cname = classname
  class_type.__ctype = ClassType.class
  class_type.super = super
  class_type.New = function(...)
    -- function num : 0_0_0 , upvalues : class_type, _ENV, _class
    local obj = {}
    obj.__class_type = class_type
    obj.__ctype = ClassType.instance
    setmetatable(obj, {__index = _class[class_type]})
    local create = nil
    create = function(c, ...)
      -- function num : 0_0_0_0 , upvalues : create, obj
      if c.super then
        create(c.super, ...)
      end
      if c.ctor then
        (c.ctor)(obj, ...)
      end
    end

    create(class_type, ...)
    return obj
  end

  local vtbl = {}
  _class[class_type] = vtbl
  setmetatable(class_type, {__newindex = function(t, k, v)
    -- function num : 0_0_1 , upvalues : vtbl
    vtbl[k] = v
  end
, __index = vtbl})
  if super then
    setmetatable(vtbl, {__index = function(t, k)
    -- function num : 0_0_2 , upvalues : _class, super
    local ret = (_class[super])[k]
    return ret
  end
})
  end
  do return class_type end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end


