-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAthSortListAllGroup = class("UINAthSortListAllGroup", UIBaseNode)
local base = UIBaseNode
local gridWidth = 130
local anchorLeftTop = (Vector2.New)(0, 1)
UINAthSortListAllGroup.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  self.athItemDic = {}
  self.__onSetLayoutHeight = BindCallback(self, self.__SetLayoutHeight)
end

UINAthSortListAllGroup.InitAthSortListAllGroup = function(self, returnAthFunc, returnAthMatFunc)
  -- function num : 0_1
  self.returnAthFunc = returnAthFunc
  self.returnAthMatFunc = returnAthMatFunc
  self:__SetLayoutHeight(0)
end

UINAthSortListAllGroup.AddMatNode2Group = function(self, athMatUpNode)
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

UINAthSortListAllGroup.AddAthItem2Group = function(self, athItem, gridId)
  -- function num : 0_3 , upvalues : _ENV, gridWidth
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  (self.athItemDic)[(athItem:GetAthItemData()).uid] = athItem
  ;
  (athItem.transform):SetParent(self.transform)
  local y = (math.ceil)(gridId / 4) - 1
  local x = gridId % 4 - 1
  if x == -1 then
    x = 3
  end
  local posX = x * (gridWidth + 10) + ((athItem.transform).sizeDelta).x / 2 + 20
  local posY = -(y * (gridWidth + 10) + ((athItem.transform).sizeDelta).y / 2)
  local pos = (Vector2.New)(posX, posY)
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (athItem.transform).anchoredPosition = pos
  local height = -posY + ((athItem.transform).sizeDelta).y / 2
  if ((self.ui).layoutElement).preferredHeight < height then
    self:__SetLayoutHeight(height)
  end
end

UINAthSortListAllGroup.GetAthItemFromAllGroup = function(self, uid)
  -- function num : 0_4
  return (self.athItemDic)[uid]
end

UINAthSortListAllGroup.HasAthMatNode = function(self)
  -- function num : 0_5
  do return self.athMatUpNode ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

UINAthSortListAllGroup.ClealAllAthItem = function(self)
  -- function num : 0_6 , upvalues : _ENV
  for k,athItem in pairs(self.athItemDic) do
    (self.returnAthFunc)(athItem)
  end
  if self.returnAthMatFunc ~= nil and self.athMatUpNode ~= nil and ((self.athMatUpNode).transform).parent == self.transform then
    (self.returnAthMatFunc)()
    self.athMatUpNode = nil
  end
  self.athItemDic = {}
  self:__SetLayoutHeight(0)
end

UINAthSortListAllGroup.__SetLayoutHeight = function(self, height)
  -- function num : 0_7
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).layoutElement).preferredHeight = height
end

UINAthSortListAllGroup.OnDelete = function(self)
  -- function num : 0_8 , upvalues : base
  (base.OnDelete)(self)
end

return UINAthSortListAllGroup

