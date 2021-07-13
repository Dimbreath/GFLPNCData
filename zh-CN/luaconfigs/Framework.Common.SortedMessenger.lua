-- params : ...
-- function num : 0 , upvalues : _ENV
local base = require("Framework.Common.Messenger")
local SortedMessenger = class("Messenger", base)
SortedMessenger.AddListener = function(self, type, callback, ...)
  -- function num : 0_0 , upvalues : _ENV
  local event = (self.events)[type]
  if event == nil then
    event = setmetatable({}, {__mode = "k"})
  end
  for k,v in ipairs(event) do
    if v ~= nil and v == callback then
      error("Aready cotains listener : " .. tostring(callback))
      return 
    end
  end
  ;
  (table.insert)(event, callback)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.events)[type] = event
end

SortedMessenger.Broadcast = function(self, type, ...)
  -- function num : 0_1 , upvalues : _ENV
  local event = (self.events)[type]
  if event == nil then
    return 
  end
  for k,v in ipairs(event) do
    assert(v ~= nil)
    v(...)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

SortedMessenger.RemoveListener = function(self, type, callback)
  -- function num : 0_2 , upvalues : _ENV
  local event = (self.events)[type]
  if event == nil or callback == nil then
    warn((string.format)("event = %s, callback = %s", event, callback))
    return 
  end
  ;
  (table.removebyvalue)(event, callback)
end

return SortedMessenger

