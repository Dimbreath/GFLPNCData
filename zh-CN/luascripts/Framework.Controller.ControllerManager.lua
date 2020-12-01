-- params : ...
-- function num : 0 , upvalues : _ENV
local ControllerManager = class("ControllerManager")
ControllerManager.ctor = function(self)
  -- function num : 0_0
  self.controllers = {}
end

local CreateControllerInternal = function(self, typeId)
  -- function num : 0_1 , upvalues : _ENV
  local config = ControllerGlobalConfig[typeId]
  assert(config)
  local controller = ((config.ControllerClass).New)()
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.controllers)[typeId] = controller
  controller.__typeId = typeId
  controller:OnInit()
  return controller
end

ControllerManager.GetController = function(self, typeId, allowCreate)
  -- function num : 0_2 , upvalues : CreateControllerInternal
  if (self.controllers)[typeId] ~= nil then
    return (self.controllers)[typeId]
  else
    if allowCreate then
      return CreateControllerInternal(self, typeId)
    else
      return nil
    end
  end
end

ControllerManager.DeleteController = function(self, typeId)
  -- function num : 0_3
  local controller = (self.controllers)[typeId]
  if controller ~= nil then
    controller:OnDelete()
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self.controllers)[typeId] = nil
  end
end

ControllerManager.DeleteAllController = function(self)
  -- function num : 0_4 , upvalues : _ENV
  for k,_ in pairs(self.controllers) do
    self:DeleteController(k)
  end
end

return ControllerManager

-- params : ...
-- function num : 0 , upvalues : _ENV
local ControllerManager = class("ControllerManager")
ControllerManager.ctor = function(self)
    -- function num : 0_0
    self.controllers = {}
end

local CreateControllerInternal = function(self, typeId)
    -- function num : 0_1 , upvalues : _ENV
    local config = ControllerGlobalConfig[typeId]
    assert(config)
    local controller = ((config.ControllerClass).New)() -- DECOMPILER ERROR at PC9: Confused about usage of register: R4 in 'UnsetPending'
    ;
    (self.controllers)[typeId] = controller
    controller.__typeId = typeId
    controller:OnInit()
    return controller
end

ControllerManager.GetController = function(self, typeId, allowCreate)
    -- function num : 0_2 , upvalues : CreateControllerInternal
    if (self.controllers)[typeId] ~= nil then
        return (self.controllers)[typeId]
    else
        if allowCreate then
            return CreateControllerInternal(self, typeId)
        else
            return nil
        end
    end
end

ControllerManager.DeleteController = function(self, typeId)
    -- function num : 0_3
    local controller = (self.controllers)[typeId]
    if controller ~= nil then
        controller:OnDelete() -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'
        ;
        (self.controllers)[typeId] = nil
    end
end

ControllerManager.DeleteAllController = function(self)
    -- function num : 0_4 , upvalues : _ENV
    for k, _ in pairs(self.controllers) do self:DeleteController(k) end
end

return ControllerManager

