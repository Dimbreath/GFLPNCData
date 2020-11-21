-- params : ...
-- function num : 0 , upvalues : _ENV
local DormAIStateBase = require("Game.Dorm.Character.AI.DormAIStateBase")
local DormAIIdleState = class("DormAIIdleState", DormAIStateBase)
DormAIIdleState.ctor = function(self, aiCtrl, actionCfg, exitAction)
    -- function num : 0_0 , upvalues : _ENV
    self.aiCtrl = aiCtrl
    self.actionCfg = actionCfg
    self.charEntity = aiCtrl.charEntity
    self.roomCtrl = (self.charEntity).roomCharCtrl
    self.exitAction = exitAction
    self.time = 0
    self.__onCompleteOneMove = BindCallback(self, self.CompleteOneMove)
end

DormAIIdleState.StartState = function(self)
    -- function num : 0_1 , upvalues : _ENV, DormAIStateBase
    print("idle")
    self.exeState = (DormAIStateBase.AIExecuteState).Runnig
    self:StartNewMove()
end

DormAIIdleState.StartNewMove = function(self)
    -- function num : 0_2 , upvalues : DormAIStateBase, _ENV
    if self.duration <= self.time then
        self:OnExit()
        return
    end
    local pointList = ((self.charEntity).roomCharCtrl):FindNearActivePoint(16,
                                                                           (self.charEntity).x,
                                                                           (self.charEntity).y)
    if #pointList <= 0 then
        (self.charEntity):AnimatorStand()
        self.exeState = (DormAIStateBase.AIExecuteState).Fail
        return
    end
    local index = (math.random)(#pointList)
    local pos = pointList[index]
    local success = (self.charEntity):DoMoveLogic(pos, self.__onCompleteOneMove)
    if success then
        (self.charEntity):AnimatorCrossFade((self.actionCfg).action_name,
                                            (self.actionCfg).trans_time)
    end
end

DormAIIdleState.CompleteOneMove = function(self)
    -- function num : 0_3
    self:StartNewMove()
end

DormAIIdleState.OnUpdate = function(self)
    -- function num : 0_4 , upvalues : DormAIStateBase, _ENV
    if self.exeState == (DormAIStateBase.AIExecuteState).End then return end
    self.time = self.time + Time.deltaTime
    if self.duration <= self.time and self.exeState ==
        (DormAIStateBase.AIExecuteState).Fail then self:OnExit() end
end

DormAIIdleState.InterruptState = function(self)
    -- function num : 0_5
end

DormAIIdleState.OnExit = function(self)
    -- function num : 0_6 , upvalues : DormAIStateBase
    (DormAIStateBase.OnExit)(self)
    if self.exitAction ~= nil then (self.exitAction)(self) end
end

return DormAIIdleState

