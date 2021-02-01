-- params : ...
-- function num : 0 , upvalues : _ENV
local UITask = class("UITask", UIBaseWindow)
local base = UIBaseWindow
local cs_ResLoader = CS.ResLoader
local cs_DoTween = ((CS.DG).Tweening).DOTween
local UINTaskPageTog = require("Game.Task.NewUI.UINTaskPageTog")
local UINTaskSubPageTog = require("Game.Task.NewUI.UINTaskSubPageTog")
local UINTaskList = require("Game.Task.NewUI.UINTaskList")
local UINTaskPeroidNode = require("Game.Task.NewUI.UINTaskPeroidNode")
UITask.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, cs_ResLoader, UINTaskPageTog, UINTaskSubPageTog, UINTaskList, UINTaskPeroidNode
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Task)
  self.resloader = (cs_ResLoader.Create)()
  ;
  (UIUtil.SetTopStatus)(self, self.OnClickBack, {})
  self._RefreshSubPages = BindCallback(self, self.RefreshSubPages)
  self._OnSelectPage = BindCallback(self, self.OnSelectPage)
  self.pageTogPool = (UIItemPool.New)(UINTaskPageTog, (self.ui).obj_taskPageTog)
  self.subPageTogPool = (UIItemPool.New)(UINTaskSubPageTog, (self.ui).obj_subPageTog)
  ;
  ((self.ui).obj_taskPageTog):SetActive(false)
  ;
  ((self.ui).obj_subPageTog):SetActive(false)
  self.taskListNode = (UINTaskList.New)()
  ;
  (self.taskListNode):Init((self.ui).obj_taskListNode)
  self.peroidNode = (UINTaskPeroidNode.New)()
  ;
  (self.peroidNode):Init((self.ui).obj_peroidListNode)
  ;
  ((self.ui).obj_emptyPage):SetActive(false)
  self:RegistRedDot()
  self:SetTaskAllTweens()
end

UITask.RefreshPages = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self.pageGroupList = (self.ctrl):GetPageGroupList()
  ;
  (self.pageTogPool):HideAll()
  local isDailyTaskUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DailyTask)
  local autoSelectPage = 1
  if (self.ctrl).isDailyTaskUnlock then
    autoSelectPage = 4
  end
  for groupIndex,group in ipairs(self.pageGroupList) do
    if isDailyTaskUnlock or not (table.contain)(group, 4) then
      local pageTog = (self.pageTogPool):GetOne()
      pageTog:InitPageTog(groupIndex, group, self._RefreshSubPages, self._OnSelectPage)
      local totalRedDotCount = 0
      for index,taskTypeId in ipairs(group) do
        local OK, taskPageNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task, taskTypeId)
        local RedDotCount = taskPageNode:GetRedDotCount()
        if RedDotCount > 0 then
          autoSelectPage = taskTypeId
        end
        if OK then
          totalRedDotCount = totalRedDotCount + RedDotCount
        end
      end
      pageTog:SetRedDotActive(totalRedDotCount > 0)
    end
  end
  self:SelectPage(autoSelectPage)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UITask.RefreshSubPages = function(self, idList, nameList)
  -- function num : 0_2 , upvalues : _ENV
  (self.subPageTogPool):HideAll()
  if idList == nil then
    self:SetTaskNodeParent(true)
    return 
  else
    self:SetTaskNodeParent(false)
  end
  for i,typeId in ipairs(idList) do
    local subPageTog = (self.subPageTogPool):GetOne()
    local name = nameList[i]
    local taskDatas = (self.ctrl):GetDatas4Task(typeId)
    subPageTog:InitSubPageTog(typeId, name, taskDatas, self._OnSelectPage)
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R11 in 'UnsetPending'

    if i == 1 then
      ((subPageTog.ui).tog_subPageTog).isOn = true
      self:OnSelectPage(typeId)
    else
      -- DECOMPILER ERROR at PC42: Confused about usage of register: R11 in 'UnsetPending'

      ;
      ((subPageTog.ui).tog_subPageTog).isOn = false
    end
    local OK, taskPageNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task, typeId)
    subPageTog:SetRedDotActive(not OK or taskPageNode:GetRedDotCount() > 0)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UITask.SetTaskNodeParent = function(self, isBase)
  -- function num : 0_3 , upvalues : _ENV
  if isBase then
    (((self.ui).obj_taskListNode).transform):SetParent(((self.ui).basePos).transform)
  else
    ;
    (((self.ui).obj_taskListNode).transform):SetParent(((self.ui).peroidPos).transform)
  end
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).obj_taskListNode).transform).localPosition = Vector3.zero
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((self.ui).obj_taskListNode).transform).sizeDelta = Vector2.zero
end

UITask.OnSelectPage = function(self, typeId, groupIndex)
  -- function num : 0_4 , upvalues : _ENV
  (self.ctrl):SelectTask(typeId)
  local taskDatas, peroidDatas = (self.ctrl):GetDatas4Task(typeId)
  if peroidDatas ~= nil then
    do
      local noPeroidDatas = not (self.ctrl):IsPeriodTaskType(typeId)
      ;
      (((self.ui).taskPage).gameObject):SetActive(not noPeroidDatas)
      ;
      ((self.ui).obj_emptyPage):SetActive(noPeroidDatas)
      if groupIndex ~= nil then
        local name = (self.ctrl):GetPageName(groupIndex)
        ;
        ((self.ui).tex_Empty):SetIndex(0, name)
      else
        ((self.ui).tex_Empty):SetIndex(1)
      end
      if peroidDatas == nil then
        ((self.ui).obj_peroidListNode):SetActive(false)
        self:RefreshTask(taskDatas, true)
      else
        ((self.ui).obj_peroidListNode):SetActive(true)
        self:RefreshTask(taskDatas, true)
        self:RefreshPeroid(typeId, peroidDatas)
        for index,togItem in ipairs((self.pageTogPool).listItem) do
          if (table.contain)(togItem.group, typeId) then
            for index,subTogItem in ipairs((self.subPageTogPool).listItem) do
              if subTogItem.id == typeId then
                subTogItem:SetMissionCount(taskDatas)
              else
                subTogItem:SetMissionCount((self.ctrl):GetDatas4Task(subTogItem.id))
              end
            end
          end
        end
      end
      if (self.ctrl):IsChangeTaskType(typeId) and self.pageSequence ~= nil then
        (self.pageSequence):Restart()
      end
      -- DECOMPILER ERROR: 9 unprocessed JMP targets
    end
  end
end

UITask.SelectPage = function(self, typeId)
  -- function num : 0_5 , upvalues : _ENV
  for _,pageTog in ipairs((self.pageTogPool).listItem) do
    if pageTog.isMult then
      for subIndex,subPageTypeId in ipairs(pageTog.group) do
        -- DECOMPILER ERROR at PC16: Confused about usage of register: R12 in 'UnsetPending'

        if typeId == subPageTypeId then
          ((pageTog.ui).tog_taskPageTog).isOn = true
          local subPageTog = ((self.subPageTogPool).listItem)[subIndex]
          -- DECOMPILER ERROR at PC22: Confused about usage of register: R13 in 'UnsetPending'

          ;
          ((subPageTog.ui).tog_subPageTog).isOn = true
          return 
        end
      end
    else
      do
        do
          -- DECOMPILER ERROR at PC33: Confused about usage of register: R7 in 'UnsetPending'

          if typeId == (pageTog.group)[1] then
            ((pageTog.ui).tog_taskPageTog).isOn = true
            return 
          end
          -- DECOMPILER ERROR at PC35: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC35: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC35: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

UITask.RefreshTask = function(self, taskDatas, needSort)
  -- function num : 0_6 , upvalues : _ENV
  local taskList = {}
  for key,value in pairs(taskDatas) do
    (table.insert)(taskList, value)
  end
  ;
  (self.taskListNode):RefreshTaskItems(taskList, needSort)
end

UITask.RefreshPeroid = function(self, peroidId, peroidDatas)
  -- function num : 0_7
  (self.peroidNode):RefreshPeroid(peroidId, peroidDatas)
end

UITask.OnClickBack = function(self)
  -- function num : 0_8
  (self.ctrl):CloseTaskUI()
end

UITask.RegistRedDot = function(self)
  -- function num : 0_9 , upvalues : _ENV
  self.__onHeroCardRedDotEvent = function(node)
    -- function num : 0_9_0 , upvalues : _ENV, self
    local OK, taskPageNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task, node.nodeId)
    for groupIndex,group in ipairs(self.pageGroupList) do
      if (table.contain)(group, node.nodeId) then
        local pageTog = ((self.pageTogPool).listItem)[groupIndex]
        if pageTog == nil then
          return 
        end
        local totalRedDotCount = 0
        for index,taskTypeId in ipairs(group) do
          local OK, taskPageNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Task, taskTypeId)
          if OK then
            totalRedDotCount = totalRedDotCount + taskPageNode:GetRedDotCount()
          end
        end
        pageTog:SetRedDotActive(totalRedDotCount > 0)
      end
    end
    for index,item in ipairs((self.subPageTogPool).listItem) do
      -- DECOMPILER ERROR at PC71: Unhandled construct in 'MakeBoolean' P1

      if OK and taskPageNode:GetRedDotCount() <= 0 then
        do
          item:SetRedDotActive(item.id ~= node.nodeId)
          -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC72: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end

  RedDotController:AddListener(RedDotDynPath.TaskPagePath, self.__onHeroCardRedDotEvent)
end

UITask.RemoveRedDot = function(self)
  -- function num : 0_10 , upvalues : _ENV
  RedDotController:RemoveListener(RedDotDynPath.TaskPagePath, self.__onHeroCardRedDotEvent)
end

UITask.OnHide = function(self)
  -- function num : 0_11 , upvalues : _ENV, base
  local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
  if homeWin ~= nil then
    homeWin:BackFromOtherWin()
  end
  ;
  (base.OnHide)(self)
end

UITask.SetTaskAllTweens = function(self)
  -- function num : 0_12 , upvalues : _ENV, cs_DoTween
  local moveY = 20
  local pageLocalPos = (((self.ui).taskPage).transform).localPosition
  pageLocalPos = (Vector3.New)(pageLocalPos.x, pageLocalPos.y - moveY, pageLocalPos.z)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((self.ui).taskPage).transform).localPosition = pageLocalPos
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).taskPage).alpha = 0
  self.pageSequence = (cs_DoTween.Sequence)()
  ;
  (self.pageSequence):Append(((((self.ui).taskPage).transform):DOLocalMoveY(moveY, 0.3)):SetRelative(true))
  ;
  (self.pageSequence):Join(((self.ui).taskPage):DOFade(1, 0.3))
  ;
  (self.pageSequence):AppendCallback(function()
    -- function num : 0_12_0
  end
)
  ;
  (self.pageSequence):SetAutoKill(false)
end

UITask.KillTaskAllTweens = function(self)
  -- function num : 0_13
  if self.pageSequence ~= nil then
    (self.pageSequence):Kill()
    self.pageSequence = nil
  end
end

UITask.OnDelete = function(self)
  -- function num : 0_14 , upvalues : base
  self:RemoveRedDot()
  ;
  (self.taskListNode):Delete()
  ;
  (self.peroidNode):Delete()
  self:KillTaskAllTweens()
  ;
  (base.OnDelete)(self)
end

return UITask

