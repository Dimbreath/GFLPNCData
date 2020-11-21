-- params : ...
-- function num : 0 , upvalues : _ENV
local GuideType_Base = class("GuideType_Base")
local CS_GSceneManager_Ins = (CS.GSceneManager).Instance
local CS_GameObject = (CS.UnityEngine).GameObject
local fallbackTime = 15
GuideType_Base.StartGuide = function(self)
    -- function num : 0_0
end

GuideType_Base.EndGuide = function(self, success)
    -- function num : 0_1
end

GuideType_Base.NeedWaitWarn = function(self)
    -- function num : 0_2
    return true
end

GuideType_Base.RunNextInternal = function(self, guideStepCfg)
    -- function num : 0_3 , upvalues : _ENV
    if guideStepCfg.delay ~= nil and guideStepCfg.delay > 0 then
        self.waitTimer = (TimerManager:GetTimer(guideStepCfg.delay,
                                                self.RunCurStep, self, true,
                                                false, self:IsTimerUnScale())):Start()
    else
        self:RunCurStep()
    end
end

GuideType_Base.NextWaitUIWindow = function(self, guideStepCfg)
    -- function num : 0_4 , upvalues : _ENV, fallbackTime
    local targetWindow = UIManager:GetWindow(guideStepCfg.target_parent)
    if targetWindow ~= nil then
        self:RunNextInternal(guideStepCfg)
        return
    end
    if guideStepCfg.wait_target then
        local waittime = Time.realtimeSinceStartup
        do
            local waitWindowFunc = function()
                -- function num : 0_4_0 , upvalues : _ENV, guideStepCfg, self, waittime, fallbackTime
                local waitWindow = UIManager:GetWindow(
                                       guideStepCfg.target_parent)
                if waitWindow ~= nil then
                    (self.waitTimer):Stop()
                    self.waitTimer = nil
                    self:RunNextInternal(guideStepCfg)
                else
                    local time = Time.realtimeSinceStartup - waittime
                    if fallbackTime < time then
                        (self.waitTimer):Stop()
                        self.waitTimer = nil
                        if self:NeedWaitWarn() then
                            warn((string.format)(
                                     "guide error,%s Id[%d],wait targetWindow overtime",
                                     (self.__class_type).__cname,
                                     guideStepCfg.id))
                        end
                        self:EndGuide(false)
                    end
                end
            end

            self.waitTimer = (TimerManager:GetTimer(0.2, waitWindowFunc, nil,
                                                    false, false,
                                                    self:IsTimerUnScale())):Start()
        end
    else
        do
            if self:NeedWaitWarn() then
                warn((string.format)(
                         "guide error,%s Id[%d],targetWindow is null,interrupt",
                         (self.__class_type).__cname, guideStepCfg.id))
            end
            self:EndGuide(false)
        end
    end
end

GuideType_Base.NextWaitSceneTarget = function(self, guideStepCfg)
    -- function num : 0_5 , upvalues : _ENV, CS_GameObject, fallbackTime
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
                -- function num : 0_5_0 , upvalues : CS_GameObject, guideStepCfg, _ENV, self, waittime, fallbackTime
                local targetObj = (CS_GameObject.Find)(guideStepCfg.target_name)
                if not IsNull(targetObj) then
                    (self.waitTimer):Stop()
                    self.waitTimer = nil
                    self.curTargetTransform = targetObj.transform
                    self:RunNextInternal(guideStepCfg)
                else
                    local time = Time.realtimeSinceStartup - waittime
                    if fallbackTime < time then
                        (self.waitTimer):Stop()
                        self.waitTimer = nil
                        if self:NeedWaitWarn() then
                            warn((string.format)(
                                     "guide error,%s Id[%d],wait scene target overtime",
                                     (self.__class_type).__cname,
                                     guideStepCfg.id))
                        end
                        self:EndGuide(false)
                    end
                end
            end

            self.waitTimer = (TimerManager:GetTimer(0.2, waitTargetFunc, nil,
                                                    false, false,
                                                    self:IsTimerUnScale())):Start()
        end
    else
        do
            if self:NeedWaitWarn() then
                warn((string.format)(
                         "guide error,%s Id[%d],target is null,interrupt",
                         (self.__class_type).__cname, guideStepCfg.id))
            end
            self:EndGuide(false)
        end
    end
end

GuideType_Base.NextWaitScene = function(self, guideStepCfg, nextAction)
    -- function num : 0_6 , upvalues : _ENV, CS_GSceneManager_Ins, fallbackTime
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
                    -- function num : 0_6_0 , upvalues : CS_GSceneManager_Ins, targetSceneName, self, nextAction, _ENV, waittime, fallbackTime, guideStepCfg
                    local waitScene = CS_GSceneManager_Ins.curSceneName
                    if waitScene == targetSceneName then
                        (self.waitTimer):Stop()
                        self.waitTimer = nil
                        nextAction(self)
                    else
                        local time = Time.realtimeSinceStartup - waittime
                        if fallbackTime < time then
                            (self.waitTimer):Stop()
                            self.waitTimer = nil
                            if self:NeedWaitWarn() then
                                warn((string.format)(
                                         "guide error,%s Id[%d],wait scene overtime",
                                         (self.__class_type).__cname,
                                         guideStepCfg.id))
                            end
                            self:EndGuide(false)
                        end
                    end
                end

                self.waitTimer = (TimerManager:GetTimer(0.2, waitTargetFunc,
                                                        nil, false, false,
                                                        self:IsTimerUnScale())):Start()
            end
        else
            do
                if self:NeedWaitWarn() then
                    warn((string.format)(
                             "guide error,%s Id[%d],scene is null,interrupt",
                             (self.__class_type).__cname, guideStepCfg.id))
                end
                self:EndGuide(false)
            end
        end
    end
end

GuideType_Base.NextWaitScriptTarget = function(self, guideStepCfg)
    -- function num : 0_7 , upvalues : _ENV, fallbackTime
    local configFunc = load(guideStepCfg.target_name)
    if configFunc == nil then
        warn((string.format)(
                 "guide error,%s Id[%d],load function is null,interrupt",
                 (self.__class_type).__cname, guideStepCfg.id))
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
                    -- function num : 0_7_0 , upvalues : configFunc, _ENV, self, guideStepCfg, waittime, fallbackTime
                    local targetObj = configFunc()
                    if not IsNull(targetObj) then
                        (self.waitTimer):Stop()
                        self.waitTimer = nil
                        self.curTargetTransform = targetObj.transform
                        self:RunNextInternal(guideStepCfg)
                    else
                        local time = Time.realtimeSinceStartup - waittime
                        if fallbackTime < time then
                            (self.waitTimer):Stop()
                            self.waitTimer = nil
                            if self:NeedWaitWarn() then
                                warn((string.format)(
                                         "guide error,%s Id[%d],wait script target overtime",
                                         (self.__class_type).__cname,
                                         guideStepCfg.id))
                            end
                            self:EndGuide(false)
                        end
                    end
                end

                self.waitTimer = (TimerManager:GetTimer(0.2, waitTargetFunc,
                                                        nil, false, false,
                                                        self:IsTimerUnScale())):Start()
            end
        else
            do
                if self:NeedWaitWarn() then
                    warn((string.format)(
                             "guide error,%s Id[%d],script target is null,interrupt",
                             (self.__class_type).__cname, guideStepCfg.id))
                end
                self:EndGuide(false)
            end
        end
    end
end

GuideType_Base.IsTimerUnScale = function(self)
    -- function num : 0_8 , upvalues : _ENV
    do return (Time.unity_time).timeScale <= 0 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return GuideType_Base

