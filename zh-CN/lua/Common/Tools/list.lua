local setmetatable = setmetatable
local list = {}
list.__index = list
list.new = function(self)
  -- function num : 0_0 , upvalues : setmetatable, list
  local t = {length = 0, _prev = 0, _next = 0}
  t._prev = t
  t._next = t
  return setmetatable(t, list)
end

list.clear = function(self)
  -- function num : 0_1
  self._next = self
  self._prev = self
  self.length = 0
end

list.push = function(self, value)
  -- function num : 0_2
  local node = {value = value, _prev = 0, _next = 0, removed = false}
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._prev)._next = node
  node._next = self
  node._prev = self._prev
  self._prev = node
  self.length = self.length + 1
  return node
end

list.pushnode = function(self, node)
  -- function num : 0_3
  if not node.removed then
    return 
  end
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._prev)._next = node
  node._next = self
  node._prev = self._prev
  self._prev = node
  node.removed = false
  self.length = self.length + 1
end

list.pop = function(self)
  -- function num : 0_4
  local _prev = self._prev
  self:remove(_prev)
  return _prev.value
end

list.unshift = function(self, v)
  -- function num : 0_5
  local node = {value = v, _prev = 0, _next = 0, removed = false}
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._next)._prev = node
  node._prev = self
  node._next = self._next
  self._next = node
  self.length = self.length + 1
  return node
end

list.shift = function(self)
  -- function num : 0_6
  local _next = self._next
  self:remove(_next)
  return _next.value
end

list.remove = function(self, iter)
  -- function num : 0_7 , upvalues : _ENV
  if iter.removed then
    return 
  end
  local _prev = iter._prev
  local _next = iter._next
  _next._prev = _prev
  _prev._next = _next
  self.length = (math.max)(0, self.length - 1)
  iter.removed = true
end

list.find = function(self, v, iter)
  -- function num : 0_8
  if not iter then
    iter = self
  end
  repeat
    if v == iter.value then
      return iter
    else
      iter = iter._next
    end
  until iter == self
  return nil
end

list.findlast = function(self, v, iter)
  -- function num : 0_9
  if not iter then
    iter = self
  end
  repeat
    if v == iter.value then
      return iter
    end
    iter = iter._prev
  until iter == self
  return nil
end

list.next = function(self, iter)
  -- function num : 0_10
  local _next = iter._next
  if _next ~= self then
    return _next, _next.value
  end
  return nil
end

list.prev = function(self, iter)
  -- function num : 0_11
  local _prev = iter._prev
  if _prev ~= self then
    return _prev, _prev.value
  end
  return nil
end

list.erase = function(self, v)
  -- function num : 0_12
  local iter = self:find(v)
  if iter then
    self:remove(iter)
  end
end

list.insert = function(self, v, iter)
  -- function num : 0_13
  if not iter then
    return self:push(v)
  end
  local node = {value = v, _next = 0, _prev = 0, removed = false}
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

  if iter._next then
    (iter._next)._prev = node
    node._next = iter._next
  else
    self.last = node
  end
  node._prev = iter
  iter._next = node
  self.length = self.length + 1
  return node
end

list.head = function(self)
  -- function num : 0_14
  return (self._next).value
end

list.tail = function(self)
  -- function num : 0_15
  return (self._prev).value
end

list.clone = function(self)
  -- function num : 0_16 , upvalues : list
  local t = list:new()
  for i,v in list.next do
    t:push(v)
  end
  return t
end

ilist = function(_list)
  -- function num : 0_17 , upvalues : list
  return list.next, _list, _list
end

rilist = function(_list)
  -- function num : 0_18 , upvalues : list
  return list.prev, _list, _list
end

setmetatable(list, {__call = list.new})
return list

