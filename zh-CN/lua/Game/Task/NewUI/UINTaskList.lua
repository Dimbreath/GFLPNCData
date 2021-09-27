local UINTaskList = class("UINTaskList", UIBaseNode)
local base = UIBaseNode
local UINTaskListItem = require("Game.Task.NewUI.UINTaskListItem")
UINTaskList.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.slotItemDic = {}
  self.dataList = {}
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).taskListNode).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).taskListNode).onChangeItem = BindCallback(self, self.__OnChangeItem)
end

UINTaskList.RefreshTaskItems = function(self, TaskDataList, needSort, typeId)
  -- function num : 0_1 , upvalues : _ENV
  self.dataList = {}
  self.typeId = typeId
  for index,value in ipairs(TaskDataList) do
    (table.insert)(self.dataList, value)
  end
  if needSort then
    (table.sort)(self.dataList, function(a, b)
    -- function num : 0_1_0
    local aComplete = a:CheckComplete()
    local bComplete = b:CheckComplete()
    if aComplete ~= bComplete then
      return aComplete
    end
    local aIsPicked = a.isPicked or false
    local bIsPicked = b.isPicked or false
    if aIsPicked ~= bIsPicked then
      return not aIsPicked
    end
    if (a.stcData).order >= (b.stcData).order then
      do return (a.stcData).order == (b.stcData).order end
      do return a.id < b.id end
      -- DECOMPILER ERROR: 3 unprocessed JMP targets
    end
  end
)
  end
  local num = #self.dataList
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).taskListNode).totalCount = num
  ;
  ((self.ui).taskListNode):RefillCells()
end

UINTaskList.__OnNewItem = function(self, go)
  -- function num : 0_2 , upvalues : UINTaskListItem
  local taskItem = (UINTaskListItem.New)()
  taskItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.slotItemDic)[go] = taskItem
end

UINTaskList.__OnChangeItem = function(self, go, index)
  -- function num : 0_3 , upvalues : _ENV
  local taskItem = (self.slotItemDic)[go]
  if taskItem == nil then
    error("Can\'t find taskItem by gameObject")
    return 
  end
  local taskData = (self.dataList)[index + 1]
  if taskData == nil then
    error("Can\'t find taskData by index, index = " .. tonumber(index))
  end
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (taskItem.gameObject).name = "taskItem" .. tostring(index)
  taskItem:InitTaskItem(taskData, self.typeId)
end

UINTaskList.OnDelete = function(self)
  -- function num : 0_4 , upvalues : base
  (base.OnDelete)(self)
end

return UINTaskList

