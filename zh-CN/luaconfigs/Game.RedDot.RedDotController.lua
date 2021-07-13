-- params : ...
-- function num : 0 , upvalues : _ENV
local RedDotController = {}
local Messenger = require("Framework.Common.Messenger")
local RedDotNode = require("Game.RedDot.RedDotNode")
RedDotController.InitRedDotData = function(self)
  -- function num : 0_0
  self:Reset()
end

RedDotController.Reset = function(self)
  -- function num : 0_1 , upvalues : Messenger, RedDotNode
  self.__dot_message = (Messenger.New)()
  self.__rootNode = (RedDotNode.New)()
end

RedDotController.AddListener = function(self, nodePath, action)
  -- function num : 0_2
  (self.__dot_message):AddListener(nodePath, action)
end

RedDotController.RemoveListener = function(self, nodePath, action)
  -- function num : 0_3
  (self.__dot_message):RemoveListener(nodePath, action)
end

RedDotController.Broadcast = function(self, nodePath, ...)
  -- function num : 0_4
  (self.__dot_message):Broadcast(nodePath, ...)
end

RedDotController.AddRedDotNode = function(self, ...)
  -- function num : 0_5 , upvalues : _ENV
  local curNode = self.__rootNode
  for i = 1, select("#", ...) do
    local nodeId = select(i, ...)
    local newNode = curNode:AddChild(nodeId)
    curNode = newNode
  end
  return curNode
end

RedDotController.AddRedDotNodeWithPath = function(self, nodePath, ...)
  -- function num : 0_6 , upvalues : _ENV
  local curNode = self.__rootNode
  local n = select("#", ...)
  for i = 1, n do
    local nodeId = (select(i, ...))
    local newNode = nil
    if i == n then
      newNode = curNode:AddChildWithPath(nodeId, nodePath)
    else
      newNode = curNode:AddChild(nodeId)
    end
    curNode = newNode
  end
  return curNode
end

RedDotController.GetRedDotNode = function(self, ...)
  -- function num : 0_7 , upvalues : _ENV
  local curNode = self.__rootNode
  for i = 1, select("#", ...) do
    local nodeId = select(i, ...)
    local newNode = curNode:GetChild(nodeId)
    if newNode == nil then
      return false, nil
    end
    curNode = newNode
  end
  return true, curNode
end

RedDotController.RemoveRedDotNode = function(self, ...)
  -- function num : 0_8 , upvalues : _ENV
  local curNode = self.__rootNode
  for i = 1, select("#", ...) do
    local nodeId = select(i, ...)
    local newNode = curNode:GetChild(nodeId)
    if newNode == nil then
      return false, nil
    end
    curNode = newNode
  end
  return curNode:RemoveFromParent(), curNode
end

RedDotController.SetRedDotCount = function(self, count, ...)
  -- function num : 0_9 , upvalues : _ENV
  local ok, node = self:GetRedDotNode(...)
  do
    if not ok then
      local nodeIdList = {...}
      error("can not find RedDotNode:" .. (string.join)(nodeIdList, "."))
      return 
    end
    node:SetRedDotCount(count)
  end
end

RedDotController.OffsetRedDotCount = function(self, count, ...)
  -- function num : 0_10 , upvalues : _ENV
  local ok, node = self:GetRedDotNode(...)
  do
    if not ok then
      local nodeIdList = {...}
      error("can not find RedDotNode:" .. (string.join)(nodeIdList, "."))
      return 
    end
    node:OffsetRedDotCount(count)
  end
end

RedDotController.SetRedDotCallback = function(self, action, ...)
  -- function num : 0_11 , upvalues : _ENV
  local ok, node = self:GetRedDotNode(...)
  do
    if not ok then
      local nodeIdList = {...}
      error("can not find RedDotNode:" .. (string.join)(nodeIdList, "."))
      return 
    end
    node:SetRedDotCallback(action)
  end
end

return RedDotController

