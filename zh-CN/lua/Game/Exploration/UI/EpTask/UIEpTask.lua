local UIEpTask = class("UIEpTask", UIBaseWindow)
local base = UIBaseWindow
local UINEpTaskItemDetail = require("Game.Exploration.UI.EpTask.UINEpTaskItemDetail")
local TaskData = require("Game.Task.Data.TaskData")
UIEpTask.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINEpTaskItemDetail
  (UIUtil.AddButtonListener)((self.ui).btn_Skip, self, self.OnClickExit)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Map, self, self.OnClickMap)
  ;
  ((self.ui).uINEpTaskItemDetail):SetActive(false)
  self.itemPool = (UIItemPool.New)(UINEpTaskItemDetail, (self.ui).uINEpTaskItemDetail)
  self.__OnClickItemGet = BindCallback(self, self.OnClickItemGet)
  for id,count in pairs((ConfigData.game_config).epTaskGiveUpReward) do
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R6 in 'UnsetPending'

    ((self.ui).priceText).text = tostring(count)
    do break end
  end
end

UIEpTask.InitEpTask = function(self, epCtrl, taskIdDic)
  -- function num : 0_1 , upvalues : _ENV, TaskData
  (((self.ui).btn_Map).gameObject):SetActive(ExplorationManager:HasRoomSceneInEp())
  self.epCtrl = epCtrl
  ;
  (self.itemPool):HideAll()
  if taskIdDic == nil or (table.count)(taskIdDic) == 0 then
    error("taskDic is empty")
    return 
  end
  for id,_ in pairs(taskIdDic) do
    local taskData = ((PlayerDataCenter.allTaskData).taskDatas)[id]
    do
      if taskData == nil then
        local stcData = (ConfigData.task)[id]
        if stcData ~= nil then
          taskData = (TaskData.CreatePickedTaskData)(stcData)
        end
      end
      do
        if taskData ~= nil then
          local item = (self.itemPool):GetOne()
          item:InitTaskItem(taskData, self.__OnClickItemGet, 0)
        end
        -- DECOMPILER ERROR at PC53: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

UIEpTask.OnClickMap = function(self)
  -- function num : 0_2
  ((self.ui).frameNode):SetActive(not ((self.ui).frameNode).activeInHierarchy)
  self:RefreshBtnState()
end

UIEpTask.OnClickExit = function(self)
  -- function num : 0_3
  (self.epCtrl):SendGiveUpTask()
end

UIEpTask.OnClickItemGet = function(self, taskId)
  -- function num : 0_4
  (self.epCtrl):SendGetTask(taskId)
end

UIEpTask.RefreshBtnState = function(self)
  -- function num : 0_5
  local inRoom = ((self.ui).frameNode).activeInHierarchy
  ;
  ((self.ui).img_btnBg):SetIndex(inRoom and 0 or 1)
  ;
  ((self.ui).tex_MapBtnName):SetIndex(inRoom and 0 or 1)
end

UIEpTask.GetDefaultSelectTaskId = function(self)
  -- function num : 0_6
  if #(self.itemPool).listItem > 0 then
    return (((self.itemPool).listItem)[1]).taskId
  end
  return 0
end

return UIEpTask

