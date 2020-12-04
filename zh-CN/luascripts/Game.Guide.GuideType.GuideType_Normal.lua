-- params : ...
-- function num : 0 , upvalues : _ENV
local GuideType_Base = require("Game.Guide.GuideType.GuideType_Base")
local GuideType_Normal = class("GuideType_Normal", GuideType_Base)
local GuideEnum = require("Game.Guide.GuideEnum")
local GuideConditionChecker = require("Game.Guide.GuideConditionChecker")
local PstConfig = require("Game.PersistentManager.PersistentData.PersistentConfig")
local CS_EventTriggerListener = CS.EventTriggerListener
local Type_RectTransform = typeof((CS.UnityEngine).RectTransform)
local slipWaitTime = 15
GuideType_Normal.ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self.__onCurStepFinish = BindCallback(self, self.OnCurStepFinish)
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

GuideType_Normal.SkipGuide = function(self, skipTask)
  -- function num : 0_2 , upvalues : _ENV, PstConfig
  if skipTask and self.taskId ~= nil and self.taskId > 0 then
    (PersistentManager:GetDataModel((PstConfig.ePackage).UserData)):SaveSkipGuideTask(self.taskId)
    PersistentManager:SaveModelData((PstConfig.ePackage).UserData)
  end
  self:EndGuide(false)
end

GuideType_Normal.BreakEndGuide = function(self)
  -- function num : 0_3
  self:EndGuide(false)
end

GuideType_Normal.EndGuide = function(self, success)
  -- function num : 0_4 , upvalues : _ENV
  self:ClearOperatorGuide()
  self.__containEventTrigger = false
  self.guideCfg = nil
  self.guideStepCfg = nil
  self.guideWindow = nil
  self.curTargetTransform = nil
  if self.waitTimer ~= nil then
    (self.waitTimer):Stop()
    self.waitTimer = nil
  end
  UIManager:DeleteWindow(UIWindowTypeID.Guide)
  GuideManager:OnEndGuide(success)
end

GuideType_Normal.NextStep = function(self)
  -- function num : 0_5 , upvalues : _ENV, GuideConditionChecker
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
  ;
  (self.guideWindow):SetWaitMaskActive(true)
  self.guideStepCfg = guideStepCfg
  ;
  (self.guideWindow):SetSkipButtonActive(false)
  if (self.guideStepCfg).target_type == 0 then
    self:RunCurStep()
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

GuideType_Normal.RunCurStep = function(self)
  -- function num : 0_6 , upvalues : GuideType_Base, GuideEnum, _ENV, slipWaitTime
  (GuideType_Base.RunCurStep)(self)
  ;
  (self.guideWindow):SetWaitMaskActive(false)
  local step_type = (self.guideStepCfg).step_type
  if step_type == (GuideEnum.StepType).LargeDialog then
    (self.guideWindow):ShowGuideLargeDialog((LanguageUtil.GetLocaleText)((self.guideStepCfg).info), (self.guideStepCfg).info_type, (self.guideStepCfg).info_pos, self.__onCurStepFinish)
  else
    if step_type == (GuideEnum.StepType).Operate then
      self:__RunCurStepOperator()
      if self.skipTimer ~= nil then
        (self.skipTimer):Stop()
        self.skipTimer = nil
      end
      if self.guideStepCfg ~= nil and (self.guideStepCfg).guide_skip then
        self.skipTimer = (TimerManager:GetTimer(slipWaitTime, function()
    -- function num : 0_6_0 , upvalues : self
    if self.guideWindow ~= nil then
      (self.guideWindow):SetSkipButtonActive(true)
    end
    ;
    (self.skipTimer):Stop()
    self.skipTimer = nil
  end
, nil, false, false, self:IsTimerUnScale())):Start()
      end
    else
      if step_type == (GuideEnum.StepType).Avg then
        local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
        avgCtrl:ShowAvg((self.guideStepCfg).avg_name, self.__onCurStepFinish, true, true)
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

GuideType_Normal.__RunCurStepOperator = function(self)
  -- function num : 0_7 , upvalues : _ENV
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
  -- function num : 0_8 , upvalues : _ENV, Type_RectTransform, GuideEnum, CS_EventTriggerListener
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
    self.__opRefreshTimer = (TimerManager:GetTimer(1, (BindCallback(self, self.__RefreshOperatorGuidePos, isRectTrasform)), nil, false, true, self:IsTimerUnScale())):Start()
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
  -- function num : 0_9 , upvalues : _ENV
  local success = false
  if IsNull(self.curTargetTransform) then
    return false
  end
  if isRectTrasform then
    if ((self.curTargetTransform).gameObject).layer == LayerMask.UI then
      success = (self.guideWindow):PlayGuide(self.curTargetTransform, UIManager.UICamera)
    else
      success = (self.guideWindow):PlayGuide(self.curTargetTransform, UIManager:GetMainCamera())
    end
  else
    local boxCollider = (self.curTargetTransform):FindComponent(eUnityComponentID.BoxCollider)
    if IsNull(boxCollider) then
      warn((string.format)("guide error id[%d],index[%d],stepId[%d],target Collider is null", (self.guideCfg).id, self.guideIndex, (self.guideStepCfg).id))
      self:EndGuide(false)
      return 
    end
    success = (self.guideWindow):PlayGuideBox(boxCollider, UIManager:GetMainCamera())
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
  -- function num : 0_10 , upvalues : GuideEnum
  local step_type = (self.guideStepCfg).step_type
  if step_type ~= (GuideEnum.StepType).LargeDialog or step_type == (GuideEnum.StepType).Operate then
    self:ClearOperatorGuide()
  else
  end
  -- DECOMPILER ERROR at PC38: Unhandled construct in 'MakeBoolean' P1

  if (((step_type ~= (GuideEnum.StepType).Avg or step_type == (GuideEnum.StepType).Code) and step_type ~= (GuideEnum.StepType).HeroSmallTalk) or step_type == (GuideEnum.StepType).Highlight) and self.__opRefreshTimer ~= nil then
    (self.__opRefreshTimer):Stop()
    self.__opRefreshTimer = nil
  end
  self:EndGuide(false)
  do return  end
  self.curTargetTransform = nil
  ;
  (self.guideWindow):CloseGuide((self.guideStepCfg).step_type)
  if self.guideIndex < #(self.guideCfg).step_list then
    self.guideIndex = self.guideIndex + 1
    self:NextStep()
  else
    self:EndGuide(true)
  end
end

GuideType_Normal.ClearOperatorGuide = function(self)
  -- function num : 0_11 , upvalues : _ENV, CS_EventTriggerListener
  if self.__opRefreshTimer ~= nil then
    (self.__opRefreshTimer):Stop()
    self.__opRefreshTimer = nil
  end
  if self.skipTimer ~= nil then
    (self.skipTimer):Stop()
    self.skipTimer = nil
  end
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

