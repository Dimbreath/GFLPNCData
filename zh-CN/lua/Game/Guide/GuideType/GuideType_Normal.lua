local GuideType_Base = require("Game.Guide.GuideType.GuideType_Base")
local GuideType_Normal = class("GuideType_Normal", GuideType_Base)
local GuideEnum = require("Game.Guide.GuideEnum")
local GuideConditionChecker = require("Game.Guide.GuideConditionChecker")
local CS_EventTriggerListener = CS.EventTriggerListener
local Type_RectTransform = typeof((CS.UnityEngine).RectTransform)
local slipWaitTime = 20
GuideType_Normal.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.__onCurStepFinish = BindCallback(self, self.OnCurStepFinish)
  self.__callTryNextGuide = BindCallback(self, self.__TryNextGuide)
  self.__guideFeature = 0
end

GuideType_Normal.StartGuide = function(self, guideCfg, taskId)
  -- function num : 0_1 , upvalues : _ENV
  self.guideCfg = guideCfg
  if #guideCfg.step_list == 0 then
    self:EndGuide(false)
    return 
  end
  self.guideIndex = 1
  self.taskId = taskId
  UIManager:ShowWindowAsync(UIWindowTypeID.Guide, function(guideWindow)
    -- function num : 0_1_0 , upvalues : self, _ENV
    if guideWindow == nil then
      self:EndGuide(false)
      return 
    end
    self.guideWindow = guideWindow
    ;
    (self.guideWindow):BindGuideSkipEvent(BindCallback(self, function()
      -- function num : 0_1_0_0 , upvalues : _ENV, self
      ((CS.MessageCommon).ShowMessageBox)(ConfigData:GetTipContent(144), function()
        -- function num : 0_1_0_0_0 , upvalues : self
        self:SkipGuide(true)
      end
, nil)
    end
))
    self:NextStep()
  end
)
end

GuideType_Normal.IsFirstIndexAndNoLast = function(self)
  -- function num : 0_2
  do return self.guideIndex == 1 and #(self.guideCfg).step_list > 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

GuideType_Normal.AddGuideFeature = function(self, feature)
  -- function num : 0_3
  self.__guideFeature = self.__guideFeature | feature
end

GuideType_Normal.RemoveGuideFeature = function(self, feature)
  -- function num : 0_4
  self.__guideFeature = self.__guideFeature & ~feature
end

GuideType_Normal.HasGuideFeature = function(self, feature)
  -- function num : 0_5
  do return self.__guideFeature & feature > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

GuideType_Normal.SkipGuide = function(self, skipTask)
  -- function num : 0_6 , upvalues : _ENV
  if skipTask and self.taskId ~= nil and self.taskId > 0 then
    (PersistentManager:GetDataModel((PersistentConfig.ePackage).UserData)):SaveSkipGuideTask(self.taskId)
    PersistentManager:SaveModelData((PersistentConfig.ePackage).UserData)
  end
  self:EndGuide(false)
end

GuideType_Normal.BreakEndGuide = function(self)
  -- function num : 0_7
  self:EndGuide(false, true)
end

GuideType_Normal.EndGuide = function(self, success, isBreak)
  -- function num : 0_8 , upvalues : _ENV
  self:ClearOperatorGuide()
  do
    if not isBreak and self.guideCfg ~= nil and (self.guideCfg).finish_task then
      local taskNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Task)
      if taskNetworkCtrl ~= nil then
        taskNetworkCtrl:CS_QUEST_ClientAddSchedule(function()
    -- function num : 0_8_0 , upvalues : self, success
    self:__RealEndGuide(success)
  end
)
        return 
      end
    end
    self:__RealEndGuide(success)
  end
end

GuideType_Normal.__RealEndGuide = function(self, success)
  -- function num : 0_9 , upvalues : _ENV
  if not success and self.guideCfg ~= nil then
    for i = self.guideIndex, #(self.guideCfg).step_list do
      self:__CallClearCode(i)
    end
  end
  do
    self.__containEventTrigger = false
    self.guideCfg = nil
    self.guideStepCfg = nil
    self.guideWindow = nil
    self.curTargetTransform = nil
    if self.waitTimerId ~= nil then
      TimerManager:StopTimer(self.waitTimerId)
      self.waitTimerId = nil
    end
    UIManager:DeleteWindow(UIWindowTypeID.Guide)
    GuideManager:OnEndGuide(success)
    if not GuideManager.inGuide then
      NoticeManager:ContinueShowNotice("guide")
    end
  end
end

GuideType_Normal.NextStep = function(self)
  -- function num : 0_10 , upvalues : _ENV, GuideConditionChecker
  if self.guideCfg == nil then
    self:EndGuide(false)
    return 
  end
  local stepId = ((self.guideCfg).step_list)[self.guideIndex]
  local guideStepCfg = (ConfigData.guide_step)[stepId]
  if guideStepCfg == nil then
    error("guide step cfg is null,id:" .. tostring(stepId))
    self:EndGuide(false)
    return 
  end
  if not (GuideConditionChecker.CheckGuideCondition)(guideStepCfg.condition, guideStepCfg.condition_arg) then
    self:EndGuide(false)
    return 
  end
  if self.guideIndex == 1 then
    if not (GuideConditionChecker.CheckTriggerGuideCondition)((self.guideCfg).guide_condition, (self.guideCfg).guide_arg) then
      self:EndGuide(false)
      return 
    end
    NoticeManager:PuaseShowNotice("guide")
  end
  ;
  (self.guideWindow):SetWaitMaskActive(true)
  self.guideStepCfg = guideStepCfg
  ;
  (self.guideWindow):SetSkipButtonActive(false)
  if not (string.IsNullOrEmpty)((self.guideStepCfg).first_code) then
    local firstExeCode = load((self.guideStepCfg).first_code)
    if firstExeCode == nil then
      warn((string.format)("guide error id[%d],index[%d],stepId[%d],fisrt code error,interrupt", (self.guideCfg).id, self.guideIndex, (self.guideStepCfg).id))
      self:EndGuide(false)
      return 
    end
    local status, current = xpcall(firstExeCode, debug.traceback)
    if not status then
      error(current)
      return 
    end
  end
  do
    if (self.guideStepCfg).target_type == 0 then
      self:RunNextInternal(guideStepCfg)
    else
      if (self.guideStepCfg).target_type == 1 then
        self:NextWaitUIWindow(self.guideStepCfg)
      else
        if (self.guideStepCfg).target_type == 2 then
          self:NextWaitScene(self.guideStepCfg, BindCallback(self, self.NextWaitSceneTarget, self.guideStepCfg))
        else
          if (self.guideStepCfg).target_type == 3 then
            self:NextWaitScriptTarget(self.guideStepCfg)
          else
            error("guideStepCfg is target_type error,id:" .. tostring((self.guideStepCfg).id))
            self:EndGuide(false)
          end
        end
      end
    end
  end
end

GuideType_Normal.RunCurStep = function(self)
  -- function num : 0_11 , upvalues : GuideType_Base, GuideEnum, _ENV, slipWaitTime
  (GuideType_Base.RunCurStep)(self)
  ;
  (self.guideWindow):SetWaitMaskActive(false)
  local step_type = (self.guideStepCfg).step_type
  if step_type == (GuideEnum.StepType).LargeDialog then
    (self.guideWindow):ShowGuideLargeDialog((LanguageUtil.GetLocaleText)((self.guideStepCfg).info), (self.guideStepCfg).info_type, (self.guideStepCfg).info_pos, self.__onCurStepFinish)
  else
    if step_type == (GuideEnum.StepType).Operate then
      self:__RunCurStepOperator()
      if self.skipTimerId ~= nil then
        TimerManager:StopTimer(self.skipTimerId)
        self.skipTimerId = nil
      end
      if self.guideStepCfg ~= nil and (self.guideStepCfg).guide_skip then
        self.skipTimerId = TimerManager:StartTimer(slipWaitTime, function()
    -- function num : 0_11_0 , upvalues : self, _ENV
    if self.guideWindow ~= nil then
      (self.guideWindow):SetSkipButtonActive(true)
    end
    TimerManager:StopTimer(self.skipTimerId)
    self.skipTimerId = nil
  end
, nil, false, false, self:IsTimerUnScale())
      end
    else
      if step_type == (GuideEnum.StepType).Avg then
        local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
        if (self.guideStepCfg).avg_skip then
          avgCtrl:ShowAvg((self.guideStepCfg).avg_name, self.__onCurStepFinish)
        else
          avgCtrl:ShowAvg((self.guideStepCfg).avg_name, self.__onCurStepFinish, true, true)
        end
      else
        do
          if step_type == (GuideEnum.StepType).Code then
            local guideCode = load((self.guideStepCfg).custom_code)
            if guideCode == nil then
              warn((string.format)("guide error id[%d],index[%d],stepId[%d],load script is null,interrupt", (self.guideCfg).id, self.guideIndex, (self.guideStepCfg).id))
              self:EndGuide(false)
              return 
            end
            local status, current = xpcall(guideCode, debug.traceback)
            if not status then
              error(current)
            end
          else
            do
              if step_type == (GuideEnum.StepType).HeroSmallTalk then
                (self.guideWindow):ShowGuideHeroSmallTalk((LanguageUtil.GetLocaleText)((self.guideStepCfg).info), (self.guideStepCfg).info_type, (self.guideStepCfg).info_pos, self.__onCurStepFinish)
              else
                if step_type == (GuideEnum.StepType).Highlight then
                  self:__RunCurStepOperator()
                else
                  if step_type == (GuideEnum.StepType).AvgStory then
                    local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
                    if (self.guideStepCfg).avg_skip then
                      avgCtrl:StartAvg(nil, tonumber((self.guideStepCfg).avg_name), self.__onCurStepFinish, false, true, false)
                    else
                      avgCtrl:StartAvg(nil, tonumber((self.guideStepCfg).avg_name), self.__onCurStepFinish, true, true, true)
                    end
                  else
                    do
                      if step_type == (GuideEnum.StepType).MultiPicture then
                        UIManager:ShowWindowAsync(UIWindowTypeID.GuidePicture, function(window)
    -- function num : 0_11_1 , upvalues : self
    window:InitGuidePicture((self.guideStepCfg).pic_id, self.__onCurStepFinish, true)
  end
)
                      else
                        self:EndGuide(false)
                        return 
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

GuideType_Normal.__RunCurStepOperator = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if (self.guideStepCfg).target_type == 1 then
    local targetWindow = UIManager:GetWindow((self.guideStepCfg).target_parent)
    if targetWindow == nil then
      warn((string.format)("guide error id[%d],index[%d],stepId[%d],targetWindow is null", (self.guideCfg).id, self.guideIndex, (self.guideStepCfg).id))
      self:EndGuide(false)
      return 
    end
    local targetTrans = (targetWindow.transform):Find((self.guideStepCfg).target_name)
    if IsNull(targetTrans) then
      warn((string.format)("guide error id[%d],index[%d],stepId[%d],target Transform is null", (self.guideCfg).id, self.guideIndex, (self.guideStepCfg).id))
      self:EndGuide(false)
      return 
    end
    self.curTargetTransform = targetTrans
  end
  do
    self:__PlayOperatorGuide()
  end
end

GuideType_Normal.__PlayOperatorGuide = function(self)
  -- function num : 0_13 , upvalues : _ENV, Type_RectTransform, GuideEnum, CS_EventTriggerListener
  if IsNull(self.curTargetTransform) then
    warn((string.format)("guide error id[%d],index[%d],stepId[%d],play target Transform is null", (self.guideCfg).id, self.guideIndex, (self.guideStepCfg).id))
    self:EndGuide(false)
    return 
  end
  if not ((self.curTargetTransform).gameObject).activeInHierarchy then
    warn((string.format)("guide error id[%d],index[%d],stepId[%d],target is Hide", (self.guideCfg).id, self.guideIndex, (self.guideStepCfg).id))
    self:EndGuide(false)
    return 
  end
  local isRectTrasform = true
  if (self.guideStepCfg).target_type > 1 then
    isRectTrasform = (GR.IsType)(self.curTargetTransform, Type_RectTransform)
  end
  if not self:__RefreshOperatorGuidePos(isRectTrasform, true) then
    return 
  end
  if (self.guideStepCfg).op_refresh then
    self.__opRefreshTimerId = TimerManager:StartTimer(1, (BindCallback(self, self.__RefreshOperatorGuidePos, isRectTrasform)), nil, false, true, self:IsTimerUnScale())
  end
  self.__containEventTrigger = false
  if (self.guideStepCfg).step_type == (GuideEnum.StepType).Operate then
    self.__containEventTrigger = not IsNull((self.curTargetTransform):FindComponent(eUnityComponentID.EventTriggerListener))
    local eventTigger = (CS_EventTriggerListener.Get)(self.curTargetTransform)
    eventTigger:onClick("+", self.__onCurStepFinish)
    local exButtonPlus = (self.curTargetTransform):FindComponent(eUnityComponentID.ExButtonPlus)
    if not IsNull(exButtonPlus) then
      self.__oldButtonClosePress = exButtonPlus.closePressAction
      exButtonPlus.closePressAction = true
    end
  else
    do
      if (self.guideStepCfg).step_type == (GuideEnum.StepType).Highlight then
        (self.guideWindow):BindContinueBtnEvent(self.__onCurStepFinish, (self.guideStepCfg).step_type)
      end
    end
  end
end

GuideType_Normal.__RefreshOperatorGuidePos = function(self, isRectTrasform, isFirst)
  -- function num : 0_14 , upvalues : _ENV
  local success = false
  if IsNull(self.curTargetTransform) then
    return false
  end
  if isRectTrasform then
    if ((self.curTargetTransform).gameObject).layer == LayerMask.UI then
      success = (self.guideWindow):PlayGuide(self.curTargetTransform, UIManager.UICamera, (self.guideStepCfg).custom_size)
    else
      success = (self.guideWindow):PlayGuide(self.curTargetTransform, UIManager:GetMainCamera(), (self.guideStepCfg).custom_size)
    end
  else
    local boxCollider = (self.curTargetTransform):FindComponent(eUnityComponentID.Collider)
    if IsNull(boxCollider) then
      warn((string.format)("guide error id[%d],index[%d],stepId[%d],target Collider is null", (self.guideCfg).id, self.guideIndex, (self.guideStepCfg).id))
      self:EndGuide(false)
      return 
    end
    success = (self.guideWindow):PlayGuideCollider(boxCollider, UIManager:GetMainCamera(), (self.guideStepCfg).custom_size)
  end
  do
    if not success then
      warn((string.format)("guide error id[%d],index[%d],stepId[%d],target is not in screen", (self.guideCfg).id, self.guideIndex, (self.guideStepCfg).id))
      self:EndGuide(false)
      return false
    end
    ;
    (self.guideWindow):ShowGuideAniInfo((LanguageUtil.GetLocaleText)((self.guideStepCfg).info), (self.guideStepCfg).info_type, (self.guideStepCfg).info_pos, isFirst, (self.guideStepCfg).step_type)
    return true
  end
end

GuideType_Normal.OnCurStepFinish = function(self)
  -- function num : 0_15 , upvalues : GuideEnum, _ENV
  if self.guideStepCfg == nil then
    return 
  end
  local step_type = (self.guideStepCfg).step_type
  if step_type ~= (GuideEnum.StepType).LargeDialog or step_type == (GuideEnum.StepType).Operate then
    self:ClearOperatorGuide()
  else
  end
  if ((step_type ~= (GuideEnum.StepType).Avg or step_type == (GuideEnum.StepType).Code) and step_type ~= (GuideEnum.StepType).HeroSmallTalk) or step_type == (GuideEnum.StepType).Highlight then
    TimerManager:StopTimer(self.__opRefreshTimerId)
    self.__opRefreshTimerId = nil
  else
  end
  if step_type ~= (GuideEnum.StepType).AvgStory or step_type == (GuideEnum.StepType).MultiPicture then
    self:EndGuide(false)
    do return  end
    self.curTargetTransform = nil
    ;
    (self.guideWindow):CloseGuide((self.guideStepCfg).step_type)
    self:__CallClearCode(self.guideIndex)
    self:OnStepFinishAction(self.guideIndex, self.__callTryNextGuide)
  end
end

GuideType_Normal.__TryNextGuide = function(self)
  -- function num : 0_16
  self:__CallCompleteCode(self.guideIndex)
  if self.guideIndex < #(self.guideCfg).step_list then
    self.guideIndex = self.guideIndex + 1
    self:NextStep()
  else
    self:EndGuide(true)
  end
end

GuideType_Normal.__CallClearCode = function(self, guideIndex)
  -- function num : 0_17 , upvalues : _ENV
  if self.guideCfg == nil then
    return 
  end
  local stepId = ((self.guideCfg).step_list)[guideIndex]
  if stepId == nil then
    return 
  end
  local guideStepCfg = (ConfigData.guide_step)[stepId]
  if not (string.IsNullOrEmpty)(guideStepCfg.clear_code) then
    local afterExeCode = load(guideStepCfg.clear_code)
    if afterExeCode == nil then
      warn((string.format)("guide error id[%d],index[%d],stepId[%d],clear code error,interrupt", (self.guideCfg).id, guideIndex, stepId))
      self:EndGuide(false)
      return 
    end
    local status, current = xpcall(afterExeCode, debug.traceback)
    if not status then
      error(current)
      return 
    end
  end
end

GuideType_Normal.__CallCompleteCode = function(self, guideIndex)
  -- function num : 0_18 , upvalues : _ENV
  if self.guideCfg == nil then
    return 
  end
  local stepId = ((self.guideCfg).step_list)[guideIndex]
  if stepId == nil then
    return 
  end
  local guideStepCfg = (ConfigData.guide_step)[stepId]
  if not (string.IsNullOrEmpty)(guideStepCfg.complete_code) then
    local afterExeCode = load(guideStepCfg.complete_code)
    if afterExeCode == nil then
      warn((string.format)("guide error id[%d],index[%d],stepId[%d],complete code error,interrupt", (self.guideCfg).id, guideIndex, stepId))
      self:EndGuide(false)
      return 
    end
    local status, current = xpcall(afterExeCode, debug.traceback)
    if not status then
      error(current)
      return 
    end
  end
end

GuideType_Normal.ClearOperatorGuide = function(self)
  -- function num : 0_19 , upvalues : _ENV, CS_EventTriggerListener
  TimerManager:StopTimer(self.__opRefreshTimerId)
  self.__opRefreshTimerId = nil
  TimerManager:StopTimer(self.skipTimerId)
  self.skipTimerId = nil
  if self.guideStepCfg == nil then
    return 
  end
  if not IsNull(self.curTargetTransform) then
    local eventTigger = (CS_EventTriggerListener.Get)(self.curTargetTransform)
    if not IsNull(eventTigger) then
      eventTigger:onClick("-", self.__onCurStepFinish)
      if not self.__containEventTrigger then
        DestroyUnityObject(eventTigger)
      end
    end
    local exButtonPlus = (self.curTargetTransform):FindComponent(eUnityComponentID.ExButtonPlus)
    if not IsNull(exButtonPlus) and self.__oldButtonClosePress ~= nil then
      self.__oldButtonClosePress = self.__oldButtonClosePress
    end
    self.__oldButtonClosePress = nil
  end
end

return GuideType_Normal

