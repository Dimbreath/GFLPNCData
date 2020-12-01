-- params : ...
-- function num : 0 , upvalues : _ENV
local UISectorTask = class("UISectorTask", UIBaseWindow)
local UISectorTaskItem = require("Game.Sector.SectorTask.New.UISectorTaskItem")
local UISectorAchiveItem = require("Game.Sector.SectorTask.New.UISectorTaskAchiveItem")
local base = UIBaseWindow
UISectorTask.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  ((self.ui).obj_TaskItem):SetActive(false)
  ;
  ((self.ui).obj_AchiveItem):SetActive(false)
  ;
  (UIUtil.CreateTopBtnGroup)((self.ui).topBtnGroup, self, self.OnPageClose)
  self.__onAchivItemClick = BindCallback(self, self.__OnAchivItemClick)
  self.__onTaskItemClick = BindCallback(self, self.__OnTaskItemClick)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).taskList).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).taskList).onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.achivParentWidth = (((self.ui).achivParent).sizeDelta).x
  self.__achivItems = {}
  self.__taskItems = {}
end

UISectorTask.InitSectorTask = function(self, controller)
  -- function num : 0_1 , upvalues : _ENV
  if controller == nil then
    error("Can`t find controller")
    return 
  end
  self.controller = controller
end

UISectorTask.RefreshSectorTask = function(self, taskDataArr, achivDataArr)
  -- function num : 0_2
  self:RefreshTaskItem(taskDataArr)
  self:RefreshAchivItem(achivDataArr)
end

UISectorTask.RefreshTaskItem = function(self, taskDataArr)
  -- function num : 0_3
  self.__currTaskDataArr = taskDataArr
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((self.ui).taskList).totalCount = #taskDataArr
  ;
  ((self.ui).taskList):RefillCells()
end

UISectorTask.__OnNewItem = function(self, go)
  -- function num : 0_4 , upvalues : UISectorTaskItem
  local taskItem = (UISectorTaskItem.New)()
  taskItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.__taskItems)[go] = taskItem
end

UISectorTask.__OnChangeItem = function(self, go, index)
  -- function num : 0_5 , upvalues : _ENV
  local taskItem = (self.__taskItems)[go]
  if taskItem == nil then
    error("Can\'t find taskItem by gameObject")
    return 
  end
  local taskData = (self.__currTaskDataArr)[index + 1]
  if taskData == nil then
    error("Can\'t find heroData by index, index = " .. tonumber(index))
  end
  taskItem:RefreshSectorTaskItem(taskData, self.__onTaskItemClick)
end

UISectorTask.__OnTaskItemClick = function(self, taskId)
  -- function num : 0_6
  (self.controller):OnTaskItemClick(taskId)
end

UISectorTask.RefreshAchivItem = function(self, achivDataArr)
  -- function num : 0_7 , upvalues : _ENV, UISectorAchiveItem
  self.initAchive = false
  self.firstStarCount = 0
  for k,achivData in ipairs(achivDataArr) do
    local achivItem = (self.__achivItems)[k]
    if achivItem == nil then
      achivItem = (UISectorAchiveItem.New)()
      local go = ((self.ui).obj_AchiveItem):Instantiate()
      go:SetActive(true)
      achivItem:Init(go)
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (self.__achivItems)[k] = achivItem
      self.initAchive = true
      achivItem:InitSectorTaskAchiveItem(achivData.achivCfg, self.__onAchivItemClick)
    end
    do
      do
        achivItem:UpdateSectorAchivItem(achivData.state)
        -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  if not self.initAchive then
    return 
  end
  self.firstStarCount = ((self.__achivItems)[1]):GetStarCount()
  local count = self.totalCount / self.firstStarCount
  local unitLength = self.achivParentWidth / count
  local xAxis = 0
  local offset = 0
  for k,achivItem in pairs(self.__achivItems) do
    if k * self.firstStarCount ~= achivItem:GetStarCount() then
      offset = offset + 1
    end
    xAxis = unitLength * (k + (offset))
    -- DECOMPILER ERROR at PC71: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (achivItem.transform).localPosition = (Vector3.New)(xAxis, 0, 0)
  end
end

UISectorTask.__OnAchivItemClick = function(self, achivId)
  -- function num : 0_8
  (self.controller):OnAchivItemClick(achivId)
end

UISectorTask.RefreshProcessUI = function(self, id, count, totalCount)
  -- function num : 0_9 , upvalues : _ENV
  self.tokenId = id
  self.totalCount = totalCount
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

  if count <= 9 then
    ((self.ui).tex_Trim).text = "0"
  else
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_Trim).text = ""
  end
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_Point).text = tostring(count)
  local rate = count / totalCount
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((self.ui).img_Process).fillAmount = rate
  local tokenCfg = (ConfigData.item)[id]
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R6 in 'UnsetPending'

  if tokenCfg ~= nil then
    ((self.ui).img_Icon).sprite = CRH:GetSprite(tokenCfg.icon)
  end
end

UISectorTask.OnPageClose = function(self)
  -- function num : 0_10
  (self.controller):OnUiWindowClose()
end

UISectorTask.OnDelete = function(self)
  -- function num : 0_11 , upvalues : _ENV, base
  if self.__achivItems ~= nil then
    for k,achivItem in pairs(self.__achivItems) do
      achivItem:OnDelete()
    end
    self.__achivItems = nil
  end
  ;
  (base.OnDelete)(self)
end

return UISectorTask

-- params : ...
-- function num : 0 , upvalues : _ENV
local UISectorTask = class("UISectorTask", UIBaseWindow)
local UISectorTaskItem = require("Game.Sector.SectorTask.New.UISectorTaskItem")
local UISectorAchiveItem = require(
                               "Game.Sector.SectorTask.New.UISectorTaskAchiveItem")
local base = UIBaseWindow
UISectorTask.OnInit = function(self)
    -- function num : 0_0 , upvalues : _ENV
    ((self.ui).obj_TaskItem):SetActive(false);
    ((self.ui).obj_AchiveItem):SetActive(false);
    (UIUtil.CreateTopBtnGroup)((self.ui).topBtnGroup, self, self.OnPageClose)
    self.__onAchivItemClick = BindCallback(self, self.__OnAchivItemClick)
    self.__onTaskItemClick = BindCallback(self, self.__OnTaskItemClick) -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).taskList).onInstantiateItem =
        BindCallback(self, self.__OnNewItem) -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'
    ;
    ((self.ui).taskList).onChangeItem = BindCallback(self, self.__OnChangeItem)
    self.achivParentWidth = (((self.ui).achivParent).sizeDelta).x
    self.__achivItems = {}
    self.__taskItems = {}
end

UISectorTask.InitSectorTask = function(self, controller)
    -- function num : 0_1 , upvalues : _ENV
    if controller == nil then
        error("Can`t find controller")
        return
    end
    self.controller = controller
end

UISectorTask.RefreshSectorTask = function(self, taskDataArr, achivDataArr)
    -- function num : 0_2
    self:RefreshTaskItem(taskDataArr)
    self:RefreshAchivItem(achivDataArr)
end

UISectorTask.RefreshTaskItem = function(self, taskDataArr)
    -- function num : 0_3
    self.__currTaskDataArr = taskDataArr -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'
    ;
    ((self.ui).taskList).totalCount = #taskDataArr;
    ((self.ui).taskList):RefillCells()
end

UISectorTask.__OnNewItem = function(self, go)
    -- function num : 0_4 , upvalues : UISectorTaskItem
    local taskItem = (UISectorTaskItem.New)()
    taskItem:Init(go) -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'
    ;
    (self.__taskItems)[go] = taskItem
end

UISectorTask.__OnChangeItem = function(self, go, index)
    -- function num : 0_5 , upvalues : _ENV
    local taskItem = (self.__taskItems)[go]
    if taskItem == nil then
        error("Can\'t find taskItem by gameObject")
        return
    end
    local taskData = (self.__currTaskDataArr)[index + 1]
    if taskData == nil then
        error("Can\'t find heroData by index, index = " .. tonumber(index))
    end
    taskItem:RefreshSectorTaskItem(taskData, self.__onTaskItemClick)
end

UISectorTask.__OnTaskItemClick = function(self, taskId)
    -- function num : 0_6
    (self.controller):OnTaskItemClick(taskId)
end

UISectorTask.RefreshAchivItem = function(self, achivDataArr)
    -- function num : 0_7 , upvalues : _ENV, UISectorAchiveItem
    self.initAchive = false
    self.firstStarCount = 0
    for k, achivData in ipairs(achivDataArr) do
        local achivItem = (self.__achivItems)[k]
        if achivItem == nil then
            achivItem = (UISectorAchiveItem.New)()
            local go = ((self.ui).obj_AchiveItem):Instantiate()
            go:SetActive(true)
            achivItem:Init(go) -- DECOMPILER ERROR at PC24: Confused about usage of register: R9 in 'UnsetPending'
            ;
            (self.__achivItems)[k] = achivItem
            self.initAchive = true
            achivItem:InitSectorTaskAchiveItem(achivData.achivCfg,
                                               self.__onAchivItemClick)
        end
        do
            do
                achivItem:UpdateSectorAchivItem(achivData.state)
                -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out DO_STMT

            end
        end
    end
    if not self.initAchive then return end
    self.firstStarCount = ((self.__achivItems)[1]):GetStarCount()
    local count = self.totalCount / self.firstStarCount
    local unitLength = self.achivParentWidth / count
    local xAxis = 0
    local offset = 0
    for k, achivItem in pairs(self.__achivItems) do
        if k * self.firstStarCount ~= achivItem:GetStarCount() then
            offset = offset + 1
        end
        xAxis = unitLength * (k + (offset)) -- DECOMPILER ERROR at PC71: Confused about usage of register: R11 in 'UnsetPending'
        ;
        (achivItem.transform).localPosition = (Vector3.New)(xAxis, 0, 0)
    end
end

UISectorTask.__OnAchivItemClick = function(self, achivId)
    -- function num : 0_8
    (self.controller):OnAchivItemClick(achivId)
end

UISectorTask.RefreshProcessUI = function(self, id, count, totalCount)
    -- function num : 0_9 , upvalues : _ENV
    self.tokenId = id
    self.totalCount = totalCount
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

    if count <= 9 then
        ((self.ui).tex_Trim).text = "0"
    else
        -- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'


        ((self.ui).tex_Trim).text = ""
    end -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'
    
    ((self.ui).tex_Point).text = tostring(count)
    local rate = count / totalCount -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'
    ;
    ((self.ui).img_Process).fillAmount = rate
    local tokenCfg = (ConfigData.item)[id]
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R6 in 'UnsetPending'

    if tokenCfg ~= nil then
        ((self.ui).img_Icon).sprite = CRH:GetSprite(tokenCfg.icon)
    end
end

UISectorTask.OnPageClose = function(self)
    -- function num : 0_10
    (self.controller):OnUiWindowClose()
end

UISectorTask.OnDelete = function(self)
    -- function num : 0_11 , upvalues : _ENV, base
    if self.__achivItems ~= nil then
        for k, achivItem in pairs(self.__achivItems) do
            achivItem:OnDelete()
        end
        self.__achivItems = nil
    end
    (base.OnDelete)(self)
end

return UISectorTask

