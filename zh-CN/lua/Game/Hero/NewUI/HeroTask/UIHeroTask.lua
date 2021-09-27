local UIHeroTask = class("UIHeroTask", UIBaseWindow)
local base = UIBaseWindow
local UINHeroTaskItem = require("Game.Hero.NewUI.HeroTask.UINHeroTaskItem")
local TaskData = require("Game.Task.Data.TaskData")
local TaskEnum = require("Game.Task.TaskEnum")
local cs_ResLoader = CS.ResLoader
UIHeroTask.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.itemDic = {}
  self.heroTaskDataDic = {}
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_scroll).onInstantiateItem = BindCallback(self, self.__OnNewItem)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((self.ui).loop_scroll).onChangeItem = BindCallback(self, self.__OnChangeItem)
  ;
  (UIUtil.AddButtonListenerWithArg)((self.ui).btn_background, self, UIUtil.OnClickBack)
  ;
  (UIUtil.AddButtonListenerWithArg)((self.ui).btn_Close, self, UIUtil.OnClickBack)
  ;
  (UIUtil.SetTopStatus)(self, self.__OnClickReturn)
  ;
  (UIUtil.HideTopStatus)()
  self._b__RefreshHeroTask = BindCallback(self, self.__RefreshHeroTask)
  MsgCenter:AddListener(eMsgEventId.OnHeroTaskChange, self._b__RefreshHeroTask)
  self.idxs = {}
  self.offsetMin = ((((self.ui).loop_scroll).gameObject).transform).offsetMin
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ReceiveAll, self, self.OnClickReceiveAll)
end

UIHeroTask.InitHeroTask = function(self, heroData, resloader, bigImgResloader, closeCallback)
  -- function num : 0_1 , upvalues : _ENV
  self.closeCallback = closeCallback
  if heroData == nil then
    error("heroData is nill")
    return 
  end
  self.heroData = heroData
  self.heroTaskIds = (ConfigData.training_task)[(self.heroData).dataId]
  self:__RefreshHeroTask()
end

UIHeroTask.__RefreshHeroTask = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local taskNum = #self.heroTaskIds
  local finishedTaskNum = 0
  ;
  (table.sort)(self.heroTaskIds, function(a, b)
    -- function num : 0_2_0
    do return a.param < b.param end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for index,task in ipairs(self.heroTaskIds) do
    if task.param <= (self.heroData).level then
      finishedTaskNum = finishedTaskNum + 1
      task.isComplect = true
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self.heroTaskDataDic)[index] = task
    else
      task.isComplect = false
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (self.heroTaskDataDic)[index] = task
    end
  end
  self.idxs = {}
  for k,v in pairs(self.heroTaskIds) do
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R8 in 'UnsetPending'

    if v.isComplect and not (self.heroData):HasGetQuestReward(v.indx) then
      (self.idxs)[v.indx] = true
    end
  end
  if (table.count)(self.idxs) > 0 then
    (((self.ui).btn_ReceiveAll).gameObject):SetActive(true)
    local size = ((((self.ui).btn_ReceiveAll).gameObject).transform).sizeDelta
    -- DECOMPILER ERROR at PC77: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((((self.ui).loop_scroll).gameObject).transform).offsetMin = (Vector2.New)((self.offsetMin).x, (self.offsetMin).y + size.y)
  else
    do
      ;
      (((self.ui).btn_ReceiveAll).gameObject):SetActive(false)
      -- DECOMPILER ERROR at PC96: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((((self.ui).loop_scroll).gameObject).transform).offsetMin = (Vector2.New)((self.offsetMin).x, (self.offsetMin).y)
      ;
      ((self.ui).tex_taskCount):SetIndex(0, tostring(finishedTaskNum), tostring(taskNum))
      -- DECOMPILER ERROR at PC110: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((self.ui).loop_scroll).totalCount = taskNum
      ;
      ((self.ui).loop_scroll):RefreshCells()
    end
  end
end

UIHeroTask.OnClickReceiveAll = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (NetworkManager:GetNetwork(NetworkTypeID.Hero)):CS_QUEST_HeroOneKeyPick((self.heroData).dataId, self.idxs, function()
    -- function num : 0_3_0 , upvalues : _ENV, self
    for k,v in pairs(self.idxs) do
      (self.heroData):SetQuestGeted(k)
    end
    self.idxs = {}
    MsgCenter:Broadcast(eMsgEventId.OnHeroTaskChange, self.heroData)
  end
)
  return 
end

UIHeroTask.__OnNewItem = function(self, go)
  -- function num : 0_4 , upvalues : UINHeroTaskItem
  local taskItem = (UINHeroTaskItem.New)()
  taskItem:Init(go)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.itemDic)[go] = taskItem
end

UIHeroTask.__OnChangeItem = function(self, go, index)
  -- function num : 0_5 , upvalues : _ENV
  local taskItem = (self.itemDic)[go]
  if taskItem == nil then
    error("Can\'t find goodItem by gameObject")
    return 
  end
  local taskData = (self.heroTaskDataDic)[index + 1]
  taskItem:InitHeroTaskItem(taskData, self.heroData)
end

UIHeroTask.__OnClickReturn = function(self)
  -- function num : 0_6
  if self.closeCallback ~= nil then
    (self.closeCallback)()
  end
  self:Delete()
end

UIHeroTask.OnHide = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (UIUtil.ReShowTopStatus)()
end

UIHeroTask.OnDelete = function(self)
  -- function num : 0_8 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.OnHeroTaskChange, self._b__RefreshHeroTask)
  if self.resloader ~= nil then
    (self.resloader):Put2Pool()
    self.resloader = nil
  end
  if self.bigImgResloader ~= nil then
    (self.bigImgResloader):Put2Pool()
    self.bigImgResloader = nil
  end
  ;
  (base.OnDelete)(self)
end

return UIHeroTask

