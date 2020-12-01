-- params : ...
-- function num : 0 , upvalues : _ENV
local UISectorTaskItem = class("UISectorTaskItem", UIBaseNode)
local base = UIBaseNode
local UISectorTaskStepItem = require("Game.Sector.SectorTask.UISectorTaskStepItem")
local TaskEnum = require("Game.Task.TaskEnum")
UISectorTaskItem.Create = function(gameObject)
  -- function num : 0_0 , upvalues : UISectorTaskItem
  local node = (UISectorTaskItem.New)()
  node:Init(gameObject)
  return node
end

UISectorTaskItem.OnInit = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.OnClickEvent = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).getBtn, self, self.__OnClickRootButton)
  ;
  ((self.ui).stepItem):SetActive(false)
  self.__stepItems = {}
  self.__stepPool = {}
end

UISectorTaskItem.InitSectorTaskItem = function(self, data, stcData)
  -- function num : 0_2 , upvalues : TaskEnum, _ENV
  self.data = data
  self.stcData = stcData
  self.id = stcData.id
  self:__RecycleStepItems()
  if self.data == nil then
    self.state = (TaskEnum.eTaskState).Picked
    ;
    (((self.ui).getBtn).gameObject):SetActive(true)
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).getBtn).interactable = false
    ;
    ((self.ui).getBtnText):SetIndex(1)
    local taskStepCfg = (ConfigData.taskStep)[stcData.id]
    if taskStepCfg ~= nil then
      for k,v in pairs(taskStepCfg) do
        local stepItem = self:__GetStepItem()
        local stepCfg = v
        stepItem:InitTaskStep(nil, stepCfg, stcData)
        -- DECOMPILER ERROR at PC45: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (self.__stepItems)[k] = stepItem
      end
    end
  else
    do
      for k,v in pairs(data.steps) do
        local stepItem = self:__GetStepItem()
        local stepCfg = (data.taskStepCfg)[k]
        stepItem:InitTaskStep(v, stepCfg, data.stcData)
        -- DECOMPILER ERROR at PC63: Confused about usage of register: R10 in 'UnsetPending'

        ;
        (self.__stepItems)[k] = stepItem
      end
      if data:CheckComplete() then
        self.state = (TaskEnum.eTaskState).Completed
        ;
        (((self.ui).getBtn).gameObject):SetActive(true)
        ;
        ((self.ui).getBtnText):SetIndex(0)
      else
        self.state = (TaskEnum.eTaskState).InProgress
        ;
        (((self.ui).getBtn).gameObject):SetActive(false)
      end
      self:__SortTask()
    end
  end
end

UISectorTaskItem.__GetStepItem = function(self)
  -- function num : 0_3 , upvalues : _ENV, UISectorTaskStepItem
  local stepItem = nil
  if #self.__stepPool > 0 then
    stepItem = (table.remove)(self.__stepPool)
  else
    local go = ((self.ui).stepItem):Instantiate()
    stepItem = (UISectorTaskStepItem.Create)(go)
  end
  do
    stepItem:Show()
    return stepItem
  end
end

UISectorTaskItem.__SortTask = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local sortTab = {}
  for k,v in pairs(self.__stepItems) do
    (table.insert)(sortTab, v)
  end
  ;
  (table.sort)(sortTab, function(a, b)
    -- function num : 0_4_0
    do return (a.stepCfg).step < (b.stepCfg).step end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for k,v in ipairs(sortTab) do
    (v.transform):SetAsLastSibling()
  end
end

UISectorTaskItem.__RecycleStepItems = function(self)
  -- function num : 0_5 , upvalues : _ENV
  for k,v in pairs(self.__stepItems) do
    v:Hide()
    ;
    (table.insert)(self.__stepPool, v)
  end
end

UISectorTaskItem.__OnClickRootButton = function(self)
  -- function num : 0_6
  if self.OnClickEvent ~= nil then
    (self.OnClickEvent)(self.data)
  end
end

UISectorTaskItem.OnDelete = function(self)
  -- function num : 0_7 , upvalues : _ENV, base
  for k,v in ipairs(self.__stepPool) do
    v:Delete()
  end
  self.__stepPool = {}
  for k,v in pairs(self.__stepItems) do
    v:Delete()
  end
  self.__stepItems = {}
  ;
  (base.OnDelete)(self)
end

return UISectorTaskItem

-- params : ...
-- function num : 0 , upvalues : _ENV
local UISectorTaskItem = class("UISectorTaskItem", UIBaseNode)
local base = UIBaseNode
local UISectorTaskStepItem = require(
                                 "Game.Sector.SectorTask.UISectorTaskStepItem")
local TaskEnum = require("Game.Task.TaskEnum")
UISectorTaskItem.Create = function(gameObject)
    -- function num : 0_0 , upvalues : UISectorTaskItem
    local node = (UISectorTaskItem.New)()
    node:Init(gameObject)
    return node
end

UISectorTaskItem.OnInit = function(self)
    -- function num : 0_1 , upvalues : _ENV
    self.OnClickEvent = nil;
    (UIUtil.LuaUIBindingTable)(self.transform, self.ui);
    (UIUtil.AddButtonListener)((self.ui).getBtn, self, self.__OnClickRootButton);
    ((self.ui).stepItem):SetActive(false)
    self.__stepItems = {}
    self.__stepPool = {}
end

UISectorTaskItem.InitSectorTaskItem = function(self, data, stcData)
    -- function num : 0_2 , upvalues : TaskEnum, _ENV
    self.data = data
    self.stcData = stcData
    self.id = stcData.id
    self:__RecycleStepItems()
    if self.data == nil then
        self.state = (TaskEnum.eTaskState).Picked;
        (((self.ui).getBtn).gameObject):SetActive(true) -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'
        ;
        ((self.ui).getBtn).interactable = false;
        ((self.ui).getBtnText):SetIndex(1)
        local taskStepCfg = (ConfigData.taskStep)[stcData.id]
        if taskStepCfg ~= nil then
            for k, v in pairs(taskStepCfg) do
                local stepItem = self:__GetStepItem()
                local stepCfg = v
                stepItem:InitTaskStep(nil, stepCfg, stcData) -- DECOMPILER ERROR at PC45: Confused about usage of register: R11 in 'UnsetPending'
                ;
                (self.__stepItems)[k] = stepItem
            end
        end
    else
        do
            for k, v in pairs(data.steps) do
                local stepItem = self:__GetStepItem()
                local stepCfg = (data.taskStepCfg)[k]
                stepItem:InitTaskStep(v, stepCfg, data.stcData) -- DECOMPILER ERROR at PC63: Confused about usage of register: R10 in 'UnsetPending'
                ;
                (self.__stepItems)[k] = stepItem
            end
            if data:CheckComplete() then
                self.state = (TaskEnum.eTaskState).Completed;
                (((self.ui).getBtn).gameObject):SetActive(true);
                ((self.ui).getBtnText):SetIndex(0)
            else
                self.state = (TaskEnum.eTaskState).InProgress;
                (((self.ui).getBtn).gameObject):SetActive(false)
            end
            self:__SortTask()
        end
    end
end

UISectorTaskItem.__GetStepItem = function(self)
    -- function num : 0_3 , upvalues : _ENV, UISectorTaskStepItem
    local stepItem = nil
    if #self.__stepPool > 0 then
        stepItem = (table.remove)(self.__stepPool)
    else
        local go = ((self.ui).stepItem):Instantiate()
        stepItem = (UISectorTaskStepItem.Create)(go)
    end
    do
        stepItem:Show()
        return stepItem
    end
end

UISectorTaskItem.__SortTask = function(self)
    -- function num : 0_4 , upvalues : _ENV
    local sortTab = {}
    for k, v in pairs(self.__stepItems) do (table.insert)(sortTab, v) end
    (table.sort)(sortTab, function(a, b)
        -- function num : 0_4_0
        do return (a.stepCfg).step < (b.stepCfg).step end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end)
    for k, v in ipairs(sortTab) do (v.transform):SetAsLastSibling() end
end

UISectorTaskItem.__RecycleStepItems = function(self)
    -- function num : 0_5 , upvalues : _ENV
    for k, v in pairs(self.__stepItems) do
        v:Hide();
        (table.insert)(self.__stepPool, v)
    end
end

UISectorTaskItem.__OnClickRootButton = function(self)
    -- function num : 0_6
    if self.OnClickEvent ~= nil then (self.OnClickEvent)(self.data) end
end

UISectorTaskItem.OnDelete = function(self)
    -- function num : 0_7 , upvalues : _ENV, base
    for k, v in ipairs(self.__stepPool) do v:Delete() end
    self.__stepPool = {}
    for k, v in pairs(self.__stepItems) do v:Delete() end
    self.__stepItems = {};
    (base.OnDelete)(self)
end

return UISectorTaskItem

