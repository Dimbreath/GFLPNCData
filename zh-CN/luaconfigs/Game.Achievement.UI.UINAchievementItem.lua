-- params : ...
-- function num : 0 , upvalues : _ENV
local UINAchievementItem = class("UINAchievementItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local TaskEnum = require("Game.Task.TaskEnum")
UINAchievementItem.OnInit = function(self)
  -- function num : 0_0 , upvalues : _ENV, UINBaseItemWithReceived
  self.isPicked = nil
  ;
  (UIUtil.LuaUIBindingTable)(self.transform, self.ui)
  ;
  (UIUtil.AddButtonListener)((self.ui).btn_ItemClick, self, self.OnClick)
  self.rewardItemPool = (UIItemPool.New)(UINBaseItemWithReceived, (self.ui).rewardItem)
  ;
  (((self.ui).rewardItem).gameObject):SetActive(false)
end

UINAchievementItem.InitAchieveItem = function(self, resloader, getRewardEvent, JumpToTargetEvent)
  -- function num : 0_1
  self.resloader = resloader
  self.getRewardEvent = getRewardEvent
  self.JumpToTargetEvent = JumpToTargetEvent
end

UINAchievementItem.RefreshAchieveItem = function(self, achieveData)
  -- function num : 0_2
  self.achieveData = achieveData
  self:m_RefreshStaticUI(achieveData.stcData)
  self:RefreshUI()
end

UINAchievementItem.m_RefreshStaticUI = function(self, stcData)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ((self.ui).tex_Title).text = (LanguageUtil.GetLocaleText)(stcData.name)
  local stepCfg = ((ConfigData.taskStep)[stcData.id])[1]
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((self.ui).tex_TaskIntro).text = (LanguageUtil.GetLocaleText)(stepCfg.intro)
  ;
  (self.resloader):LoadABAssetAsync(PathConsts:GetAtlasAssetPath("AchievementIcon"), function(spriteAtlas)
    -- function num : 0_3_0 , upvalues : self, stcData
    if spriteAtlas == nil then
      return 
    end
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((self.ui).img_Icon).sprite = spriteAtlas:GetSprite(stcData.icon)
  end
)
end

UINAchievementItem.RefreshUI = function(self)
  -- function num : 0_4 , upvalues : TaskEnum, _ENV
  if (self.achieveData).state == (TaskEnum.eTaskState).InProgress then
    local schedule, aim = ((self.achieveData).taskData):GetTaskProcess()
    ;
    ((self.ui).tex_Progress):SetIndex(0, tostring(schedule), tostring(aim))
    self:m_FillProcess(schedule / aim)
    ;
    ((self.ui).tex_State):SetIndex(0)
    ;
    ((self.ui).obj_isOver):SetActive(false)
  else
    do
      if (self.achieveData).state == (TaskEnum.eTaskState).Completed then
        local schedule, aim = ((self.achieveData).taskData):GetTaskProcess()
        ;
        ((self.ui).tex_Progress):SetIndex(0, tostring(schedule), tostring(aim))
        self:m_FillProcess(1)
        ;
        ((self.ui).tex_State):SetIndex(1)
        ;
        ((self.ui).obj_isOver):SetActive(false)
      else
        do
          if (self.achieveData).state == (TaskEnum.eTaskState).Picked then
            local aim = (((ConfigData.taskStep)[((self.achieveData).stcData).id])[1]).finish_value
            ;
            ((self.ui).tex_Progress):SetIndex(0, tostring(aim), tostring(aim))
            local time = (TimestampToDate((self.achieveData).completedTimestamp))
            -- DECOMPILER ERROR at PC99: Overwrote pending register: R3 in 'AssignReg'

            local month = .end
            if time.month < 10 then
              month = "0" .. tostring(time.month)
            else
              month = tostring(time.month)
            end
            local day = nil
            if time.day < 10 then
              day = "0" .. tostring(time.day)
            else
              day = tostring(time.day)
            end
            -- DECOMPILER ERROR at PC135: Confused about usage of register: R5 in 'UnsetPending'

            ;
            ((self.ui).textCompleteTime).text = time.year .. "." .. month .. "." .. day
            self:m_FillProcess(1)
            ;
            ((self.ui).tex_State):SetIndex(2)
            ;
            ((self.ui).obj_isOver):SetActive(true)
          else
            do
              error("not configed task state:" .. tostring((self.achieveData).stat))
              self:RefreshRewards()
            end
          end
        end
      end
    end
  end
end

UINAchievementItem.m_FillProcess = function(self, value)
  -- function num : 0_5 , upvalues : _ENV
  local sizeDelta = ((self.ui).bar).sizeDelta
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

  if value >= 1 then
    ((self.ui).img_Fill).sizeDelta = sizeDelta
  else
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((self.ui).img_Fill).sizeDelta = (Vector2.New)(value * sizeDelta.x, sizeDelta.y)
  end
end

UINAchievementItem.RefreshRewards = function(self)
  -- function num : 0_6 , upvalues : TaskEnum, _ENV
  (self.rewardItemPool):HideAll()
  local stcData = (self.achieveData).stcData
  local isPicked = (self.achieveData).state == (TaskEnum.eTaskState).Picked
  for k,rewardId in ipairs(stcData.rewardIds) do
    local rewardNum = (stcData.rewardNums)[k]
    local itemCfg = (ConfigData.item)[rewardId]
    local rewardItem = (self.rewardItemPool):GetOne()
    rewardItem:InitItemWithCount(itemCfg, rewardNum, nil, isPicked)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

UINAchievementItem.OnClick = function(self)
  -- function num : 0_7 , upvalues : TaskEnum, _ENV
  if (self.achieveData).state == (TaskEnum.eTaskState).InProgress then
    self:JumpToTarget()
  else
    if (self.achieveData).state == (TaskEnum.eTaskState).Completed then
      local containAth = false
      for k,rewardId in ipairs(((self.achieveData).stcData).rewardIds) do
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
          (self.getRewardEvent)(self.achieveData)
        end
      end
    end
  end
end

UINAchievementItem.JumpToTarget = function(self)
  -- function num : 0_8
  if self.JumpToTargetEvent ~= nil then
    (self.JumpToTargetEvent)((self.achieveData).stcData)
  end
end

UINAchievementItem.OnDelete = function(self)
  -- function num : 0_9 , upvalues : base
  (base.OnDelete)(self)
end

return UINAchievementItem

