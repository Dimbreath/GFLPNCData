-- params : ...
-- function num : 0 , upvalues : _ENV
local UIAchivUnitItem = class("UIAchivUnitItem", UIBaseNode)
local base = UIBaseNode
local UICommonItem = require("Game.CommonUI.Item.UICommonItem")
local TaskEnum = require("Game.Task.TaskEnum")
local cs_MessageCommon = CS.MessageCommon
UIAchivUnitItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UICommonItem
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_GetReward, self, self.OnClickGetAchivReward)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_jump2Finish, self, self.OnClickJump2Finish)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Root, self, self.__OnClickRootBtn)
  ;
  ((self.ui).rewardItem):SetActive(false)
  self.rewardItemPool = (UIItemPool.New)(UICommonItem, (self.ui).rewardItem)
end

UIAchivUnitItem.InitAchivUnitItem = function(self, taskData, stcData, resLoader, getRewardEvent, completedTimeStamp)
  -- function num : 0_1 , upvalues : _ENV, TaskEnum
  self.taskData = taskData
  self.stcData = stcData
  self.id = stcData.id
  self.getRewardEvent = getRewardEvent
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((self.ui).tex_Title).text = (LanguageUtil.GetLocaleText)(stcData.name)
  local path = PathConsts:GetAchievementIconPath(stcData.icon)
  local icon = resLoader:LoadABAsset(path)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R8 in 'UnsetPending'

  ;
  ((self.ui).img_Icon).texture = icon
  local stepCfg = ((ConfigData.taskStep)[stcData.id])[1]
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R9 in 'UnsetPending'

  ;
  ((self.ui).tex_Intro).text = (LanguageUtil.GetLocaleText)(stepCfg.intro)
  ;
  (self.rewardItemPool):HideAll()
  for k,rewardId in ipairs(stcData.rewardIds) do
    local rewardNum = (stcData.rewardNums)[k]
    local itemCfg = (ConfigData.item)[rewardId]
    local rewardItem = (self.rewardItemPool):GetOne()
    rewardItem:InitItem(itemCfg, rewardNum)
    rewardItem:ParentWindowType(UIWindowTypeID.Achievement)
  end
  if taskData == nil then
    self.state = (TaskEnum.eTaskState).Picked
    ;
    (((self.ui).btn_GetReward).gameObject):SetActive(false)
    ;
    ((self.ui).notFinish):SetActive(true)
    ;
    ((self.ui).tex_Complete):SetIndex(1)
    ;
    (((self.ui).btn_jump2Finish).gameObject):SetActive(false)
  else
    if taskData:CheckComplete() then
      self.state = (TaskEnum.eTaskState).Completed
      ;
      (((self.ui).btn_GetReward).gameObject):SetActive(true)
      ;
      ((self.ui).notFinish):SetActive(false)
      ;
      (((self.ui).btn_jump2Finish).gameObject):SetActive(false)
    else
      self.state = (TaskEnum.eTaskState).InProgress
      ;
      (((self.ui).btn_GetReward).gameObject):SetActive(false)
      ;
      (((self.ui).btn_jump2Finish).gameObject):SetActive(false)
      ;
      ((self.ui).notFinish):SetActive(true)
      if ((ConfigData.task)[self.id]).jump_id ~= nil and ((ConfigData.task)[self.id]).jump_id ~= 0 then
        ((self.ui).notFinish):SetActive(false)
        ;
        (((self.ui).btn_jump2Finish).gameObject):SetActive(true)
      end
      ;
      ((self.ui).tex_Complete):SetIndex(0)
    end
  end
  if self.state == (TaskEnum.eTaskState).Picked then
    ((self.ui).processBar):SetActive(false)
    ;
    (((self.ui).tex_Process).gameObject):SetActive(false)
  else
    ;
    ((self.ui).processBar):SetActive(true)
    ;
    (((self.ui).tex_Process).gameObject):SetActive(true)
    local step = (taskData.steps)[1]
    local cur = (math.min)(step.schedule, step.aim)
    -- DECOMPILER ERROR at PC201: Confused about usage of register: R11 in 'UnsetPending'

    ;
    ((self.ui).img_Fill).fillAmount = cur / step.aim
    ;
    ((self.ui).tex_Process):SetIndex(0, tostring(cur), tostring(step.aim))
  end
  do
    local completeDate = self.state == (TaskEnum.eTaskState).Picked and (os.date)("%Y-%m-%d %H:%M", completedTimeStamp) or ""
    -- DECOMPILER ERROR at PC228: Confused about usage of register: R10 in 'UnsetPending'

    ;
    ((self.ui).tex_CompleteTime).text = completeDate
  end
end

UIAchivUnitItem.OnClickGetAchivReward = function(self)
  -- function num : 0_2 , upvalues : _ENV, cs_MessageCommon
  local containAth = false
  for k,rewardId in ipairs((self.stcData).rewardIds) do
    local itemCfg = (ConfigData.item)[rewardId]
    if itemCfg ~= nil and itemCfg.type == eItemType.Arithmetic then
      containAth = true
      break
    end
  end
  do
    if containAth and (ConfigData.game_config).athMaxNum <= #(PlayerDataCenter.allAthData):GetAllAthList() then
      (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
      return 
    end
    if self.getRewardEvent ~= nil then
      if self.taskData == nil then
        (cs_MessageCommon.ShowMessageTips)(ConfigData:GetTipContent(TipContent.achievement_taskCompleted))
      else
        ;
        (self.getRewardEvent)(self.taskData)
      end
    end
  end
end

UIAchivUnitItem.GetAchivUnitItemState = function(self)
  -- function num : 0_3
  return self.state
end

UIAchivUnitItem.SetJump2Finish = function(self, JumpManager, uiTopStatus)
  -- function num : 0_4
  self.jumpManager = JumpManager
  self.uiTopStatus = uiTopStatus
end

UIAchivUnitItem.OnClickJump2Finish = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (self.uiTopStatus):OnBtnReturnClicked()
  ;
  (self.jumpManager):Jump(((ConfigData.task)[self.id]).jump_id)
end

UIAchivUnitItem.__OnClickRootBtn = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if (GR.EnableTaskLog)() then
    print((string.format)("[Dev]TaskId:%s, stepId:%s", self.id, 1))
  end
end

UIAchivUnitItem.OnDelete = function(self)
  -- function num : 0_7 , upvalues : base
  (self.rewardItemPool):DeleteAll()
  ;
  (base.OnDelete)(self)
end

return UIAchivUnitItem

