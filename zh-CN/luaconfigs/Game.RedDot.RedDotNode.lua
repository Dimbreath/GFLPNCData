-- params : ...
-- function num : 0 , upvalues : _ENV
local RedDotNode = class("RedDotNode")
RedDotNode.ctor = function(self, nodeId, parent, nodePath)
  -- function num : 0_0 , upvalues : _ENV
  self.nodeId = nodeId
  self.__dotCount = 0
  self.__childs = {}
  self.__childCount = 0
  self.__parent = parent
  if nodeId == nil then
    return 
  end
  if nodePath ~= nil then
    self.nodePath = nodePath
  else
    if self.__parent == nil then
      self.nodePath = nil
    else
      if (self.__parent).nodePath == nil then
        self.nodePath = tostring(self.nodeId)
      else
        self.nodePath = tostring((self.__parent).nodePath) .. "." .. tostring(self.nodeId)
      end
    end
  end
end

RedDotNode.GetParentNode = function(self)
  -- function num : 0_1
  return self.__parent
end

RedDotNode.GetParentNodeId = function(self)
  -- function num : 0_2
  if self.__parent == nil then
    return nil
  end
  return (self.__parent).nodeId
end

RedDotNode.GetChild = function(self, nodeId)
  -- function num : 0_3
  return (self.__childs)[nodeId]
end

RedDotNode.AddChild = function(self, nodeId)
  -- function num : 0_4 , upvalues : RedDotNode
  local node = self:GetChild(nodeId)
  if node ~= nil then
    return node
  end
  node = (RedDotNode.New)(nodeId, self)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.__childs)[nodeId] = node
  self.__childCount = self.__childCount + 1
  return node
end

RedDotNode.AddChildWithPath = function(self, nodeId, nodePath)
  -- function num : 0_5 , upvalues : RedDotNode
  local node = self:GetChild(nodeId)
  if node ~= nil then
    return node
  end
  node = (RedDotNode.New)(nodeId, self, nodePath)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (self.__childs)[nodeId] = node
  self.__childCount = self.__childCount + 1
  return node
end

RedDotNode.RemoveChild = function(self, nodeId, update)
  -- function num : 0_6
  local node = (self.__childs)[nodeId]
  if node == nil then
    return false
  end
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R4 in 'UnsetPending'

  if update ~= nil or not true then
    (self.__childs)[nodeId] = nil
    self.__childCount = self.__childCount - 1
    self:ChangeRedDotCount(true)
    return true
  end
end

RedDotNode.RemoveFromParent = function(self)
  -- function num : 0_7
  if self.__parent == nil then
    return false
  end
  return (self.__parent):RemoveChild(self)
end

RedDotNode.ClearChild = function(self)
  -- function num : 0_8
  if self.__childCount == 0 then
    return 
  end
  self.__childs = {}
  self.__childCount = 0
  self:SetRedDotCount(0)
end

RedDotNode.GetRedDotCount = function(self)
  -- function num : 0_9
  return self.__dotCount
end

RedDotNode.SetRedDotCount = function(self, num)
  -- function num : 0_10 , upvalues : _ENV
  assert(self.__childCount == 0, "红点数量只能设置叶子节点，请检查代码!!!")
  if self.__dotCount == num then
    return 
  end
  self.__dotCount = num
  RedDotController:Broadcast(self.nodePath, self)
  if self.__parent ~= nil then
    (self.__parent):ChangeRedDotCount()
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

RedDotNode.OffsetRedDotCount = function(self, offsetNum)
  -- function num : 0_11
  self:SetRedDotCount(self.__dotCount + offsetNum)
end

RedDotNode.ChangeRedDotCount = function(self, ignoreCheck)
  -- function num : 0_12 , upvalues : _ENV
  if self.__childCount <= 0 then
    assert(ignoreCheck, "红点数量更新只能是非叶子节点，请检查代码!!!")
    if self.nodeId == nil then
      return 
    end
    local num = 0
    for k,node in pairs(self.__childs) do
      num = num + node:GetRedDotCount()
    end
    if num == self.__dotCount then
      return 
    end
    self.__dotCount = num
    RedDotController:Broadcast(self.nodePath, self)
    if self.__parent ~= nil then
      (self.__parent):ChangeRedDotCount()
    end
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
end

return RedDotNode

