local GuideType_Base = class("GuideType_Base")
local CS_GSceneManager_Ins = (CS.GSceneManager).Instance
local CS_GameObject = (CS.UnityEngine).GameObject
local fallbackTime = 15
GuideType_Base.StartGuide = function(self)
  -- function num : 0_0
end

GuideType_Base.EndGuide = function(self, success, isBreak)
  -- function num : 0_1
end

GuideType_Base.BreakEndGuide = function(self)
  -- function num : 0_2
end

GuideType_Base.OnStepFinishAction = function(self, stepIndex, action)
  -- function num : 0_3
  if action ~= nil then
    action()
  end
end

GuideType_Base.NeedWaitWarn = function(self)
  -- function num : 0_4
  return true
end

GuideType_Base.BeforeRunCode = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self.guideStepCfg == nil then
    return 
  end
  if not (string.IsNullOrEmpty)((self.guideStepCfg).after_code) then
    local afterExeCode = load((self.guideStepCfg).after_code)
    if afterExeCode == nil then
      warn((string.format)("guide error id[%d],index[%d],stepId[%d],after code error,interrupt", (self.guideCfg).id, self.guideIndex, (self.guideStepCfg).id))
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

GuideType_Base.RunNextInternal = function(self, guideStepCfg)
  -- function num : 0_6 , upvalues : _ENV
  self:BeforeRunCode()
  if guideStepCfg.delay ~= nil and guideStepCfg.delay > 0 then
    self.waitTimerId = TimerManager:StartTimer(guideStepCfg.delay, self.RunCurStep, self, true, false, self:IsTimerUnScale())
  else
    self:RunCurStep()
  end
end

GuideType_Base.RunCurStep = function(self)
  -- function num : 0_7
  self.waitTimerId = nil
end

GuideType_Base.NextWaitUIWindow = function(self, guideStepCfg)
  -- function num : 0_8 , upvalues : _ENV, fallbackTime
  local targetWindow = UIManager:GetWindow(guideStepCfg.target_parent)
  if targetWindow ~= nil then
    self:RunNextInternal(guideStepCfg)
    return 
  end
  if guideStepCfg.wait_target then
    local waittime = Time.realtimeSinceStartup
    do
      local waitWindowFunc = function()
    -- function num : 0_8_0 , upvalues : _ENV, guideStepCfg, self, waittime, fallbackTime
    local waitWindow = UIManager:GetWindow(guideStepCfg.target_parent)
    if waitWindow ~= nil then
      TimerManager:StopTimer(self.waitTimerId)
      self.waitTimerId = nil
      self:RunNextInternal(guideStepCfg)
    else
      local time = Time.realtimeSinceStartup - waittime
      if fallbackTime < time then
        TimerManager:StopTimer(self.waitTimerId)
        self.waitTimerId = nil
        if self:NeedWaitWarn() then
          warn((string.format)("guide error,%s Id[%d],wait targetWindow overtime", (self.__class_type).__cname, guideStepCfg.id))
        end
        self:EndGuide(false)
      end
    end
  end

      self.waitTimerId = TimerManager:StartTimer(0.2, waitWindowFunc, nil, false, false, self:IsTimerUnScale())
    end
  else
    do
      if self:NeedWaitWarn() then
        warn((string.format)("guide error,%s Id[%d],targetWindow is null,interrupt", (self.__class_type).__cname, guideStepCfg.id))
      end
      self:EndGuide(false)
    end
  end
end

GuideType_Base.NextWaitSceneTarget = function(self, guideStepCfg)
  -- function num : 0_9 , upvalues : _ENV, CS_GameObject, fallbackTime
  if (string.IsNullOrEmpty)(guideStepCfg.target_name) then
    self:RunNextInternal(guideStepCfg)
    return 
  end
  local targetObj = (CS_GameObject.Find)(guideStepCfg.target_name)
  if not IsNull(targetObj) then
    self.curTargetTransform = targetObj.transform
    self:RunNextInternal(guideStepCfg)
    return 
  end
  if guideStepCfg.wait_target then
    local waittime = Time.realtimeSinceStartup
    do
      local waitTargetFunc = function()
    -- function num : 0_9_0 , upvalues : CS_GameObject, guideStepCfg, _ENV, self, waittime, fallbackTime
    local targetObj = (CS_GameObject.Find)(guideStepCfg.target_name)
    if not IsNull(targetObj) then
      TimerManager:StopTimer(self.waitTimerId)
      self.waitTimerId = nil
      self.curTargetTransform = targetObj.transform
      self:RunNextInternal(guideStepCfg)
    else
      local time = Time.realtimeSinceStartup - waittime
      if fallbackTime < time then
        TimerManager:StopTimer(self.waitTimerId)
        self.waitTimerId = nil
        if self:NeedWaitWarn() then
          warn((string.format)("guide error,%s Id[%d],wait scene target overtime", (self.__class_type).__cname, guideStepCfg.id))
        end
        self:EndGuide(false)
      end
    end
  end

      self.waitTimerId = TimerManager:StartTimer(0.2, waitTargetFunc, nil, false, false, self:IsTimerUnScale())
    end
  else
    do
      if self:NeedWaitWarn() then
        warn((string.format)("guide error,%s Id[%d],target is null,interrupt", (self.__class_type).__cname, guideStepCfg.id))
      end
      self:EndGuide(false)
    end
  end
end

GuideType_Base.NextWaitScene = function(self, guideStepCfg, nextAction)
  -- function num : 0_10 , upvalues : _ENV, CS_GSceneManager_Ins, fallbackTime
  local targetSceneName = guideStepCfg.target_parent
  if (string.IsNullOrEmpty)(targetSceneName) then
    nextAction(self)
    return 
  end
  local scene_Name = CS_GSceneManager_Ins.curSceneName
  if scene_Name == targetSceneName then
    nextAction(self)
  else
    if guideStepCfg.wait_target then
      local waittime = Time.realtimeSinceStartup
      do
        local waitTargetFunc = function()
    -- function num : 0_10_0 , upvalues : CS_GSceneManager_Ins, targetSceneName, _ENV, self, nextAction, waittime, fallbackTime, guideStepCfg
    local waitScene = CS_GSceneManager_Ins.curSceneName
    if waitScene == targetSceneName then
      TimerManager:StopTimer(self.waitTimerId)
      self.waitTimerId = nil
      nextAction(self)
    else
      local time = Time.realtimeSinceStartup - waittime
      if fallbackTime < time then
        TimerManager:StopTimer(self.waitTimerId)
        self.waitTimerId = nil
        if self:NeedWaitWarn() then
          warn((string.format)("guide error,%s Id[%d],wait scene overtime", (self.__class_type).__cname, guideStepCfg.id))
        end
        self:EndGuide(false)
      end
    end
  end

        self.waitTimerId = TimerManager:StartTimer(0.2, waitTargetFunc, nil, false, false, self:IsTimerUnScale())
      end
    else
      do
        if self:NeedWaitWarn() then
          warn((string.format)("guide error,%s Id[%d],scene is null,interrupt", (self.__class_type).__cname, guideStepCfg.id))
        end
        self:EndGuide(false)
      end
    end
  end
end

GuideType_Base.NextWaitScriptTarget = function(self, guideStepCfg)
  -- function num : 0_11 , upvalues : _ENV, fallbackTime
  local configFunc = load(guideStepCfg.target_name)
  if configFunc == nil then
    warn((string.format)("guide error,%s Id[%d],load function is null,interrupt", (self.__class_type).__cname, guideStepCfg.id))
    self:EndGuide(false)
    return 
  end
  local target = configFunc()
  if not IsNull(target) then
    self.curTargetTransform = target.transform
    self:RunNextInternal(guideStepCfg)
    return 
  else
    if guideStepCfg.wait_target then
      local waittime = Time.realtimeSinceStartup
      do
        local waitTargetFunc = function()
    -- function num : 0_11_0 , upvalues : configFunc, _ENV, self, guideStepCfg, waittime, fallbackTime
    local targetObj = configFunc()
    if not IsNull(targetObj) then
      TimerManager:StopTimer(self.waitTimerId)
      self.waitTimerId = nil
      self.curTargetTransform = targetObj.transform
      self:RunNextInternal(guideStepCfg)
    else
      local time = Time.realtimeSinceStartup - waittime
      if fallbackTime < time then
        TimerManager:StopTimer(self.waitTimerId)
        self.waitTimerId = nil
        if self:NeedWaitWarn() then
          warn((string.format)("guide error,%s Id[%d],wait script target overtime", (self.__class_type).__cname, guideStepCfg.id))
        end
        self:EndGuide(false)
      end
    end
  end

        self.waitTimerId = TimerManager:StartTimer(0.2, waitTargetFunc, nil, false, false, self:IsTimerUnScale())
      end
    else
      do
        if self:NeedWaitWarn() then
          warn((string.format)("guide error,%s Id[%d],script target is null,interrupt", (self.__class_type).__cname, guideStepCfg.id))
        end
        self:EndGuide(false)
      end
    end
  end
end

GuideType_Base.IsTimerUnScale = function(self)
  -- function num : 0_12 , upvalues : _ENV
  do return (Time.unity_time).timeScale <= 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return GuideType_Base

