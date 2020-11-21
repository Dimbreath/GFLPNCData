-- params : ...
-- function num : 0 , upvalues : _ENV
local DormAIStateBase = require("Game.Dorm.Character.AI.DormAIStateBase")
local DormAIVisitState = class("DormAIVisitState", DormAIStateBase)
local DormUtil = require("Game.Dorm.DormUtil")
DormAIVisitState.ctor = function(self, aiCtrl, actionCfg, exitAction)
    -- function num : 0_0
    self.time = 0
    self.aiCtrl = aiCtrl
    self.actionCfg = actionCfg
    self.charEntity = aiCtrl.charEntity
    self.exitAction = exitAction
    self.isFail = false
end

DormAIVisitState.StartState = function(self)
    -- function num : 0_1 , upvalues : _ENV, DormAIStateBase, DormUtil
    print("visit")
    self.exeState = (DormAIStateBase.AIExecuteState).Runnig;
    (self.charEntity):AnimatorCrossFade((self.actionCfg).action_name,
                                        (self.actionCfg).trans_time)
    local logicX, logicY = ((self.charEntity).roomData):GetDoorCoord()
    local pos = (DormUtil.XYCoord2Fnt)(logicX, logicY)
    local success = (self.charEntity):DoMoveLogic(pos, BindCallback(self,
                                                                    self.VisitOtherDormRoom))
    if success then
        (self.charEntity):AnimatorCrossFade((self.actionCfg).action_name,
                                            (self.actionCfg).trans_time)
    else

        (self.charEntity):AnimatorStand()
        self.exeState = (DormAIStateBase.AIExecuteState).Fail
    end
end

DormAIVisitState.VisitOtherDormRoom = function(self)
    -- function num : 0_2 , upvalues : DormAIStateBase, _ENV
    local success = (self.charEntity):ChangeOtherDormRoom()
    if not success then
        (self.charEntity):AnimatorStand()
        self.exeState = (DormAIStateBase.AIExecuteState).Fail
        return
    end
    (self.charEntity):ResetToDoorCoord()
    local pointList = ((self.charEntity).roomCharCtrl):FindNearActivePoint(16,
                                                                           (self.charEntity).x,
                                                                           (self.charEntity).y)
    if #pointList <= 0 then
        self.exeState = (DormAIStateBase.AIExecuteState).Fail;
        (self.charEntity):AnimatorStand()
        return
    end
    local index = (math.random)(#pointList)
    local pos = pointList[index]
    local success = (self.charEntity):DoMoveLogic(pos, BindCallback(self,
                                                                    self.OnExit))
    if success then
        (self.charEntity):AnimatorCrossFade((self.actionCfg).action_name,
                                            (self.actionCfg).trans_time)
    else

        (self.charEntity):AnimatorStand()
        self.exeState = (DormAIStateBase.AIExecuteState).Fail
    end
end

DormAIVisitState.OnUpdate = function(self)
    -- function num : 0_3 , upvalues : DormAIStateBase, _ENV
    if self.exeState == (DormAIStateBase.AIExecuteState).End then return end
    self.time = self.time + Time.deltaTime
    if self.duration <= self.time and self.exeState ==
        (DormAIStateBase.AIExecuteState).Fail then self:OnExit() end
end

DormAIVisitState.InterruptState = function(self)
    -- function num : 0_4
end

DormAIVisitState.OnExit = function(self)
    -- function num : 0_5 , upvalues : DormAIStateBase
    (DormAIStateBase.OnExit)(self)
    if self.exitAction ~= nil then (self.exitAction)(self) end
end

return DormAIVisitState

