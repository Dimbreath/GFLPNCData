-- params : ...
-- function num : 0 , upvalues : _ENV
local UINHeroTaskItem = class("UINHeroTaskItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local TaskEnum = require("Game.Task.TaskEnum")
local JumpManager = require("Game.Jump.JumpManager")
UINHeroTaskItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithReceived
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Get, self, self.OnClickGet)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_Goto, self, self.OnClickGoto)
  ;
  ((self.ui).rewardItem):SetActive(false)
  self.rewardPool = (UIItemPool.New)(UINBaseItemWithReceived, (self.ui).rewardItem)
end

UINHeroTaskItem.InitHeroTaskItem = function(self, taskInfo)
  -- function num : 0_1 , upvalues : TaskEnum, _ENV
  self.taskInfo = taskInfo
  local isFinish = taskInfo.state == (TaskEnum.eTaskState).Picked
  ;
  (self.rewardPool):HideAll()
  for i,v in ipairs((taskInfo.stcData).rewardIds) do
    local item = (self.rewardPool):GetOne(true)
    local itemCfg = (ConfigData.item)[v]
    local num = ((taskInfo.stcData).rewardNums)[i]
    item:InitItemWithCount(itemCfg, num, nil, isFinish)
  end
  self:UpdateUI()
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINHeroTaskItem.UpdateUI = function(self)
  -- function num : 0_2 , upvalues : _ENV, TaskEnum
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ((self.ui).tex_TaskIntro).text = (LanguageUtil.GetLocaleText)(((self.taskInfo).stcData).name)
  ;
  ((self.ui).obj_Unfinish):SetActive(false)
  ;
  ((self.ui).obj_Completed):SetActive(false)
  ;
  (((self.ui).btn_Get).gameObject):SetActive(false)
  ;
  (((self.ui).btn_Goto).gameObject):SetActive(false)
  local isFinish = (self.taskInfo).state == (TaskEnum.eTaskState).Picked
  local isComplect = (self.taskInfo):CheckComplete()
  local isCanjump = ((self.taskInfo).stcData).jump_id ~= nil and ((self.taskInfo).stcData).jump_id > 0
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self.ui).tex_TaskIntro).color = Color.black
  if isFinish then
    ((self.ui).img_Buttom):SetIndex(2)
    -- DECOMPILER ERROR at PC70: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_TaskIntro).color = (self.ui).col_isFinish
    -- DECOMPILER ERROR at PC75: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((self.ui).tex_Progress).color = (self.ui).col_isFinish
  elseif isComplect then
    ((self.ui).img_Buttom):SetIndex(1)
  else
    ((self.ui).img_Buttom):SetIndex(0)
  end
  ;
  (((self.ui).btn_Goto).gameObject):SetActive((not isComplect and isCanjump))
  ;
  (((self.ui).obj_Unfinish).gameObject):SetActive((not isComplect and not isCanjump))
  if isComplect then
    (((self.ui).btn_Get).gameObject):SetActive(not isFinish)
    ;
    ((self.ui).obj_Completed):SetActive(isFinish)
    local schedule, aim = (self.taskInfo):GetTaskProcess()
    -- DECOMPILER ERROR at PC138: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((self.ui).tex_Progress).text = tostring(schedule) .. "/" .. tostring(aim)
    local progress = schedule / aim
    if progress >= 1 or not progress then
      progress = 1
    end
    self.barWidth = ((((self.ui).bar).rectTransform).rect).width
    local vec = (((self.ui).img_Fill).rectTransform).sizeDelta
    vec.x = self.barWidth * progress
    -- DECOMPILER ERROR at PC161: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (((self.ui).img_Fill).rectTransform).sizeDelta = vec
    for i,v in ipairs((self.rewardPool).listItem) do
      v:SetPickedUIActive(isFinish)
    end
    -- DECOMPILER ERROR: 14 unprocessed JMP targets
  end
end

UINHeroTaskItem.OnClickGoto = function(self)
  -- function num : 0_3 , upvalues : JumpManager
  if ((self.taskInfo).stcData).jump_id ~= nil and ((self.taskInfo).stcData).jump_id > 0 then
    JumpManager:Jump(((self.taskInfo).stcData).jump_id, nil, nil, ((self.taskInfo).stcData).jumpArgs)
  end
end

UINHeroTaskItem.OnClickGet = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local stcTask = (self.taskInfo).stcData
  self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
  ;
  (NetworkManager:GetNetwork(NetworkTypeID.Task)):SendCommitQuest(self.taskInfo, function()
    -- function num : 0_4_0 , upvalues : _ENV, stcTask, self
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      -- function num : 0_4_0_0 , upvalues : stcTask, self, _ENV
      if window == nil then
        return 
      end
      window:InitRewardsItem(stcTask.rewardIds, stcTask.rewardNums, self._heroIdSnapShoot)
      local taskStepCfg = (ConfigData.taskStep)[stcTask.id]
      if taskStepCfg ~= nil then
        for stepIndex,stepCfg in ipairs(taskStepCfg) do
          local rewardTips = (string.format)(ConfigData:GetTipContent(360), "", (LanguageUtil.GetLocaleText)(stepCfg.intro), stepCfg.finish_value, stepCfg.finish_value)
          window:InitRewardTips(rewardTips)
          do return  end
        end
      end
    end
)
  end
)
end

UINHeroTaskItem.OnDelete = function(self)
  -- function num : 0_5 , upvalues : _ENV, base
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallBack)
  ;
  (base.OnDelete)(self)
end

return UINHeroTaskItem

