local UINAthListGroup = class("UINAthListGroup", UIBaseNode)
local base = UIBaseNode
local gridWidth = 117
local anchorLeftTop = (Vector2.New)(0, 1)
local spaceSize = (Vector2.New)(6, 6)
UINAthListGroup.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.athItemDic = {}
  self.__onSetLayoutHeight = BindCallback(self, self.__SetLayoutHeight)
end

UINAthListGroup.InitAthListGroup = function(self, returnAthFunc, returnAthMatFunc, groupGridSize)
  -- function num : 0_1
  self.returnAthFunc = returnAthFunc
  self.returnAthMatFunc = returnAthMatFunc
  self.groupGridSize = groupGridSize
  self:__SetLayoutHeight(0)
end

UINAthListGroup.AddMatNode2Group = function(self, athMatUpNode)
  -- function num : 0_2 , upvalues : anchorLeftTop, _ENV
  (athMatUpNode.transform):SetParent(self.transform)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (athMatUpNode.transform).anchorMax = anchorLeftTop
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (athMatUpNode.transform).anchorMin = anchorLeftTop
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (athMatUpNode.transform).anchoredPosition = (Vector2.New)(((athMatUpNode.transform).sizeDelta).x / 2, 0)
  self:__SetLayoutHeight(((athMatUpNode.transform).sizeDelta).y)
  athMatUpNode:SetAthMatNodeChangeHeightFunc(self.__onSetLayoutHeight)
  self.athMatUpNode = athMatUpNode
end

UINAthListGroup.AddAthSuit2Group = function(self, athSuitItem, returnAthSuitFunc)
  -- function num : 0_3 , upvalues : anchorLeftTop, _ENV
  (athSuitItem.transform):SetParent(self.transform)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (athSuitItem.transform).anchorMax = anchorLeftTop
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (athSuitItem.transform).anchorMin = anchorLeftTop
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (athSuitItem.transform).anchoredPosition = (Vector2.New)(((athSuitItem.transform).sizeDelta).x / 2, -((athSuitItem.transform).sizeDelta).y / 2)
  self:__SetLayoutHeight(((athSuitItem.transform).sizeDelta).y)
  self.athSuitItem = athSuitItem
  self.returnAthSuitFunc = returnAthSuitFunc
end

UINAthListGroup.AddAthItem2Group = function(self, athItem, gridId)
  -- function num : 0_4 , upvalues : _ENV, gridWidth, spaceSize
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  (self.athItemDic)[(athItem:GetAthItemData()).uid] = athItem
  ;
  (athItem.transform):SetParent(self.transform)
  local y = (math.ceil)(gridId / (self.groupGridSize).x) - 1
  local x = gridId % (self.groupGridSize).x - 1
  if x == -1 then
    x = (self.groupGridSize).x - 1
  end
  local posX = (x) * (gridWidth + spaceSize.x) + ((athItem.transform).sizeDelta).x / 2
  local posY = -(y * (gridWidth + spaceSize.y) + ((athItem.transform).sizeDelta).y / 2)
  local pos = (Vector2.New)(posX, posY)
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (athItem.transform).anchoredPosition = pos
  local height = -posY + ((athItem.transform).sizeDelta).y / 2
  if ((self.ui).layoutElement).preferredHeight < height then
    self:__SetLayoutHeight(height)
  end
end

UINAthListGroup.GetAthItemFromAllGroup = function(self, uid)
  -- function num : 0_5
  return (self.athItemDic)[uid]
end

UINAthListGroup.HasAthMatNode = function(self)
  -- function num : 0_6
  do return self.athMatUpNode ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINAthListGroup.ClealAllAthItem = function(self)
  -- function num : 0_7 , upvalues : _ENV
  for k,athItem in pairs(self.athItemDic) do
    (self.returnAthFunc)(athItem)
  end
  if self.athMatUpNode ~= nil and self.returnAthMatFunc ~= nil and ((self.athMatUpNode).transform).parent == self.transform then
    (self.athMatUpNode):SetAthMatNodeChangeHeightFunc(nil)
    ;
    (self.returnAthMatFunc)()
    self.athMatUpNode = nil
  end
  if self.athSuitItem ~= nil and self.returnAthSuitFunc ~= nil and ((self.athSuitItem).transform).parent == self.transform then
    (self.returnAthSuitFunc)()
    self.athSuitItem = nil
  end
  self.athItemDic = {}
  self:__SetLayoutHeight(0)
end

UINAthListGroup.__SetLayoutHeight = function(self, height)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).layoutElement).preferredHeight = height
end

UINAthListGroup.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthListGroup

