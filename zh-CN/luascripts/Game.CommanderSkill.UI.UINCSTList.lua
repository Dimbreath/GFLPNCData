-- params : ...
-- function num : 0 , upvalues : _ENV
local UINCSTList = class("UINCSTList", UIBaseNode)
local base = UIBaseNode
local UINCSTListItem = require("Game.CommanderSkill.UI.UINCSTListItem")
UINCSTList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.treeDataList = nil
  self.showDetailCallback = nil
  self.treeItemDic = {}
  self.selectedTreeData = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).treeLoopList).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).treeLoopList).onChangeItem = BindCallback(self, self.__OnChangeItem)
end

UINCSTList.InitTreeList = function(self, treeDataList, showDetailCallback, resloader)
  -- function num : 0_1
  self.treeDataList = treeDataList
  self.showDetailCallback = showDetailCallback
  self.resloader = resloader
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).treeLoopList).totalCount = #treeDataList
  ;
  ((self.ui).treeLoopList):RefillCells()
end

UINCSTList.SelectTree = function(self, treeData)
  -- function num : 0_2
  local treeItem, index = nil, nil
  if treeData == nil then
    treeItem = self:__GetTreeItemGoByIndex(0)
    self.selectedTreeData = (self.treeDataList)[1]
  else
    treeItem = self:__GetTreeItemByData(treeData)
    self.selectedTreeData = treeData
  end
  if treeItem == nil then
    ((self.ui).treeLoopList):SrollToCell(index, 5000, function()
    -- function num : 0_2_0 , upvalues : treeItem, self, index
    treeItem = self:__GetTreeItemGoByIndex(index)
    treeItem:SetSelected()
  end
)
  else
    treeItem:SetSelected()
  end
end

UINCSTList.__OnNewItem = function(self, go)
  -- function num : 0_3 , upvalues : UINCSTListItem
  local treeItem = (UINCSTListItem.New)()
  treeItem:Init(go)
  treeItem:InitListItem(self.resloader, self.showDetailCallback)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.treeItemDic)[go] = treeItem
end

UINCSTList.__OnChangeItem = function(self, go, index)
  -- function num : 0_4 , upvalues : _ENV
  local treeItem = (self.treeItemDic)[go]
  if treeItem == nil then
    error("Can\'t find treeItem by gameObject")
    return 
  end
  local treeData = (self.treeDataList)[index + 1]
  if treeData == nil then
    error("Can\'t find treeData by index, index = " .. tonumber(index))
  end
  treeItem:RefreshListItem(treeData)
  if self.selectedTreeData == treeData then
    treeItem:SetSelected()
  end
end

UINCSTList.__GetTreeItemByData = function(self, treeData)
  -- function num : 0_5 , upvalues : _ENV
  for k,v in ipairs(self.treeDataList) do
    if v == treeData then
      local index = k - 1
      return self:__GetTreeItemGoByIndex(index), index
    end
  end
end

UINCSTList.__GetTreeItemGoByIndex = function(self, index)
  -- function num : 0_6
  if (((self.ui).treeLoopList).content).childCount < index then
    return nil
  end
  local go = ((self.ui).treeLoopList):GetCellByIndex(index)
  do
    if go ~= nil then
      local treeItem = (self.treeItemDic)[go]
      return treeItem
    end
    return nil
  end
end

UINCSTList.RefreshTreeRedDot = function(self)
  -- function num : 0_7 , upvalues : _ENV
  for _,treeData in ipairs(self.treeDataList) do
    local item = self:__GetTreeItemByData(treeData)
    if item ~= nil then
      item:RefreshRedDot()
    end
  end
end

UINCSTList.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  for _,item in pairs(self.treeItemDic) do
    item:Delete()
  end
  ;
  (base.OnDelete)(self)
end

return UINCSTList

